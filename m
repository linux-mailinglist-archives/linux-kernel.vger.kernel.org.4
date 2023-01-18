Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71A671DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjARNZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjARNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:25:20 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE77CCC0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674046352;
  x=1705582352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDuZPaHsxgFdJEIP3i2Sn6P/NroSujvTJa3yqm7oHHI=;
  b=n9p3JwfPY9TxVbx5u8UMOxd/dhSZYoBqCDll3/aGS1AGvE91ctIJTrGY
   regvK3W4qqElNLkcoqxnLunTwROGRnQUoZ2biGkquJcUbytnGE6imQIW8
   d8tAYWGLaQRJIfJBeq6VyM8zkqDTz+oQVjdC8IQ/sxjj0sXbQDX9l4sfN
   WvXNZxtnbRmRZQVSmWAA+T++kL+MD1ObJ75z1SZ2gzR0HV7B4TLQLVhTY
   poGaezo1CVjmT3cQfBZrsS3ihJf/HG9oK+z2NmqC3Lb3xm1/Z/mZsoeHz
   QG2CUAktvCZ6LAF27fDUz7wif9LNDg5Y6GBvlPBEYKdZpcIbhto656Gv8
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v1 2/4] ASoC: simple-card-utils: create jack inputs for aux_devs
Date:   Wed, 18 Jan 2023 13:52:24 +0100
Message-ID: <20230118125226.333214-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230118125226.333214-1-astrid.rost@axis.com>
References: <20230118125226.333214-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic way to create jack inputs for auxiliary jack detection
drivers (e.g. via i2c, spi), which are not part of any real codec.
The simple-card can be used as combining card driver to add the jacks,
no new one is required.

Create a jack (for input-events) for jack devices in the auxiliary
device list (aux_devs). A device which has the functions set_jack and
get_jack_supported_type counts as jack device.

Add a devicetree entry, in case not all input types are required.
 simple-card,aux-jack-types:
Array of snd_jack_type to create jack-input-event for jack devices in
aux-devs. If the setting is 0, the supported type of the device is used.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 include/sound/simple_card_utils.h     |  3 ++
 sound/soc/generic/simple-card-utils.c | 63 +++++++++++++++++++++++++++
 sound/soc/generic/simple-card.c       |  4 ++
 3 files changed, 70 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 38590f1ae9ee..a3f3f3aa9e6e 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -69,6 +69,7 @@ struct asoc_simple_priv {
 	} *dai_props;
 	struct asoc_simple_jack hp_jack;
 	struct asoc_simple_jack mic_jack;
+	struct snd_soc_jack *aux_jacks;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dais;
 	struct snd_soc_dai_link_component *dlcs;
@@ -187,6 +188,8 @@ int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
 			       int is_hp, char *prefix, char *pin);
+int asoc_simple_init_aux_jacks(struct asoc_simple_priv *priv,
+				char *prefix);
 int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			       struct link_info *li);
 int asoc_simple_remove(struct platform_device *pdev);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index e35becce9635..668123549fbf 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -786,6 +786,69 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_init_jack);
 
+int asoc_simple_init_aux_jacks(struct asoc_simple_priv *priv, char *prefix)
+{
+	struct snd_soc_card *card = simple_priv_to_card(priv);
+	struct device *dev = card->dev;
+	struct snd_soc_component *component;
+	char prop[128];
+	int found_jack_index = 0;
+	int num = 0;
+	int ret;
+
+	if (priv->aux_jacks)
+		return 0;
+
+	snprintf(prop, sizeof(prop), "%saux-jack-types", prefix);
+	num = of_property_count_u32_elems(dev->of_node, prop);
+	if (num < 1)
+		return 0;
+
+	priv->aux_jacks = devm_kcalloc(card->dev, num,
+				       sizeof(struct snd_soc_jack), GFP_KERNEL);
+	if (!priv->aux_jacks)
+		return -ENOMEM;
+
+	for_each_card_auxs(card, component) {
+		if (found_jack_index >= num)
+			break;
+
+		if (component->driver->set_jack &&
+		    component->driver->get_jack_supported_type) {
+			char id[128];
+			int type = 0;
+			struct snd_soc_jack *jack =
+				&(priv->aux_jacks[found_jack_index]);
+			int type_supp_mask =
+				snd_soc_component_get_jack_supported_type(
+					component);
+
+			ret = of_property_read_u32_index(
+				dev->of_node, prop, found_jack_index++, &type);
+			if (ret)
+				continue;
+
+			if (type)
+				type &= type_supp_mask; /* use only supported types */
+			else
+				type = type_supp_mask; /* use all supported types */
+
+			if (!type)
+				continue;
+
+			/* create jack */
+			snprintf(id, sizeof(id), "%s-jack", component->name);
+			ret = snd_soc_card_jack_new(card, id, type, jack);
+			if (ret)
+				continue;
+
+			(void)snd_soc_component_set_jack(component, jack, NULL);
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_init_aux_jacks);
+
 int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			  struct link_info *li)
 {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index feb55b66239b..e98932c16754 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -623,6 +623,10 @@ static int simple_soc_probe(struct snd_soc_card *card)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_init_aux_jacks(priv, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.30.2


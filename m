Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D82671DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjARN0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjARNZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:25:34 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80A9B11A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674046360;
  x=1705582360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/x6a0kRqZFzfACVy+tFZa/D9buCWMk7aPEZ6L3MonEA=;
  b=kEwuorQ0DMhcfZFTIhFT5F/jom3ZIXO2OGSjrpg+vM+iF/G4FQQrF2IN
   O2yQ/LHkHn46R2fk+Qv0ofE+lppaox1QR8jv7ksH2WpPvlLzjGoCeITOT
   rKSN3A1qJiZb2yQMHMBl1TVN4nQtS6W1hgwp8QN5IeWPM8RwN5IPV6z2G
   U+xdLWxeBUCcAsyOBsClt0O1vKLnbrNbWRkGNTwKAxWrohcv32AUhd7v7
   MLdqvmW485U2xdd6Q8zq0y92WsAO4E3GS7l7NOlmyy4xwF8Uy8QscGYrd
   1TLHaLthuiApM/xdTUIGdyHA42e6CnwHPItEQ+9owezkyEYpjiWq3Tm1e
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v1 1/4] ASoC: soc-component: add get_jack_supported_type
Date:   Wed, 18 Jan 2023 13:52:23 +0100
Message-ID: <20230118125226.333214-2-astrid.rost@axis.com>
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

Add function to return the supported jack type of snd_jack_types.
This allows a generic card driver to check whether the jack
type is valid or add all supported ones.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 include/sound/soc-component.h |  2 ++
 sound/soc/soc-component.c     | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index c26ffb033777..5aa43c323028 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -98,6 +98,7 @@ struct snd_soc_component_driver {
 		       int source, unsigned int freq_in, unsigned int freq_out);
 	int (*set_jack)(struct snd_soc_component *component,
 			struct snd_soc_jack *jack,  void *data);
+	int (*get_jack_supported_type)(struct snd_soc_component *component);
 
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
@@ -384,6 +385,7 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 			      unsigned int freq_out);
 int snd_soc_component_set_jack(struct snd_soc_component *component,
 			       struct snd_soc_jack *jack, void *data);
+int snd_soc_component_get_jack_supported_type(struct snd_soc_component *component);
 
 void snd_soc_component_seq_notifier(struct snd_soc_component *component,
 				    enum snd_soc_dapm_type type, int subseq);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index e12f8244242b..112da1647f10 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -256,6 +256,24 @@ int snd_soc_component_set_jack(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_set_jack);
 
+/**
+ * snd_soc_component_get_jack_supported_type
+ * @component: COMPONENTs
+ *
+ * Returns the supported jack type of the component
+ */
+int snd_soc_component_get_jack_supported_type(
+	struct snd_soc_component *component)
+{
+	int ret = -ENOTSUPP;
+
+	if (component->driver->get_jack_supported_type)
+		ret = component->driver->get_jack_supported_type(component);
+
+	return soc_component_ret(component, ret);
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_get_jack_supported_type);
+
 int snd_soc_component_module_get(struct snd_soc_component *component,
 				 void *mark, int upon_open)
 {
-- 
2.30.2


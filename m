Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D490670E013
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjEWPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbjEWPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:13:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CDE58;
        Tue, 23 May 2023 08:12:57 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A8BFCC0002;
        Tue, 23 May 2023 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684854776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIgj9hYW8BvuR/TDsfHXr8sG/1TWuLwG/JP4/jjJtyQ=;
        b=IZBvW7ufNfmBKRdFYU2zKdQY3poFbD6ku8VIEy0wSJzRFfUMQ0lvdQcbQgs2nS17SfIzAJ
        tLUjKVqr/RSK7nBgjE3CoOTiMCIp0G/fRadFVnuY0keir3Y0Zu9X3iHCw/YGNgrnIad82L
        Eqx7GWI1MMPrNJMmDBI/VGXLaDqO6NWhIpdOJsFyMSEZ4+GmP+nUdTb9p+/bWwEBhDC9sG
        Ym5KhIssszuqIewM+VlX8ZKrLKhStOhiN6uZQfi4yIfw7GzyClaK76oKoB/XSHOO77k4jk
        HPX5OOXyOts4LDfxRTS1ssBs0dqdxpb0dYgCQz9/mueuDAEHgZRj9BZ4vHYvow==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
Date:   Tue, 23 May 2023 17:12:23 +0200
Message-Id: <20230523151223.109551-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An additional-devs subnode can be present in the simple-card top node.
This subnode is used to declared some "virtual" additional devices.

Create related devices from this subnode and avoid this subnode presence
to interfere with the already supported subnodes analysis.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/generic/simple-card.c | 52 +++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5a5e4ecd0f61..4992ab433d6a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -348,6 +348,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
+	struct device_node *add_devs;
 	uintptr_t dpcm_selectable = (uintptr_t)of_device_get_match_data(dev);
 	bool is_top = 0;
 	int ret = 0;
@@ -359,6 +360,8 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 		is_top = 1;
 	}
 
+	add_devs = of_get_child_by_name(top, PREFIX "additional-devs");
+
 	/* loop for all dai-link */
 	do {
 		struct asoc_simple_data adata;
@@ -367,6 +370,12 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 		struct device_node *np;
 		int num = of_get_child_count(node);
 
+		/* Skip additional-devs node */
+		if (node == add_devs) {
+			node = of_get_next_child(top, node);
+			continue;
+		}
+
 		/* get codec */
 		codec = of_get_child_by_name(node, is_top ?
 					     PREFIX "codec" : "codec");
@@ -380,12 +389,15 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
-		for_each_child_of_node(node, np)
+		for_each_child_of_node(node, np) {
+			if (np == add_devs)
+				continue;
 			simple_parse_convert(dev, np, &adata);
+		}
 
 		/* loop for all CPU/Codec node */
 		for_each_child_of_node(node, np) {
-			if (plat == np)
+			if (plat == np || add_devs == np)
 				continue;
 			/*
 			 * It is DPCM
@@ -428,6 +440,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 	} while (!is_top && node);
 
  error:
+	of_node_put(add_devs);
 	of_node_put(node);
 	return ret;
 }
@@ -652,6 +665,36 @@ static int simple_soc_probe(struct snd_soc_card *card)
 	return 0;
 }
 
+static void simple_populate_aux_release(struct device *dev, void *res)
+{
+	of_platform_depopulate(*(struct device **)res);
+}
+
+static int simple_populate_aux(struct asoc_simple_priv *priv)
+{
+	struct device *dev = simple_priv_to_dev(priv);
+	struct device_node *node;
+	struct device **ptr;
+	int ret;
+
+	node = of_get_child_by_name(dev->of_node, PREFIX "additional-devs");
+	if (!node)
+		return 0;
+
+	ptr = devres_alloc(simple_populate_aux_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		devres_free(ptr);
+	} else {
+		*ptr = dev;
+		devres_add(dev, ptr);
+	}
+	return ret;
+}
+
 static int asoc_simple_probe(struct platform_device *pdev)
 {
 	struct asoc_simple_priv *priv;
@@ -688,6 +731,11 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		return ret;
 
 	if (np && of_device_is_available(np)) {
+		ret = simple_populate_aux(priv);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "populate aux error\n");
+			goto err;
+		}
 
 		ret = simple_parse_of(priv, li);
 		if (ret < 0) {
-- 
2.40.1


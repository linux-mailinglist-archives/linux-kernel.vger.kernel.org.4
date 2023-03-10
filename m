Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757D6B4796
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjCJOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjCJOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:51:12 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF85A90B;
        Fri, 10 Mar 2023 06:48:20 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176e43eb199so6065225fac.7;
        Fri, 10 Mar 2023 06:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lNbDhvtNNABoeoJ1EEfrQ6VIu2kxnEGjaB82Wf/W24=;
        b=Pe1BDNpd01txhXt6eGukgr1wHj3cSErzzunF3Mazt8LNdzb8w9yPMNlRULX3K0Y5oh
         kqfpApNidKjTOw10hz+nACZ9NRddvA8Hk8HcwscRR8yseqweWKakXVvfCEA3B54oztPk
         hF3764FyAj6lPC9nW3UlKFjVnyV1rGehVDLcpLBzS8Oog296OsVYQ1rCPZexqYm8o2HB
         KHmM5LE/g4gvBzv96V6TWhGW74/QDzVk1rUdjHUn2A1sSPTa94eenspjuse5HuIkEgJM
         K4DXex0MiTq/f7vclDSCu7e0vNVFsVLArwwo7RVC9vNWNGXA13bXyQY1CDxdnJ69R2eO
         mtJg==
X-Gm-Message-State: AO0yUKXmg+Jm/CDj0lWmSQi7f+C5rg0CvylFV/8WFBSD+Na9tHp9u41j
        5I3395g0jKPNGkBkwpMUHQ==
X-Google-Smtp-Source: AK7set9I+4VRoGtOVjvZEWPeH4QUf03Pg5OM+6KwBoqWhi2Fyc9oRdnGlhttZ2bQMXTrEhf9nUK3ig==
X-Received: by 2002:a05:6870:73c6:b0:163:535d:4a86 with SMTP id a6-20020a05687073c600b00163535d4a86mr15295757oan.22.1678459676973;
        Fri, 10 Mar 2023 06:47:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m3-20020a056870a40300b00172289de1besm115189oal.18.2023.03.10.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:56 -0800 (PST)
Received: (nullmailer pid 1546370 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: [PATCH] ASoC: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:31 -0600
Message-Id: <20230310144732.1546328-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/codecs/lpass-macro-common.c | 2 +-
 sound/soc/generic/audio-graph-card.c  | 2 +-
 sound/soc/generic/audio-graph-card2.c | 2 +-
 sound/soc/mxs/mxs-sgtl5000.c          | 2 +-
 sound/soc/samsung/i2s.c               | 2 +-
 sound/soc/sh/fsi.c                    | 2 +-
 sound/soc/stm/stm32_i2s.c             | 2 +-
 sound/soc/stm/stm32_sai_sub.c         | 4 ++--
 sound/soc/tegra/tegra_asoc_machine.c  | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index 1b9082d237c1..f54baaad54d4 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -16,7 +16,7 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 	struct lpass_macro *l_pds;
 	int ret;
 
-	if (!of_find_property(dev->of_node, "power-domains", NULL))
+	if (!of_property_present(dev->of_node, "power-domains"))
 		return NULL;
 
 	l_pds = devm_kzalloc(dev, sizeof(*l_pds), GFP_KERNEL);
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 5daa824a4ffc..d788f5f23a8a 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -78,7 +78,7 @@ static int graph_get_dai_id(struct device_node *ep)
 		 * only of_graph_parse_endpoint().
 		 * We need to check "reg" property
 		 */
-		if (of_get_property(ep,   "reg", NULL))
+		if (of_property_present(ep,   "reg"))
 			return info.id;
 
 		node = of_get_parent(ep);
diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 06609a526b78..259544f64df9 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -376,7 +376,7 @@ static int graph_get_dai_id(struct device_node *ep)
 		 * only of_graph_parse_endpoint().
 		 * We need to check "reg" property
 		 */
-		if (of_get_property(ep,   "reg", NULL))
+		if (of_property_present(ep,   "reg"))
 			return info.id;
 
 		node = of_get_parent(ep);
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 746f40938675..a55e7256a4c3 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -150,7 +150,7 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	if (of_find_property(np, "audio-routing", NULL)) {
+	if (of_property_present(np, "audio-routing")) {
 		card->dapm_widgets = mxs_sgtl5000_dapm_widgets;
 		card->num_dapm_widgets = ARRAY_SIZE(mxs_sgtl5000_dapm_widgets);
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6f96032090de..083e278aa021 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1289,7 +1289,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	int ret, i;
 
 	/* Register the clock provider only if it's expected in the DTB */
-	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
+	if (!of_property_present(dev->of_node, "#clock-cells"))
 		return 0;
 
 	/* Get the RCLKSRC mux clock parent clock names */
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index f3edc2e3d9d7..9f3f1af6349f 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1855,7 +1855,7 @@ static void fsi_of_parse(char *name,
 
 	for (i = 0; i < ARRAY_SIZE(of_parse_property); i++) {
 		sprintf(prop, "%s,%s", name, of_parse_property[i].name);
-		if (of_get_property(np, prop, NULL))
+		if (of_property_present(np, prop))
 			flags |= of_parse_property[i].val;
 	}
 	info->flags = flags;
diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index f3dd9f8e621c..9dad85ecb93f 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1066,7 +1066,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 				     "Could not get x11k parent clock\n");
 
 	/* Register mclk provider if requested */
-	if (of_find_property(np, "#clock-cells", NULL)) {
+	if (of_property_present(np, "#clock-cells")) {
 		ret = stm32_i2s_add_mclk_provider(i2s);
 		if (ret < 0)
 			return ret;
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index eb31b49e6597..8ba4206f751d 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1394,7 +1394,7 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 	/* Get spdif iec60958 property */
 	sai->spdif = false;
-	if (of_get_property(np, "st,iec60958", NULL)) {
+	if (of_property_present(np, "st,iec60958")) {
 		if (!STM_SAI_HAS_SPDIF(sai) ||
 		    sai->dir == SNDRV_PCM_STREAM_CAPTURE) {
 			dev_err(&pdev->dev, "S/PDIF IEC60958 not supported\n");
@@ -1480,7 +1480,7 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return 0;
 
 	/* Register mclk provider if requested */
-	if (of_find_property(np, "#clock-cells", NULL)) {
+	if (of_property_present(np, "#clock-cells")) {
 		ret = stm32_sai_add_mclk_provider(sai);
 		if (ret < 0)
 			return ret;
diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 78faa8bcae27..2dc1f44c5a8b 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -502,7 +502,7 @@ int tegra_asoc_machine_probe(struct platform_device *pdev)
 	 * If clock parents are not set in DT, configure here to use clk_out_1
 	 * as mclk and extern1 as parent for Tegra30 and higher.
 	 */
-	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
+	if (!of_property_present(dev->of_node, "assigned-clock-parents") &&
 	    !of_machine_is_compatible("nvidia,tegra20")) {
 		struct clk *clk_out_1, *clk_extern1;
 
-- 
2.39.2


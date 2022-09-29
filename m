Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119295EFD6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiI2Svg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiI2Sva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:51:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FD113D843;
        Thu, 29 Sep 2022 11:51:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so3553701wrb.4;
        Thu, 29 Sep 2022 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uJCpTsol33adXLxMDart/Wy7pkutj64k3IMODFcdBMM=;
        b=bDtr6y11sU/2/ngcdFDVjqnDXOU7rGNFrhQaGQ4Xz8u5WUwU/pbEkAH9JmvhwE7R9M
         gf4IN8g3I+tb/MODIQso2HhSgu0iL5R63i6T3ktnDiJl4V503KCN2Tu5R/z9dXTOWi+O
         Ty7WeO3SqrdppGGkscSu2oyorLxe9YllWefIbRvooUztV+ucrte6cJrvb29gr8jj707P
         nhj2EaKtg+RQYJdm/NO6xM6DCuEn4Sl6S2gDxqwvKprKScktvl2M5Wj3KtdriTtpWAJF
         +0A+PvrpuUW0p+KlcG0qmo0/S/StwGfYQg9GgGrOjX43dXqsUF9a0bd/Jl2Fqf9CL8E7
         iraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uJCpTsol33adXLxMDart/Wy7pkutj64k3IMODFcdBMM=;
        b=nlsv9IowQ08YkDluxYlluaeRNg+lOnZ+c6jR0BHKn8Hrjj15DlYDl2ok3x6PeCq19F
         aiWvbo8Iq1UBcyHFboFU001vVsrRhWvQGNRTTLs9c7Lp/ijrek1y7k0KGonNB/t9v6Nz
         pEcBfYTBRZWvMq3SsYP2kblZDp3vvg5v8ttRPz7MdiXFHN2Pz72IDOxd+yVq/Q3uJapd
         M6EvhwDKbQxuNrXAYYsywhbt/IdqB006G7U3TxuKfsE/Q7gLU+QQ0U7Qzp9cmIw00AFO
         px2vrIqvSm3kEE1TEcmnnBHqPjspJwQnBhlreOOe0Mfqoik3uBSM5o6voeQ6tJ9askCE
         ZLWw==
X-Gm-Message-State: ACrzQf3IwP+clDqm1mjCb+vFlyi2gjqDNhv/hpQvRkvpFLLdg5gAQHfn
        tOQ/RWITK73PllrLU9a8GMY=
X-Google-Smtp-Source: AMsMyM6d0YhYrIEtWUrp7FmQ8yw/TtwNZEZcnROIVVYMURQWW90o7fNGe49ph0Dj8SfeoU+CUATQWw==
X-Received: by 2002:a5d:5a84:0:b0:22c:ada2:5219 with SMTP id bp4-20020a5d5a84000000b0022cada25219mr3462952wrb.45.1664477487930;
        Thu, 29 Sep 2022 11:51:27 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9174:aca4:83d8:90fd])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d43ca000000b00228aea99efcsm167301wrr.14.2022.09.29.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:51:27 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
Date:   Thu, 29 Sep 2022 19:51:18 +0100
Message-Id: <20220929185119.335273-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

There are cases where not all CPG_MOD clocks should be assumed to support
PM. For example on the CRU block there is a particular sequence that needs
to be followed to initialize the CSI-2 D-PHY in which individual clocks
need to be turned ON/OFF, due to which Runtime PM support wasn't used by
the CRU CSI-2 driver.

This patch adds support to allow indicating if PM is supported by the
CPG_MOD clocks. A new macro is DEF_NO_PM() is added which sets the no_pm
flag in struct rzg2l_mod_clk and when the driver uses Runtime PM support
no_pm flag is checked to see if the clk needs to included as part of
Runtime PM.

CPG_MOD clocks with no_pm flag set need to be individually turned ON/OFF
depending on the requirement of the driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v1
* Added no_pm_mod_clks and num_no_pm_mod_clks members as part of
  struct rzg2l_cpg_priv
---
 drivers/clk/renesas/rzg2l-cpg.c | 45 ++++++++++++++++++++++++++++-----
 drivers/clk/renesas/rzg2l-cpg.h | 12 ++++++---
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3ff6ecd61756..431697a37692 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -108,12 +108,16 @@ struct rzg2l_cpg_priv {
 	unsigned int num_mod_clks;
 	unsigned int num_resets;
 	unsigned int last_dt_core_clk;
+	int *no_pm_mod_clks;
+	unsigned int num_no_pm_mod_clks;
 
 	const struct rzg2l_cpg_info *info;
 
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
+static struct rzg2l_cpg_priv *rzg2l_cpg_priv;
+
 static void rzg2l_cpg_del_clk_provider(void *data)
 {
 	of_clk_del_provider(data);
@@ -1225,16 +1229,24 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
 
 static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
 {
+	struct rzg2l_cpg_priv *priv = rzg2l_cpg_priv;
+	const struct rzg2l_cpg_info *info = priv->info;
+	unsigned int id;
+	unsigned int i;
+
 	if (clkspec->args_count != 2)
 		return false;
 
-	switch (clkspec->args[0]) {
-	case CPG_MOD:
-		return true;
-
-	default:
+	if (clkspec->args[0] != CPG_MOD)
 		return false;
+
+	id = clkspec->args[1] + info->num_total_core_clks;
+	for (i = 0; i < priv->num_no_pm_mod_clks; i++) {
+		if (priv->no_pm_mod_clks[i] == id)
+			return false;
 	}
+
+	return true;
 }
 
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)
@@ -1330,7 +1342,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct rzg2l_cpg_info *info;
 	struct rzg2l_cpg_priv *priv;
-	unsigned int nclks, i;
+	unsigned int nclks, i, j;
 	struct clk **clks;
 	int error;
 
@@ -1348,6 +1360,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	rzg2l_cpg_priv = priv;
 	nclks = info->num_total_core_clks + info->num_hw_mod_clks;
 	clks = devm_kmalloc_array(dev, nclks, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
@@ -1366,8 +1379,26 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	for (i = 0; i < info->num_core_clks; i++)
 		rzg2l_cpg_register_core_clk(&info->core_clks[i], info, priv);
 
-	for (i = 0; i < info->num_mod_clks; i++)
+	priv->num_no_pm_mod_clks = 0;
+	for (i = 0; i < info->num_mod_clks; i++) {
+		if (info->mod_clks[i].no_pm)
+			priv->num_no_pm_mod_clks++;
+	}
+
+	if (priv->num_no_pm_mod_clks && info->num_mod_clks) {
+		priv->no_pm_mod_clks =
+				devm_kmalloc_array(dev, priv->num_no_pm_mod_clks,
+						   sizeof(info->mod_clks[0].id),
+						   GFP_KERNEL);
+		if (!priv->no_pm_mod_clks)
+			return -ENOMEM;
+	}
+
+	for (i = 0, j = 0; i < info->num_mod_clks; i++) {
+		if (info->mod_clks[i].no_pm)
+			priv->no_pm_mod_clks[j++] = info->mod_clks[i].id;
 		rzg2l_cpg_register_mod_clk(&info->mod_clks[i], info, priv);
+	}
 
 	error = of_clk_add_provider(np, rzg2l_cpg_clk_src_twocell_get, priv);
 	if (error)
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index cecbdf5e4f93..1d68d3838392 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -176,6 +176,7 @@ enum clk_types {
  * @off: register offset
  * @bit: ON/MON bit
  * @is_coupled: flag to indicate coupled clock
+ * @no_pm: flag to indicate if clock doesn't support PM
  */
 struct rzg2l_mod_clk {
 	const char *name;
@@ -184,9 +185,10 @@ struct rzg2l_mod_clk {
 	u16 off;
 	u8 bit;
 	bool is_coupled;
+	bool no_pm;
 };
 
-#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled)	\
+#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled, _no_pm)	\
 	{ \
 		.name = _name, \
 		.id = MOD_CLK_BASE + (_id), \
@@ -194,13 +196,17 @@ struct rzg2l_mod_clk {
 		.off = (_off), \
 		.bit = (_bit), \
 		.is_coupled = (_is_coupled), \
+		.no_pm = (_no_pm), \
 	}
 
 #define DEF_MOD(_name, _id, _parent, _off, _bit)	\
-	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false)
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false, false)
 
 #define DEF_COUPLED(_name, _id, _parent, _off, _bit)	\
-	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true)
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true, false)
+
+#define DEF_NO_PM(_name, _id, _parent, _off, _bit)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false, true)
 
 /**
  * struct rzg2l_reset - Reset definitions
-- 
2.25.1


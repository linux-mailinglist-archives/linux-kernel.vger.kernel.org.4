Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386DC5ECE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiI0UbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiI0UbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:31:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B965C9D8;
        Tue, 27 Sep 2022 13:31:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z6so16753410wrq.1;
        Tue, 27 Sep 2022 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JwWeSyqh6XDkvRuae2xCSGuiu1TcGjy5DWuLUo0Mul8=;
        b=YihYpIiRooMtvNhcmNwW9CmgZQfD/YEQyvhs4mbMngF1+rQKGW/x1J7/pmlLwv3iQh
         iybsutX7JCkP9MLIlkf5+DwSJ8roFhfh9c5HpbkHozclVgRiYmjZ4DknjdcQcTYqMrYH
         6cLmn8FooeoXH/7fQITyduO8FdNtIQRQmN3aNPILlNq5dMwNSEavCFtFhaaezi6b4Q2M
         9S9ZPHr0dN4VaZrSY7FKPPmg5pm5r6zR/SZ+d2hLy/1T+v0p/e3cuSy+BUuwSMtJuJWh
         BvIdIohnz9N4dsV6aLsZXXhJ5450K9/NrINftbWY5B4/k4ggdrmUiWXehhZTYtKdoN1C
         tE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JwWeSyqh6XDkvRuae2xCSGuiu1TcGjy5DWuLUo0Mul8=;
        b=G8dTkJu6VSOLcBZS6sdbbI212MnxnschmorGsCaRi3vDjz80jS0TFT+7EDbZzt2QQy
         McWykP7uf2OLoo3Kd+fVmWv4ilG95bxNnfI8h3y2pRCJjygOlTgCLjcqjYDFo4vdnzo/
         +IAAQcEr+qx4DbvMPDC2ggTGsgXmtV29nwfWgAEFgAKnCg179mMA1oT6K9RimTG3MhWH
         6GAeRQDtbBy6utLpVagJdGeQjwr2t3arid8AO+MFlOahMjm4N7EeuvpfJW3J7CbabXDf
         9jktqKNeBm6RSR88+cQHsnhWh+XBuVZb8PE6WK7PiKJ5dXeQob4kZOEU+xCjqgFlwx4h
         8WPA==
X-Gm-Message-State: ACrzQf0CfwC7w89myJXm3SX39q/Y0v+kbdO7qYgovk6W03Ctxbkh65rB
        zMQ2yB65lcOWF+be6kN7ktg=
X-Google-Smtp-Source: AMsMyM5J2IMXO54ovE1z7OIYL3Vj8ny58vvaeQUfEvlKnpu6/2YbTPdpIb9DpI3dnSXKuRUj4oKaAA==
X-Received: by 2002:a5d:6b0e:0:b0:22a:2cb1:6605 with SMTP id v14-20020a5d6b0e000000b0022a2cb16605mr17811499wrw.552.1664310664849;
        Tue, 27 Sep 2022 13:31:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:c6a:3c62:baf6:511c])
        by smtp.gmail.com with ESMTPSA id ck16-20020a5d5e90000000b0022cc4b7861fsm754830wrb.97.2022.09.27.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:31:04 -0700 (PDT)
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
Subject: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
Date:   Tue, 27 Sep 2022 21:30:43 +0100
Message-Id: <20220927203044.751611-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/clk/renesas/rzg2l-cpg.c | 35 +++++++++++++++++++++++++++++----
 drivers/clk/renesas/rzg2l-cpg.h | 12 ++++++++---
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3ff6ecd61756..d275324909e7 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -114,6 +114,8 @@ struct rzg2l_cpg_priv {
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
+static struct rzg2l_cpg_priv *rzg2l_cpg_priv;
+
 static void rzg2l_cpg_del_clk_provider(void *data)
 {
 	of_clk_del_provider(data);
@@ -1223,18 +1225,42 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
 
+static inline const struct rzg2l_mod_clk
+*rzg2l_get_mod_clk(const struct rzg2l_cpg_info *info, int id)
+{
+	unsigned int i;
+
+	id += info->num_total_core_clks;
+	for (i = 0; i < info->num_mod_clks; i++) {
+		if (info->mod_clks[i].id == id)
+			return &info->mod_clks[i];
+	}
+
+	return NULL;
+}
+
 static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
 {
+	struct rzg2l_cpg_priv *priv = rzg2l_cpg_priv;
+	const struct rzg2l_cpg_info *info = priv->info;
+	const struct rzg2l_mod_clk *mod_clk;
+
 	if (clkspec->args_count != 2)
 		return false;
 
-	switch (clkspec->args[0]) {
-	case CPG_MOD:
-		return true;
+	if (clkspec->args[0] != CPG_MOD)
+		return false;
 
-	default:
+	if (clkspec->args[1] >= info->num_hw_mod_clks) {
+		dev_err(priv->dev, "Invalid clk index\n");
 		return false;
 	}
+
+	mod_clk = rzg2l_get_mod_clk(info, clkspec->args[1]);
+	if (mod_clk && mod_clk->no_pm)
+		return false;
+
+	return true;
 }
 
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)
@@ -1348,6 +1374,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	rzg2l_cpg_priv = priv;
 	nclks = info->num_total_core_clks + info->num_hw_mod_clks;
 	clks = devm_kmalloc_array(dev, nclks, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
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


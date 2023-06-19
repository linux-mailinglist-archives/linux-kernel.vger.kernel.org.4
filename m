Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38E734B03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFSEKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFSEJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:09:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483D1BB;
        Sun, 18 Jun 2023 21:09:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f907f311ccso19192645e9.1;
        Sun, 18 Jun 2023 21:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147793; x=1689739793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=PnkZkZpxaAiwmnP6qwVfvAhgi5ppqxFoHoxW0zoaRz6A+HSVY6zatqwYWwKgtiwR9e
         j8H5G4MAkhcbW7nr85JVQD19Mv8E5wnm9G/bSPZk38FS+vxBuNSJZEQSn5OfhZl2/+jF
         21ZmPEWNtqnVzXp8L/Gh39LC7s5ki01q4Wa1sGKBMufZtN68/zmC5C3jBDLUI+pkLQMF
         FMbRpXXst9vty5xT0w1N8zmbf1ZFMnye7PcWP24QDEvJxMD3XrMkKTfG14MneF02MudH
         oEDYN04PgoKlQHMRIdeWoKAh4eW8+UdqTSv907GKpjSgUnOuL2ZpkViF9xtTrET8iYEN
         My/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147793; x=1689739793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=jAihW4Ipxue/Dz1WAiy82VNqHrHHTCSu4qSfam57nLuK/RWgxHI4hDb+g2noCHHOz/
         sFDFSfrOChF8Xym98Cy9BmDkHk7LyADdAmiMxm9o5OASSd4wvV1V++0t/CIgeSnTjq/H
         xL6IGgMjn19J1GZKjIpAG7VbbZrn34ZfEnYjJ2xhrI3syF68OiFpgufdF6f0p5Fy7csB
         0h9OQr71XRFjixSC+KS5cAIkff6B4QlGuIa0sAhrYmLcr9/HBJZ2+4AyGN+Ylbg7mb4y
         SKKHJ7pNuBUGYHWU1ghWMIi8iJSJza5/ujZk6R5FbCgaZTq1r3nE4AdRS0EYaTQPS5/3
         vXCA==
X-Gm-Message-State: AC+VfDy5bd3HmjJmstLEoOBGCxzOyU4xXq1dSISZXI5fIeP3eebbaXgD
        cJJnb0ZZ4D7Cfh+QUaphiuyDg9cx29Q=
X-Google-Smtp-Source: ACHHUZ4JC/fli78EtYqECZqhF1tI0bQGCRVYvdGHHsNggh+3561s5jw8oEPxdePI1OfPPY3zHHEKkQ==
X-Received: by 2002:a05:600c:21d6:b0:3f9:a4e:190b with SMTP id x22-20020a05600c21d600b003f90a4e190bmr2986700wmj.7.1687147793648;
        Sun, 18 Jun 2023 21:09:53 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:53 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: [PATCH v5 7/9] mips: ralink: remove reset related code
Date:   Mon, 19 Jun 2023 06:09:39 +0200
Message-Id: <20230619040941.1340372-8-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A proper clock driver for ralink SoCs has been added. This driver is also
a reset provider for the SoC. Hence there is no need to have reset related
code in 'arch/mips/ralink' folder anymore. The only code that remains is
the one related with mips_reboot_setup where a PCI reset is performed.
We maintain this because I cannot test old ralink board with PCI to be
sure all works if we remove also this code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/common.h |  2 --
 arch/mips/ralink/of.c     |  4 ---
 arch/mips/ralink/reset.c  | 61 ---------------------------------------
 3 files changed, 67 deletions(-)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index fcdfc9dc6210..b0d671442966 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -23,8 +23,6 @@ extern struct ralink_soc_info soc_info;
 
 extern void ralink_of_remap(void);
 
-extern void ralink_rst_init(void);
-
 extern void __init prom_soc_init(struct ralink_soc_info *soc_info);
 
 __iomem void *plat_of_remap_node(const char *node);
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 4d06de77d92a..df29e6c896aa 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -81,10 +81,6 @@ static int __init plat_of_setup(void)
 {
 	__dt_register_buses(soc_info.compatible, "palmbus");
 
-	/* make sure that the reset controller is setup early */
-	if (ralink_soc != MT762X_SOC_MT7621AT)
-		ralink_rst_init();
-
 	return 0;
 }
 
diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 274d33078c5e..4875637ef469 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/delay.h>
-#include <linux/reset-controller.h>
 
 #include <asm/reboot.h>
 
@@ -22,66 +21,6 @@
 #define RSTCTL_RESET_PCI	BIT(26)
 #define RSTCTL_RESET_SYSTEM	BIT(0)
 
-static int ralink_assert_device(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	u32 val;
-
-	if (id == 0)
-		return -1;
-
-	val = rt_sysc_r32(SYSC_REG_RESET_CTRL);
-	val |= BIT(id);
-	rt_sysc_w32(val, SYSC_REG_RESET_CTRL);
-
-	return 0;
-}
-
-static int ralink_deassert_device(struct reset_controller_dev *rcdev,
-				  unsigned long id)
-{
-	u32 val;
-
-	if (id == 0)
-		return -1;
-
-	val = rt_sysc_r32(SYSC_REG_RESET_CTRL);
-	val &= ~BIT(id);
-	rt_sysc_w32(val, SYSC_REG_RESET_CTRL);
-
-	return 0;
-}
-
-static int ralink_reset_device(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	ralink_assert_device(rcdev, id);
-	return ralink_deassert_device(rcdev, id);
-}
-
-static const struct reset_control_ops reset_ops = {
-	.reset = ralink_reset_device,
-	.assert = ralink_assert_device,
-	.deassert = ralink_deassert_device,
-};
-
-static struct reset_controller_dev reset_dev = {
-	.ops			= &reset_ops,
-	.owner			= THIS_MODULE,
-	.nr_resets		= 32,
-	.of_reset_n_cells	= 1,
-};
-
-void ralink_rst_init(void)
-{
-	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
-						"ralink,rt2880-reset");
-	if (!reset_dev.of_node)
-		pr_err("Failed to find reset controller node");
-	else
-		reset_controller_register(&reset_dev);
-}
-
 static void ralink_restart(char *command)
 {
 	if (IS_ENABLED(CONFIG_PCI)) {
-- 
2.25.1


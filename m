Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16D6C1B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjCTQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjCTQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A333441;
        Mon, 20 Mar 2023 09:18:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso2446125wms.3;
        Mon, 20 Mar 2023 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=An+WpA5xhk2iPPHB2atTditY7h3cWb8+ezPf9QC5ID5JF1flwLrez4WFHSrsy+gQBP
         9eciv/q81KWxPEUiVMZTh40ly70sdiEcziEAS08KEitNiesJPdtuEXi4WTnVNxPB9KHC
         Fb/DaaOj6Ugtmv4Pfqsr5QL5X9wAPmAwidjSFCszhZ3EweISwEy157pL8sf0hJx+eDSb
         ozscbdtqyZ3D3TnL0zHHzzTL9Iufd70TwdcAI6XnB/KL9y+NcTbXyDtmUE6EkVuJkUSP
         vi7zXuqyDya2gIFox9R1gvDD1e5B2SDdqWdwzdadKHyEC/5OuCRhQ16fXoPUVkSJSgXA
         IrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=o3GmoaGFttrWf47pozNJ9VLVmX1rqcNpDNC+DhJfDf/NlRv98YmyIa26RC1nyncbrb
         366SolrcDEQ3SIHlaWYX8BDKl8X8/PXUw0QXuxh9OdUnX3nF16BysPmzBUJ61wJpvhtR
         xzZa0xWifsqUwwNjHBP7ie1GCU9lM8Z2OR2RPLUZGm0nGVso+VTs7RUgGpAyjb6Czk/N
         2PZUxXZmCnV4nlr7TjvZaybN+H0bK40QBFUpFyipKS9AxvlajFUJkqfM129X4hgMeXpi
         s8SKxYJFZVkTlPlPKWYjlB2FO05aVpnqx2A0GC2XIaKAUNn1tVm5QhkNEn/rsCNuCqaZ
         LBfQ==
X-Gm-Message-State: AO0yUKWuNHdHOjvhQegpJFKuwq29n++sxTCMJ7tLhIw32lVBiOtI9Z2z
        8Fe3kLw+rfxZHwRGsVcUPF9R89t98C4=
X-Google-Smtp-Source: AK7set9JMAaB8onr8ZwPfOWeIcq5MnxYgyQqc+Gl1fZtkXxt6JBdWNQzd3jsQK6TF/aKn/yKnowZUA==
X-Received: by 2002:a7b:c383:0:b0:3dc:5b88:e6dd with SMTP id s3-20020a7bc383000000b003dc5b88e6ddmr117399wmj.10.1679329119351;
        Mon, 20 Mar 2023 09:18:39 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:38 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 08/10] mips: ralink: remove reset related code
Date:   Mon, 20 Mar 2023 17:18:21 +0100
Message-Id: <20230320161823.1424278-9-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
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


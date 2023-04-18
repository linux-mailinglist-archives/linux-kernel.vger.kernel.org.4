Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966D6E5CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDRJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjDRJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64644C1F;
        Tue, 18 Apr 2023 02:03:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id he13so20153789wmb.2;
        Tue, 18 Apr 2023 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808604; x=1684400604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=KRZkxLZTylTvuVpmpvNKLfPbQPcRoxL2WfKOEJI12CDAZMd4zsDNL09515bM3/nk9W
         9/5MG1pmZoBvaJ0NhnbPB4o2Xkb286U9MaVqOBWTr/++TlyMeNsJBx52Qe72VZapcQtn
         9NQK9bVCaNuUUXbdZSM2Irv33rFmB17pJCvJqXKw5/bRCy/cd9A81QDgRpFKei7+QCor
         Orz+k9svYfVa+QWlp2bj5kj+KWC5U9u17BHFU+6zgO6gCmAjlTibapGrRtLOxb+beFEM
         xWpTFcSXpa9F/5BQU2MerB234YjVrx/2xuynvqecNgkHCML1ZCXM0Tcnrxm2gHZ/X5lt
         ldtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808604; x=1684400604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=M+I5hUNz0M9UDeEbw6F17ijhRh5sOidtj71p/JpJWEwEAjHPXl2clE1LHAfFENiMqc
         JZ+D1c98NgMnQ3wUuhKoNB4rA2Py1ik2sbgKUXx2etpVM8UFyc4pvm2p1cQa9Y2CO9ht
         /ZCG2AMCftltBbv7nVQ6EGWpoTI2psQ0PJ8n4LPy7RCQJsOA//n2uA5rmowYiZI+5fYB
         GqaSENQCLL+/oByFOKwNsWSI0T0r9PgJlD7n+FSgMZ2CURF/G3T/Hkci6m/Sk7AHwuLz
         QLrW89Ql/8g38IAOkJ8d01QIVZOYdNxQH1584igx/zmXxbDu35VMIcOL0npc/4C7gz/Y
         08Wg==
X-Gm-Message-State: AAQBX9cpYnsmgWk9SEpK6vWh34fW0Vla7ZgpSv7LHt7mOXtvuSaIYqaD
        dKjOKRAXSWPq8eJj5AU08TbNYRtqDhI=
X-Google-Smtp-Source: AKy350YZJPXvN94s+jD7H6m0FRMdSvsxhj3izOsDmzTyCD7MWwZyuNAcBpkBUgtmxi+inM5UaQXhZA==
X-Received: by 2002:a1c:f402:0:b0:3f0:9f44:c7ce with SMTP id z2-20020a1cf402000000b003f09f44c7cemr13047992wma.22.1681808603703;
        Tue, 18 Apr 2023 02:03:23 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm14341109wmj.15.2023.04.18.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:03:23 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v3 7/9] mips: ralink: remove reset related code
Date:   Tue, 18 Apr 2023 11:03:10 +0200
Message-Id: <20230418090312.2818879-8-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
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


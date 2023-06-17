Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B17733E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbjFQFZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjFQFYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE431FD7;
        Fri, 16 Jun 2023 22:24:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3112902f785so311184f8f.0;
        Fri, 16 Jun 2023 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979486; x=1689571486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=XFQyzWpj7Jlbugq24+BlEyTX3sU+6meUAMaXTxiiic6OI/gvrCm7PfRlay8lZAHNyK
         KlRYGkSmup7vAAzUJNtqGC2Op6Q5Np5ARxM4sNQ3C7if2WHRa8ZhWJBVFLn2z/lC3KOt
         d2X8nV4NdY21QezL/bS7pYCm6pzJGR7aTYYgXbdIOLn5bulWzgeLO5PBzU/QxA31JQml
         p9P+4xCzzcHvU2DMAdE5fCyeRtvhQ0dNHvHu/LOApQFpXx1Mm3U42Uzv3YqIX6aJjL09
         mQh/n+xvNA7dy6D2TcYqRmf3uQwEDa16m9i5goFH8WKjyJKNjAGx7AK1dBNxiejktLM6
         saWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979486; x=1689571486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LE+IJWXi7tfgCTNCrrJQAxQtllNFJS6/BWkoAapNRE=;
        b=ioZASXWimkJLuly5irgXCUHdWAvbLPWLeLVVi8YLb5JF5qIUhk6dAdFiarR6bMkKxL
         cm47/V7h6IhBbQZxRQlH8VrbmKXqRuoK4POzGuP4e7HMRQAWH/J+fX++TqgxY4uj8a1I
         uWJcsXqUuB0kTpxM56BWdDD9p6zP3OrPlqrNO1K4+9MASC6F276OPD36Exz1DAgrZ5iS
         qRyM5XVeGLs/FsgEZeq0nynQuecmOr1Rj8ExkrWA6PmiQuDZIh42uYivIO6apoghzPBt
         6Ep4QwybET2GLG2Ffmh0myuULFqL8q5smbCrvFMhAuXJ+HL3CR71JnxX1qWxfWFtnL1L
         vkjg==
X-Gm-Message-State: AC+VfDzmg4cojPY+187EXhPj5EIdWdQSprzqJQCdKjPpXJzkNVwlPe3p
        LRhWDtWOvBqCxucso+/Wu4/Wi2GDKi0=
X-Google-Smtp-Source: ACHHUZ5UIAnCxqX0syU7RskvhnO1jIY3SVYBfk+cztLymg+nS+XUmII5MULL+fFTid8OHEI3y/WbFQ==
X-Received: by 2002:adf:e5c7:0:b0:30a:e3bb:ba8b with SMTP id a7-20020adfe5c7000000b0030ae3bbba8bmr8303561wrn.29.1686979486048;
        Fri, 16 Jun 2023 22:24:46 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:45 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 7/9] mips: ralink: remove reset related code
Date:   Sat, 17 Jun 2023 07:24:33 +0200
Message-Id: <20230617052435.359177-8-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
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


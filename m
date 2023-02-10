Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D638B691DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjBJLNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjBJLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:13:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330772DEB;
        Fri, 10 Feb 2023 03:12:34 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k13so6173995plg.0;
        Fri, 10 Feb 2023 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4V9spyiEwfehqA2gEWTBlez2WNzN4xeTbha22bMXzas=;
        b=duaPPcn1vtiqWc2seQlgLf+6XBvC259l5kfLfhuox3u6Szpziiv0VMuEP8dPqJ4Uip
         gc128eNCgFyiNKfwtWbTISSdWV9W2mWkMHjyh2zy6Yvlo3GuZlsAY0p4G+YH7kVQpqX4
         9B+DitvhRX+YsGxPiQEyq//7nbVp33ckG92XfQmBua04OwssH6/o3Rn8yAy0z8oYx8Yl
         2mh6a9hoOw6Lnx4S7aXFQgjrExoCWMGjsp0kYmhdim5JWSzqgTyLlL11UkqfQriZQkZs
         p1kZWAQDhTGkrbLAlcIYPGUIdUBXkRdWHb9kEpo/d5rQDuuA1I3FUQwei9M19e6JJ1c5
         P+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V9spyiEwfehqA2gEWTBlez2WNzN4xeTbha22bMXzas=;
        b=dcH8V7xHwFzqklZkCJi/xf9oGlEBQoQ3xsHij6agn2tWJ/XPdC9BcbOzhetAOlsvCF
         WBejJg7OcsnqUPFZ/OY3rmoV4sB3gAyIFnGse26gHCSPDO84kLiF123COuA63Gv9fqa3
         kI8inDE0ZKaOMJ4378r/bvIcWxHhuBFl+2VFLf2a+mV5msw+V5mWjWYTnClw8yE3fJEk
         ByVEWbbafMQA2OPCyy4jg64IPolm3VpAPcoWcmHpBsZMeYsmL2PJ+pt3+B4k2ADgQf6V
         v/+byouGsVt06bX4l4AMmnwxrPjQt4iPxvNL6RA1PPRcHyggrPOcKhJdSaRzEJqXJNrT
         5lfw==
X-Gm-Message-State: AO0yUKUvCigDSZ8bWVXK0Phx8zvTgGOjzgPdQQFe7IbMD5jUGI//lfeB
        qXYp5oJEI0ik3U+mlG66juVLWuamv4yHvQ==
X-Google-Smtp-Source: AK7set8RAS551R5LFayDhHImXHHMj5qqQ9IxGdmdZoYBKJm7B2BgpygY9dxXkQlYzXbtSxLVikzJag==
X-Received: by 2002:a17:90a:195a:b0:231:284:ea4d with SMTP id 26-20020a17090a195a00b002310284ea4dmr11934030pjh.22.1676027550879;
        Fri, 10 Feb 2023 03:12:30 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a66c800b00232e9ff80acsm2518524pjl.56.2023.02.10.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:12:30 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: loongson32: Update the clock initialization
Date:   Fri, 10 Feb 2023 19:11:41 +0800
Message-Id: <20230210111141.1379645-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson-1 clock driver is under re-implementation
to add DT support. As a result, ls1x_clk_init() will be dropped soon.
Therefore, call of_clk_init() for clock initialization instead.

Link: https://lore.kernel.org/all/20230209132614.1079198-3-keguang.zhang@gmail.com
Link: https://lore.kernel.org/all/20230209132614.1079198-4-keguang.zhang@gmail.com
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/platform.h | 1 -
 arch/mips/loongson32/common/time.c               | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 86e1a6aab4e5..2cdcfb5f6012 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -20,7 +20,6 @@ extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_rtc_pdev;
 extern struct platform_device ls1x_wdt_pdev;
 
-void __init ls1x_clk_init(void);
 void __init ls1x_rtc_set_extclk(struct platform_device *pdev);
 void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index 459b15c96d3b..965c04aa56fd 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of_clk.h>
 #include <linux/interrupt.h>
 #include <linux/sizes.h>
 #include <asm/time.h>
@@ -211,7 +212,7 @@ void __init plat_time_init(void)
 	struct clk *clk = NULL;
 
 	/* initialize LS1X clocks */
-	ls1x_clk_init();
+	of_clk_init(NULL);
 
 #ifdef CONFIG_CEVT_CSRC_LS1X
 	/* setup LS1X PWM timer */

base-commit: 159c610af8cdf2b3c915e59162fc867b557cbe7e
prerequisite-patch-id: 6a8c8d604fca8bce5d9e35cac080b87a33be2b5c
-- 
2.34.1


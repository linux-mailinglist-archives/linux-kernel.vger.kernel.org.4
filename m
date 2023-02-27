Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587336A3FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjB0K6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjB0K6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7E1B572;
        Mon, 27 Feb 2023 02:58:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so5750438wrw.2;
        Mon, 27 Feb 2023 02:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brrg22pJXALLuqjwL3ofKoGSohLv11kyaas+ufZNm48=;
        b=RIhWaol/uA/GNrRqyAErinRj1oB4C/GL0DLtY0DOT2EJ+VVYsUi/YSlfPHNlwGpN1x
         FGP8CNWcKOnQjKERksMLpDjk0u+4UGV3ExIzToMCsEKTR5Maapq5t4cXkvxT9iYSWLAG
         ritysr5OvqfRTuwE97V4/8yaRrBWX06n11KuQtEz/Dd9IJCLwReXZ9HZtn+2PwYU76+f
         O7ACNKJl2yFoFOnKoFtQ/KhGM94bTFMP9i5HLXWkgSe/L/M5Fpq2uumH747ryXgM9B4g
         dG5k5YpxI7VmMcb/m6md6KDLFFSc/We4MJCGDadidjJ8li4dxHUJGINPO5G8youlnUD1
         QphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brrg22pJXALLuqjwL3ofKoGSohLv11kyaas+ufZNm48=;
        b=bY+RwKuCz7eFPQu60J5atcamzns9BRkQmRsqgsNu3ZR33sn2pqk3IauVo3itX+qlgr
         f12AwV+C7ScrO1UEnou01px36fWZtZeAojI488qgHon0uxk7t2632meMXlvzvbdM+KFf
         c+8VcP3URM71xmXOCubzTZGgYWkUkPkuCaliIhbyIzbbUvUAcNMjYiUFlyEP35GmjKcm
         9HOlBLyZr/lQGbtjoR/UvICUJNNzm9XJx04wHnWI11st1vr2EVuF2zaEs4uNxYeKIf4P
         VtGCfORvWMmbtAxtqPbolHEc6viQbZOjs/U9G9pRtEM8F9ANEawE/NyqGdrUdFIJxv0v
         dOAQ==
X-Gm-Message-State: AO0yUKV3XtGBBqZ79RK6X+4Dct8xWxOr8PNELzWoXfrkM+j+bFkNb5pK
        hmoWhV6QaTkSttWw9wV0VH1UWLonLY4=
X-Google-Smtp-Source: AK7set9lNcxC/d4NqXiCLUZzcfLrT9s1IijfjXJOsnnvvduAq/nlWLBWs9mgyUZbl/vGDvggQC29FA==
X-Received: by 2002:adf:dd45:0:b0:2c7:a55:bef5 with SMTP id u5-20020adfdd45000000b002c70a55bef5mr14150209wrm.23.1677495497782;
        Mon, 27 Feb 2023 02:58:17 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:17 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 10/12] mips: ralink: mt7620: define MT7620_SYSC_BASE with __iomem
Date:   Mon, 27 Feb 2023 11:58:04 +0100
Message-Id: <20230227105806.2394101-11-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
References: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
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

So that MT7620_SYSC_BASE can be used later in multiple functions without
needing to repeat this __iomem declaration each time

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |  3 ++-
 arch/mips/ralink/mt7620.c                  | 15 +++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index d51dfad8f543..3e37705ea9cf 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -11,7 +11,8 @@
 #ifndef _MT7620_REGS_H_
 #define _MT7620_REGS_H_
 
-#define MT7620_SYSC_BASE		0x10000000
+#define IOMEM(x)			((void __iomem *)(KSEG1ADDR(x)))
+#define MT7620_SYSC_BASE		IOMEM(0x10000000)
 
 #define SYSC_REG_CHIP_NAME0		0x00
 #define SYSC_REG_CHIP_NAME1		0x04
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index ae1fa0391c88..c13b73b6ee3f 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -326,7 +326,6 @@ mt7628_dram_init(struct ralink_soc_info *soc_info)
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
-	void __iomem *sysc = (void __iomem *) KSEG1ADDR(MT7620_SYSC_BASE);
 	unsigned char *name = NULL;
 	u32 n0;
 	u32 n1;
@@ -336,9 +335,9 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 	u32 pmu1;
 	u32 bga;
 
-	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
-	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
+	n0 = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+	rev = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_REV);
 	bga = (rev >> CHIP_REV_PKG_SHIFT) & CHIP_REV_PKG_MASK;
 
 	if (n0 == MT7620_CHIP_NAME0 && n1 == MT7620_CHIP_NAME1) {
@@ -352,7 +351,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 			soc_info->compatible = "ralink,mt7620n-soc";
 		}
 	} else if (n0 == MT7620_CHIP_NAME0 && n1 == MT7628_CHIP_NAME1) {
-		u32 efuse = __raw_readl(sysc + SYSC_REG_EFUSE_CFG);
+		u32 efuse = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_EFUSE_CFG);
 
 		if (efuse & EFUSE_MT7688) {
 			ralink_soc = MT762X_SOC_MT7688;
@@ -372,7 +371,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		(rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK,
 		(rev & CHIP_REV_ECO_MASK));
 
-	cfg0 = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG0);
+	cfg0 = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_SYSTEM_CONFIG0);
 	if (is_mt76x8()) {
 		dram_type = cfg0 & DRAM_TYPE_MT7628_MASK;
 	} else {
@@ -388,8 +387,8 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 	else
 		mt7620_dram_init(soc_info);
 
-	pmu0 = __raw_readl(sysc + PMU0_CFG);
-	pmu1 = __raw_readl(sysc + PMU1_CFG);
+	pmu0 = __raw_readl(MT7620_SYSC_BASE + PMU0_CFG);
+	pmu1 = __raw_readl(MT7620_SYSC_BASE + PMU1_CFG);
 
 	pr_info("Analog PMU set to %s control\n",
 		(pmu0 & PMU_SW_SET) ? ("sw") : ("hw"));
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F386A3FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjB0K7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjB0K6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57812BF8;
        Mon, 27 Feb 2023 02:58:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j2so5715324wrh.9;
        Mon, 27 Feb 2023 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUV9hLKOdU18pBMiDrMjFGutWffcfv1IB6gkYAwpmlw=;
        b=Ur6w/ahwqv/lj3FjKNGY7RbDcan7PvkgloTbDyYRRh1gpj8KzbA6Cmb/d4LIRKLjUs
         MJineUYEOjpaR6vbOXl5TblUDJfBPY+BiNhXfhK6B1aoZimRLaXWLFjzRtf6UlnGn+lM
         IB9kUKCSF7RpIaG2//IlpXEh+ZaMkaTBdDKylIyBlhFFJgy1Zpk4PAAYTaxWy5ku7Ly4
         Lrb8VHOmhzoDVpr6cIND+rwszj80mOfEy1qelMInJv8ynnDmDCZyRqsFSp4c4aI2zEFd
         NAglJ5HfohCpioezXfvPVgytrnC/+pdsf5FNcamWme1fJ3C7+GlMzQuhn0ARd1knGz4Q
         os0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUV9hLKOdU18pBMiDrMjFGutWffcfv1IB6gkYAwpmlw=;
        b=6G92hDgRd5sGLbVa90gbh40znFX/kMZuI2G7DtoMnSITVk4STCZn+EoQNZr0SHdudC
         HrA1fnKm5UmOcYVsdBBIoOGrXnTKfWfulk8HBTT9QG6U7YvN4C03HL+slQG9ijS9gYGd
         miiCDQY5jM5ASly6vGO3FTJDTChm9xUmDMkgdLpCQPvKDsO3YeiASTHIxqoGAbVpdzBQ
         ss4Ta12V70g5pRUiU9f0Gf1dDl0SZk+0kOe0QCldX81vlwn9raqeGmRgFuTNE3SDnaaO
         NGQ3V46/8+p5onzsveCM6rCiISacb4oSR+C+v7ujHoWEx9HrS4EKy9wWJG7A8PbYUzyF
         mx8Q==
X-Gm-Message-State: AO0yUKVb9ceEVAwH+5mkElZ7Tml/kz31VFbEOhNEqycJkClvttbTcwkg
        2JoUQJKZqBFlNKBKbHef8hRuxadHhxA=
X-Google-Smtp-Source: AK7set8vQA/DiJ5hLWxIEZq7BZ30IrR4eJYp1TCY+Wu0F8k/8RowI0djS8gFJDaDzVXUm2sEo1/Nrg==
X-Received: by 2002:adf:fbc8:0:b0:2c5:5ff8:93e5 with SMTP id d8-20020adffbc8000000b002c55ff893e5mr18944881wrs.44.1677495498702;
        Mon, 27 Feb 2023 02:58:18 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:18 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 11/12] mips: ralink: mt7620: soc queries and tests as functions
Date:   Mon, 27 Feb 2023 11:58:05 +0100
Message-Id: <20230227105806.2394101-12-sergio.paracuellos@gmail.com>
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

Move the SoC register value queries and tests to specific functions,
to remove repetition of logic. No functional changes intended

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/mt7620.c | 94 ++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index c13b73b6ee3f..8604d91f3375 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -324,34 +324,76 @@ mt7628_dram_init(struct ralink_soc_info *soc_info)
 	}
 }
 
-void __init prom_soc_init(struct ralink_soc_info *soc_info)
+static unsigned int __init mt7620_get_soc_name0(void)
 {
-	unsigned char *name = NULL;
-	u32 n0;
-	u32 n1;
-	u32 rev;
-	u32 cfg0;
-	u32 pmu0;
-	u32 pmu1;
-	u32 bga;
+	return __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+}
+
+static unsigned int __init mt7620_get_soc_name1(void)
+{
+	return __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+}
+
+static bool __init mt7620_soc_valid(void)
+{
+	if (mt7620_get_soc_name0() == MT7620_CHIP_NAME0 &&
+	    mt7620_get_soc_name1() == MT7620_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static bool __init mt7628_soc_valid(void)
+{
+	if (mt7620_get_soc_name0() == MT7620_CHIP_NAME0 &&
+	    mt7620_get_soc_name1() == MT7628_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
 
-	n0 = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_NAME1);
-	rev = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_REV);
-	bga = (rev >> CHIP_REV_PKG_SHIFT) & CHIP_REV_PKG_MASK;
+static unsigned int __init mt7620_get_rev(void)
+{
+	return __raw_readl(MT7620_SYSC_BASE + SYSC_REG_CHIP_REV);
+}
+
+static unsigned int __init mt7620_get_bga(void)
+{
+	return (mt7620_get_rev() >> CHIP_REV_PKG_SHIFT) & CHIP_REV_PKG_MASK;
+}
+
+static unsigned int __init mt7620_get_efuse(void)
+{
+	return __raw_readl(MT7620_SYSC_BASE + SYSC_REG_EFUSE_CFG);
+}
+
+static unsigned int __init mt7620_get_soc_ver(void)
+{
+	return (mt7620_get_rev() >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK;
+}
+
+static unsigned int __init mt7620_get_soc_eco(void)
+{
+	return (mt7620_get_rev() & CHIP_REV_ECO_MASK);
+}
+
+static const char __init *mt7620_get_soc_name(struct ralink_soc_info *soc_info)
+{
+	if (mt7620_soc_valid()) {
+		u32 bga = mt7620_get_bga();
 
-	if (n0 == MT7620_CHIP_NAME0 && n1 == MT7620_CHIP_NAME1) {
 		if (bga) {
 			ralink_soc = MT762X_SOC_MT7620A;
-			name = "MT7620A";
 			soc_info->compatible = "ralink,mt7620a-soc";
+			return "MT7620A";
 		} else {
 			ralink_soc = MT762X_SOC_MT7620N;
-			name = "MT7620N";
 			soc_info->compatible = "ralink,mt7620n-soc";
+			return "MT7620N";
 		}
-	} else if (n0 == MT7620_CHIP_NAME0 && n1 == MT7628_CHIP_NAME1) {
-		u32 efuse = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_EFUSE_CFG);
+	} else if (mt7628_soc_valid()) {
+		u32 efuse = mt7620_get_efuse();
+		unsigned char *name = NULL;
 
 		if (efuse & EFUSE_MT7688) {
 			ralink_soc = MT762X_SOC_MT7688;
@@ -361,15 +403,23 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 			name = "MT7628AN";
 		}
 		soc_info->compatible = "ralink,mt7628an-soc";
+		return name;
 	} else {
-		panic("mt762x: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
+		panic("mt762x: unknown SoC, n0:%08x n1:%08x\n",
+		      mt7620_get_soc_name0(), mt7620_get_soc_name1());
 	}
+}
+
+void __init prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	const char *name = mt7620_get_soc_name(soc_info);
+	u32 cfg0;
+	u32 pmu0;
+	u32 pmu1;
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"MediaTek %s ver:%u eco:%u",
-		name,
-		(rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK,
-		(rev & CHIP_REV_ECO_MASK));
+		name, mt7620_get_soc_ver(), mt7620_get_soc_eco());
 
 	cfg0 = __raw_readl(MT7620_SYSC_BASE + SYSC_REG_SYSTEM_CONFIG0);
 	if (is_mt76x8()) {
-- 
2.25.1


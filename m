Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835B46A3FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjB0K6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjB0K6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC565FC3;
        Mon, 27 Feb 2023 02:58:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l1so2679988wry.12;
        Mon, 27 Feb 2023 02:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHJ28rGYoNleFVDOkHjpHIMUmWDA43thW23nuYI9tAQ=;
        b=EK9YaRCT3GX41yW7xA+KEywd62d/Cd7kjaiaMgDyGKVCGCpmpccGv1GzezuqgCxvYv
         MYyIMxpt4ok71jEdzRDaAIl3ZZ/i7La22i5z7kgJSGPkBCWPa3hP5Hq0Y/eFkRRwy90h
         CEZdUfnZH5xkDEaOCD/bICbSng0wtPMtR/PEZxZHlObzwCE6pR7WgxBGyi40SaWmgBvw
         LXTgQ40vBwnwoI3PvgZnN7rgqZgTLK56i46MCDAFuKzcY/IVpOzMGHsAg7/dTKpgFMDP
         aku+jzeDUuurA3ykbafPss8fZFFdDFwUXMOT+IeCYyscMOfum16bW362FselW0BJl3RV
         +h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHJ28rGYoNleFVDOkHjpHIMUmWDA43thW23nuYI9tAQ=;
        b=45K6gcXU5JVK/yIXSc9BAXZP39zTCw1gaDuBQiy5zKeeZjNS+cfG5xBoWXDcgaVle3
         GX+eZFowHigWAlKeUckFYoocQRoyWTJ3LDnckrYxcScdgNWEIJ+WMw17CK8FuFfrQ2nM
         +nPQAqM3bJh7d8tGjx1pe4eXItZUUr+/hEOpIDhsR2VIoSlaIyWw4Pc35iQneLTnxAPf
         L7kxbByegHVW90ZdxVg+xJ2rg8551g7CODG2tTEgJ7zVxV/6ZETGC2wP36ZH4yg+UXLR
         P1XW+ZVtjYKlh8UBqkW/QlFM43wDmW/BPjWNAU3XtYiBXJdiP9V54Pn9h4RyvRKQt5nj
         5v6Q==
X-Gm-Message-State: AO0yUKVMrvIe9Ghu9vmmv6LmvVcTJZrzscpmPAei5PrThaJ19lvSc5fQ
        1zRaXlsVZ/r7cydkwChd2OtC4Ao4Pvc=
X-Google-Smtp-Source: AK7set9+/e6z4/dzp7NqkF3ZUUbUakHpZK3dIcLBN1vDOiD6ek9nlE8MvFlXTAoswShRkjsx0J0LZw==
X-Received: by 2002:a5d:48c6:0:b0:2c5:58fc:e1bb with SMTP id p6-20020a5d48c6000000b002c558fce1bbmr21073847wrs.10.1677495490197;
        Mon, 27 Feb 2023 02:58:10 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:09 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 02/12] mips: ralink: rt305x: soc queries and tests as functions
Date:   Mon, 27 Feb 2023 11:57:56 +0100
Message-Id: <20230227105806.2394101-3-sergio.paracuellos@gmail.com>
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
 arch/mips/ralink/rt305x.c | 97 +++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 135a46517763..a24143c739ee 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -139,52 +139,109 @@ void __init ralink_of_remap(void)
 		panic("Failed to remap core resources");
 }
 
-void __init prom_soc_init(struct ralink_soc_info *soc_info)
+static unsigned int __init rt305x_get_soc_name0(void)
+{
+	return __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+}
+
+static unsigned int __init rt305x_get_soc_name1(void)
 {
-	unsigned char *name;
-	u32 n0;
-	u32 n1;
-	u32 id;
+	return __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+}
 
-	n0 = __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+static bool __init rt3052_soc_valid(void)
+{
+	if (rt305x_get_soc_name0() == RT3052_CHIP_NAME0 &&
+	    rt305x_get_soc_name1() == RT3052_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
 
-	if (n0 == RT3052_CHIP_NAME0 && n1 == RT3052_CHIP_NAME1) {
+static bool __init rt3350_soc_valid(void)
+{
+	if (rt305x_get_soc_name0() == RT3350_CHIP_NAME0 &&
+	    rt305x_get_soc_name1() == RT3350_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static bool __init rt3352_soc_valid(void)
+{
+	if (rt305x_get_soc_name0() == RT3352_CHIP_NAME0 &&
+	    rt305x_get_soc_name1() == RT3352_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static bool __init rt5350_soc_valid(void)
+{
+	if (rt305x_get_soc_name0() == RT5350_CHIP_NAME0 &&
+	    rt305x_get_soc_name1() == RT5350_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static const char __init *rt305x_get_soc_name(struct ralink_soc_info *soc_info)
+{
+	if (rt3052_soc_valid()) {
 		unsigned long icache_sets;
 
 		icache_sets = (read_c0_config1() >> 22) & 7;
 		if (icache_sets == 1) {
 			ralink_soc = RT305X_SOC_RT3050;
-			name = "RT3050";
 			soc_info->compatible = "ralink,rt3050-soc";
+			return "RT3050";
 		} else {
 			ralink_soc = RT305X_SOC_RT3052;
-			name = "RT3052";
 			soc_info->compatible = "ralink,rt3052-soc";
+			return "RT3052";
 		}
-	} else if (n0 == RT3350_CHIP_NAME0 && n1 == RT3350_CHIP_NAME1) {
+	} else if (rt3350_soc_valid()) {
 		ralink_soc = RT305X_SOC_RT3350;
-		name = "RT3350";
 		soc_info->compatible = "ralink,rt3350-soc";
-	} else if (n0 == RT3352_CHIP_NAME0 && n1 == RT3352_CHIP_NAME1) {
+		return "RT3350";
+	} else if (rt3352_soc_valid()) {
 		ralink_soc = RT305X_SOC_RT3352;
-		name = "RT3352";
 		soc_info->compatible = "ralink,rt3352-soc";
-	} else if (n0 == RT5350_CHIP_NAME0 && n1 == RT5350_CHIP_NAME1) {
+		return "RT3352";
+	} else if (rt5350_soc_valid()) {
 		ralink_soc = RT305X_SOC_RT5350;
-		name = "RT5350";
 		soc_info->compatible = "ralink,rt5350-soc";
+		return "RT5350";
 	} else {
-		panic("rt305x: unknown SoC, n0:%08x n1:%08x", n0, n1);
+		panic("rt305x: unknown SoC, n0:%08x n1:%08x",
+		      rt305x_get_soc_name0(), rt305x_get_soc_name1());
 	}
+}
+
+static unsigned int __init rt305x_get_soc_id(void)
+{
+	return __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_ID);
+}
+
+static unsigned int __init rt305x_get_soc_ver(void)
+{
+	return (rt305x_get_soc_id() >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK;
+}
 
-	id = __raw_readl(sysc + SYSC_REG_CHIP_ID);
+static unsigned int __init rt305x_get_soc_rev(void)
+{
+	return (rt305x_get_soc_id() & CHIP_ID_REV_MASK);
+}
+
+void __init prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	const char *name = rt305x_get_soc_name(soc_info);
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"Ralink %s id:%u rev:%u",
 		name,
-		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
-		(id & CHIP_ID_REV_MASK));
+		rt305x_get_soc_ver(),
+		rt305x_get_soc_rev());
 
 	soc_info->mem_base = RT305X_SDRAM_BASE;
 	if (soc_is_rt5350()) {
-- 
2.25.1


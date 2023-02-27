Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04546A3FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjB0K6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjB0K6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC9EB54;
        Mon, 27 Feb 2023 02:58:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l25so5743642wrb.3;
        Mon, 27 Feb 2023 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q66bHBctBFwEmexbcNsZu9cAPfXaFAcm9g/elou8jLA=;
        b=Xpgb9y8iqSWjnhj+rVJyKp+DC9qju+tBwbsyml1lWuUdzchm8yoV7Rb5E6WymIpjOQ
         5h2PYNVcBxHRo8GDrcNDNs3rCbrtx147rxajFPpgCWy4g5bPq7QtMWIg/VoeXrh+h+dP
         BC8u3IVaj9Mq8TdUB4vu3M7rSGviM2GehrHw0S8NOr7DksC483B9ui51ejMQes/vwtQl
         oj2w3Dw1Kjt3GelIam/yASEiYsDeJl3k96PlxnKO6aN8bJNQyGltP4PZcBTGgvT4dL5+
         r1xt7l3aWOCSla56cqJ32dcWgEH06HlPEi264qmNswEust4aSMaE0zaUFsD+HJihGYsl
         KFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q66bHBctBFwEmexbcNsZu9cAPfXaFAcm9g/elou8jLA=;
        b=BebraczbNfGGnAMYAme7w4vScdbX4na4Zbnx2CEPpLxCpn8aKx9TKQYSjfVTXFNA6h
         gBOfY54e33GztPju/e762nWJaS/ZO5wc+E8vdZNgeI6dL0Ea0G2Sdfbt0+mtTuixIRt8
         JcGB6yCHypt22LN3gUioAB7q3/S+oHRMM+3JNeJFF2dEjuzJ4/dXmOWQKE02gjX67kl2
         A2mA1w2E1gbpTT0JecEVYEa+6+fY2mPrh21JukfXgF4q8ZbSdfLrtPa2uOVNudgAtncS
         5hdVYsfEfdkXFmLJ9vx2PnNasjUDj8f5UyVP2JvFsN+LqV+9JxvXIeGpF9eAtCAnKdPN
         2kjQ==
X-Gm-Message-State: AO0yUKWIK8xa9byYrcmPeKnGkwe6/AR5clKryhg/cBWs+Um2cndv66WY
        VHpaiCWEwaqlmi0VocLAgF9o2vk5Z3Y=
X-Google-Smtp-Source: AK7set8t+Y0N56zWcxYuaD+Nq5bTRsi71w9WAwKD4Jr4NgczEakae7DPbS/8kgLuqHbpAag4lwfdYA==
X-Received: by 2002:a5d:604a:0:b0:2c7:16c3:175e with SMTP id j10-20020a5d604a000000b002c716c3175emr9900360wrt.64.1677495492145;
        Mon, 27 Feb 2023 02:58:12 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:11 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 04/12] mips: ralink: rt3883: define RT3883_SYSC_BASE with __iomem
Date:   Mon, 27 Feb 2023 11:57:58 +0100
Message-Id: <20230227105806.2394101-5-sergio.paracuellos@gmail.com>
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

So that RT3883_SYSC_BASE can be used later in multiple functions without
needing to repeat this __iomem declaration each time

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/rt3883.h | 4 +++-
 arch/mips/ralink/rt3883.c                  | 7 +++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt3883.h b/arch/mips/include/asm/mach-ralink/rt3883.h
index f250de9c055b..ad25d5e8d2dc 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883.h
@@ -10,8 +10,10 @@
 
 #include <linux/bitops.h>
 
+#define IOMEM(x)		((void __iomem *)(KSEG1ADDR(x)))
+
 #define RT3883_SDRAM_BASE	0x00000000
-#define RT3883_SYSC_BASE	0x10000000
+#define RT3883_SYSC_BASE	IOMEM(0x10000000)
 #define RT3883_TIMER_BASE	0x10000100
 #define RT3883_INTC_BASE	0x10000200
 #define RT3883_MEMC_BASE	0x10000300
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index d9875f146d66..fa215c07558d 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -72,15 +72,14 @@ void __init ralink_of_remap(void)
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
-	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT3883_SYSC_BASE);
 	const char *name;
 	u32 n0;
 	u32 n1;
 	u32 id;
 
-	n0 = __raw_readl(sysc + RT3883_SYSC_REG_CHIPID0_3);
-	n1 = __raw_readl(sysc + RT3883_SYSC_REG_CHIPID4_7);
-	id = __raw_readl(sysc + RT3883_SYSC_REG_REVID);
+	n0 = __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID0_3);
+	n1 = __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID4_7);
+	id = __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_REVID);
 
 	if (n0 == RT3883_CHIP_NAME0 && n1 == RT3883_CHIP_NAME1) {
 		soc_info->compatible = "ralink,rt3883-soc";
-- 
2.25.1


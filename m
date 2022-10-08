Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B7B5F8303
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 06:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJHEzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 00:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJHEzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 00:55:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022F9C7D4;
        Fri,  7 Oct 2022 21:55:41 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mkt936ccczkXvT;
        Sat,  8 Oct 2022 12:53:11 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 12:55:39 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 12:55:38 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] clk: at91: fix the build with binutils 2.27
Date:   Sat, 8 Oct 2022 13:15:34 +0800
Message-ID: <20221008051534.151392-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an issue when build with older versions of binutils 2.27.0,

arch/arm/mach-at91/pm_suspend.S: Assembler messages:
arch/arm/mach-at91/pm_suspend.S:1086: Error: garbage following instruction -- `ldr tmp1,=0x00020010UL'

Use UL() macro to fix the issue in assembly file.

Fixes: 4fd36e458392 ("ARM: at91: pm: add plla disable/enable support for sam9x60")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/clk/at91_pmc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 3484309b59bf..4fc387d0335d 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -12,6 +12,8 @@
 #ifndef AT91_PMC_H
 #define AT91_PMC_H
 
+#include <vdso/bits.h>
+
 #define AT91_PMC_V1		(1)			/* PMC version 1 */
 #define AT91_PMC_V2		(2)			/* PMC version 2 [SAM9X60] */
 
@@ -45,8 +47,8 @@
 #define	AT91_PMC_PCSR		0x18			/* Peripheral Clock Status Register */
 
 #define AT91_PMC_PLL_ACR	0x18			/* PLL Analog Control Register [for SAM9X60] */
-#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	0x12020010UL	/* Default PLL ACR value for UPLL */
-#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	0x00020010UL	/* Default PLL ACR value for PLLA */
+#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	UL(0x12020010)	/* Default PLL ACR value for UPLL */
+#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	UL(0x00020010)	/* Default PLL ACR value for PLLA */
 #define		AT91_PMC_PLL_ACR_UTMIVR		(1 << 12)	/* UPLL Voltage regulator Control */
 #define		AT91_PMC_PLL_ACR_UTMIBG		(1 << 13)	/* UPLL Bandgap Control */
 
-- 
2.35.3


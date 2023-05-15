Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D70703CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbjEOSf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbjEOSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:35:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C9414E45;
        Mon, 15 May 2023 11:35:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FIZHp9081369;
        Mon, 15 May 2023 13:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684175717;
        bh=HI41MmN1o0il5MdqxxwNhXWMrjOyfyAcGRIkMr8+fTM=;
        h=From:To:CC:Subject:Date;
        b=ydPXDv6WXsGtiS0yMgQRWIwByQRDH7+FVP8FQDCSbOLCeAgEBOiAManj59XfsOGsK
         L6lV5l4ZC3V4jj7egzl4fDXBhQpyJOTQ04QF/lkoiHb8vx7jtdzjZefqgoEEsKsncd
         xf3Bd+QNSCklwmpdiqdLVqHUGB+A8fANiWXqG+1w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FIZHui126954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 13:35:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 13:35:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 13:35:16 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FIZGXN103396;
        Mon, 15 May 2023 13:35:16 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/5] ARM: keystone: Merge memory.h into the only file that uses it
Date:   Mon, 15 May 2023 13:35:11 -0500
Message-ID: <20230515183515.509371-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines in memory.h can go into the file that makes use of them.
No reason to have a header here, remove.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-keystone/keystone.c | 12 ++++++++++--
 arch/arm/mach-keystone/memory.h   | 18 ------------------
 2 files changed, 10 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-keystone/memory.h

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index aa352c2de313..fdc7d3621bd0 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -20,10 +20,18 @@
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 
-#include "memory.h"
-
 #include "keystone.h"
 
+#define KEYSTONE_LOW_PHYS_START		0x80000000ULL
+#define KEYSTONE_LOW_PHYS_SIZE		0x80000000ULL /* 2G */
+#define KEYSTONE_LOW_PHYS_END		(KEYSTONE_LOW_PHYS_START + \
+					 KEYSTONE_LOW_PHYS_SIZE - 1)
+
+#define KEYSTONE_HIGH_PHYS_START	0x800000000ULL
+#define KEYSTONE_HIGH_PHYS_SIZE		0x400000000ULL	/* 16G */
+#define KEYSTONE_HIGH_PHYS_END		(KEYSTONE_HIGH_PHYS_START + \
+					 KEYSTONE_HIGH_PHYS_SIZE - 1)
+
 #ifdef CONFIG_ARM_LPAE
 static int keystone_platform_notifier(struct notifier_block *nb,
 				      unsigned long event, void *data)
diff --git a/arch/arm/mach-keystone/memory.h b/arch/arm/mach-keystone/memory.h
deleted file mode 100644
index 1b9ed1271e05..000000000000
--- a/arch/arm/mach-keystone/memory.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2014 Texas Instruments, Inc.
- *	Santosh Shilimkar <santosh.shilimkar@ti.com>
- */
-#ifndef __MEMORY_H
-#define __MEMORY_H
-
-#define KEYSTONE_LOW_PHYS_START		0x80000000ULL
-#define KEYSTONE_LOW_PHYS_SIZE		0x80000000ULL /* 2G */
-#define KEYSTONE_LOW_PHYS_END		(KEYSTONE_LOW_PHYS_START + \
-					 KEYSTONE_LOW_PHYS_SIZE - 1)
-
-#define KEYSTONE_HIGH_PHYS_START	0x800000000ULL
-#define KEYSTONE_HIGH_PHYS_SIZE		0x400000000ULL	/* 16G */
-#define KEYSTONE_HIGH_PHYS_END		(KEYSTONE_HIGH_PHYS_START + \
-					 KEYSTONE_HIGH_PHYS_SIZE - 1)
-#endif /* __MEMORY_H */
-- 
2.39.2


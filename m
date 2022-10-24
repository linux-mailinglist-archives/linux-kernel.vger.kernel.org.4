Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE560B36F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiJXRGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiJXREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86DD8EF5;
        Mon, 24 Oct 2022 08:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1748A6148E;
        Mon, 24 Oct 2022 15:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D89C433D7;
        Mon, 24 Oct 2022 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625910;
        bh=KwMZrO00iVnxwnhEpYpfBtEpyDgfWlroRyU4bRtZWH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKpn0jSnwzMlsvSYThZiufeQx1e/whTC74gY5Nd2K8R6wv4gSGXrVakmoOyPx3tof
         yGWyVwmerRVWNSjLTxBM8InjUU/OGvY6xgwZY1IB8GVQStJThdgZ9iNn1jezWHDkMr
         bZkOzToUxKlo+qqR/iJeltBZ/FM4tLoSOqc8Asp0XDB80kTwbg2/OZrbkVYu7BvzJw
         LbX8jQhlNCkMssgMaIA+9gLYXcyS72WUE4RiI2GGWH1HzI2OcXyoj+pXc/4f5w8UdJ
         EvUuBmfLggxsqTev4mO1gMd47rn20mn8e940nbnIqjdhn2KUbtztNWGkXiHblmCFy6
         Dxs2TDS5b5pkQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/10] ARM: omap2: remove unused omap_hwmod_reset.c
Date:   Mon, 24 Oct 2022 17:38:07 +0200
Message-Id: <20221024153814.254652-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Since commit 90aa4ed5a43f ("ARM: OMAP2+: Drop legacy platform
data for dra7 rtcss"), this is not used any more and can be
removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Makefile           |  2 +-
 arch/arm/mach-omap2/omap_hwmod.h       |  7 --
 arch/arm/mach-omap2/omap_hwmod_reset.c | 98 --------------------------
 3 files changed, 1 insertion(+), 106 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2feb9f6630af..43b44e0858c1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -7,7 +7,7 @@
 obj-y := id.o io.o control.o devices.o fb.o pm.o \
 	 common.o dma.o omap-headsmp.o sram.o
 
-hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
+hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o \
 					  omap_hwmod_common_ipblock_data.o \
 					  omap_device.o display.o hdq1w.o \
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 6962a8d267e7..1bb42f3d2e83 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -669,13 +669,6 @@ omap_hwmod_for_each_by_class(const char *classname,
 }
 #endif	/* CONFIG_OMAP_HWMOD */
 
-/*
- *
- */
-
-void omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
-void omap_hwmod_rtc_lock(struct omap_hwmod *oh);
-
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
deleted file mode 100644
index 143623bb056d..000000000000
--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * OMAP IP block custom reset and preprogramming stubs
- *
- * Copyright (C) 2012 Texas Instruments, Inc.
- * Paul Walmsley
- *
- * A small number of IP blocks need custom reset and preprogramming
- * functions.  The stubs in this file provide a standard way for the
- * hwmod code to call these functions, which are to be located under
- * drivers/.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-
-#include "omap_hwmod.h"
-#include "common.h"
-
-#define OMAP_RTC_STATUS_REG	0x44
-#define OMAP_RTC_KICK0_REG	0x6c
-#define OMAP_RTC_KICK1_REG	0x70
-
-#define OMAP_RTC_KICK0_VALUE	0x83E70B13
-#define OMAP_RTC_KICK1_VALUE	0x95A4F1E0
-#define OMAP_RTC_STATUS_BUSY	BIT(0)
-#define OMAP_RTC_MAX_READY_TIME	50
-
-/**
- * omap_rtc_wait_not_busy - Wait for the RTC BUSY flag
- * @oh: struct omap_hwmod *
- *
- * For updating certain RTC registers, the MPU must wait
- * for the BUSY status in OMAP_RTC_STATUS_REG to become zero.
- * Once the BUSY status is zero, there is a 15 microseconds access
- * period in which the MPU can program.
- */
-static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)
-{
-	int i;
-
-	/* BUSY may stay active for 1/32768 second (~30 usec) */
-	omap_test_timeout(omap_hwmod_read(oh, OMAP_RTC_STATUS_REG)
-			  & OMAP_RTC_STATUS_BUSY, OMAP_RTC_MAX_READY_TIME, i);
-	/* now we have ~15 microseconds to read/write various registers */
-}
-
-/**
- * omap_hwmod_rtc_unlock - Unlock the Kicker mechanism.
- * @oh: struct omap_hwmod *
- *
- * RTC IP have kicker feature. This prevents spurious writes to its registers.
- * In order to write into any of the RTC registers, KICK values has te be
- * written in respective KICK registers. This is needed for hwmod to write into
- * sysconfig register.
- */
-void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	omap_rtc_wait_not_busy(oh);
-	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
-	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
-	local_irq_restore(flags);
-}
-
-/**
- * omap_hwmod_rtc_lock - Lock the Kicker mechanism.
- * @oh: struct omap_hwmod *
- *
- * RTC IP have kicker feature. This prevents spurious writes to its registers.
- * Once the RTC registers are written, KICK mechanism needs to be locked,
- * in order to prevent any spurious writes. This function locks back the RTC
- * registers once hwmod completes its write into sysconfig register.
- */
-void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	omap_rtc_wait_not_busy(oh);
-	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
-	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
-	local_irq_restore(flags);
-}
-- 
2.29.2


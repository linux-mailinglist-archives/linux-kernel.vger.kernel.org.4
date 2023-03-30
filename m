Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850376CFB42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjC3GJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjC3GJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:09:35 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898A40C8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:09:33 -0700 (PDT)
X-UUID: 033a14a9cd8241bb9dfdbc7bef98356a-20230330
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ebafa566-ce38-4805-b97e-5c459c92663f,IP:5,U
        RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:ebafa566-ce38-4805-b97e-5c459c92663f,IP:5,URL
        :0,TC:0,Content:-25,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:491df029-564d-42d9-9875-7c868ee415ec,B
        ulkID:230330140918KLMIUS1O,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 033a14a9cd8241bb9dfdbc7bef98356a-20230330
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 39918076; Thu, 30 Mar 2023 14:09:17 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        jgg@ziepe.ca, akrowiak@linux.ibm.com, arnd@arndb.de,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        alex.gaynor@gmail.com, me@kloenk.de, gregkh@linuxfoundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, gehao618@163.com,
        Hao Ge <gehao@kylinos.cn>
Subject: [RESEND PATCH] kmemleak-test: Optimize kmemleak_test.c build flow
Date:   Thu, 30 Mar 2023 14:09:04 +0800
Message-Id: <20230330060904.292975-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now kmemleak-test.c is moved to samples directory,
if CONFIG_DEBUG_KMEMLEAK_TEST=m,but CONFIG_SAMPLES
is not set,it will be meaningless.

So we will remove CONFIG_DEBUG_KMEMLEAK_TEST and
add CONFIG_SAMPLE_KMEMLEAK which in samples directory
to control kmemleak-test.c build or not

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/Kconfig.debug          | 8 --------
 samples/Kconfig           | 7 +++++++
 samples/Makefile          | 2 +-
 samples/kmemleak/Makefile | 2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index c3547a373c9c..fb86e9952bac 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -249,14 +249,6 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
 	  fully initialised, this memory pool acts as an emergency one
 	  if slab allocations fail.
 
-config DEBUG_KMEMLEAK_TEST
-	tristate "Simple test for the kernel memory leak detector"
-	depends on DEBUG_KMEMLEAK && m
-	help
-	  This option enables a module that explicitly leaks memory.
-
-	  If unsure, say N.
-
 config DEBUG_KMEMLEAK_DEFAULT_OFF
 	bool "Default kmemleak to off"
 	depends on DEBUG_KMEMLEAK
diff --git a/samples/Kconfig b/samples/Kconfig
index 30ef8bd48ba3..69076fbf3298 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -273,6 +273,13 @@ config SAMPLE_CORESIGHT_SYSCFG
 	  This demonstrates how a user may create their own CoreSight
 	  configurations and easily load them into the system at runtime.
 
+config SAMPLE_KMEMLEAK
+        tristate "Simple test for the kernel memory leak detector"
+        depends on DEBUG_KMEMLEAK && m
+        help
+          Build a sample program which have explicitly leaks memory to test
+          kmemleak
+
 source "samples/rust/Kconfig"
 
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 7cb632ef88ee..7727f1a0d6d1 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -33,7 +33,7 @@ subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
 obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
-obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
diff --git a/samples/kmemleak/Makefile b/samples/kmemleak/Makefile
index 16b6132c540c..8a999ab43b6d 100644
--- a/samples/kmemleak/Makefile
+++ b/samples/kmemleak/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
+obj-$(CONFIG_SAMPLE_KMEMLEAK) += kmemleak-test.o
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

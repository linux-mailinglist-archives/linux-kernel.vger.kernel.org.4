Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B566D5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjAQGBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjAQGAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:00:08 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487E2313B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 22:00:04 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 30H5xluX010533;
        Tue, 17 Jan 2023 13:59:47 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 17 Jan 2023 13:59:44 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH] mm: use stack_depot_early_init for kmemleak
Date:   Tue, 17 Jan 2023 13:59:29 +0800
Message-ID: <1673935169-30019-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 30H5xluX010533
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
Solve this by having stackdepot use stack_depot_early_init.

On 1/4/23 17:08, Mirsad Goran Todorovac wrote:
I hate to bring bad news again, but there seems to be a problem with the output of /sys/kernel/debug/kmemleak:

[root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff951c118568b0 (size 16):
comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
    hex dump (first 16 bytes):
      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
    backtrace:
 [root@pc-mtodorov ~]#
   Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
 This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
 and 6.2-rc1 and 6.2-rc2 builds.
 This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
 from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
 Please find attached the config, lshw and kmemleak output.

reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 401ad4b..50cc9f5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -727,6 +727,7 @@ config DEBUG_KMEMLEAK
 	select KALLSYMS
 	select CRC32
 	select STACKDEPOT
+	select STACKDEPOT_ALWAYS_INIT
 	help
 	  Say Y here if you want to enable the memory leak
 	  detector. The memory allocation/freeing is traced in a way
-- 
1.9.1


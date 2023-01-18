Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079326710D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjARCJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjARCIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:08:35 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3A42DDD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:08:07 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 30I27vdA018004;
        Wed, 18 Jan 2023 10:07:57 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 18 Jan 2023 10:07:52 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCHv3] mm: use stack_depot_early_init for kmemleak
Date:   Wed, 18 Jan 2023 10:07:35 +0800
Message-ID: <1674007655-23016-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 30I27vdA018004
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
suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: use stack_depot_want_early_init instead of CONFIG_STACKDEPOT_ALWAYS_INIT
v3: have the Kconfig changes commited in another patch
---

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/kmemleak.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 762b91f..ddc1ddf 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -2070,8 +2070,10 @@ static int __init kmemleak_boot_config(char *str)
 		return -EINVAL;
 	if (strcmp(str, "off") == 0)
 		kmemleak_disable();
-	else if (strcmp(str, "on") == 0)
+	else if (strcmp(str, "on") == 0) {
 		kmemleak_skip_disable = 1;
+		stack_depot_want_early_init();
+	}
 	else
 		return -EINVAL;
 	return 0;
-- 
1.9.1


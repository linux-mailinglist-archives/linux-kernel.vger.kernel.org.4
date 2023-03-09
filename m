Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662556B1D46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCIIEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:04:33 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143560428;
        Thu,  9 Mar 2023 00:04:32 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PXMCT4jY1zKmXP;
        Thu,  9 Mar 2023 16:04:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 16:04:29 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Fix invalid address access in lookup_rec() when index is 0
Date:   Thu, 9 Mar 2023 16:02:30 +0800
Message-ID: <20230309080230.36064-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported follow problem:

 BUG: KASAN: use-after-free in lookup_rec
 Read of size 8 at addr ffff000199270ff0 by task modprobe
 CPU: 2 Comm: modprobe
 Call trace:
  kasan_report
  __asan_load8
  lookup_rec
  ftrace_location
  arch_check_ftrace_location
  check_kprobe_address_safe
  register_kprobe

When checking pg->records[pg->index - 1].ip in lookup_rec(), it can get a
pg which is newly added to ftrace_pages_start in ftrace_process_locs().
Before the first pg->index++, index is 0 and accessing pg->records[-1].ip
will cause this problem.

Don't check the ip when pg->index is 0.

Fixes: 9644302e3315 ("ftrace: Speed up search by skipping pages by address")
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..9b2803c7a18f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1564,7 +1564,8 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
 	for (pg = ftrace_pages_start; pg; pg = pg->next) {
-		if (end < pg->records[0].ip ||
+		if (pg->index == 0 ||
+		    end < pg->records[0].ip ||
 		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
 			continue;
 		rec = bsearch(&key, pg->records, pg->index,
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BF6DC27F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDJCBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDJCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:01:47 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED6E3590
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:01:44 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 33A1xiga063929;
        Mon, 10 Apr 2023 09:59:44 +0800 (+08)
        (envelope-from Xiaosong.Ma@unisoc.com)
Received: from bj10638pcu1.spreadtrum.com (10.0.74.32) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 10 Apr 2023 09:59:41 +0800
From:   "xiaosong.ma" <Xiaosong.Ma@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <yuming.han@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH V2] fs: perform the check when page without mapping but page->mapping contains junk or random bitscribble
Date:   Mon, 10 Apr 2023 09:45:02 +0800
Message-ID: <1681091102-31907-1-git-send-email-Xiaosong.Ma@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.32]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 33A1xiga063929
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perform the check in dump_mapping() to print warning info and avoid crash with invalid non-NULL page->mapping.
For example, a panic with following backtraces show dump_page will show wrong info and panic when the bad page
is non-NULL mapping and page->mapping is 0x80000000000.

    crash_arm64> bt
    PID: 232    TASK: ffffff80e8c2c340  CPU: 0   COMMAND: "Binder:232_2"
     #0 [ffffffc013e5b080] sysdump_panic_event$b2bce43a479f4f7762201bfee02d7889 at ffffffc0108d7c2c
     #1 [ffffffc013e5b0c0] atomic_notifier_call_chain at ffffffc010300228
     #2 [ffffffc013e5b2c0] panic at ffffffc0102c926c
     #3 [ffffffc013e5b370] die at ffffffc010267670
     #4 [ffffffc013e5b3a0] die_kernel_fault at ffffffc0102808a4
     #5 [ffffffc013e5b3d0] __do_kernel_fault at ffffffc010280820
     #6 [ffffffc013e5b410] do_bad_area at ffffffc01028059c
     #7 [ffffffc013e5b440] do_translation_fault$4df5decbea5d08a63349aa36f07426b2 at ffffffc0111149c8
     #8 [ffffffc013e5b470] do_mem_abort at ffffffc0100a4488
     #9 [ffffffc013e5b5e0] el1_ia at ffffffc0100a6c00
     #10 [ffffffc013e5b5f0] __dump_page at ffffffc0104beecc
     #11 [ffffffc013e5b630] bad_page at ffffffc0104e6ffc
     #12 [ffffffc013e5b820] rmqueue_bulk at ffffffc0104e9128
     #13 [ffffffc013e5b950] rmqueue at ffffffc0104e7c3c
     #14 [ffffffc013e5b9c0] get_page_from_freelist at ffffffc0104e3e3c
     #15 [ffffffc013e5ba50] __alloc_pages_nodemask at ffffffc0104e3a7c
     #16 [ffffffc013e5bac0] pagecache_get_page at ffffffc01047d0e4
     #17 [ffffffc013e5bb20] grab_cache_page_write_begin at ffffffc010480e3c
     #18 [ffffffc013e5bb50] block_write_begin at ffffffc010586204
     #19 [ffffffc013e5bb90] blkdev_write_begin$75b353f60767e771433fc3b19ba260ab at ffffffc01058cc48
     #20 [ffffffc013e5bc00] generic_perform_write at ffffffc010480f1c
     #21 [ffffffc013e5bc60] __generic_file_write_iter at ffffffc01048115c
     #22 [ffffffc013e5bcf0] blkdev_write_iter at ffffffc01058c0a8
     #23 [ffffffc013e5bda0] __vfs_write at ffffffc01052d808
     #24 [ffffffc013e5bdd0] vfs_write at ffffffc01052da5c
     #25 [ffffffc013e5be30] __arm64_sys_pwrite64 at ffffffc01052e09c
     #26 [ffffffc013e5be60] el0_svc_common at ffffffc010272224
     #27 [ffffffc013e5bea0] el0_svc_handler at ffffffc010272148
     #28 [ffffffc013e5bff0] el0_svc at ffffffc0100a7ec4

Signed-off-by: xiaosong.ma <Xiaosong.Ma@unisoc.com>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index f453eb5..c9021e5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -564,7 +564,8 @@ void dump_mapping(const struct address_space *mapping)
 	 * If mapping is an invalid pointer, we don't want to crash
 	 * accessing it, so probe everything depending on it carefully.
 	 */
-	if (get_kernel_nofault(host, &mapping->host) ||
+	if (get_kernel_nofault(mapping, &mapping) ||
+	    get_kernel_nofault(host, &mapping->host) ||
 	    get_kernel_nofault(a_ops, &mapping->a_ops)) {
 		pr_warn("invalid mapping:%px\n", mapping);
 		return;
-- 
1.9.1


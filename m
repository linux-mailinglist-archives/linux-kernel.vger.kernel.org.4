Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975846D5832
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjDDFuz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 01:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDDFuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:50:54 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7851FD7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:50:45 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 3345oEnN057348;
        Tue, 4 Apr 2023 13:50:14 +0800 (+08)
        (envelope-from Xiaosong.Ma@unisoc.com)
Received: from bj10638pcu1.spreadtrum.com (10.0.74.28) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 4 Apr 2023 13:50:12 +0800
From:   "xiaosong.ma" <Xiaosong.Ma@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: check mapping addr is correct when dump page
Date:   Tue, 4 Apr 2023 13:50:25 +0800
Message-ID: <1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.28]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 3345oEnN057348
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when we debug with slub_debug_on, the following backtraces show dump_page
will show wrong info when the bad page is non-NULL mapping and page->mapping
is 0x80000000000 so do virt_addr valid check is needed when dump mapping page.

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
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 7f8e5f7..da61172 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -109,7 +109,7 @@ static void __dump_page(struct page *page)
                type = "ksm ";
        else if (PageAnon(page))
                type = "anon ";
-       else if (mapping)
+       else if (mapping && virt_addr_valid(mapping))
                dump_mapping(mapping);
        BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);

--
1.9.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。

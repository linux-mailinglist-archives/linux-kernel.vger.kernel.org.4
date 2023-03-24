Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA96C7E43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXMrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:47:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCB1C591;
        Fri, 24 Mar 2023 05:47:38 -0700 (PDT)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pjhm93H8nzrSQh;
        Fri, 24 Mar 2023 20:46:33 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 20:47:36 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] ring-buffer: Fix race while reader and writer are on the same page
Date:   Fri, 24 Mar 2023 20:50:37 +0800
Message-ID: <20230324125037.2719020-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user reads file 'trace_pipe', kernel keeps printing following logs
that warn at "cpu_buffer->reader_page->read > rb_page_size(reader)".
It just looks like there's an infinite loop in tracing_read_pipe().
This problem occurs several times on arm64 when testing v5.10 and below.

  Call trace:
   rb_get_reader_page+0x248/0x1300
   rb_buffer_peek+0x34/0x160
   ring_buffer_peek+0xbc/0x224
   peek_next_entry+0x98/0xbc
   __find_next_entry+0xc4/0x1c0
   trace_find_next_entry_inc+0x30/0x94
   tracing_read_pipe+0x198/0x304
   vfs_read+0xb4/0x1e0
   ksys_read+0x74/0x100
   __arm64_sys_read+0x24/0x30
   el0_svc_common.constprop.0+0x7c/0x1bc
   do_el0_svc+0x2c/0x94
   el0_svc+0x20/0x30
   el0_sync_handler+0xb0/0xb4
   el0_sync+0x160/0x180

Then I dump the vmcore and look into the problematic per_cpu ring_buffer,
I found that tail_page/commit_page/reader_page are on the same page while
reader_page->read is obviously abnormal:
  tail_page == commit_page == reader_page == {
    .write = 0x100d20,
    .read = 0x8f9f4805,  // Far greater than 0xd20, obviously abnormal!!!
    .entries = 0x10004c,
    .real_end = 0x0,
    .page = {
      .time_stamp = 0x857257416af0,
      .commit = 0xd20,  // This page hasn't been full filled.
      // .data[0...0xd20] seems normal
    }
 }

The root cause is most likely the race that reader and writer are on the
same page while reader saw an event that not fully committed by writer.

To fix this, add memory barriers to make sure that reader can see every
completely committed event. Since commit a0fcaaed0c46 ("ring-buffer: Fix
race between reset page and reading page") has added the read barrier in
rb_get_reader_page(), here we just need to add the write barrier.

Fixes: 77ae365eca89 ("ring-buffer: make lockless")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ring_buffer.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c6f47b6cfd5f..79fd5e10ee05 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2942,6 +2942,13 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 		event->array[0] = length;
 	} else
 		event->type_len = DIV_ROUND_UP(length, RB_ALIGNMENT);
+
+	/*
+	 * The 'event' may be reserved from the page which is reading
+	 * by reader, make sure 'event' is completely updated before
+	 * reader_page->page->commit being set.
+	 */
+	smp_wmb();
 }
 
 static unsigned rb_calculate_event_length(unsigned length)
@@ -4684,7 +4691,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 
 	/*
 	 * Make sure we see any padding after the write update
-	 * (see rb_reset_tail())
+	 * (see rb_reset_tail()).
+	 *
+	 * In addition, writer may be writing on the reader page
+	 * if the page has not been fully filled, so the read barrier
+	 * is also needed to make sure we see the completely updated
+	 * event that reserved by writer (see rb_update_event()).
 	 */
 	smp_rmb();
 
-- 
2.25.1


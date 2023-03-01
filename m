Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47366A66B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCADpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCADpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:45:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFA2CFEA;
        Tue, 28 Feb 2023 19:44:38 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PRKn30lK4z9tPk;
        Wed,  1 Mar 2023 11:42:31 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 11:44:30 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [RFC PATCH] tracing/ring-buffer: Drop inappropriate WARN in rb_set_head_page()
Date:   Wed, 1 Mar 2023 11:47:02 +0800
Message-ID: <20230301034702.3449755-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following WARNING appears several times during test on v5.10 but
mainline kernel should have the same problem. However I currently
can't find the reproduction method.

WARNING: CPU: 29 PID: 686834 at kernel/trace/ring_buffer.c:1357
           rb_set_head_page+0x168/0x264
Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/trace/ring_buffer.c?h=linux-5.10.y#n1357
Call trace:
 rb_set_head_page+0x168/0x264
 rb_per_cpu_empty+0x34/0x15c
 ring_buffer_empty_cpu.part.0.isra.0+0x1a4/0x3f0
 ring_buffer_empty_cpu+0x74/0xb4
 __find_next_entry+0x14c/0x2f4
 trace_find_next_entry_inc+0x48/0x13c
 tracing_read_pipe+0x2c8/0x6b4
 vfs_read+0x144/0x324
 ksys_read+0x104/0x220
 __arm64_sys_read+0x54/0x70
 el0_svc_common.constprop.0+0xd8/0x37c
 do_el0_svc+0x50/0x120
 el0_svc+0x24/0x3c
 el0_sync_handler+0x17c/0x180
 el0_sync+0x160/0x180

The WARNING appears because rb_set_head_page() didn't grab the header
after three loops traversing buffer pages. This was not considered
to be expected, as comment said, writer possibly moves the header in
one loop.

However, supposing writer keeps moving the header, we may miss more
loops and it seems normal not to grab the header within three loops
in rb_set_head_page(). Therefore drop that RB_WARN_ON().

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ring_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..cbfa306570d3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1471,9 +1471,7 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	page = head = cpu_buffer->head_page;
 	/*
 	 * It is possible that the writer moves the header behind
-	 * where we started, and we miss in one loop.
-	 * A second loop should grab the header, but we'll do
-	 * three loops just because I'm paranoid.
+	 * where we started, so we try three loops to grab the header.
 	 */
 	for (i = 0; i < 3; i++) {
 		do {
@@ -1485,8 +1483,6 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 		} while (page != head);
 	}
 
-	RB_WARN_ON(cpu_buffer, 1);
-
 	return NULL;
 }
 
-- 
2.25.1


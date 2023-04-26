Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8311C6EF924
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjDZRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjDZRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73486525D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D1963049
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623EBC433D2;
        Wed, 26 Apr 2023 17:17:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim5-005KXf-1H;
        Wed, 26 Apr 2023 13:17:49 -0400
Message-ID: <20230426171749.213807197@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-next][PATCH 01/11] ring-buffer: Clearly check null ptr returned by rb_set_head_page()
References: <20230426171703.202523909@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

In error case, 'buffer_page' returned by rb_set_head_page() is NULL,
currently check '&buffer_page->list' is equivalent to check 'buffer_page'
due to 'list' is the first member of 'buffer_page', but suppose it is not
some time, 'head_page' would be wild memory while check would be bypassed.

Link: https://lore.kernel.org/linux-trace-kernel/20230414071729.57312-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2d5c3caff32d..58be5b409f72 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2054,10 +2054,11 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 		struct list_head *head_page, *prev_page, *r;
 		struct list_head *last_page, *first_page;
 		struct list_head *head_page_with_bit;
+		struct buffer_page *hpage = rb_set_head_page(cpu_buffer);
 
-		head_page = &rb_set_head_page(cpu_buffer)->list;
-		if (!head_page)
+		if (!hpage)
 			break;
+		head_page = &hpage->list;
 		prev_page = head_page->prev;
 
 		first_page = pages->next;
-- 
2.39.2

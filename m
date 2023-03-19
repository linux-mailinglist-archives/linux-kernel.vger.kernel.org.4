Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394F56C0346
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCSQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E0C1E9FC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 579F261137
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34220C433B3;
        Sun, 19 Mar 2023 16:47:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pdwCD-000Ja5-0z;
        Sun, 19 Mar 2023 12:47:49 -0400
Message-ID: <20230319164749.115087761@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 19 Mar 2023 12:46:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [for-linus][PATCH 7/8] ring-buffer: remove obsolete comment for free_buffer_page()
References: <20230319164643.513018619@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

The comment refers to mm/slob.c which is being removed. It comes from
commit ed56829cb319 ("ring_buffer: reset buffer page when freeing") and
according to Steven the borrowed code was a page mapcount and mapping
reset, which was later removed by commit e4c2ce82ca27 ("ring_buffer:
allocate buffer page pointer"). Thus the comment is not accurate anyway,
remove it.

Link: https://lore.kernel.org/linux-trace-kernel/20230315142446.27040-1-vbabka@suse.cz

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Reported-by: Mike Rapoport <mike.rapoport@gmail.com>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Fixes: e4c2ce82ca27 ("ring_buffer: allocate buffer page pointer")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 071184324d18..3c7cd135333f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -354,10 +354,6 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
-/*
- * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
- * this issue out.
- */
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
-- 
2.39.1

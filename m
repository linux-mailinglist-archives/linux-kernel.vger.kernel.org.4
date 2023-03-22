Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595C6C53F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCVSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185C23A75
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA3962284
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F1CC433EF;
        Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qt-000pbL-2O;
        Wed, 22 Mar 2023 14:43:35 -0400
Message-ID: <20230322184335.558195206@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [for-next][PATCH 10/11] ring_buffer: Use try_cmpxchg instead of cmpxchg
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Link: https://lkml.kernel.org/r/20230305155532.5549-4-ubizjak@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93f854433d89..2d5c3caff32d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4057,10 +4057,10 @@ void ring_buffer_record_off(struct trace_buffer *buffer)
 	unsigned int rd;
 	unsigned int new_rd;
 
+	rd = atomic_read(&buffer->record_disabled);
 	do {
-		rd = atomic_read(&buffer->record_disabled);
 		new_rd = rd | RB_BUFFER_OFF;
-	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
+	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_off);
 
@@ -4080,10 +4080,10 @@ void ring_buffer_record_on(struct trace_buffer *buffer)
 	unsigned int rd;
 	unsigned int new_rd;
 
+	rd = atomic_read(&buffer->record_disabled);
 	do {
-		rd = atomic_read(&buffer->record_disabled);
 		new_rd = rd & ~RB_BUFFER_OFF;
-	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
+	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_on);
 
-- 
2.39.1

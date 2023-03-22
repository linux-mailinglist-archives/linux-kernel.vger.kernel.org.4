Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84F6C53F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCVSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FA9298D6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C8B6227E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF96C433A1;
        Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qt-000paE-14;
        Wed, 22 Mar 2023 14:43:35 -0400
Message-ID: <20230322184335.149101791@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [for-next][PATCH 08/11] ring_buffer: Change some static functions to void
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

The results of some static functions are not used. Change the
type of these function to void and remove unnecessary returns.

No functional change intended.

Link: https://lkml.kernel.org/r/20230305155532.5549-2-ubizjak@gmail.com

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c6f47b6cfd5f..b45915dd67b9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1565,15 +1565,12 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 }
 
-static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
+static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 			  struct buffer_page *bpage)
 {
 	unsigned long val = (unsigned long)bpage;
 
-	if (RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK))
-		return 1;
-
-	return 0;
+	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
 /**
@@ -1583,30 +1580,28 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
  */
-static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
+static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *head = rb_list_head(cpu_buffer->pages);
 	struct list_head *tmp;
 
 	if (RB_WARN_ON(cpu_buffer,
 			rb_list_head(rb_list_head(head->next)->prev) != head))
-		return -1;
+		return;
 
 	if (RB_WARN_ON(cpu_buffer,
 			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return -1;
+		return;
 
 	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
 		if (RB_WARN_ON(cpu_buffer,
 				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return -1;
+			return;
 
 		if (RB_WARN_ON(cpu_buffer,
 				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return -1;
+			return;
 	}
-
-	return 0;
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
@@ -4496,7 +4491,6 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 	default:
 		RB_WARN_ON(cpu_buffer, 1);
 	}
-	return;
 }
 
 static void
@@ -4527,7 +4521,6 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 	default:
 		RB_WARN_ON(iter->cpu_buffer, 1);
 	}
-	return;
 }
 
 static struct buffer_page *
@@ -4942,7 +4935,6 @@ rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
 {
 	if (likely(locked))
 		raw_spin_unlock(&cpu_buffer->reader_lock);
-	return;
 }
 
 /**
-- 
2.39.1

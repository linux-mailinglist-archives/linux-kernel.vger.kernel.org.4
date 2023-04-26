Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DF6EF928
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjDZRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjDZRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523BF65B7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78C8863049
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C11C4339E;
        Wed, 26 Apr 2023 17:17:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim7-005KdF-1Q;
        Wed, 26 Apr 2023 13:17:51 -0400
Message-ID: <20230426171751.250610496@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ken Lin <lyenting@google.com>
Subject: [for-next][PATCH 11/11] tracing: Add missing spaces in trace_print_hex_seq()
References: <20230426171703.202523909@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ken Lin <lyenting@google.com>

If the buffer length is larger than 16 and concatenate is set to false,
there would be missing spaces every 16 bytes.
Example:
  Before: c5 11 10 50 05 4d 31 40 00 40 00 40 00 4d 31 4000 40 00
  After:  c5 11 10 50 05 4d 31 40 00 40 00 40 00 4d 31 40 00 40 00

Link: https://lore.kernel.org/linux-trace-kernel/20230426032257.3157247-1-lyenting@google.com

Signed-off-by: Ken Lin <lyenting@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 952cc8aa8e59..15f05faaae44 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -221,8 +221,11 @@ trace_print_hex_seq(struct trace_seq *p, const unsigned char *buf, int buf_len,
 	const char *ret = trace_seq_buffer_ptr(p);
 	const char *fmt = concatenate ? "%*phN" : "%*ph";
 
-	for (i = 0; i < buf_len; i += 16)
+	for (i = 0; i < buf_len; i += 16) {
+		if (!concatenate && i != 0)
+			trace_seq_putc(p, ' ');
 		trace_seq_printf(p, fmt, min(buf_len - i, 16), &buf[i]);
+	}
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.39.2

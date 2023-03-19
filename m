Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878AC6C034A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCSQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCSQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:47:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD71E9E2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8DBDACE0F6E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD19BC433AC;
        Sun, 19 Mar 2023 16:47:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pdwCC-000JYx-2r;
        Sun, 19 Mar 2023 12:47:48 -0400
Message-ID: <20230319164748.701864960@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 19 Mar 2023 12:46:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>
Subject: [for-linus][PATCH 5/8] ftrace: Set direct_ops storage-class-specifier to static
References: <20230319164643.513018619@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

smatch reports this warning
kernel/trace/ftrace.c:2594:19: warning:
  symbol 'direct_ops' was not declared. Should it be static?

The variable direct_ops is only used in ftrace.c, so it should be static

Link: https://lore.kernel.org/linux-trace-kernel/20230311135113.711824-1-trix@redhat.com

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a47f7d93e32d..ec2897a76004 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2503,7 +2503,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 	arch_ftrace_set_direct_caller(fregs, addr);
 }
 
-struct ftrace_ops direct_ops = {
+static struct ftrace_ops direct_ops = {
 	.func		= call_direct_funcs,
 	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
-- 
2.39.1

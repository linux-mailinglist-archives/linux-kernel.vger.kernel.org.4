Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC0648608
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiLIP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiLIP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:56:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D4520F41;
        Fri,  9 Dec 2022 07:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCED7B82896;
        Fri,  9 Dec 2022 15:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F96C433D2;
        Fri,  9 Dec 2022 15:56:41 +0000 (UTC)
Date:   Fri, 9 Dec 2022 10:56:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ftrace: Fix print_ip_ins() to print only two digits per
 byte
Message-ID: <20221209105640.6d5eda0e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Fix print_ip_ins() to use unsigned char, as:

	e9:2b:b6:0d:18

is easier to understand than

	ffffffe9:2b:ffffffb6:0d:18

Link: https://lore.kernel.org/all/CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: 6c14133d2d3f7 ("ftrace: Do not blindly read the ip address in ftrace_bug()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d04552c0c275..32fc1600d596 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2028,7 +2028,7 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 
 static void print_ip_ins(const char *fmt, const unsigned char *p)
 {
-	char ins[MCOUNT_INSN_SIZE];
+	unsigned char ins[MCOUNT_INSN_SIZE];
 
 	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
 		printk(KERN_CONT "%s[FAULT] %px\n", fmt, p);
-- 
2.35.1


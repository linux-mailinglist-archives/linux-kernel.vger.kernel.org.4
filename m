Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAD648F02
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLJN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AC16599
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3998D60C13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D09C433B4;
        Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40My-000koq-2R;
        Sat, 10 Dec 2022 08:58:24 -0500
Message-ID: <20221210135824.622690768@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Chen <chensong_2000@189.cn>
Subject: [for-next][PATCH 09/25] trace/kprobe: remove duplicated calls of ring_buffer_event_data
References: <20221210135750.425719934@goodmis.org>
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

From: Song Chen <chensong_2000@189.cn>

Function __kprobe_trace_func calls ring_buffer_event_data to
get a ring buffer, however, it has been done in above call
trace_event_buffer_reserve. So does __kretprobe_trace_func.

This patch removes those duplicated calls.

Link: https://lore.kernel.org/all/1666145478-4706-1-git-send-email-chensong_2000@189.cn/

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5a75b039e586..ee77c8203bd5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1344,7 +1344,6 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 		return;
 
 	fbuffer.regs = regs;
-	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
@@ -1385,7 +1384,6 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		return;
 
 	fbuffer.regs = regs;
-	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = get_kretprobe_retaddr(ri);
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
-- 
2.35.1



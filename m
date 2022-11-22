Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6537063494E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiKVVcf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Nov 2022 16:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiKVVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:32:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA74B79
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF583B81DBD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E12C433C1;
        Tue, 22 Nov 2022 21:32:27 +0000 (UTC)
Date:   Tue, 22 Nov 2022 16:32:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid replacing the list func with itself
Message-ID: <20221122163225.76a19e1d@gandalf.local.home>
In-Reply-To: <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com>
References: <20221026132039.2236233-1-suagrfillet@gmail.com>
        <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 02:28:25 +0000
Song Shuai <suagrfillet@gmail.com> wrote:

> Song Shuai <suagrfillet@gmail.com> 于2022年10月26日周三 13:20写道：
> >
> > The list func (ftrace_ops_list_func) will be patched first
> > before the transition between old and new calls are set,
> > which fixed the race described in this commit `59338f75`.
> >
> > While ftrace_trace_function changes from the list func to a
> > ftrace_ops func, like unregistering the klp_ops to leave the only
> > global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
> > replaced with the list func although it already exists. So there
> > should be a condition to avoid this.
> >
> > This patch backups saved_ftrace_func by saved_ftrace_func_old
> > which will be compared with the list func before trying to patch it.
> >  
> Ping...

Wouldn't something like this be simpler and easier to manage (without
adding another variable to keep track of)?

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65a5d36463e0..d04552c0c275 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2763,6 +2763,19 @@ void __weak ftrace_arch_code_modify_post_process(void)
 {
 }
 
+static int update_ftrace_func(ftrace_func_t func)
+{
+	static ftrace_func_t save_func;
+
+	/* Avoid updating if it hasn't changed */
+	if (func == save_func)
+		return 0;
+
+	save_func = func;
+
+	return ftrace_update_ftrace_func(func);
+}
+
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
@@ -2783,7 +2796,7 @@ void ftrace_modify_all_code(int command)
 	 * traced.
 	 */
 	if (update) {
-		err = ftrace_update_ftrace_func(ftrace_ops_list_func);
+		err = update_ftrace_func(ftrace_ops_list_func);
 		if (FTRACE_WARN_ON(err))
 			return;
 	}
@@ -2799,7 +2812,7 @@ void ftrace_modify_all_code(int command)
 		/* If irqs are disabled, we are in stop machine */
 		if (!irqs_disabled())
 			smp_call_function(ftrace_sync_ipi, NULL, 1);
-		err = ftrace_update_ftrace_func(ftrace_trace_function);
+		err = update_ftrace_func(ftrace_trace_function);
 		if (FTRACE_WARN_ON(err))
 			return;
 	}

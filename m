Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6405D746099
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGCQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGCQS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC6138;
        Mon,  3 Jul 2023 09:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA12160F53;
        Mon,  3 Jul 2023 16:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D59DC433C7;
        Mon,  3 Jul 2023 16:18:25 +0000 (UTC)
Date:   Mon, 3 Jul 2023 12:18:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mateusz Stachyra <m.stachyra@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: Re: [PATCH] trace: fix null pointer dereference in
 tracing_err_log_open()
Message-ID: <20230703121823.5d96c1cb@gandalf.local.home>
In-Reply-To: <20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4>
References: <CGME20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4>
        <20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023 17:52:37 +0200
Mateusz Stachyra <m.stachyra@samsung.com> wrote:

> >From d6ef949d29b884dd77fe5e628dc71318de08868c Mon Sep 17 00:00:00 2001  
> From: Mateusz Stachyra <m.stachyra@samsung.com>
> Date: Mon, 3 Jul 2023 17:48:40 +0200
> Subject: [PATCH] trace: fix null pointer dereference in tracing_err_log_open()
> 
> Fix an issue in function 'tracing_err_log_open'.
> The function doesn't call 'seq_open' if file is opened only with
> write permissions, which results in 'file->private_data' being left at null.
> If we then use 'lseek' on that opened file, 'seq_lseek' dereferences
> 'file->private_data' in 'mutex_lock(&m->lock)', resulting in a Kernel panic.
> Writing to this node requires root privilages, therefore this bug
> has very little security impact.
> 
> Tracefs node: /sys/kernel/tracing/error_log
> 

Nice catch, but I recommend a different solution.


> Example Kernel panic:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
> Call trace:
>  mutex_lock+0x30/0x110
>  seq_lseek+0x34/0xb8
>  __arm64_sys_lseek+0x6c/0xb8
>  invoke_syscall+0x58/0x13c
>  el0_svc_common+0xc4/0x10c
>  do_el0_svc+0x24/0x98
>  el0_svc+0x24/0x88
>  el0t_64_sync_handler+0x84/0xe4
>  el0t_64_sync+0x1b4/0x1b8
> Code: d503201f aa0803e0 aa1f03e1 aa0103e9 (c8e97d02)
> ---[ end trace 561d1b49c12cf8a5 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> 
> Signed-off-by: Mateusz Stachyra <m.stachyra@samsung.com>
> ---
>  kernel/trace/trace.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5d2c5678b..bfa8e2d01 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8097,8 +8097,16 @@ static int tracing_err_log_open(struct inode *inode, struct file *file)
>  		return ret;
>  
>  	/* If this file was opened for write, then erase contents */
> -	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
> +	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
>  		clear_tracing_err_log(tr);
> +		ret = seq_open(file, &tracing_err_log_seq_ops);
> +		if (!ret) {
> +			struct seq_file *m = file->private_data;
> +			m->private = tr;
> +		} else {
> +			trace_array_put(tr);
> +		}
> +	}
>  
>  	if (file->f_mode & FMODE_READ) {
>  		ret = seq_open(file, &tracing_err_log_seq_ops);
> 
> base-commit: 1ef6663a587ba3e57dc5065a477db1c64481eedd

I believe this can be better fixed by:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64a4dde073ef..999b7c73e324 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8135,7 +8135,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek		= tracing_lseek,
 	.release        = tracing_err_log_release,
 };

as that tracing_lseek() is for this exact scenario.

Care to send a v2?

Thanks,

-- Steve

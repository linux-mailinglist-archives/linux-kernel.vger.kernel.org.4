Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9F61F41B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiKGNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiKGNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:17:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A6615C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11238B80DF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB42C433C1;
        Mon,  7 Nov 2022 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667827033;
        bh=tisMPvmQNILTB7LyB3EX0agbELSzq8kO29YbQ9xN0Jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IJDf4vhRTqNwvRn2xO+C0oA6M2BJBQNtVfvf34X/iDAxnbWeNBCX0ZZI6WOk7HTJM
         oSzU0vbvpXb3aHMcbakCvYJNpisj8K3rkrjROnKwDALVQcIuUvXHpjKxCJTh+S7OE5
         xKtgWA9pFz2SuSD7zxM7aw1S3WwoCziLxBjhmSyjasxVDkv4oDyvJBzSeSe5x73RJZ
         b62JZJCxFgfhsmA1sHhHqFcWGtbUZ8n6SBAQANN0n7G7nzV47aPMDPXxuyPJrah9NR
         fvWPDHnvICMvk2Smd49/Hx9bsOLIjhvNPj8c/hJ7gCzWv/6fWu/Fr18Q4vIXZ1EXBn
         5mIcSkcQcHWlw==
Date:   Mon, 7 Nov 2022 22:17:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     wangyufen <wangyufen@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>
Subject: Re: [PATCH v2] tracing: fix memory leak in tracing_read_pipe
Message-Id: <20221107221710.23d90a4cf74043a9b5f7d6fc@kernel.org>
In-Reply-To: <a5a79265-be08-0375-ad50-fbe568c7a769@huawei.com>
References: <1667819090-4643-1-git-send-email-wangyufen@huawei.com>
        <a5a79265-be08-0375-ad50-fbe568c7a769@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 19:45:04 +0800
wangyufen <wangyufen@huawei.com> wrote:

> 
> 在 2022/11/7 19:04, Wang Yufen 写道:
> > kmemleak reports this issue:
> >
> > unreferenced object 0xffff888105a18900 (size 128):
> >    comm "test_progs", pid 18933, jiffies 4336275356 (age 22801.766s)
> >    hex dump (first 32 bytes):
> >      25 73 00 90 81 88 ff ff 26 05 00 00 42 01 58 04  %s......&...B.X.
> >      03 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000560143a1>] __kmalloc_node_track_caller+0x4a/0x140
> >      [<000000006af00822>] krealloc+0x8d/0xf0
> >      [<00000000c309be6a>] trace_iter_expand_format+0x99/0x150
> >      [<000000005a53bdb6>] trace_check_vprintf+0x1e0/0x11d0
> >      [<0000000065629d9d>] trace_event_printf+0xb6/0xf0
> >      [<000000009a690dc7>] trace_raw_output_bpf_trace_printk+0x89/0xc0
> >      [<00000000d22db172>] print_trace_line+0x73c/0x1480
> >      [<00000000cdba76ba>] tracing_read_pipe+0x45c/0x9f0
> >      [<0000000015b58459>] vfs_read+0x17b/0x7c0
> >      [<000000004aeee8ed>] ksys_read+0xed/0x1c0
> >      [<0000000063d3d898>] do_syscall_64+0x3b/0x90
> >      [<00000000a06dda7f>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > iter->fmt alloced in
> >    tracing_read_pipe() -> .. ->trace_iter_expand_format(), but not
> > freed, to fix, add free in tracing_release_pipe()
> Fixes: efbbdaa22bb7 ("tracing: Show real address for trace event arguments")

Oops, good catch!

Cc: stable@vger.kernel.org

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> > Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> > ---
> > v1 -> v2: del if (iter->fmt), free iter->fmt directly
> >   kernel/trace/trace.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 47a44b0..f9d98e7 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6657,6 +6657,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
> >   	mutex_unlock(&trace_types_lock);
> >   
> >   	free_cpumask_var(iter->started);
> > +	kfree(iter->fmt);
> >   	mutex_destroy(&iter->mutex);
> >   	kfree(iter);
> >   


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

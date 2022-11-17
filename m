Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523FC62E812
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKQWRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbiKQWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:17:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763278D55
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:17:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97D9BB821FA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98FBC433D6;
        Thu, 17 Nov 2022 22:17:31 +0000 (UTC)
Date:   Thu, 17 Nov 2022 17:17:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix null pointer dereference in
 ftrace_add_mod()
Message-ID: <20221117171730.023c8472@gandalf.local.home>
In-Reply-To: <20221116015207.30858-1-xiujianfeng@huawei.com>
References: <20221116015207.30858-1-xiujianfeng@huawei.com>
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

On Wed, 16 Nov 2022 09:52:07 +0800
Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> The @ftrace_mod is allocated by kzalloc(), so both the members {prev,next}
> of @ftrace_mode->list are NULL, it's not a valid state to call list_del().
> If kstrdup() for @ftrace_mod->{func|module} fails, it goes to @out_free
> tag and calls free_ftrace_mod() to destroy @ftrace_mod, then list_del()
> will write prev->next and next->prev, where null pointer dereference
> happens.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> Oops: 0002 [#1] PREEMPT SMP NOPTI
> Call Trace:
>  <TASK>
>  ftrace_mod_callback+0x20d/0x220
>  ? do_filp_open+0xd9/0x140
>  ftrace_process_regex.isra.51+0xbf/0x130
>  ftrace_regex_write.isra.52.part.53+0x6e/0x90
>  vfs_write+0xee/0x3a0
>  ? __audit_filter_op+0xb1/0x100
>  ? auditd_test_task+0x38/0x50
>  ksys_write+0xa5/0xe0
>  do_syscall_64+0x3a/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Kernel panic - not syncing: Fatal exception
> 
> So call INIT_LIST_HEAD() to initialize the list member to fix this issue.
> 
> Fixes: 673feb9d76ab ("ftrace: Add :mod: caching infrastructure to trace_array")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---


Queued. Thanks Xiu!

-- Steve

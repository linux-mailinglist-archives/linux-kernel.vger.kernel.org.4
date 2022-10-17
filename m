Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C3600788
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJQHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJQHSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:18:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266B59734
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BEE9B80E85
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6CDC433D6;
        Mon, 17 Oct 2022 07:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665991118;
        bh=t97qEput9rfKGvHu4kWBwBSatUl9dKUty9GkQ0q1PKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7ch1MZa8dy92gpY38Ymd54KV8aq1PT9cViY1j/Hu7ehloG8boDlSMmSQbd/Pcf6s
         9qMs1wHZGtrQUwIB7jsT1vM/a15qmUAyG1XNUExXcTzK8LF9JU+wrBC3wEOXGSfJ7l
         jq5Xxkrwu3oLTuZj/yHuJHj/zBycHkpgC72a04Xol7FHuFNkkudFWuhgzX2zX0XmmI
         +U6SQHzuSoskbGMbtUyXT4MI2csKNnrzo5BhTpRi8k7zfVZkJOvE22dPpCPYP4WDqA
         Vdyl98/GWTClbDFZfOqKwi0UWjmSbjJdRe9+R2bAkUQpbOyo6k3UZ8vPErIn7kJzer
         hba/DNCqOhJZw==
Date:   Mon, 17 Oct 2022 09:18:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        ebiederm@xmission.com, luto@kernel.org, bigeasy@linutronix.de,
        Liam.Howlett@Oracle.com, fenghua.yu@intel.com,
        peterz@infradead.org, viro@zeniv.linux.org.uk, jannh@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_process(): fix a memleak in copy_process()
Message-ID: <20221017071832.yy7oyhatdszlg3l2@wittgenstein>
References: <20221017063406.604188-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221017063406.604188-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:34:06PM +0800, Gaosheng Cui wrote:
> If CLONE_PIDFD is set in clone_flags, pidfile will hold the reference
> count of pid by getpid(pid), In the error path bad_fork_put_pidfd, the
> reference of pid needs to be released, otherwise there will be a
> memleak issue, fix it.
> 
> unreferenced object 0xffff888164aed400 (size 224):
>   comm "sh", pid 75274, jiffies 4295717290 (age 2955.536s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
>     ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
>   backtrace:
>     [<00000000bcb9eebb>] kmem_cache_alloc+0x16a/0x7f0
>     [<00000000340cf9ad>] alloc_pid+0xc5/0xce0
>     [<000000002387362c>] copy_process+0x29ef/0x6c90
>     [<00000000bf7d7efc>] kernel_clone+0xd9/0xc70
>     [<0000000047b1a04f>] __do_sys_clone+0xe1/0x120
>     [<0000000000f1aa25>] __x64_sys_clone+0xc3/0x150
>     [<00000000250a19f1>] do_syscall_64+0x5c/0x90
>     [<000000007e0ac417>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 08969f5aa38d..8706c06be8af 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2499,6 +2499,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	cgroup_cancel_fork(p, args);
>  bad_fork_put_pidfd:
>  	if (clone_flags & CLONE_PIDFD) {
> +		put_pid(pid);

This will be released during __fput() when ->release() ==
pidfd_release() is called so calling put_pid() here will result in UAF
later on. What syzbot instance does this report come from?

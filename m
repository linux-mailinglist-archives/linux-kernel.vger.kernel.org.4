Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935C6FFDA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbjELAHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D3B6EB7;
        Thu, 11 May 2023 17:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A1B652AF;
        Fri, 12 May 2023 00:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72334C433D2;
        Fri, 12 May 2023 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683850045;
        bh=uH+0ywap70mIlaz4NF+wlpWBdWo1veoSLZknjEZyHms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgGHc7GUb4827kTynUla5rMKEKhF4zhhVix7ecZuhabV3/ZoFgib4lR0hJlPOK2TH
         Ul/C8aXEDufVxNCqHn8UOYxMWy2HeKBtpYHO/xjeV+v+ifFqD0937c/5YcPhkkbe/P
         y3HqbUhTkI5z+I18bcLyuPDYSOvdVUoZJ43WXBFWQcdszIcR6tBh+epY4lWBm2zqPk
         QHJJh369+zvyCrjAGNTYPWhZBf5nxTTfGIvBG2THsh4HTuieeYvyf7c0i+rY7ziifq
         vUD4ve30bP45CmuXoXOeYRTWemobtYZj2q/EX318vpq1KNdAK1RfqWpEXHYsOSDBKN
         +e520SI1OgBbA==
Date:   Thu, 11 May 2023 17:07:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <20230512000724.GH858799@frogsfrogsfrogs>
References: <20230511151702.14704-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511151702.14704-1-tycho@tycho.pizza>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:17:02AM -0600, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> Similar to 5a8bee63b10f ("fuse: in fuse_flush only wait if someone wants
> the return code"), we have a task that is stuck that can't be killed, so a
> pid ns can't exit, wreaking all kinds of havoc:
> 
> INFO: task C2 CompilerThre:3546103 blocked for more than 1912 seconds.
>       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:C2 CompilerThre state:D stack:    0 pid:3546103 ppid:3546047 flags:0x00004222
> Call Trace:
>  <TASK>
>  __schedule+0x2c5/0x8d0
>  schedule+0x3a/0xa0
>  schedule_timeout+0x115/0x280
>  ? __schedule+0x2cd/0x8d0
>  wait_for_completion+0x9f/0x100
>  __flush_work+0x161/0x1f0
>  ? worker_detach_from_pool+0xb0/0xb0
>  destroy_inode+0x3b/0x70
>  __dentry_kill+0xcc/0x160
>  dput+0x141/0x2e0
>  ovl_destroy_inode+0x15/0x50 [overlay]
>  destroy_inode+0x3b/0x70
>  __dentry_kill+0xcc/0x160
>  dput+0x141/0x2e0
>  __fput+0xe1/0x250
>  task_work_run+0x73/0xb0
>  do_exit+0x37e/0xb80
>  do_group_exit+0x3a/0xa0
>  get_signal+0x140/0x870
>  ? perf_event_groups_first+0x80/0x80
>  arch_do_signal_or_restart+0xae/0x7c0
>  ? __x64_sys_futex+0x5e/0x1d0
>  ? __x64_sys_futex+0x5e/0x1d0
>  exit_to_user_mode_prepare+0x10f/0x1c0
>  syscall_exit_to_user_mode+0x26/0x40
>  do_syscall_64+0x46/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f3295cf3cf5
> RSP: 002b:00007f327c834d00 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007f32900bde50 RCX: 00007f3295cf3cf5
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f32900bde78
> RBP: 00007f327c834dd0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f32900bde74
> R13: 00007f32900bde78 R14: 00007f32900bde28 R15: 0000000000000000
>  </TASK>
> 
> The bad call path is:
> 
> xfs_fs_destroy_inode() ->
>   xfs_inode_mark_reclaimable ->
>     xfs_inodegc_queue() ->
>       xfs_inodegc_want_queue_work()
>       xfs_inodegc_want_flush_work() ->
>         flush_work() ->
>           __flush_work() ->
>             wait_for_completion()
> 
> We can avoid this task getting stuck by just not queuing the gc work from
> do_exit().
> 
> The fact that there's a lockup at all probably indicative of another xfs
> bug somewhere else that I am still looking for, but we should at least not
> generate unkillable tasks as a result.

Yeah, we just added a couple of fixpatches to 6.4 to deal with inodegc
hangs:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=03e0add80f4cf3f7393edb574eeb3a89a1db7758
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=2254a7396a0ca6309854948ee1c0a33fa4268cec

If you've got a spare machine and a reproducer, could you try applying
those two to see if the problem goes away?

If you have online fsck enabled (I hope not in a 5.15 kernel) then
turn it off or apply:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=2d5f38a31980d7090f5bf91021488dc61a0ba8ee

> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/xfs/xfs_icache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 351849fc18ff..90e94d84f8ad 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -2011,6 +2011,9 @@ xfs_inodegc_want_queue_work(
>   *
>   * Note: If the current thread is running a transaction, we don't ever want to
>   * wait for other transactions because that could introduce a deadlock.
> + * If the task is currently exiting there is nobody to wait for
> + * the flush and it can deadlock, so we should not try to flush in this case

What do you mean by "there is nobody to wait for"?  The process state
still exists in the kernel, so the completion should wake up the exiting
process, right?

--D

> + * either.
>   */
>  static inline bool
>  xfs_inodegc_want_flush_work(
> @@ -2021,6 +2024,9 @@ xfs_inodegc_want_flush_work(
>  	if (current->journal_info)
>  		return false;
>  
> +	if (current->flags & PF_EXITING)
> +		return false;
> +
>  	if (shrinker_hits > 0)
>  		return true;
>  
> 
> base-commit: 78b421b6a7c6dbb6a213877c742af52330f5026d
> -- 
> 2.34.1
> 

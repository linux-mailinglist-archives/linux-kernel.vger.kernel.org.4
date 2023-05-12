Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10C6FFE81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjELBpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjELBpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:45:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231B3AA5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:45:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf21bb42bso67231785ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683855952; x=1686447952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCg3T/vJ8MiMj+/j3ev3pgirr6NJ/cPm/C3qnowqYrc=;
        b=ShKwQ2YX/0wpfroqYl4bPqvg2Rpn4duoV6QSnY1EYnCLGB/O15wjeujsuu1c1QgvQr
         U372lCm9emANGLoTr95GZOiO2Pgbc9XCmUjWAp+x32B12cEzh1vIhi4i+XLg2ePEWSF6
         J0Ks+iRqFG2CsxgwUimsA0ZRZYWfcHGGc5IhEKEdXb8lKesoU8c7muhTeu4cRABcP4XJ
         5pjDZJJ/tvWmzSvGfeRuVGxuwfEuEphHU+ouhYQgvCEna/c/ePEa3tFc0tiNig0N7C9z
         y1skz3pdMTmuossMC00QoGz/kJAYp8AQmM7ryFrb6snb5cd1FjdDvKm1bgA+u7dCaU9w
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683855952; x=1686447952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCg3T/vJ8MiMj+/j3ev3pgirr6NJ/cPm/C3qnowqYrc=;
        b=UdKVKABdhF8IRBQ0wfhoUJlWJsydyE8g3duRGiMxBPOWJ++lKPBbLE8rTI5+G6N9Zk
         M4FTClO6zY1cCEgqK+hxzrpX0mq2gb3Cngr3kRlClVgoYeHqqfhxfdYChuAXAKG4mkNk
         PwCPISG4FjxIhcX/QllLeDZpS8jm4whPFeyLvoPmCdsBq6OGZJkVVZ+7WrGEWhe8xMdz
         MqwIvr3BlPtNh6mctSHYVmo0SDgH0WGIuG6Ge0VNVk8rm7NNsTUXDnUFvq1LmeWMKQ3Y
         fZgR2NNR6wuze/dvHfNNEK/2rVanOJ5dRMGYaK5k073t+E7TW+VJWyNjo4E4z75ikLPW
         5c0w==
X-Gm-Message-State: AC+VfDxVB6yfUKe5WUHiP8fvizlaIok35PN9gOFH6GaxIjRgT+4XFrX9
        xFuQAp3/m+a1wxuqjN+FImEHY1nZUrbALBzkR4I=
X-Google-Smtp-Source: ACHHUZ6NijAmXH7yRr8VuD/XYvPKoKeY72vg41+9OJX8jU/woazj7YEIqCq96PZMwPdbbDCRMsU6wA==
X-Received: by 2002:a17:902:d505:b0:1a6:dd9a:62c5 with SMTP id b5-20020a170902d50500b001a6dd9a62c5mr29582051plg.10.1683855951687;
        Thu, 11 May 2023 18:45:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902a40a00b001acae9734c0sm567702plq.266.2023.05.11.18.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 18:45:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pxHqt-00EEDe-Qq; Fri, 12 May 2023 11:45:47 +1000
Date:   Fri, 12 May 2023 11:45:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <20230512014547.GA3223426@dread.disaster.area>
References: <20230511151702.14704-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511151702.14704-1-tycho@tycho.pizza>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

It is likely that something has gone wrong in background inodegc if
we block here for that length of time.

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
> 
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

Yeah, this is papering over the observed symptom, not addressing the
root cause of the inodegc flush delay. What do you see when you run
sysrq-w and sysrq-l? Are there inodegc worker threads blocked
performing inodegc?

e.g. inodegc flushes could simply be delayed by an unlinked inode
being processed that has millions of extents that need to be freed.

In reality, inode reclaim can block for long periods of time
on any filesystem, so the concept of "inode reclaim should
not block when PF_EXITING" is not a behaviour that we guarantee
anywhere or could guarantee across the board.

Let's get to the bottom of why inodegc has apparently stalled before
trying to work out how to fix it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5F701249
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbjELWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbjELWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:54:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95C559B
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:54:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8908363b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683932058; x=1686524058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xw4RNP6p9BVSOpDZtwoCjXs6A4xbd0WgFJaBNB3t0SU=;
        b=4H8vTWWjgP8YgYqL3CI3Cx/tH7ktwTvsFj+5vOj+pjBVPrkPf0bYMqP4/kMiaoSp4g
         EH2Q36FLDUpaem9VTjfDS0elq9JxQaZp1eJbW3WjHBeP05+FZIG2GZw2tKpfhcMPQbVz
         9qMAm6hhKsSaIR3+tKrjBrVYctAdzqNqVI5eAqX9NZdNHrZesf//hTObCHrNvamj+Jvb
         ppQiEt/VJ3jxojcfVx9ZSj4ertqnikTXkW059vLK1JBADRxxdh8PbWyPLHVid0OHfDPW
         tZ3wvzpme0S+JLfeOezH4PC8dS/EV4jnr31njQCjdSHcHzTB+Ai6LozEd+zOau31D32P
         n68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683932058; x=1686524058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw4RNP6p9BVSOpDZtwoCjXs6A4xbd0WgFJaBNB3t0SU=;
        b=mE8wMJTVFacxfbgyqFKsthcBwbpjjiToSinI3DeKnojZVYQGmvl3F6sdOQN/1mrVvG
         KitN8IsJNRMMR7P2dmYhcx8ymVDjTXacmFNdGw5KQybhry7abmQAlE5crT/rer9aiAJH
         crLTkqxEgN+nsIqYS7ee0W8LZe0IJggmjRLz8n/QHvK6akxwqqZwPJqyKnD/jBXTOd5z
         HI6pwDiMs0JiezW8kLc255Nv8bVApespStgmQ8QZcH5WoqqiOOtyYp1TU4J2v1ttw6FA
         jSq6VwfF9aLADgohcTm5898q4Zo6kEUEisUhZNa6m1o44R55YHjXhYoq0xyU8gtzHQvs
         aMNw==
X-Gm-Message-State: AC+VfDzz7rcSUBo1EdaMyFRAqdRCWc7Nb1mPg3EZjzal3Fz18wyoNODe
        malojG1WnHb6jkaYn8uXSUL5bQ==
X-Google-Smtp-Source: ACHHUZ7IQF8tj7PMuEYgsCQZlAe0r/sNb1zkwWw9hK0qHO6sRng86j+Z7QU4KwoL8PxpvzCjcuRBsA==
X-Received: by 2002:a05:6a00:3028:b0:643:a841:887a with SMTP id ay40-20020a056a00302800b00643a841887amr30197988pfb.4.1683932057868;
        Fri, 12 May 2023 15:54:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id f14-20020aa78b0e000000b0063d666566d1sm7559518pfd.72.2023.05.12.15.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 15:54:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pxbeQ-00EZh4-IM; Sat, 13 May 2023 08:54:14 +1000
Date:   Sat, 13 May 2023 08:54:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <20230512225414.GE3223426@dread.disaster.area>
References: <20230511151702.14704-1-tycho@tycho.pizza>
 <20230512000724.GH858799@frogsfrogsfrogs>
 <ZF5X/8RQSzGMn3aZ@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF5X/8RQSzGMn3aZ@tycho.pizza>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:15:11AM -0600, Tycho Andersen wrote:
> INFO: task java:3546393 blocked for more than 1912 seconds.
>       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:skyframe-evalua state:D stack:    0 pid:3546393 ppid:3532734 flags:0x00000220
> Call Trace:
>  <TASK>
>  __schedule+0x2c5/0x8d0
>  schedule+0x3a/0xa0
>  schedule_timeout+0x115/0x280
>  ? xfs_buf_read_map+0x52/0x2e0 [xfs]
>  ? xfs_da_read_buf+0xcf/0x120 [xfs]
>  __down+0x90/0xe0
>  ? down+0x43/0x60
>  down+0x43/0x60
>  xfs_buf_lock+0x29/0xa0 [xfs]
>  xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
>  xfs_buf_get_map+0x4c/0x400 [xfs]
>  xfs_buf_read_map+0x52/0x2e0 [xfs]
>  ? xfs_read_agi+0x8c/0x120 [xfs]
>  xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
>  ? xfs_read_agi+0x8c/0x120 [xfs]
>  xfs_read_agi+0x8c/0x120 [xfs]
>  xfs_ialloc_read_agi+0x2a/0x90 [xfs]
>  xfs_dialloc+0x1ab/0x680 [xfs]
>  ? xfs_trans_reserve_quota_icreate+0x32/0x40 [xfs]
>  ? xfs_trans_alloc_icreate+0x75/0xf0 [xfs]
>  xfs_create+0x39e/0x5b0 [xfs]
>  xfs_generic_create+0x129/0x380 [xfs]
>  ? generic_permission+0x27/0x200
>  vfs_create+0x12b/0x1c0
>  ovl_create_real+0xd7/0x220 [overlay]
>  ovl_create_or_link+0x166/0x670 [overlay]

Lots of stuff blocked on the AGI lock doing inode allocation. Kinda
what I expected to see...

> INFO: task kworker/66:1:3548191 blocked for more than 1912 seconds.
>       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/66:1    state:D stack:    0 pid:3548191 ppid:     2 flags:0x00004000
> Workqueue: xfs-inodegc/nvme1n1 xfs_inodegc_worker [xfs]
> Call Trace:
>  <TASK>
>  __schedule+0x2c5/0x8d0
>  schedule+0x3a/0xa0
>  schedule_timeout+0x115/0x280
>  __down+0x90/0xe0
>  ? down+0x43/0x60
>  down+0x43/0x60
>  xfs_buf_lock+0x29/0xa0 [xfs]
>  xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
>  xfs_buf_get_map+0x4c/0x400 [xfs]
>  xfs_buf_read_map+0x52/0x2e0 [xfs]
>  ? xfs_read_agi+0x8c/0x120 [xfs]
>  xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
>  ? xfs_read_agi+0x8c/0x120 [xfs]
>  xfs_read_agi+0x8c/0x120 [xfs]
>  xfs_iunlink_remove+0x5a/0x220 [xfs]
>  xfs_ifree+0x7a/0x4c0 [xfs]
>  ? xfs_trans_alloc+0xec/0x1e0 [xfs]
>  xfs_inactive_ifree+0xa1/0x1a0 [xfs]
>  xfs_inactive+0xf1/0x170 [xfs]
>  xfs_inodegc_worker+0x76/0x100 [xfs]
>  process_one_work+0x200/0x3d0
>  worker_thread+0x2d/0x3e0
>  ? process_one_work+0x3d0/0x3d0
>  kthread+0x11a/0x140
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x22/0x30
>  </TASK>

Yup, there's the stuck inodegc worker - also trying to get the AGI
lock doing inode unlink. I'm not surprised at all by this - working
out why this worker is stuck here is the goal because that is what
is causing all your flush problems.

It also gives me a better idea of what the likely issue is, too.

> INFO: task bazelenv:3548683 blocked for more than 1912 seconds.
>       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:bazelenv        state:D stack:    0 pid:3548683 ppid:3435211 flags:0x00000220
> Call Trace:
>  <TASK>
>  __schedule+0x2c5/0x8d0
>  schedule+0x3a/0xa0
>  schedule_timeout+0x115/0x280
>  __down+0x90/0xe0
>  ? down+0x43/0x60
>  down+0x43/0x60
>  xfs_buf_lock+0x29/0xa0 [xfs]
>  xfs_buf_find.isra.34+0x1fd/0x610 [xfs]
>  xfs_buf_get_map+0x4c/0x400 [xfs]
>  xfs_buf_read_map+0x52/0x2e0 [xfs]
>  ? xfs_read_agf+0x84/0x100 [xfs]
>  xfs_trans_read_buf_map+0x223/0x2d0 [xfs]
>  ? xfs_read_agf+0x84/0x100 [xfs]
>  xfs_read_agf+0x84/0x100 [xfs]
>  xfs_alloc_read_agf+0x3a/0x1b0 [xfs]
>  xfs_alloc_fix_freelist+0x434/0x500 [xfs]
>  ? __kmalloc+0x3c0/0x400
>  ? xfs_dquot_to_disk+0xfe/0x110 [xfs]
>  ? xfs_qm_dquot_logitem_format+0x89/0x150 [xfs]
>  xfs_free_extent_fix_freelist+0x61/0xa0 [xfs]
>  __xfs_free_extent+0x6a/0x1c0 [xfs]
>  xfs_trans_free_extent+0x3b/0xd0 [xfs]
>  xfs_extent_free_finish_item+0x23/0x40 [xfs]
>  xfs_defer_finish_noroll+0x24b/0x5a0 [xfs]
>  xfs_defer_finish+0x13/0x80 [xfs]
>  xfs_itruncate_extents_flags+0x13b/0x220 [xfs]
>  xfs_setattr_size+0x35c/0x3d0 [xfs]
>  ? aa_compute_fperms+0x16f/0x190
>  xfs_vn_setattr+0xf7/0x110 [xfs]

And that confirms the suspicions I have - another process blocked on
an AGF lock. That might be IO it's blocking on here, but combined
with the inode unlink being stuck in inodegc, I have a suspicion
that this is an AGF - AGI - inode buffer lock ordering issue.

There's been a heap of work done in this space since 5.15, and I'd
suggest that almost none of it is trivially backportable as it's
deeply intertwined with relatively complex algorithm changes.

I also recently found evidence of another AGI -> inode buffer -> AGF
-> inode buffer deadlock issue debugging another hang from a machine
making heavy use of O_TMPFILEs via OVL.  Without a kernel code to
examine in intricate detail, I can't say if this is what you are
seeing.

I also don't have a fix for that yet because, well, it's complex and
I can really only accomodate one complex high priority bug at a time
in my head and it hasn't been my highiest priority. As it is, I
don't think the fix for it will be trivially backportable to 5.15,
either....

> INFO: task journalctl:3549038 blocked for more than 1912 seconds.
>       Tainted: G           OE     5.15.35netflix-g54efd87a8576 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:journalctl      state:D stack:    0 pid:3549038 ppid:469330 flags:0x00000224
> Call Trace:
>  <TASK>
>  __schedule+0x2c5/0x8d0
>  schedule+0x3a/0xa0
>  schedule_timeout+0x115/0x280
>  ? __traceiter_sched_wakeup+0x29/0x40
>  ? ttwu_do_wakeup+0x106/0x170
>  wait_for_completion+0x9f/0x100
>  __flush_work+0x161/0x1f0
>  ? worker_detach_from_pool+0xb0/0xb0
>  xfs_inodegc_flush.part.25+0x4f/0xa0 [xfs]
>  xfs_fs_statfs+0x35/0x1e0 [xfs]
>  statfs_by_dentry+0x67/0x90
>  vfs_statfs+0x16/0xd0
>  ovl_statfs+0x40/0x70 [overlay]

Fixed by commit 5e672cd69f0a ("xfs: introduce xfs_inodegc_push()")
which also means that the commits Darrick suggested you try aren't
relevant. The mod_delayed_work() issues they address weren't
introduced until commit 7cf2b0f9611b ("xfs: bound maximum wait time
for inodegc work") which has a direct dependency on 5e672cd69f0a
being present....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

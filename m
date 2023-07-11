Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9592D74E412
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGKC3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjGKC3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:29:50 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F8197
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:29:48 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b74e2d8c98so4564551a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689042588; x=1691634588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAcYcQjSn8xP98Kv6S6ayhAabmO1DM5t1UR0BBuH+OE=;
        b=WZ3Cco+0z7/goRk3rzbW1Q8Bm4NGTZcWnUC4vx8nMXY8TEYFlAEhAh/31nyCtxASLI
         L0XUXJAEbEb33DoxeF6TkhvLwj+vqCoG4LoSfb8eeYaC6cpxlzYbMdC+bWUQrT8KeEqO
         UOkra5wQjWOgV8+D1ElqXs2KXM1lYzwOSPikHVw+B3WYEtsDfuJjxr+F+XFJHP354+ah
         l77MfOmlkTIe8LM6g+ZdXxdOA0blmTvsYghrNylAKBUYLXWothqZTrQgjWb3qQ0kRWCo
         M5e1jgUk/3a6Mh5J2vJlylGoUtbkBLxElCO1U3Q04sFoHKvT0xzj+VJH/qC4sv5fiPeJ
         pFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689042588; x=1691634588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAcYcQjSn8xP98Kv6S6ayhAabmO1DM5t1UR0BBuH+OE=;
        b=L9I/UsLUzD3S6FdCFk6a81Et6t1KqsV+QpbQDijhIzrGd84GkpyPHzEDZEDCmTW4ko
         c0lzjlYt9YVf1yZlCH+it0zXZqPoZTtYX6QIwiCGPqoRHLOgGpBWD71KY/H9kSNnvVe/
         oqJZcY9j1S++6/wjweuW66pN6WWpLIPIWLaSYr7k8/PQTVmxOpvl4wIDxLFoegpN2lnN
         h5uXxU3MgHI7V2IntYjlQBn8uwdl0UvT/6H8HG9K6ZgKfQfV8fAclhRmXTljKlUOlp25
         4FqyEUKkWor6YnHxBnWsSChqFBOvQxdXcQx2fSHIibHfRSN7jSPaVeodvokFqK7BhbvB
         LdVw==
X-Gm-Message-State: ABy/qLa/u5RonpvoPm/OWkxBCoI8dl/q4vm+R48m90lcDDfpnU6vmmHl
        QqFR8iymv//DzB7gZEK5TxyElQ==
X-Google-Smtp-Source: APBJJlElSoBOffVTVDIpbJy4UIiu3P3+qhqg6us2VrXGZDT0hzskw1HitduzKJ97j3awUJOVmxodsg==
X-Received: by 2002:a9d:5e18:0:b0:6b4:54f6:59d2 with SMTP id d24-20020a9d5e18000000b006b454f659d2mr13483143oti.3.1689042587927;
        Mon, 10 Jul 2023 19:29:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-246-40.pa.nsw.optusnet.com.au. [49.180.246.40])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090ab29000b002657aa777f1sm6880198pjr.19.2023.07.10.19.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 19:29:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qJ38J-004clZ-0w;
        Tue, 11 Jul 2023 12:29:43 +1000
Date:   Tue, 11 Jul 2023 12:29:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Dunlop <chris@onthe.net.au>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: rm hanging, v6.1.35
Message-ID: <ZKy+lxkSDKs84Edr@dread.disaster.area>
References: <20230710215354.GA679018@onthe.net.au>
 <ZKyoD7WDKfzsKAaT@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKyoD7WDKfzsKAaT@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:53:35AM +0700, Bagas Sanjaya wrote:
> On Tue, Jul 11, 2023 at 07:53:54AM +1000, Chris Dunlop wrote:
> > Hi,
> > 
> > This box is newly booted into linux v6.1.35 (2 days ago), it was previously
> > running v5.15.118 without any problems (other than that fixed by
> > "5e672cd69f0a xfs: non-blocking inodegc pushes", the reason for the
> > upgrade).
> > 
> > I have rm operations on two files that have been stuck for in excess of 22
> > hours and 18 hours respectively:
> > 
> > $ ps -opid,lstart,state,wchan=WCHAN-xxxxxxxxxxxxxxx,cmd -C rm
> >     PID                  STARTED S WCHAN-xxxxxxxxxxxxxxx CMD
> > 2379355 Mon Jul 10 09:07:57 2023 D vfs_unlink            /bin/rm -rf /aaa/5539_tmp
> > 2392421 Mon Jul 10 09:18:27 2023 D down_write_nested     /bin/rm -rf /aaa/5539_tmp
> > 2485728 Mon Jul 10 09:28:57 2023 D down_write_nested     /bin/rm -rf /aaa/5539_tmp
> > 2488254 Mon Jul 10 09:39:27 2023 D down_write_nested     /bin/rm -rf /aaa/5539_tmp
> > 2491180 Mon Jul 10 09:49:58 2023 D down_write_nested     /bin/rm -rf /aaa/5539_tmp
> > 3014914 Mon Jul 10 13:00:33 2023 D vfs_unlink            /bin/rm -rf /bbb/5541_tmp
> > 3095893 Mon Jul 10 13:11:03 2023 D down_write_nested     /bin/rm -rf /bbb/5541_tmp
> > 3098809 Mon Jul 10 13:21:35 2023 D down_write_nested     /bin/rm -rf /bbb/5541_tmp
> > 3101387 Mon Jul 10 13:32:06 2023 D down_write_nested     /bin/rm -rf /bbb/5541_tmp
> > 3195017 Mon Jul 10 13:42:37 2023 D down_write_nested     /bin/rm -rf /bbb/5541_tmp
> > 
> > The "rm"s are run from a process that's obviously tried a few times to get
> > rid of these files.
>
> > There's nothing extraordinary about the files in terms of size:
> > 
> > $ ls -ltrn --full-time /aaa/5539_tmp /bbb/5541_tmp
> > -rw-rw-rw- 1 1482 1482 7870643 2023-07-10 06:07:58.684036505 +1000 /aaa/5539_tmp
> > -rw-rw-rw- 1 1482 1482  701240 2023-07-10 10:00:34.181064549 +1000 /bbb/5541_tmp
> > 
> > As hinted by the WCHAN in the ps output above, each "primary" rm (i.e. the
> > first one run on each file) stack trace looks like:
> > 
> > [<0>] vfs_unlink+0x48/0x270
> > [<0>] do_unlinkat+0x1f5/0x290
> > [<0>] __x64_sys_unlinkat+0x3b/0x60
> > [<0>] do_syscall_64+0x34/0x80
> > [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

This looks to be stuck on the target inode lock (i.e. the locks for
the inodes at /aaa/5539_tmp and /bbb/5541_tmp).

What's holding these inode locks? This hasn't even got to XFS yet
here, so there's something else going on in the background. Attached
the full output of 'echo w > /proc/sysrq-trigger' and 'echo t >
/proc/sysrq-trigger', please?

> > 
> > And each "secondary" rm (i.e. the subsequent ones on each file) stack trace
> > looks like:
> > 
> > == blog-230710-xfs-rm-stuckd
> > [<0>] down_write_nested+0xdc/0x100
> > [<0>] do_unlinkat+0x10d/0x290
> > [<0>] __x64_sys_unlinkat+0x3b/0x60
> > [<0>] do_syscall_64+0x34/0x80
> > [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

These are likely all stuck on the parent directory inode lock (i.e.
/aaa and /bbb).


> > Where to from here?
> > 
> > I'm guessing only a reboot is going to unstick this. Anything I should be
> > looking at before reverting to v5.15.118?
> > 
> > ...subsequent to starting writing all this down I have another two sets of
> > rms stuck, again on unremarkable files, and on two more separate
> > filesystems.

What's an "unremarkable file" look like? Is is a reflink copy of
something else, a hard link, a small/large regular data file or something else?

> > 
> > ...oh. And an 'ls' on those files is hanging. The reboot has become more
> > urgent.

Yup, that's most likely getting stuck on the directory locks that
the unlinks are holding....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

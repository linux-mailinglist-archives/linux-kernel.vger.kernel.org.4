Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD45FCC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJLUgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJLUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:36:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97731FF21B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:36:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so77363pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OftXi8iVR7KoOTzPTGUIG7HzL3FJsGrWb5IKb4t36FU=;
        b=oJ0HojSiLLdfTqLiz1TRHEOy5oLVTEOJN7PxSWW1hwkvpdYlAao5EWDn38A2Bi7TOE
         iXaq0sjJcPZZpIAik1kgZLNVeO59RHYdB4dn2LEc4cwTWUzJhoBH4arFKSvgZwNORv6L
         Og4/FzSeUdURogtLdJcAsZ+aZDSHrpSoDFBQY2v6z3AN4uzjpvO5+6p4+KcICfhF/lOf
         OgN1RLZYZnK7ELA1t/NzjFFrOKknddjZhCH1Mwfsa18+nerOSY2nR98SMPl3IlCq75DU
         s8jBjrqF+xNHwnt9VIx3kp4QPdXMBSmyyN7cUx9jIeE5xr9efj3ojcfU9RurIy8JJTYw
         V9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OftXi8iVR7KoOTzPTGUIG7HzL3FJsGrWb5IKb4t36FU=;
        b=T4klMUcXrWmIQWjrItFKvfLm17RLUpLUZHSFkICOxcd4eBFfpYxhwCMzmUoTb8+LOp
         IBcYuBDE+yIFXR1ZmMmtVZU3oJhIBzNR24ZRd3KhARzLzTsjpgvIlgmVsY/d5YFzb6rl
         fh3BxNx3I0/Asp2lMR1RoAslXgimmiez4CuRryd7zX0vMCD9BoCzq6/dp21UXavENkoy
         WkM9WJS6NOU5LloFJdSIzKLC13mqzMRcjXUOisASwP3/6J7Aj9+iasr7OQZVSNv0eB4C
         DMQiK11nHIZysuRANFSTZ8brH0F0nTnvgnf3ZWd7DJ8tjbwl3gxhjFbMeepGkwirvLQQ
         oFpQ==
X-Gm-Message-State: ACrzQf0+3ksaRHwALCRZox3KMko6DAAI4GS4LBwwghoMMN2bNl0+Ow6c
        RV1HFHd1lvFELZ1g/ElF3qI=
X-Google-Smtp-Source: AMsMyM5n7kLa4PDNmN4tv8Z4NM2D3rhBj9iDIEUkz9bH6Yum9vpd2akwD7jCx/7ocKJp8AdNgUF0Aw==
X-Received: by 2002:a17:90b:38cd:b0:20d:6f2a:69c2 with SMTP id nn13-20020a17090b38cd00b0020d6f2a69c2mr7307434pjb.114.1665607004846;
        Wed, 12 Oct 2022 13:36:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7952d000000b0056323de479bsm281243pfp.120.2022.10.12.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:36:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Oct 2022 10:36:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     syzbot <syzbot+141cc7ede4844354c9c5@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in kernfs_fop_open
Message-ID: <Y0clWyDlLzG+Eqvx@slm.duckdns.org>
References: <000000000000fe10d805ead95567@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fe10d805ead95567@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:00:55AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15adbd1c880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d97b00ebbd65d751
> dashboard link: https://syzkaller.appspot.com/bug?extid=141cc7ede4844354c9c5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127fb348880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140790e8880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c383c6221def/disk-e8bc52cb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/212eadb7e8f5/vmlinux-e8bc52cb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+141cc7ede4844354c9c5@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810bfdeb80 (size 96):
>   comm "udevd", pid 2966, jiffies 4294946369 (age 13.650s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816f6911>] kmalloc include/linux/slab.h:600 [inline]
>     [<ffffffff816f6911>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816f6911>] kernfs_get_open_node fs/kernfs/file.c:568 [inline]
>     [<ffffffff816f6911>] kernfs_fop_open+0x4f1/0x5b0 fs/kernfs/file.c:736
>     [<ffffffff815d909f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815ff9b6>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815ff9b6>] path_openat+0x1756/0x1be0 fs/namei.c:3691
>     [<ffffffff816026e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3718
>     [<ffffffff815dca0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815dd45f>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815dd45f>] __do_sys_openat fs/open.c:1342 [inline]
>     [<ffffffff815dd45f>] __se_sys_openat fs/open.c:1337 [inline]
>     [<ffffffff815dd45f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1337
>     [<ffffffff845fc895>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845fc895>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

I tried to reproduce it on my test setup and then qemu running the syz image
but haven't been successful yet. The bug definitely seems plausible but I
haven't been able to spot anything obvious looking at the code yet either.
I'm a bit out of ideas right now. Will keep thinking about it and come back
to it later.

Thanks.

-- 
tejun

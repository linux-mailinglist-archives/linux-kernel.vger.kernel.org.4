Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335C5FCAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJLSa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:30:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15234B84F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:30:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z20so17001317plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlwFT/czCkzZYPQLFNBenmnjlc6I7VIZp8IwB7h7paY=;
        b=Kj30AAISyYWYT7BrVovWAeueM7BNNd0i3ZC4ngZALVv6W9+ubEoGP3RYUiZUyPFFKz
         RVTBvlO3nqmNSsX9HPQqCFEtgYkbD/eIUfnAn4QFNwBKrKsqPPdEeY8XqXQSRpDp+8zc
         4HTrLO0cQXhOTW1sojjFLi7/cQVEKwexEQinqhY4SHYVfCMK8XOSaP9xQIVZ9yOhPuiO
         E9eAObM7Elg4VY0a98VMvzrtdj4N04T8XBNW+IEfhB3sCZPQXqALZF7akh7931FwDhWm
         v3Xich7HJ7Vr7qbQVgif+2fggN+RcyKz26yuw4PqrW/XNyEOx+nUgEmBzY3CegJBQrMk
         Zi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlwFT/czCkzZYPQLFNBenmnjlc6I7VIZp8IwB7h7paY=;
        b=rIvHNRbPzjNtB0SiWEmXH12Z0S+dl4WX2uMyeTikdZ8JzGIwbHDnqMGH3a29M2HS7g
         OvYWR3dLOkOyBGeFjvzltDkFQoIAU9cW1Oju7SFKIH3/oU94O6Agk8Uonh5Tl/ujHqdf
         kVBDo3RW4jF2tQuT9J2oRkkZ9wSTss8l2iUVFPJoXfGpHTxkWqwsGkAzjAxQAx2NweLs
         YV8xgz0OIGsk61HzihQWMvtPX01Ai/KP006OJ5aPjrL8oEiKg2AytjqmZEe2zLFhQ6BL
         g+fVr/pd3HzDS1nEIagggDAmIOdBWQCF4k5N3XqknG0ymmtNLfzQNwWhCU0s0Ve9TYE5
         /iAg==
X-Gm-Message-State: ACrzQf0NK4dScB2ocsSZlZHGfmL+EbMRQxs9X9IN8pS6AOrG/5wVJ6+O
        NGOGWhONUMGZth6Q0hj1srl5FxIyd3adFg==
X-Google-Smtp-Source: AMsMyM5Pg9H18CzLYwcq5WouBmpX3CQHQzHdiOuWQNtFgiemrAHx6iDmkxf0qjsvuMtqhF9aEjyTQA==
X-Received: by 2002:a17:902:ba8f:b0:17f:9b1b:6634 with SMTP id k15-20020a170902ba8f00b0017f9b1b6634mr31275040pls.171.1665599439327;
        Wed, 12 Oct 2022 11:30:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s18-20020a656452000000b00464aa9ea6fasm3214145pgv.20.2022.10.12.11.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:30:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Oct 2022 08:30:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     syzbot <syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 kernfs_walk_and_get_ns
Message-ID: <Y0cEQbWsy7XAkyVZ@slm.duckdns.org>
References: <0000000000002b89b205ead703ff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002b89b205ead703ff@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 07:14:35AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    282342f2dc97 Add linux-next specific files for 20220830
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14b47c63080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7b70bd555c649f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=9baaae5fc5795e2e6acf
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12acb375080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1718658b080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1498
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3603, name: syz-executor323
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<ffffffff814710e0>] copy_process+0x20f0/0x7120 kernel/fork.c:2199
> softirqs last  enabled at (0): [<ffffffff81471128>] copy_process+0x2138/0x7120 kernel/fork.c:2203
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 PID: 3603 Comm: syz-executor323 Not tainted 6.0.0-rc3-next-20220830-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
>  down_read+0x71/0x450 kernel/locking/rwsem.c:1498
>  kernfs_walk_and_get_ns+0xcc/0x3a0 fs/kernfs/dir.c:897
>  kernfs_walk_and_get include/linux/kernfs.h:600 [inline]
>  cgroup_get_from_path+0x61/0x610 kernel/cgroup/cgroup.c:6647

The fix for this one is already queued in cgroup/for-6.1-fixes. Will send
that to linus once rc1 drops.

Thanks.

-- 
tejun

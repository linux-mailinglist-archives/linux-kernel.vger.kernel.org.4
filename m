Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737086F2912
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjD3NfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3NfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 09:35:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292612D73;
        Sun, 30 Apr 2023 06:35:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so17009465e9.1;
        Sun, 30 Apr 2023 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682861702; x=1685453702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q66B2VAsNUEUORNlqd/SH3lXkCF0Wmvm/NkUzg1deG4=;
        b=BmCyo1xoZ+cVDt6YzcEtIIxzt546M6p04my6rYSGd+KiYf6AriqYLQlNarK0WY0LxS
         pQoLafhW2AYJ3lPZTZEIwCVNrV6o0pGcJf5dPZ6XcpHsKIjxQZcOextuqkwLkiVm6jK4
         00ydwThgdRiEh2NLwea1qsbBbvAKBsm8DN5tTj8tTfYrSOxj5TtqXBJiIExbwH5miNW8
         MuXMpVS4GNFC2ik192kiP8SGLTOWS3ZMKqPP20tmXQ13vtj7voQnYOoSm/XN+t4n/H1i
         vkFwd2YghAErCKWm9fagZd7XLG2u7UAqcJRQQ7IAk87/4OCG3G7zk9U/c1QrWPipXZSF
         vQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682861702; x=1685453702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q66B2VAsNUEUORNlqd/SH3lXkCF0Wmvm/NkUzg1deG4=;
        b=Q+CLmntVLjErm/9Yh7lA7u5Bpvpzdp+U5K+dSb8vq/6BiNeKUXNeHUYV1KvX6YF+BN
         0rUGVgzboNe8cN1MrrfEqnNIhaqaYv0KXnokWt3YO5OtJQDdVHU+8xtVnXT1+VVy9jzj
         RYsOxBceBHBe7R4nbA/qa2VPn5ta5fTWGfMPfKB0f+8t9fJmufAc8ycyFnINEDtpk97Y
         /VL83VCZxZiSruXpJW6xO3ffFr7UkHYWWkng+YZZadd+JMKnwacKArlxHfcQhZNoOS2f
         g3njdvl2GDXC8sk+d23xhxlDtzYhdHIEMlO8x6EgUuI8W+Pt52CADPI39/k1ao47A2DY
         HRLw==
X-Gm-Message-State: AC+VfDxvDdaw5VcXsSsemFXdfn8dZjVMC87fadsLyPwR4gOP8y3q8tkO
        9L/ODH8CrLJlJbS5LcOGGqO8AVrjssljpQ==
X-Google-Smtp-Source: ACHHUZ6f/Of5in+f+7rmLzDThrDRTY8P7ry/dx2mW37IvLwVIFHa0pZqc55OHMKJnZv46o13k/JELw==
X-Received: by 2002:a05:600c:22d0:b0:3f0:7e15:f8fc with SMTP id 16-20020a05600c22d000b003f07e15f8fcmr8505350wmg.14.1682861702347;
        Sun, 30 Apr 2023 06:35:02 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003f3195be0a0sm10174326wmi.31.2023.04.30.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 06:35:01 -0700 (PDT)
Date:   Sun, 30 Apr 2023 14:35:00 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com,
        stable@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: Fix use-after-free of VMA iterator
Message-ID: <5066f333-5021-451d-abdd-07a027d98820@lucifer.local>
References: <20230410152205.2294819-1-Liam.Howlett@oracle.com>
 <yt9dildhke9l.fsf@linux.ibm.com>
 <20230427173247.s5rn6nujoxiatviu@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427173247.s5rn6nujoxiatviu@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 01:32:47PM -0400, Liam R. Howlett wrote:
> * Sven Schnelle <svens@linux.ibm.com> [230427 02:53]:
> > "Liam R. Howlett" <Liam.Howlett@oracle.com> writes:
> >
> > > set_mempolicy_home_node() iterates over a list of VMAs and calls
> > > mbind_range() on each VMA, which also iterates over the singular list of
> > > the VMA passed in and potentially splits the VMA.  Since the VMA
> > > iterator is not passed through, set_mempolicy_home_node() may now point
> > > to a stale node in the VMA tree.  This can result in a UAF as reported
> > > by syzbot.
> > >
> > > Avoid the stale maple tree node by passing the VMA iterator through to
> > > the underlying call to split_vma().
> > >
> > > mbind_range() is also overly complicated, since there are two calling
> > > functions and one already handles iterating over the VMAs.  Simplify
> > > mbind_range() to only handle merging and splitting of the VMAs.
> > >
> > > Align the new loop in do_mbind() and existing loop in
> > > set_mempolicy_home_node() to use the reduced mbind_range() function.
> > > This allows for a single location of the range calculation and avoids
> > > constantly looking up the previous VMA (since this is a loop over the
> > > VMAs).
> > >
> > > Link: https://lore.kernel.org/linux-mm/000000000000c93feb05f87e24ad@google.com/
> > > Reported-and-tested-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com
> > > Fixes: 66850be55e8e ("mm/mempolicy: use vma iterator & maple state instead of vma linked list")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> >
> > This breaks the vma02 testcase from ltp on s390:
> >
> >  ~ # ./vma02
> > vma02       0  TINFO  :  pid = 617 addr = 0x3ff8f673000
> > vma02       0  TINFO  :  start = 0x3ff8f673000, end = 0x3ff8f674000
> > vma02       0  TINFO  :  start = 0x3ff8f674000, end = 0x3ff8f675000
> > vma02       0  TINFO  :  start = 0x3ff8f675000, end = 0x3ff8f676000
> > vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.
> >
> > When this happens the following VM_WARN_ON() is triggered:
> >
> > [   25.628747] ------------[ cut here ]------------
> > [   25.628821] WARNING: CPU: 0 PID: 617 at mm/mmap.c:922 vma_merge+0x7ca/0x970
> > [   25.628834] Modules linked in:
> > [   25.628841] CPU: 0 PID: 617 Comm: vma02 Not tainted 6.3.0-09574-g285e1dccc348 #108
> > [   25.628846] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> > [   25.628850] Krnl PSW : 0704e00180000000 00000000004317b6 (vma_merge+0x7ce/0x970)
> > [   25.628859]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> > [   25.628866] Krnl GPRS: 000003ff8f62d000 000003ff8f674000 000000008e7cb908 000000000131f0f4
> > [   25.628871]            0000000000000001 0000038000bdba1c 000003ff8f675000 000000008e7cb908
> > [   25.628876]            000000008e7cb908 000003ff8f674000 000003ff8f675000 000000008e7ca308
> > [   25.628881]            0000000000000001 000000003ff8f674 0000000000431048 0000038000bdbb08
> > [   25.628891] Krnl Code: 00000000004317aa: a7f4fcea            brc     15,000000000043117e
> > [   25.628891]            00000000004317ae: b9040087            lgr     %r8,%r7
> > [   25.628891]           #00000000004317b2: af000000            mc      0,0
> > [   25.628891]           >00000000004317b6: a7f4fc5f            brc     15,0000000000431074
> > [   25.628891]            00000000004317ba: ec38fd30007c        cgij    %r3,0,8,000000000043121a
> > [   25.628891]            00000000004317c0: e31031d80004        lg      %r1,472(%r3)
> > [   25.628891]            00000000004317c6: e310f0f80024        stg     %r1,248(%r15)
> > [   25.628891]            00000000004317cc: a7f4fd27            brc     15,000000000043121a
> > [   25.628970] Call Trace:
> > [   25.628974]  [<00000000004317b6>] vma_merge+0x7ce/0x970
> > [   25.628979] ([<0000000000431048>] vma_merge+0x60/0x970)
> > [   25.628985]  [<0000000000482e5a>] mbind_range+0x13a/0x1c8
> > [   25.628990]  [<0000000000483448>] do_mbind+0x2c8/0x448
> > [   25.629013]  [<0000000000483662>] kernel_mbind+0x9a/0xb8
> > [   25.629018]  [<0000000000483724>] __s390x_sys_mbind+0x4c/0x58
> > [   25.629023]  [<0000000000f38c3a>] __do_syscall+0x1da/0x208
> > [   25.629030]  [<0000000000f4ed40>] system_call+0x70/0x98
> > [   25.629037] 1 lock held by vma02/617:
> > [   25.629042]  #0: 000000008c570ca8 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind+0x102/0x448
> > [   25.629055] Last Breaking-Event-Address:
> > [   25.629058]  [<0000000000431070>] vma_merge+0x88/0x970
> > [   25.629066] irq event stamp: 12559
> > [   25.629070] hardirqs last  enabled at (12567): [<00000000001fcc6c>] __up_console_sem+0x8c/0xc0
> > [   25.629080] hardirqs last disabled at (12574): [<00000000001fcc4e>] __up_console_sem+0x6e/0xc0
> > [   25.629086] softirqs last  enabled at (10076): [<0000000000f516e2>] __do_softirq+0x512/0x618
> > [   25.629123] softirqs last disabled at (10053): [<0000000000162bbe>] __irq_exit_rcu+0x13e/0x170
> > [   25.629132] ---[ end trace 0000000000000000 ]---
> >
> > which is:
> >
> >        /* verify some invariant that must be enforced by the caller */
> >        VM_WARN_ON(prev && addr <= prev->vm_start);
> > -->    VM_WARN_ON(mid && end > mid->vm_end);
> >        VM_WARN_ON(addr >= end);
> >
> > Any thoughts?
>
> No thoughts that I should share.
>
> I will have to boot my s390 (vm) and have a look.
>
> Thanks for letting me know.
>
> Regards,
> Liam

I tracked down what this (almost certainly) was + added fix in [1] as it
popped up as a 6.2.y stable bug. It doesn't seem arch-specific so you can
put that s390 down :)

[1]:https://lore.kernel.org/all/db42467a692d78c654ec5c1953329401bd8a9c34.1682859234.git.lstoakes@gmail.com/

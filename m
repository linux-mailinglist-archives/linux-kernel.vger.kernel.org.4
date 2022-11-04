Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D715E619F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiKDRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:51:45 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F843AD4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:51:42 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 94-20020a9d0067000000b0066c8d13a33dso1765854ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCqgcGN9zqs2VEJFRukgPdiLT8vqXjhzWBwbMn1DN+0=;
        b=sXgB45hiZ4y0H27vNcBd+mTMkw1hAgat53Ttdk4qHW/nYEvsgsWhWYBrVK1Ax5Xf4F
         /jEvCu4r8loxN542EzD0snfF6F4skPWKwZ9QpD8hSQSGtGXbSoKWAo2N78AbXtm1cKTd
         6IhWSN4hxTvjYF2/zyF4WhV+VhGXzC6S8ti+wA+ggnnzSflqHVjtXAce4C5kyJ9yqWB8
         omeigi82IjcwquYeABPTFeEx76OO+0VdyvqwFBNe9cucqCDrEE4yRTidRtInANXR/Jqi
         ClAtO0DofCHOtfDJzN99988sANYCrQaov8xc3mh9vKdwhsRcSap25odZdYmWnmhs9Pac
         MPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCqgcGN9zqs2VEJFRukgPdiLT8vqXjhzWBwbMn1DN+0=;
        b=5zrgfuM/kEjLLygfq/SqlI59j1/gL8Vx0Q2jjuPPLp9Wm2MRCg/yqS8bLwzmUXaSzG
         rTf0vwZhXuWfibl6Uu0EKQnthPofbbLuTKYINXva7LiWR2KB+Oqx+wUSlQQ2RMfMZdpV
         LfamOmRKyW+eD5md1B1P6T7iGcFBLDsfwbPhwc0FWZ2gx1brIcIFkAI8YRxT7tEXvau/
         WPRECfHheBWwkLao/rz9FG3NSnhKC7UuhR7bvC1kI9khI3yAah0ujEzdiMEsOMdJBLfR
         2ZHwc22+OfF2AO1BUsY++DcopTm0kef37BdwQ5ayDNznCqZDISfbajZ3e/zsssxEeimm
         /StQ==
X-Gm-Message-State: ACrzQf1kM46HAD8BDgWj+fE5psf4QjiNcn5f+pZBMNng/hPe+dL9tzlR
        49BjDDmUhSfWU1SZAV1sWAl54YXWgXcJAK/fYoHnXw==
X-Google-Smtp-Source: AMsMyM4SGlMA9G8nN94b1Y7ZGsZ+HzA793yhFSnNl//JWkgFIJGHMqAZ4Ox2k8gGvNDjf5aaAXVmSI/0RYhZKhDYwa0=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr13859624otk.269.1667584301529; Fri, 04
 Nov 2022 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000035fba305eca64106@google.com> <Y2UvigDr9ctxlEEE@google.com>
 <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
 <Y2U+8cM9z0axes2y@google.com> <Y2VOU96gcoor288M@google.com>
In-Reply-To: <Y2VOU96gcoor288M@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 10:51:30 -0700
Message-ID: <CACT4Y+Y6A0wooT1ua9qcoGuRBV9nF5sfF4q3-tSs3y+AqnGvfA@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
To:     Sean Christopherson <seanjc@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 10:39, 'Sean Christopherson' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Nov 04, 2022, Sean Christopherson wrote:
> > On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> > > On Fri, 4 Nov 2022 at 08:28, 'Sean Christopherson' via syzkaller-bugs
> > > <syzkaller-bugs@googlegroups.com> wrote:
> > > >
> > > > On Fri, Nov 04, 2022, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    81214a573d19 Add linux-next specific files for 20221103
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=132019de880000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc625e9234bac0
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ffb4f000dc2872c93f62
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd52ca880000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/5d4dda497754/disk-81214a57.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/9658efff160a/vmlinux-81214a57.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/3711180f2565/bzImage-81214a57.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> > > > >
> > > > > BUG: unable to handle page fault for address: fffffbc5a1c22e00
> > > > > #PF: supervisor read access in kernel mode
> > > > > #PF: error_code(0x0000) - not-present page
> > > > > PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > > RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
> > > >
> > > > I'm pretty sure this is the same thing as
> > > >
> > > >   BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff
> > > >
> > > > I'll verify and get a patch posted shortly.
> > >
> > > This repro does not create any VMs, it's just:
> > >
> > > iopl(0x3)
> > > rt_sigreturn()
> > >
> > > Do you still think it's related to the vmx_handle_exit_irqoff issue?
> >
> > Yes, the issue is that the shadow for the read-only IDT mapping in the CPU entry
> > area isn't populated (commit 9fd429c28073 ("x86/kasan: Map shadow for percpu pages
> > on demand") is to blame).  The bug manifests anytime software manually does an IDT
> > lookup.
>
> Hrm, but the lookup is into the GDT, not the IDT, and I haven't been able to reproduce
> this one.  I'll leave it open for now.

The repro calls rt_sigreturn() w/o actually setting up the signal
frame (mcontext, etc). So I assume the kernel will restore completely
bogus/random user-space mcontext. The data it reads from the stack may
be uninit or depend on the compiler, etc.

As the result it should get completely random segment selector here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/x86/lib/insn-eval.c?id=81214a573d19ae2fa5b528286ba23cd1cb17feec#n725

Can it be out-of-bounds or something?

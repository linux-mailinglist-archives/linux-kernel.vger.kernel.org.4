Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0C61A02B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiKDSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKDSlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:41:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282C4B981
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:41:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g24so5694878plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GIo5gi3HGWQl6egIqC/qAVdBHe+Mh+KRDU+xHxkQoo=;
        b=dFfV25gj0GfOuyia2c1rN9RfUPxPIzUyp9dnlisG6G9NsPRMb9MXAOqwiegO3CVtvh
         dymeglIEgIe/raNz5uw91jLAESop6NxauON/BOV+os4OjtBb+3JQd2rLYfy+PySgeam1
         zDBPhNMpmuvMKpGxdGBYSh1K79WR+Rqvq7gg6FzUimZhcu/WO22VepH0J9jCOjpGZl2X
         Yl8hvdHREWWVgskDxW6VoWyiDl5H3Ed/iuxu8UjTSBbCcT6v8nOIvb+KUStZ8XT2usgP
         dk3MOBE2J/910Iyj5uVp+aNDarssJDukC/ibLIkCrJyaMuZz3jLPLFjw9oO3Wkpnv8F8
         tfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GIo5gi3HGWQl6egIqC/qAVdBHe+Mh+KRDU+xHxkQoo=;
        b=JwsnejcP77+4om0qQ/Owl8g98DZ7fyi/60PMBuy/xf2YNFgzWd0OCDpD0vbsgAVWHl
         eNCf5pBhp2EJpdWUuzuoxyqsIG+XEBtDZbdiQZrMU+fD68D5+0/alyAqMq+JR3MU2lFp
         VWr1W3PVB1hyBYfboNNzVpTAU41oVZTWxJyg6n8Xv0NYMB8fbFA8rCX30R7CpjMPCpxk
         Sqnni8jbOdx5hBmd6V+pi+jTMI1rIeSHSAWM/QxP2NpLCjA+FoaCOtfo+aBapAi1GbDa
         WhnnYKsNuChTXwutjctIvsCxcpqTZoBbJpsY91rxoL2V1IBb/JX1Wkkk3DQ58e7mHVuZ
         NV6g==
X-Gm-Message-State: ACrzQf2FQjse83lk4aP0l8b8BXuNKugM2s8NaB13dC3nmtKJ8cR2503o
        sE6c+HIR0vJrTrjbF2CwBB9x6w==
X-Google-Smtp-Source: AMsMyM4AOO7B11qn/AZ+LdPc9Xqv1p8S6cvxe0dvi+WNlwtGcsYec76KV5RhxD89snEPOhfMUmp1nw==
X-Received: by 2002:a17:90a:c918:b0:213:f5ea:5a60 with SMTP id v24-20020a17090ac91800b00213f5ea5a60mr25583539pjt.167.1667587265839;
        Fri, 04 Nov 2022 11:41:05 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id my5-20020a17090b4c8500b00213ee5a12c9sm37992pjb.55.2022.11.04.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:41:05 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:41:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
Message-ID: <Y2Vcvf2AiUJ5jCVf@google.com>
References: <00000000000035fba305eca64106@google.com>
 <Y2UvigDr9ctxlEEE@google.com>
 <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
 <Y2U+8cM9z0axes2y@google.com>
 <Y2VOU96gcoor288M@google.com>
 <CACT4Y+Y6A0wooT1ua9qcoGuRBV9nF5sfF4q3-tSs3y+AqnGvfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y6A0wooT1ua9qcoGuRBV9nF5sfF4q3-tSs3y+AqnGvfA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> On Fri, 4 Nov 2022 at 10:39, 'Sean Christopherson' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Fri, Nov 04, 2022, Sean Christopherson wrote:
> > > On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> > > > On Fri, 4 Nov 2022 at 08:28, 'Sean Christopherson' via syzkaller-bugs
> > > > <syzkaller-bugs@googlegroups.com> wrote:
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> > > > > >
> > > > > > BUG: unable to handle page fault for address: fffffbc5a1c22e00
> > > > > > #PF: supervisor read access in kernel mode
> > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> > > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > > CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > > > RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
> > > > >
> > > > > I'm pretty sure this is the same thing as
> > > > >
> > > > >   BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff
> > > > >
> > > > > I'll verify and get a patch posted shortly.
> > > >
> > > > This repro does not create any VMs, it's just:
> > > >
> > > > iopl(0x3)
> > > > rt_sigreturn()
> > > >
> > > > Do you still think it's related to the vmx_handle_exit_irqoff issue?
> > >
> > > Yes, the issue is that the shadow for the read-only IDT mapping in the CPU entry
> > > area isn't populated (commit 9fd429c28073 ("x86/kasan: Map shadow for percpu pages
> > > on demand") is to blame).  The bug manifests anytime software manually does an IDT
> > > lookup.
> >
> > Hrm, but the lookup is into the GDT, not the IDT, and I haven't been able to reproduce
> > this one.  I'll leave it open for now.
> 
> The repro calls rt_sigreturn() w/o actually setting up the signal
> frame (mcontext, etc). So I assume the kernel will restore completely
> bogus/random user-space mcontext. The data it reads from the stack may
> be uninit or depend on the compiler, etc.
> 
> As the result it should get completely random segment selector here:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/x86/lib/insn-eval.c?id=81214a573d19ae2fa5b528286ba23cd1cb17feec#n725
> 
> Can it be out-of-bounds or something?

The lookup is on CS.base (I trimmed the stack in my first reply) as part of the
IOPL emulation to see if userspace is attempting CLI or STI, so it's not related
to the sigframe.

  insn_get_seg_base arch/x86/lib/insn-eval.c:725 [inline]
  insn_get_effective_ip+0x187/0x1f0 arch/x86/lib/insn-eval.c:1476
  fixup_iopl_exception+0xd0/0x190 arch/x86/kernel/traps.c:627
  __exc_general_protection arch/x86/kernel/traps.c:752 [inline]
  exc_general_protection+0x176/0x210 arch/x86/kernel/traps.c:728
  asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:564
 RIP: 0003:0x7f250f3abf8c

It does look like some form out out-of-bounds selector though.  The offset in the
splat suggests CS.sel is something way above __USER_CS, which would explain why
insn_get_effective_ip() is doing a lookup in the first place (CS.base is assumed
to be 0 if userspace is in 64-bit mode, user_64bit_mode() is true if CS == __USER_CS)),
I just can't figure out how that tiny reproducer is getting a bad CS.  And the above
RIP strongly suggests userspace is indeed in 64-bit mode.

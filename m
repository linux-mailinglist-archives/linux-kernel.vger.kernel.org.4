Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B3619EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiKDRjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiKDRjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:39:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB178B842
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:39:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so8872700pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEEv1AywiXkhljOATlKLojbeil+y0XxR22BrhAZuad0=;
        b=VsMXhm+I0ktezbwg+zJnOVhdEr6eAKA9lB7gvqdUShiA4hAeB7An5n1y1M/9LiDT/5
         4jpXreXCw7uHOmJAj+XpdxihrwjTadUiA8GrqO2digmzl4aMys95TuNBbSJG8bL8AsOb
         XYTZvwaVwrJmLQv0Um7H+N36owCivdem7oaS2wIZOTb7k03zmyWN/l3eRum2Y9u+Y2RQ
         1rDmr1n6d1xEKOmpj9SwEBr6JST8o1I8G8I3UPR8PByGoyFzwtO4bs29j/371kFQjPXZ
         Aj9wyvtlXPah8U6sJInlPDk4+lnms3I8fjfm6M1s6G6KfNEv2K2Mg4PbwynPwyMmHJdY
         Ss3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEEv1AywiXkhljOATlKLojbeil+y0XxR22BrhAZuad0=;
        b=nqCX+osrMt76S6fbu6c0BVvHqw6OMaavCCqqYM2S1vOQlDeqrd7V8brbwTmpJr/FQP
         F0NUOkR1jRF08Obmf+ghKIXG1EqGkolvqQ+zZLxz0vDlYpUgYsSrxn2MpnqEc7oF8m0k
         iB++7yhE8Ay+99EQYionC/BYoNm1nJlJ5lsHYySxO0csxCh8sRAfonV+XxhMgkTo9/0Y
         CsgTprjzSlLH1q7W6f44mtxPHinL1YeGKC7Pyhe2fYRU68G57EjyQ1tFvv1lEZDApKlT
         o8OLL+8b1qDfZ83U2A9wRtydiqJPn2z+GP3kKwA/AyYg/5uPvILfLolfFMRN7+cWqTBn
         6kTg==
X-Gm-Message-State: ACrzQf3yWgoKJwnETI+objHZE7vEheWYIzwKV9YMDnOWK1h+QLzpuywI
        xZ2wdn4Z5trBQ3vy+Wnynm0vxtrw0gXFbw==
X-Google-Smtp-Source: AMsMyM5MigB3yPnyRcVqTWxlMJPU4qt8aBjknfdfYnJwGyT/QfKBhfcHVQeUJb54kcWrooSDPoo2Hg==
X-Received: by 2002:a17:90a:3947:b0:213:ebeb:2cf3 with SMTP id n7-20020a17090a394700b00213ebeb2cf3mr27088057pjf.9.1667583575140;
        Fri, 04 Nov 2022 10:39:35 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id mm11-20020a17090b358b00b0020d24ea4400sm1899772pjb.38.2022.11.04.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:39:34 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:39:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
Message-ID: <Y2VOU96gcoor288M@google.com>
References: <00000000000035fba305eca64106@google.com>
 <Y2UvigDr9ctxlEEE@google.com>
 <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
 <Y2U+8cM9z0axes2y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2U+8cM9z0axes2y@google.com>
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

On Fri, Nov 04, 2022, Sean Christopherson wrote:
> On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> > On Fri, 4 Nov 2022 at 08:28, 'Sean Christopherson' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Fri, Nov 04, 2022, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    81214a573d19 Add linux-next specific files for 20221103
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=132019de880000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc625e9234bac0
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ffb4f000dc2872c93f62
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd52ca880000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/5d4dda497754/disk-81214a57.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/9658efff160a/vmlinux-81214a57.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/3711180f2565/bzImage-81214a57.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> > > >
> > > > BUG: unable to handle page fault for address: fffffbc5a1c22e00
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
> > >
> > > I'm pretty sure this is the same thing as
> > >
> > >   BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff
> > >
> > > I'll verify and get a patch posted shortly.
> > 
> > This repro does not create any VMs, it's just:
> > 
> > iopl(0x3)
> > rt_sigreturn()
> > 
> > Do you still think it's related to the vmx_handle_exit_irqoff issue?
> 
> Yes, the issue is that the shadow for the read-only IDT mapping in the CPU entry
> area isn't populated (commit 9fd429c28073 ("x86/kasan: Map shadow for percpu pages
> on demand") is to blame).  The bug manifests anytime software manually does an IDT
> lookup.

Hrm, but the lookup is into the GDT, not the IDT, and I haven't been able to reproduce
this one.  I'll leave it open for now.

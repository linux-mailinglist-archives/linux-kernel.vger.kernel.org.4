Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4A619D59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKDQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKDQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:33:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560D26AF0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:33:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d20so4307576plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fa+9pzByyyOGNNNTspXMvmKC9Vtsxl57f41N5dapZU=;
        b=liPkB0me59LM/W27MdLVMB+8ftyNZZL3decmTl6jzo7c3q1OELbiohDjCszweoJhvB
         FZz648E4HWskfa9h+qQt8KQ9jxDEOrsaq/jH95iWBM+fhIonAZ3IxlR28V15HFgj6tBw
         B3bGbdNlhcCUwrIfqRMOc8IiSne+lrX5NS4kaVRSKCBmr7VLqbMJW2lUJWj/OPzyAMlx
         5DRDCbpgxHLbgl+D21Pag9AfBVgDZwANnhpisVzB+CmhQBqvLbEx6klvnlrqGbvFYP0+
         cJZaNmSEeCkaX/z7g1fZx4XUm31IJGjvzIihfejIlnWtGgxjaNGWV8iiylKxTQpLx76Z
         7gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fa+9pzByyyOGNNNTspXMvmKC9Vtsxl57f41N5dapZU=;
        b=ws8pO5GhmwVl4lW5VPFLLXtZn27D5FRM6+zRCBIbCodKQBv4Pof8Hj1DzduLcDi0o0
         yeX2InGu6fFQ5dA6yd87Xowkx42wqeL0FzV3v1B4JMGAtXmPAK6N6Wxqnw76G/hwmeoB
         PKSDLstCq/4njsESLGv/P8XdpWYHkhBN9rk5lcVlLmYmZDIE0/ZaJmutUZphAR4QG4DT
         28Dy5GigrA/JT+RsW3pOQ+1LvKlSbgz6VI0JM0Fnv3KFV3RONyHRJOlDw/7lClyYklf9
         Mc+QD2oWqpJxZ+fhrmPb6sxPl5EqV/VMZyR4oC1QZZD7f1TEvhzu4hbl1+qzmK70I+ac
         et1Q==
X-Gm-Message-State: ACrzQf3ylH/zRqH29n0N3bQ+MHai058ry9oRDCftxKIAigUb5vzR6m8w
        1Xk4g3dve2agEhJKi8kyL1CsLg==
X-Google-Smtp-Source: AMsMyM41kqotuNlGQkdPt9fasGd8+mt1D2dkTNV9FPVQpu5bo9vVrk1UipAjmrMI0dVry8M9ghYL3w==
X-Received: by 2002:a17:902:c2c4:b0:187:640:205c with SMTP id c4-20020a170902c2c400b001870640205cmr34878237pla.11.1667579636802;
        Fri, 04 Nov 2022 09:33:56 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x1-20020aa79561000000b0056dae187730sm3014447pfq.96.2022.11.04.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:33:56 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:33:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
Message-ID: <Y2U+8cM9z0axes2y@google.com>
References: <00000000000035fba305eca64106@google.com>
 <Y2UvigDr9ctxlEEE@google.com>
 <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
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
> On Fri, 4 Nov 2022 at 08:28, 'Sean Christopherson' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Fri, Nov 04, 2022, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    81214a573d19 Add linux-next specific files for 20221103
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=132019de880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc625e9234bac0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=ffb4f000dc2872c93f62
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd52ca880000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/5d4dda497754/disk-81214a57.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/9658efff160a/vmlinux-81214a57.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/3711180f2565/bzImage-81214a57.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> > >
> > > BUG: unable to handle page fault for address: fffffbc5a1c22e00
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
> >
> > I'm pretty sure this is the same thing as
> >
> >   BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff
> >
> > I'll verify and get a patch posted shortly.
> 
> This repro does not create any VMs, it's just:
> 
> iopl(0x3)
> rt_sigreturn()
> 
> Do you still think it's related to the vmx_handle_exit_irqoff issue?

Yes, the issue is that the shadow for the read-only IDT mapping in the CPU entry
area isn't populated (commit 9fd429c28073 ("x86/kasan: Map shadow for percpu pages
on demand") is to blame).  The bug manifests anytime software manually does an IDT
lookup.

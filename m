Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE5461A13F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKDTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKDTi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3296265
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:38:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 136so1346232pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK+m7MRr41PHHav5DC3Ex/mQeW8vO4eMgkutiWS0ewE=;
        b=DB/h8XQZxC2wf0y9ySUzUeAzIG4qd/o+G9/NBU2HkntZu1Y/yu4318g2kpb3yLH7St
         p9ZNmxT1HMlc5M0AKCybE9B1wcYLixSsbDfB0RFmeLpQCYF4OGlxuPZq4yCFe/PDLt7p
         VGxnTOYEAjrhL0dDgwobj7zdjzDCtIxxAtZ2LFY41TB1ANTYEZKTHb0YQxMx32WiwB+4
         yuTpOp3SeZqmzwqXm5tsu+cU+anzUqFu84Ud24mnDlL4KJlwOSjoXPj0PEKium8KlIiC
         LpPFDSdOvN4V/K/6s7JZYnYw4pO9n5FMheXvov4lFD5belJCaonogbWUqm2d5vbgVd3+
         VKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK+m7MRr41PHHav5DC3Ex/mQeW8vO4eMgkutiWS0ewE=;
        b=AY/DOBHOL9tSk07kGj2YUHdFFTh5yGbNmc/WiVPeXTQ0ZFda6M8mQH6HIGWFri5F31
         +w6PgANa666UAIEa9mLa5ZUZxkvHKVD4A3LtfyyAlY6ljgu7Qs+je7MADzNcIzvoB9u1
         sgqFZCLRYw+1TyiyAFwyQgFVS1EdmdW5Mb1pb9oXwcTII1KWevWe4+P+Ow9WBVvTSWyX
         NixEn4uhpuezABWiYGnD/wpxyv7BIosVbJ3dsQJKAEx5q7/U76DesFFuljQntVtZDOp1
         JNYf9Cm/UPbzREZzaMdLjwlqgv9b2Buqg92COvsW4MJFBQlzHSyxNZqBPol4jaFh3eCn
         OdwA==
X-Gm-Message-State: ACrzQf12sG+36mql4dhSxPyvA7+IQS1NAbk3TptPyJSeOUg40XrbHR/k
        mwPblPuaIwdxjvJwcenMnRmhxw==
X-Google-Smtp-Source: AMsMyM4NKA7uI8gQK/Hjqqt9u08c5p7zjb9fEPoD/34sH7oRnv59K5bACJ+nE9EYEcbyhcq8ukh6OA==
X-Received: by 2002:a65:6702:0:b0:470:15c5:4363 with SMTP id u2-20020a656702000000b0047015c54363mr10753268pgf.546.1667590733345;
        Fri, 04 Nov 2022 12:38:53 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o23-20020a63e357000000b00462612c2699sm82510pgj.86.2022.11.04.12.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:38:52 -0700 (PDT)
Date:   Fri, 4 Nov 2022 19:38:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
Message-ID: <Y2VqSBWY/xGM/HBF@google.com>
References: <00000000000035fba305eca64106@google.com>
 <Y2UvigDr9ctxlEEE@google.com>
 <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
 <Y2U+8cM9z0axes2y@google.com>
 <Y2VOU96gcoor288M@google.com>
 <CACT4Y+Y6A0wooT1ua9qcoGuRBV9nF5sfF4q3-tSs3y+AqnGvfA@mail.gmail.com>
 <Y2Vcvf2AiUJ5jCVf@google.com>
 <CACT4Y+ZUiiKNH56QM-JAy0ykh1fJ+CJ-k-aMcWD1euTbviKcwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZUiiKNH56QM-JAy0ykh1fJ+CJ-k-aMcWD1euTbviKcwQ@mail.gmail.com>
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
> On Fri, 4 Nov 2022 at 11:41, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> > > On Fri, 4 Nov 2022 at 10:39, 'Sean Christopherson' via syzkaller-bugs
> > > <syzkaller-bugs@googlegroups.com> wrote:
> > > Can it be out-of-bounds or something?
> >
> > The lookup is on CS.base (I trimmed the stack in my first reply) as part of the
> > IOPL emulation to see if userspace is attempting CLI or STI, so it's not related
> > to the sigframe.
> >
> >   insn_get_seg_base arch/x86/lib/insn-eval.c:725 [inline]
> >   insn_get_effective_ip+0x187/0x1f0 arch/x86/lib/insn-eval.c:1476
> >   fixup_iopl_exception+0xd0/0x190 arch/x86/kernel/traps.c:627
> >   __exc_general_protection arch/x86/kernel/traps.c:752 [inline]
> >   exc_general_protection+0x176/0x210 arch/x86/kernel/traps.c:728
> >   asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:564
> >  RIP: 0003:0x7f250f3abf8c
> >
> > It does look like some form out out-of-bounds selector though.  The offset in the
> > splat suggests CS.sel is something way above __USER_CS, which would explain why
> > insn_get_effective_ip() is doing a lookup in the first place (CS.base is assumed
> > to be 0 if userspace is in 64-bit mode, user_64bit_mode() is true if CS == __USER_CS)),
> > I just can't figure out how that tiny reproducer is getting a bad CS.  And the above
> > RIP strongly suggests userspace is indeed in 64-bit mode.
> 
> My understanding is that rt_sigreturn() restores complete user context
> from the info stored on the stack.
> Normally signal delivery will store that info on the stack first. But
> in this case there is no signal delivery, so rt_sigreturn() reads
> complete garbage from the stack and restores it into the context. I
> assume this can setup any non-sense CS and maybe even pretend this is
> not normal x86_64 mode (?).

Ha!  Indeed, shoving a sigcontext onto the stack that's valid enough to pass
basic checks but throws in a bad CS does the trick.

int main(void)
{
  struct sigcontext regs;
  
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_iopl, 3);

  memset(&regs, 0, sizeof(regs));
  regs.cs = 0x1d0;
  syscall(__NR_rt_sigreturn);
  return 0;
}

Same root cause, different fix.  I'll post officially in a bit.

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index dff9001e5e12..4a6440461c10 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -195,7 +195,7 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
        pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
-       cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
+       cea_map_percpu_pages(&cea->gdt, get_cpu_gdt_rw(cpu), 1, gdt_prot);
 
        cea_map_percpu_pages(&cea->entry_stack_page,
                             per_cpu_ptr(&entry_stack_storage, cpu), 1,

The other bare use of cea_set_pte() in percpu_setup_debug_store() also appears
suspect.  The base debug_store area is mapped, but the buffers are not.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5A73021A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbjFNOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjFNOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14BE4D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 803DB638BD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85366C433C8;
        Wed, 14 Jun 2023 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686753457;
        bh=XtFGXoNLr5Xg1fYKHdLT0cmLOK0PzxwD/t+GFu3PZok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8AZ5oAbcpR1K0zHXSn0dRYPTOCl5sA6Ss2r0lG289q7AoxxL6fnEdmbfj7BeRnA7
         Vnww2msQJmX4hQjhO1oP0AJRFSyYQ5/vMwK6QkgpAFHdLWFfJNk7eS7AfA6UuiRJpq
         z96yi2Bz+X49yZaJWDi2SiaOq6079ABO9fnP+CSSoiyz20BBOxvohX22SGiVJ2UcRB
         JL2KALmWSd9ZcYWO9JknvBMHnHugHIEDV34rN4GPaF9ZRXBBsWSKiTzjGFDL2vnVPt
         VAJDT6hfU9faP3AiqBCy00zuvaGP2t7LE0WooXK9O2d9ha04HYgsrAPd1jbt8lIQ9u
         1NQ++iTkHIQdg==
Date:   Wed, 14 Jun 2023 15:37:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: x86: pgtable / kaslr initialisation (OOB) help
Message-ID: <20230614143732.GW3635807@google.com>
References: <20230614132339.GS3635807@google.com>
 <20230614141654.GA1640123@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614141654.GA1640123@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Peter Zijlstra wrote:

> On Wed, Jun 14, 2023 at 02:23:39PM +0100, Lee Jones wrote:
> > Good afternoon,
> > 
> > I'm looking for a little expert help with a out-of-bounds issue I've
> > been working on.  Please let me know if my present understanding does
> > not quite match reality.
> > 
> > - Report
> > 
> > The following highly indeterministic kernel panic was reported to occur every
> > few hundred boots:
> > 
> >     Kernel panic - not syncing: Fatal exception
> >      RIP: 0010:alloc_ucounts+0x68/0x280
> >      RSP: 0018:ffffb53ac13dfe98 EFLAGS: 00010006
> >      RAX: 0000000000000000 RBX: 000000015b804063 RCX: ffff9bb60d5aa500
> >      RDX: 0000000000000001 RSI: 00000000000003fb RDI: 0000000000000001
> >      RBP: ffffb53ac13dfec0 R08: 0000000000000000 R09: ffffd53abf600000
> >      R10: ffff9bb60b4bdd80 R11: ffffffffbcde7bb0 R12: ffffffffbf04e710
> >      R13: ffffffffbf405160 R14: 00000000000003fb R15: ffffffffbf1afc60
> >      FS:  00007f5be44d5000(0000) GS:ffff9bb6b9cc0000(0000) knlGS:0000000000000000
> >      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >      CR2: 000000015b80407b CR3: 00000001038ea000 CR4: 00000000000406a0
> >      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >      Call Trace:
> >       <TASK>
> >       __sys_setuid+0x1a0/0x290
> >       __x64_sys_setuid+0xc/0x10
> >       do_syscall_64+0x43/0x90
> >       ? asm_exc_page_fault+0x8/0x30
> >       entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > - Problem
> > 
> > The issue was eventually tracked down to the attempted dereference of a value
> > located in a corrupted hash table.  ucounts_hashtable is an array of 1024
> > struct hlists.  Each element is the head of its own linked list where previous
> > ucount allocations are stored.  The [20]th element of ucounts_hashtable was
> > being consistently trashed on each and every boot.  However the indeterminism
> > comes from it being accessed only every few hundred boots.
> > 
> > The issue disappeared, or was at least unidentifiable when !(LTO=full) or when
> > memory base randomisation (a.k.a. KASLR) was disabled, rending GDB all but
> > impossible to use effectively.
> > 
> > The cause of the corruption was uncovered using a verity of different debugging
> > techniques and was eventually tracked down to page table manipulation in early
> > architecture setup.
> > 
> > The following line in arch/x86/realmode/init.c [0] allocates a variable, just 8
> > Bytes in size, to "hold the pgd entry used on booting additional CPUs":
> > 
> >   pgd_t trampoline_pgd_entry;
> > 
> > The address of that variable is then passed from init_trampoline_kaslr() via a
> > call to set_pgd() [1] to have a value (not too important here) assigned to it.
> > Numerous abstractions take place, eventually leading to native_set_p4d(), an
> > inline function [2] contained in arch/x86/include/asm/pgtable_64.h.
> > 
> > From here, intentionally or otherwise, a call to pti_set_user_pgtbl() is made.
> > This is where the out-of-bounds write eventually occurs.  It is not known (by
> > me) why this function is called.  The returned result is subsequently used as a
> > value to write using the WRITE_ONCE macro.  Perhaps the premature write is not
> > intended.  This is what I hope to find out.
> > 
> > A little way down in pti_set_user_pgtbl() [3] the following line occurs:
> > 
> >   kernel_to_user_pgdp(pgdp)->pgd = pgd.pgd
> > 
> > The kernel_to_user_pgdp() part takes the address of pgdp (a.k.a.
> > trampoline_pgd_entry) and ends up flipping the 12th bit, essentially adding 4k
> > (0x1000) to the address.  Then the part at the end assigns our value (still not
> > important here) to it.  However, if we remember that only 8 Bytes was allocated
> > (globally) for trampoline_pgd_entry, then means we just stored the value into
> > the outlands (what we now know to be allocated to another global storage user
> > ucounts_hashtable).
> > 
> > - Ask
> > 
> > Hopefully I haven't messed anything up in the explanation here.  Please let me
> > know if this is the case.  I'm keen to understand what the intention was and
> > what we might do to fix it, if of course this hasn't already been remedied
> > somewhere.
> > 
> > As ever, any help / guidance would be gratefully received.
> 
> This is the PTI, or Page-Table-Isolation muck that is the Meltdown
> mitigation. Basically we end up running with 2 sets of page-tables, a
> kernel and user pagetable, where the user pagetable only contains the
> bare minimum of the kernel to make the transition (and consequently
> userspace cannot access the kernel data).
> 
> The way this is done is by making the PGD two consecutive pages aligned
> to 2*PAGE_SIZE, and a switch between the two CR3 values is a simple
> bitop. The kernel is the first (or lower address) while the user is the
> second (or higher address).
> 
> This is what kernel_to_user_pgdp() is doing, and what you'll find in
> things like SWITCH_TO_{KERNEL,USER}_CR3 from arch/x86/entry/calling.h.
> 
> Now the problem is that:
> 
> 1) this kaslr trampoline stuff does not play by the same rules, but
> triggers it because it's about the first 1M of memory -- aka userspace
> range.
> 
> 2) we've already set X86_FEATURE_PTI by the time this happens
> 
> I've not yet remebered enough of this crap to figure out the best way to
> cure this. Clearly we don't need PTI to perform kalsr, but all of this
> early setup is a giant maze so perhaps PTI is needed for something else
> this early.
> 
> IFF not, the solution might be to set PTI later.

I see.

Still unsure how we (the kernel) can/should write to an area of memory
that does not belong to it.  Should we allocate enough memory
(2*PAGE_SIZE? rather than 8-Bytes) for trampoline_pgd_entry to consume
in a more sane way?

-- 
Lee Jones [李琼斯]

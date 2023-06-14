Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B0772FFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbjFNNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFNNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FA172A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D6660BC3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397FFC433C8;
        Wed, 14 Jun 2023 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686749025;
        bh=qAp1EyPAJ/3UHgu6vuw4vJIYncffs63ClelMAcaMES0=;
        h=Date:From:To:Cc:Subject:From;
        b=nuEcGBGhCCIa7Yu11c5lQemBvsdW38aqdyZgdfqotQj5+acb+Uwy89w3+LsFxL7rB
         /BxtO1UZEDaB3C8ZUZ7OtyBnAZQLpX7qEZgDkwLlFFinv17rzfygp9ia90XC6NS478
         lZLYmERk92GMlz4oGHgqIhb3hYta9MOC8Ilv0lIukbzCFe0O5PCxmEHV2wxuylr4B/
         8oH3thNg0MAIEEMfcU4o4l0DzaCBUtYmgJ4QEqEodk7aXQAIqToPsnyFXqu0i9Hpos
         aR1r03TE2/mtSmioXP2cUZolTPXNcH2xdvGfYob2ZZIPW58mcEfBCPtadQWw0iGrbj
         PFijLfuTAoegA==
Date:   Wed, 14 Jun 2023 14:23:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Lee Jones <lee@kernel.org>
Subject: x86: pgtable / kaslr initialisation (OOB) help
Message-ID: <20230614132339.GS3635807@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,

I'm looking for a little expert help with a out-of-bounds issue I've
been working on.  Please let me know if my present understanding does
not quite match reality.

- Report

The following highly indeterministic kernel panic was reported to occur every
few hundred boots:

    Kernel panic - not syncing: Fatal exception
     RIP: 0010:alloc_ucounts+0x68/0x280
     RSP: 0018:ffffb53ac13dfe98 EFLAGS: 00010006
     RAX: 0000000000000000 RBX: 000000015b804063 RCX: ffff9bb60d5aa500
     RDX: 0000000000000001 RSI: 00000000000003fb RDI: 0000000000000001
     RBP: ffffb53ac13dfec0 R08: 0000000000000000 R09: ffffd53abf600000
     R10: ffff9bb60b4bdd80 R11: ffffffffbcde7bb0 R12: ffffffffbf04e710
     R13: ffffffffbf405160 R14: 00000000000003fb R15: ffffffffbf1afc60
     FS:  00007f5be44d5000(0000) GS:ffff9bb6b9cc0000(0000) knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 000000015b80407b CR3: 00000001038ea000 CR4: 00000000000406a0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     Call Trace:
      <TASK>
      __sys_setuid+0x1a0/0x290
      __x64_sys_setuid+0xc/0x10
      do_syscall_64+0x43/0x90
      ? asm_exc_page_fault+0x8/0x30
      entry_SYSCALL_64_after_hwframe+0x44/0xae

- Problem

The issue was eventually tracked down to the attempted dereference of a value
located in a corrupted hash table.  ucounts_hashtable is an array of 1024
struct hlists.  Each element is the head of its own linked list where previous
ucount allocations are stored.  The [20]th element of ucounts_hashtable was
being consistently trashed on each and every boot.  However the indeterminism
comes from it being accessed only every few hundred boots.

The issue disappeared, or was at least unidentifiable when !(LTO=full) or when
memory base randomisation (a.k.a. KASLR) was disabled, rending GDB all but
impossible to use effectively.

The cause of the corruption was uncovered using a verity of different debugging
techniques and was eventually tracked down to page table manipulation in early
architecture setup.

The following line in arch/x86/realmode/init.c [0] allocates a variable, just 8
Bytes in size, to "hold the pgd entry used on booting additional CPUs":

  pgd_t trampoline_pgd_entry;

The address of that variable is then passed from init_trampoline_kaslr() via a
call to set_pgd() [1] to have a value (not too important here) assigned to it.
Numerous abstractions take place, eventually leading to native_set_p4d(), an
inline function [2] contained in arch/x86/include/asm/pgtable_64.h.

From here, intentionally or otherwise, a call to pti_set_user_pgtbl() is made.
This is where the out-of-bounds write eventually occurs.  It is not known (by
me) why this function is called.  The returned result is subsequently used as a
value to write using the WRITE_ONCE macro.  Perhaps the premature write is not
intended.  This is what I hope to find out.

A little way down in pti_set_user_pgtbl() [3] the following line occurs:

  kernel_to_user_pgdp(pgdp)->pgd = pgd.pgd

The kernel_to_user_pgdp() part takes the address of pgdp (a.k.a.
trampoline_pgd_entry) and ends up flipping the 12th bit, essentially adding 4k
(0x1000) to the address.  Then the part at the end assigns our value (still not
important here) to it.  However, if we remember that only 8 Bytes was allocated
(globally) for trampoline_pgd_entry, then means we just stored the value into
the outlands (what we now know to be allocated to another global storage user
ucounts_hashtable).

- Ask

Hopefully I haven't messed anything up in the explanation here.  Please let me
know if this is the case.  I'm keen to understand what the intention was and
what we might do to fix it, if of course this hasn't already been remedied
somewhere.

As ever, any help / guidance would be gratefully received.

Kind regards,
Lee

[0] https://elixir.bootlin.com/linux/latest/source/arch/x86/realmode/init.c#L18
[1] https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/kaslr.c#L178
[2] https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/pgtable_64.h#L142
[3] https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/pti.c#L142

-- 
Lee Jones [李琼斯]

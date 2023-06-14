Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC69730436
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244864AbjFNPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244838AbjFNPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73AF195
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54E5263A3D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C99C433C8;
        Wed, 14 Jun 2023 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686757968;
        bh=AJyVucwoIxaM7hk3ir8inG10Nh04x4lV/Oh6Cfm53pE=;
        h=From:To:Cc:Subject:Date:From;
        b=YzdjsJvWQr6h2yhmVELon5Fqk487hQhdR8rpMkV52G9CttvAFNz+K9pVfp1LDXyyz
         DwcUhPrUoIv0EEPxP795WtniC1fvaB+16D9y5hobtmo1QdzH+q5xQ7NFzEMta9yDD3
         70N6lLinPTMw0rmuoKtdj0UGWE3xNmqM2RpiEqBQGx8Uopa5r044GvyusGHU05AW8t
         tmoUnO61B9YoWQZK7507sTEXyy+P1RT2EnmiiApHxtXdbXX2m0s3DrMEC8VVDItCMj
         7T84a4KSDwyzrVt4SqH+YKKuaLJsMy1J8oPyWN4s4qKZc/wuyYrWnG7STHNSrpJjRL
         dcrXh3BIlMwDg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] x86: Fix .bss corruption
Date:   Wed, 14 Jun 2023 16:52:09 +0100
Message-ID: <20230614155223.905222-1-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
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

[0] https://elixir.bootlin.com/linux/latest/source/arch/x86/realmode/init.c#L18
[1] https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/kaslr.c#L178
[2] https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/pgtable_64.h#L142
[3] https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/pti.c#L142

Lee Jones (1):
  x86/mm/KASLR: Store pud_page_tramp into entry rather than page

 arch/x86/mm/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog


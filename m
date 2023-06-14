Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9B730527
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjFNQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFNQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2158EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3741364486
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2F3C433C8;
        Wed, 14 Jun 2023 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760760;
        bh=N49DIUM8N1AIbUqV2rLwZ2dEQ1XQhBV1xliOLIOeXd4=;
        h=From:To:Cc:Subject:Date:From;
        b=Z7XbgqIlPAgdyJHIn2m24HrFNNPLjQ9Uzo2REpu9SaaIFGnt3rinRowHcnD4flYhi
         NiWbod/sCD4tHxNR+rGgci2WqjSQ/Tz+76XYt/dZ2+esSoON+9Ez1r96C4s8zJRlLl
         7ppS01YwKpLUYJEKwdb7f+lOCEh/nvIF9k9vR1tZEjI2br4JP4//9Y+XBZYAIOeKwL
         /Sg3/SmNcz5G6mzeTo3NX0SwjXQSGguPfGArNVyh7Bj77VOybpcYsLWtAT0Y8ruoo5
         HzU6YcdMR4CcExzGaEEGt7WLzlbKGgKZVqiY9udr3U75O0JD1wjC3yt9/O0KV0LoZ7
         JAtKfVHpshb0w==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] x86: Fix .bss corruption
Date:   Wed, 14 Jun 2023 17:38:53 +0100
Message-ID: <20230614163859.924309-1-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

 arch/x86/mm/kaslr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog


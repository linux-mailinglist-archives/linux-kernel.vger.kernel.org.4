Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB756866D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjBAN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBAN1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:27:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F94469A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:27:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675258053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6E/Zy5bjPfbqEf7KZTtuKxX7NxDusFVJ01Vzisn4RWU=;
        b=1OsUeRe78OBdcW704sxCwMF6t4Xlp+6nX/ZVsX7bz490eqLhBR6zyBZzXjvv3bKZcR4uPd
        F4uMmbDHv1KNnzqVUnEOFhm1GmFHARZ20xGDkFK18Vc5IRFs4tCrHbTQNYDTUjRD50Df+R
        VedwsF8/53YHfidIgsdNDzeoJIn8XxRsgTt+ERCLvozYFq5ydVY4PUyXBeTq6iVCPo9JCJ
        xpw5tqkZloVnDRkBS4cXpBnpwqsLC+SWqLIDUcV5zURUolrnccU8YyEiarisGUDdpzGE59
        DEgTEE9lOZ+2+jdmJ1FcdrbutK2qIn+/25NkN0aq0eNr9k9Qj5WOKmrx7u2riw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675258053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6E/Zy5bjPfbqEf7KZTtuKxX7NxDusFVJ01Vzisn4RWU=;
        b=5NxabF6mLuqwuvxI2LNIiQHaU+3uHJm9egcwksUhan3+JNHB3Ei5xqHNNdxUIE1zhQ6tIV
        LIyNTnxuUJoLVZDQ==
To:     kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <202302011308.f53123d2-oliver.sang@intel.com>
References: <202302011308.f53123d2-oliver.sang@intel.com>
Date:   Wed, 01 Feb 2023 14:27:33 +0100
Message-ID: <87o7qdzfay.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01 2023 at 14:02, kernel test robot wrote:
> FYI, we noticed WARNING:at_kernel/locking/lockdep.c:#lockdep_hardirqs_on_prepare due to commit (built with gcc-11):
>
> commit: 02fb8013ee5f9b7d7bc35d54bf8bc5fe1179970c ("[PATCH 5/5] genirq: Use the maple tree for IRQ descriptors management")
> url: https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/genirq-Use-hlist-for-managing-resend-handlers/20230130-085956
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 188a569658584e93930ab60334c5a1079c0330d8
> patch link: https://lore.kernel.org/all/20230130005725.3517597-6-sdonthineni@nvidia.com/
> patch subject: [PATCH 5/5] genirq: Use the maple tree for IRQ
> descriptors management

> [    2.214554][    T0] ------------[ cut here ]------------
> [    2.215401][    T0] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
> [    2.215446][    T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4308 lockdep_hardirqs_on_prepare+0x2d4/0x350
> [    2.217975][    T0] Modules linked in:
> [    2.218526][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc3-00015-g02fb8013ee5f #1
> [    2.219803][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> [    2.221228][    T0] RIP: 0010:lockdep_hardirqs_on_prepare+0x2d4/0x350
> [    2.222207][    T0] Code: 11 38 d0 7c 04 84 d2 75 5e 8b 0d bf 8b f7 03 85 c9 0f 85 c9 fe ff ff 48 c7 c6 40 7d a9 83 48 c7 c7 60 4e a9 83 e8 60 7c 35 02 <0f> 0b e9 af fe ff ff e8 50 8d 62 00 e9 0c fe ff ff e8 e6 8d 62 00
> [    2.224923][    T0] RSP: 0000:ffffffff844075a0 EFLAGS: 00010082
> [    2.225792][    T0] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    2.226889][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffbfff0880ea6
> [    2.227955][    T0] RBP: ffff8883af23fac0 R08: 0000000000000000 R09: ffffffff844072df
> [    2.229068][    T0] R10: fffffbfff0880e5b R11: 0000000000000001 R12: 0000000000000002
> [    2.230147][    T0] R13: 0000000000000002 R14: ffff88810022b018 R15: ffff88810022b010
> [    2.231269][    T0] FS:  0000000000000000(0000) GS:ffff8883af200000(0000) knlGS:0000000000000000
> [    2.232522][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.233395][    T0] CR2: ffff88843ffff000 CR3: 000000000442a000 CR4: 00000000000406b0
> [    2.234504][    T0] Call Trace:
> [    2.234941][    T0]  <TASK>
> [    2.235345][    T0]  trace_hardirqs_on+0x40/0x140
> [    2.236029][    T0]  __kmem_cache_alloc_bulk+0x22e/0x490
> [    2.236795][    T0]  ? kasan_set_track+0x25/0x30
> [    2.237470][    T0]  kmem_cache_alloc_bulk+0x159/0x2e0
> [    2.238225][    T0]  mas_alloc_nodes+0x253/0x690
> [    2.238886][    T0]  mas_split+0x30d/0x1580
> [    2.239561][    T0]  ? mas_push_data+0x1a40/0x1a40
> [    2.240219][    T0]  ? memset+0x24/0x50
> [    2.240782][    T0]  ? blake2s_final+0x110/0x140
> [    2.241426][    T0]  ? blake2s+0x115/0x150
> [    2.242143][    T0]  ? wait_for_random_bytes+0xd0/0xd0
> [    2.242859][    T0]  ? mas_mab_cp+0x2f6/0x890
> [    2.243527][    T0]  ? memset+0x24/0x50
> [    2.244122][    T0]  ? find_held_lock+0x2c/0x110
> [    2.244803][    T0]  ? mas_store_b_node+0x54c/0x1180
> [    2.245510][    T0]  ? rcu_read_lock_sched_held+0x16/0x80
> [    2.246282][    T0]  mas_wr_bnode+0x14f/0x1d0
> [    2.246902][    T0]  ? mas_commit_b_node+0x600/0x600
> [    2.247677][    T0]  ? secondary_startup_64_no_verify+0xe0/0xeb
> [    2.248567][    T0]  ? ___slab_alloc+0x70b/0xe00
> [    2.249251][    T0]  ? mas_wr_store_entry+0x2e9/0xe30
> [    2.250088][    T0]  ? rcu_read_lock_sched_held+0x16/0x80
> [    2.250864][    T0]  mas_store_gfp+0xc2/0x190
> [    2.251516][    T0]  ? mtree_erase+0x100/0x100
> [    2.252190][    T0]  ? lockdep_init_map_type+0x2c7/0x780
> [    2.252924][    T0]  irq_insert_desc+0xac/0xf0
> [    2.253562][    T0]  ? irq_kobj_release+0x100/0x100
> [    2.254243][    T0]  early_irq_init+0x81/0x8c
> [    2.254866][    T0]  start_kernel+0x1c7/0x3a4
> [    2.255479][    T0]  secondary_startup_64_no_verify+0xe0/0xeb

This triggers because __kmem_cache_alloc_bulk() uses
lock_irq()/unlock_irq(). Seems nobody used it during early boot stage
yet. Though the maple tree conversion of the interrupt descriptor
storage which is the purpose of the patch in question makes that happen.

Fix below.

Thanks,

        tglx
---
Subject: mm, slub: Take slab lock with irqsave()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 01 Feb 2023 14:14:00 +0100

<Add blurb>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 mm/slub.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3913,6 +3913,7 @@ static inline int __kmem_cache_alloc_bul
 			size_t size, void **p, struct obj_cgroup *objcg)
 {
 	struct kmem_cache_cpu *c;
+	unsigned long irqflags;
 	int i;
 
 	/*
@@ -3921,7 +3922,7 @@ static inline int __kmem_cache_alloc_bul
 	 * handlers invoking normal fastpath.
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
-	local_lock_irq(&s->cpu_slab->lock);
+	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3942,7 +3943,7 @@ static inline int __kmem_cache_alloc_bul
 			 */
 			c->tid = next_tid(c->tid);
 
-			local_unlock_irq(&s->cpu_slab->lock);
+			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
 
 			/*
 			 * Invoking slow path likely have side-effect
@@ -3956,7 +3957,7 @@ static inline int __kmem_cache_alloc_bul
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
-			local_lock_irq(&s->cpu_slab->lock);
+			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
 
 			continue; /* goto for-loop */
 		}
@@ -3965,7 +3966,7 @@ static inline int __kmem_cache_alloc_bul
 		maybe_wipe_obj_freeptr(s, p[i]);
 	}
 	c->tid = next_tid(c->tid);
-	local_unlock_irq(&s->cpu_slab->lock);
+	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
 	slub_put_cpu_ptr(s->cpu_slab);
 
 	return i;



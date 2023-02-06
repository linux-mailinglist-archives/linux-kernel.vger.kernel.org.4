Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4968BFFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjBFOYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBFOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:24:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E88271F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:24:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5D403E77D;
        Mon,  6 Feb 2023 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675693469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaWJCZn5wk4cwp/DWLmXG4NK2srtynO5Bfwei+Wbao4=;
        b=t33vZtSZap1swUa8tn75NNZhHT899H2+/m09VJf/YG/rSBH38mCtGI8zyR8NqWrNohcflB
        7wK9RVyDx7kMSgHSKUQB4EPWaSf9qZvLNP14mG/1MPynWQppB4JN4HD9gTpFLJXhzc2b/9
        1oWULyD113Pdd0U7pho5Gxvaalttrco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675693469;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaWJCZn5wk4cwp/DWLmXG4NK2srtynO5Bfwei+Wbao4=;
        b=svjUMC4UH8wUuVJ4injC+pTH+ngDMSLgXgrf6DBmpnu17P2K8AerBccuYrcea9gZS2sE1O
        yEQqcwHG/wygzBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CB5B138E7;
        Mon,  6 Feb 2023 14:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pRenHZ0N4WMiSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 06 Feb 2023 14:24:29 +0000
Message-ID: <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
Date:   Mon, 6 Feb 2023 15:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors
 management
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <87o7qdzfay.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 14:27, Thomas Gleixner wrote:
> On Wed, Feb 01 2023 at 14:02, kernel test robot wrote:
>> FYI, we noticed WARNING:at_kernel/locking/lockdep.c:#lockdep_hardirqs_on_prepare due to commit (built with gcc-11):
>>
>> commit: 02fb8013ee5f9b7d7bc35d54bf8bc5fe1179970c ("[PATCH 5/5] genirq: Use the maple tree for IRQ descriptors management")
>> url: https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/genirq-Use-hlist-for-managing-resend-handlers/20230130-085956
>> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 188a569658584e93930ab60334c5a1079c0330d8
>> patch link: https://lore.kernel.org/all/20230130005725.3517597-6-sdonthineni@nvidia.com/
>> patch subject: [PATCH 5/5] genirq: Use the maple tree for IRQ
>> descriptors management
> 
>> [    2.214554][    T0] ------------[ cut here ]------------
>> [    2.215401][    T0] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
>> [    2.215446][    T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4308 lockdep_hardirqs_on_prepare+0x2d4/0x350
>> [    2.217975][    T0] Modules linked in:
>> [    2.218526][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc3-00015-g02fb8013ee5f #1
>> [    2.219803][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
>> [    2.221228][    T0] RIP: 0010:lockdep_hardirqs_on_prepare+0x2d4/0x350
>> [    2.222207][    T0] Code: 11 38 d0 7c 04 84 d2 75 5e 8b 0d bf 8b f7 03 85 c9 0f 85 c9 fe ff ff 48 c7 c6 40 7d a9 83 48 c7 c7 60 4e a9 83 e8 60 7c 35 02 <0f> 0b e9 af fe ff ff e8 50 8d 62 00 e9 0c fe ff ff e8 e6 8d 62 00
>> [    2.224923][    T0] RSP: 0000:ffffffff844075a0 EFLAGS: 00010082
>> [    2.225792][    T0] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
>> [    2.226889][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffbfff0880ea6
>> [    2.227955][    T0] RBP: ffff8883af23fac0 R08: 0000000000000000 R09: ffffffff844072df
>> [    2.229068][    T0] R10: fffffbfff0880e5b R11: 0000000000000001 R12: 0000000000000002
>> [    2.230147][    T0] R13: 0000000000000002 R14: ffff88810022b018 R15: ffff88810022b010
>> [    2.231269][    T0] FS:  0000000000000000(0000) GS:ffff8883af200000(0000) knlGS:0000000000000000
>> [    2.232522][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    2.233395][    T0] CR2: ffff88843ffff000 CR3: 000000000442a000 CR4: 00000000000406b0
>> [    2.234504][    T0] Call Trace:
>> [    2.234941][    T0]  <TASK>
>> [    2.235345][    T0]  trace_hardirqs_on+0x40/0x140
>> [    2.236029][    T0]  __kmem_cache_alloc_bulk+0x22e/0x490
>> [    2.236795][    T0]  ? kasan_set_track+0x25/0x30
>> [    2.237470][    T0]  kmem_cache_alloc_bulk+0x159/0x2e0
>> [    2.238225][    T0]  mas_alloc_nodes+0x253/0x690
>> [    2.238886][    T0]  mas_split+0x30d/0x1580
>> [    2.239561][    T0]  ? mas_push_data+0x1a40/0x1a40
>> [    2.240219][    T0]  ? memset+0x24/0x50
>> [    2.240782][    T0]  ? blake2s_final+0x110/0x140
>> [    2.241426][    T0]  ? blake2s+0x115/0x150
>> [    2.242143][    T0]  ? wait_for_random_bytes+0xd0/0xd0
>> [    2.242859][    T0]  ? mas_mab_cp+0x2f6/0x890
>> [    2.243527][    T0]  ? memset+0x24/0x50
>> [    2.244122][    T0]  ? find_held_lock+0x2c/0x110
>> [    2.244803][    T0]  ? mas_store_b_node+0x54c/0x1180
>> [    2.245510][    T0]  ? rcu_read_lock_sched_held+0x16/0x80
>> [    2.246282][    T0]  mas_wr_bnode+0x14f/0x1d0
>> [    2.246902][    T0]  ? mas_commit_b_node+0x600/0x600
>> [    2.247677][    T0]  ? secondary_startup_64_no_verify+0xe0/0xeb
>> [    2.248567][    T0]  ? ___slab_alloc+0x70b/0xe00
>> [    2.249251][    T0]  ? mas_wr_store_entry+0x2e9/0xe30
>> [    2.250088][    T0]  ? rcu_read_lock_sched_held+0x16/0x80
>> [    2.250864][    T0]  mas_store_gfp+0xc2/0x190
>> [    2.251516][    T0]  ? mtree_erase+0x100/0x100
>> [    2.252190][    T0]  ? lockdep_init_map_type+0x2c7/0x780
>> [    2.252924][    T0]  irq_insert_desc+0xac/0xf0
>> [    2.253562][    T0]  ? irq_kobj_release+0x100/0x100
>> [    2.254243][    T0]  early_irq_init+0x81/0x8c
>> [    2.254866][    T0]  start_kernel+0x1c7/0x3a4
>> [    2.255479][    T0]  secondary_startup_64_no_verify+0xe0/0xeb
> 
> This triggers because __kmem_cache_alloc_bulk() uses
> lock_irq()/unlock_irq(). Seems nobody used it during early boot stage
> yet. Though the maple tree conversion of the interrupt descriptor
> storage which is the purpose of the patch in question makes that happen.
> 
> Fix below.

Looks like it should work. But I think we also need to adjust SLAB's
mm/slab.c kmem_cache_alloc_bulk() which does local_irq_disable(); /
local_irq_enable(); right?

Also if we enter this with IRQ's disabled, then we should take care about
the proper gfp flags. Looking at the patch [1] I see

WARN_ON(mas_store_gfp(&mas, desc, GFP_KERNEL) != 0);

so GFP_KERNEL would be wrong with irqs disabled, looks like a case for
GFP_ATOMIC.
OTOH I can see the thing it replaces was:

static RADIX_TREE(irq_desc_tree, GFP_KERNEL);

so that's also a GFP_KERNEL and we haven't seen debug splats from
might_alloc() checks before in this code?. That's weird, or maybe the case
of "we didn't enable irqs yet on this cpu being bootstrapped" is handled
differently than "we have temporarily disabled irqs"? Sure, during early
boot we should have all the memory and no need to reclaim...


[1]
https://lore.kernel.org/all/20230130005725.3517597-6-sdonthineni@nvidia.com/#t

> Thanks,
> 
>         tglx
> ---
> Subject: mm, slub: Take slab lock with irqsave()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 01 Feb 2023 14:14:00 +0100
> 
> <Add blurb>

Will you add the blurb, and the SLAB part, or should I? And once done should
I put it in slab tree for 6.3 or want to make it part of the series so it's
not blocked?

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  mm/slub.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3913,6 +3913,7 @@ static inline int __kmem_cache_alloc_bul
>  			size_t size, void **p, struct obj_cgroup *objcg)
>  {
>  	struct kmem_cache_cpu *c;
> +	unsigned long irqflags;
>  	int i;
>  
>  	/*
> @@ -3921,7 +3922,7 @@ static inline int __kmem_cache_alloc_bul
>  	 * handlers invoking normal fastpath.
>  	 */
>  	c = slub_get_cpu_ptr(s->cpu_slab);
> -	local_lock_irq(&s->cpu_slab->lock);
> +	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>  
>  	for (i = 0; i < size; i++) {
>  		void *object = kfence_alloc(s, s->object_size, flags);
> @@ -3942,7 +3943,7 @@ static inline int __kmem_cache_alloc_bul
>  			 */
>  			c->tid = next_tid(c->tid);
>  
> -			local_unlock_irq(&s->cpu_slab->lock);
> +			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
>  
>  			/*
>  			 * Invoking slow path likely have side-effect
> @@ -3956,7 +3957,7 @@ static inline int __kmem_cache_alloc_bul
>  			c = this_cpu_ptr(s->cpu_slab);
>  			maybe_wipe_obj_freeptr(s, p[i]);
>  
> -			local_lock_irq(&s->cpu_slab->lock);
> +			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>  
>  			continue; /* goto for-loop */
>  		}
> @@ -3965,7 +3966,7 @@ static inline int __kmem_cache_alloc_bul
>  		maybe_wipe_obj_freeptr(s, p[i]);
>  	}
>  	c->tid = next_tid(c->tid);
> -	local_unlock_irq(&s->cpu_slab->lock);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
>  	slub_put_cpu_ptr(s->cpu_slab);
>  
>  	return i;
> 
> 


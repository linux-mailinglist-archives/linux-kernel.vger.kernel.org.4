Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1B68DBFD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjBGOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBGOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:47:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BC4138
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:47:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94C213FA0D;
        Tue,  7 Feb 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675781228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1euP+5g3F8dmaNFSkEY7841ge/tRXwdJuU/Jmr7LVE=;
        b=eiINbXN15J5Isq2zx4nrwklAKQFKf8+anD5bWhkebxn6IaVsdPsXMEw9hRNPTUnBkkLxuV
        hohaG1Gh26MLhiarvm6wD6e8RGbWGrJvOaQjL2etshHYx7MljcDqkBxYZutPtHoTk410C3
        /Srv/Twmx6vuB0jEOUkeBeS+bRAlyMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675781228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1euP+5g3F8dmaNFSkEY7841ge/tRXwdJuU/Jmr7LVE=;
        b=blR7tP0V4qEsqmauw75NEbGVD4W9KrmhFvSLeq/F3KeMKGpAPdxyOtOED4UdFmB7qATL5Y
        96a1LXdhg8jr1CDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BE2B13467;
        Tue,  7 Feb 2023 14:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WiHBEWxk4mPaFwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Feb 2023 14:47:08 +0000
Message-ID: <8b7762c3-02be-a5c9-1c4d-507cfb51a15c@suse.cz>
Date:   Tue, 7 Feb 2023 15:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
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
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx> <871qn1wofe.ffs@tglx>
 <6c0b681e-97bc-d975-a8b9-500abdaaf0bc@suse.cz>
In-Reply-To: <6c0b681e-97bc-d975-a8b9-500abdaaf0bc@suse.cz>
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

On 2/7/23 15:45, Vlastimil Babka wrote:
> On 2/7/23 15:16, Thomas Gleixner wrote:
>> The memory allocators are available during early boot even in the phase
>> where interrupts are disabled and scheduling is not yet possible.
>> 
>> The setup is so that GFP_KERNEL allocations work in this phase without
>> causing might_alloc() splats to be emitted because the system state is
>> SYSTEM_BOOTING at that point which prevents the warnings to trigger.
>> 
>> Most allocation/free functions use local_irq_save()/restore() or a lock
>> variant of that. But kmem_cache_alloc_bulk() and kmem_cache_free_bulk() use
>> local_[lock]_irq_disable()/enable(), which leads to a lockdep warning when
>> interrupts are enabled during the early boot phase.
>> 
>> This went unnoticed so far as there are no early users of these
>> interfaces. The upcoming conversion of the interrupt descriptor store from
>> radix_tree to maple_tree triggered this warning as maple_tree uses the bulk
>> interface.
>> 
>> Cure this by moving the kmem_cache_alloc/free() bulk variants of SLUB and
>> SLAB to local[_lock]_irq_save()/restore().
>> 
>> There is obviously no reclaim possible and required at this point so there
>> is no need to expand this coverage further.
>> 
>> No functional change.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> +Cc rest of slab folks
> 
> Thanks, added to slab/for-6.3/fixes

After your patch, I think it also makes sense to do the following:
----8<----
From 340d7c7b99f3e67780f6dec480ed1d27e6f325eb Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 7 Feb 2023 15:34:53 +0100
Subject: [PATCH] mm, slab/slub: remove notes that bulk alloc/free needs
 interrupts enabled

The slab functions kmem_cache_[alloc|free]_bulk() have been documented
as requiring interrupts to be enabled, since their addition in 2015.
It's unclear whether that was a fundamental restriction, or an attempt
to save some cpu cycles by not having to save and restore the irq flags.

However, it appears that most of the code involved was/became safe to be
called with interrupts disabled, and the remaining bits were fixed by
commit f244b0182b8e ("mm, slab/slub: Ensure kmem_cache_alloc_bulk() is
available early"). While the commit was aimed at early boot scenario, we
can now also remove the documented restrictions for any interrupt
disabled scenarios.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 2 --
 mm/slub.c            | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 45af70315a94..ea439b4e2b34 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -481,8 +481,6 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
  * metadata structures unnecessarily.
- *
- * Note that interrupts must be enabled when calling these functions.
  */
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
 int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
diff --git a/mm/slub.c b/mm/slub.c
index c16d78698e3f..23b3fb86045d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3889,7 +3889,6 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	return same;
 }
 
-/* Note that interrupts must be enabled when calling this function. */
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	if (!size)
@@ -4009,7 +4008,6 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 }
 #endif /* CONFIG_SLUB_TINY */
 
-/* Note that interrupts must be enabled when calling this function. */
 int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			  void **p)
 {
-- 
2.39.1




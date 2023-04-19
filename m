Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB06E7497
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjDSID3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjDSIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:03:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93C30F8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:03:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C9E8D1FD87;
        Wed, 19 Apr 2023 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681891397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlSYbYryU4jjk+BGdngS93om7BXz5+VfainCEWdrZZY=;
        b=hf2iFPF5Hn50QE1fOamw1ZlHAK42J5yzoTsydNl4kHhV3qAwIPXByYxDmWfHEX9gUbUISP
        vWh+UKnbhcP//0Wrw7s99EA3Kkc6oSP3Z/+MR7l1EA1oz1izXDpDyhO6H16zM0938HwwnP
        pU6Wdos463O6mv4/XRpJh7K8b3homgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681891397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlSYbYryU4jjk+BGdngS93om7BXz5+VfainCEWdrZZY=;
        b=9bZuRAexrUicuQ6GrXi6eO/ZsVRjuCYg/Q+RzVRXrycCiiRXRMgF1Z/TknfrlEvjN8MKSW
        T9aOBgD9HzUIhZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97D7B1390E;
        Wed, 19 Apr 2023 08:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PWcDJEWgP2SEVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Apr 2023 08:03:17 +0000
Message-ID: <6f183ff4-f23e-b82a-3524-2d1f5d833a2d@suse.cz>
Date:   Wed, 19 Apr 2023 10:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] kasan: Fix lockdep report invalid wait context
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Zqiang <qiang1.zhang@intel.com>, elver@google.com,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230327120019.1027640-1-qiang1.zhang@intel.com>
 <f16db6f6-2699-bb8f-d34c-2ce3d37a6498@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f16db6f6-2699-bb8f-d34c-2ce3d37a6498@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 04:52, Qi Zheng wrote:
> 
> 
> On 2023/3/27 20:00, Zqiang wrote:
>> For kernels built with the following options and booting
>> 
>> CONFIG_SLUB=y
>> CONFIG_DEBUG_LOCKDEP=y
>> CONFIG_PROVE_LOCKING=y
>> CONFIG_PROVE_RAW_LOCK_NESTING=y
>> 
>> [    0.523115] [ BUG: Invalid wait context ]
>> [    0.523315] 6.3.0-rc1-yocto-standard+ #739 Not tainted
>> [    0.523649] -----------------------------
>> [    0.523663] swapper/0/0 is trying to lock:
>> [    0.523663] ffff888035611360 (&c->lock){....}-{3:3}, at: put_cpu_partial+0x2e/0x1e0
>> [    0.523663] other info that might help us debug this:
>> [    0.523663] context-{2:2}
>> [    0.523663] no locks held by swapper/0/0.
>> [    0.523663] stack backtrace:
>> [    0.523663] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc1-yocto-standard+ #739
>> [    0.523663] Call Trace:
>> [    0.523663]  <IRQ>
>> [    0.523663]  dump_stack_lvl+0x64/0xb0
>> [    0.523663]  dump_stack+0x10/0x20
>> [    0.523663]  __lock_acquire+0x6c4/0x3c10
>> [    0.523663]  lock_acquire+0x188/0x460
>> [    0.523663]  put_cpu_partial+0x5a/0x1e0
>> [    0.523663]  __slab_free+0x39a/0x520
>> [    0.523663]  ___cache_free+0xa9/0xc0
>> [    0.523663]  qlist_free_all+0x7a/0x160
>> [    0.523663]  per_cpu_remove_cache+0x5c/0x70
>> [    0.523663]  __flush_smp_call_function_queue+0xfc/0x330
>> [    0.523663]  generic_smp_call_function_single_interrupt+0x13/0x20
>> [    0.523663]  __sysvec_call_function+0x86/0x2e0
>> [    0.523663]  sysvec_call_function+0x73/0x90
>> [    0.523663]  </IRQ>
>> [    0.523663]  <TASK>
>> [    0.523663]  asm_sysvec_call_function+0x1b/0x20
>> [    0.523663] RIP: 0010:default_idle+0x13/0x20
>> [    0.523663] RSP: 0000:ffffffff83e07dc0 EFLAGS: 00000246
>> [    0.523663] RAX: 0000000000000000 RBX: ffffffff83e1e200 RCX: ffffffff82a83293
>> [    0.523663] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8119a6b1
>> [    0.523663] RBP: ffffffff83e07dc8 R08: 0000000000000001 R09: ffffed1006ac0d66
>> [    0.523663] R10: ffff888035606b2b R11: ffffed1006ac0d65 R12: 0000000000000000
>> [    0.523663] R13: ffffffff83e1e200 R14: ffffffff84a7d980 R15: 0000000000000000
>> [    0.523663]  default_idle_call+0x6c/0xa0
>> [    0.523663]  do_idle+0x2e1/0x330
>> [    0.523663]  cpu_startup_entry+0x20/0x30
>> [    0.523663]  rest_init+0x152/0x240
>> [    0.523663]  arch_call_rest_init+0x13/0x40
>> [    0.523663]  start_kernel+0x331/0x470
>> [    0.523663]  x86_64_start_reservations+0x18/0x40
>> [    0.523663]  x86_64_start_kernel+0xbb/0x120
>> [    0.523663]  secondary_startup_64_no_verify+0xe0/0xeb
>> [    0.523663]  </TASK>
>> 
>> The local_lock_irqsave() is invoked in put_cpu_partial() and happens
>> in IPI context, due to the CONFIG_PROVE_RAW_LOCK_NESTING=y (the
>> LD_WAIT_CONFIG not equal to LD_WAIT_SPIN), so acquire local_lock in
>> IPI context will trigger above calltrace.
> 
> Just to add another similar case:
> 
> Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x69/0x97
>   __lock_acquire+0x4a0/0x1b50
>   lock_acquire+0x261/0x2c0
>   ? restore_bytes+0x40/0x40
>   local_lock_acquire+0x21/0x70
>   ? restore_bytes+0x40/0x40
>   put_cpu_partial+0x41/0x130
>   ? flush_smp_call_function_queue+0x125/0x4d0
>   kfree+0x250/0x2c0
>   flush_smp_call_function_queue+0x125/0x4d0
>   __sysvec_call_function_single+0x3a/0x100
>   sysvec_call_function_single+0x4b/0x90
>   </IRQ>
>   <TASK>
>   asm_sysvec_call_function_single+0x16/0x20
> 
> So we can't call kfree() and its friends in interrupt context?

We can (well not RT "hard IRQ" context AFAIK, but that shouldn't be the case
here), although I don't see from the part that you posted if it's again
CONFIG_PROVE_RAW_LOCK_NESTING clashing with something else (no KASAN in the
trace or I'm missing it?)

> Also +Vlastimil Babka.
> 
> Thanks,
> Qi
> 
>> 
>> This commit therefore move qlist_free_all() from hard-irq context to
>> task context.
>> 
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>> ---
>>   v1->v2:
>>   Modify the commit information and add Cc.
>> 
>>   mm/kasan/quarantine.c | 34 ++++++++--------------------------
>>   1 file changed, 8 insertions(+), 26 deletions(-)
>> 
>> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
>> index 75585077eb6d..152dca73f398 100644
>> --- a/mm/kasan/quarantine.c
>> +++ b/mm/kasan/quarantine.c
>> @@ -99,7 +99,6 @@ static unsigned long quarantine_size;
>>   static DEFINE_RAW_SPINLOCK(quarantine_lock);
>>   DEFINE_STATIC_SRCU(remove_cache_srcu);
>>   
>> -#ifdef CONFIG_PREEMPT_RT
>>   struct cpu_shrink_qlist {
>>   	raw_spinlock_t lock;
>>   	struct qlist_head qlist;
>> @@ -108,7 +107,6 @@ struct cpu_shrink_qlist {
>>   static DEFINE_PER_CPU(struct cpu_shrink_qlist, shrink_qlist) = {
>>   	.lock = __RAW_SPIN_LOCK_UNLOCKED(shrink_qlist.lock),
>>   };
>> -#endif
>>   
>>   /* Maximum size of the global queue. */
>>   static unsigned long quarantine_max_size;
>> @@ -319,16 +317,6 @@ static void qlist_move_cache(struct qlist_head *from,
>>   	}
>>   }
>>   
>> -#ifndef CONFIG_PREEMPT_RT
>> -static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
>> -{
>> -	struct kmem_cache *cache = arg;
>> -	struct qlist_head to_free = QLIST_INIT;
>> -
>> -	qlist_move_cache(q, &to_free, cache);
>> -	qlist_free_all(&to_free, cache);
>> -}
>> -#else
>>   static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
>>   {
>>   	struct kmem_cache *cache = arg;
>> @@ -340,7 +328,6 @@ static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
>>   	qlist_move_cache(q, &sq->qlist, cache);
>>   	raw_spin_unlock_irqrestore(&sq->lock, flags);
>>   }
>> -#endif
>>   
>>   static void per_cpu_remove_cache(void *arg)
>>   {
>> @@ -362,6 +349,8 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>>   {
>>   	unsigned long flags, i;
>>   	struct qlist_head to_free = QLIST_INIT;
>> +	int cpu;
>> +	struct cpu_shrink_qlist *sq;
>>   
>>   	/*
>>   	 * Must be careful to not miss any objects that are being moved from
>> @@ -372,20 +361,13 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>>   	 */
>>   	on_each_cpu(per_cpu_remove_cache, cache, 1);
>>   
>> -#ifdef CONFIG_PREEMPT_RT
>> -	{
>> -		int cpu;
>> -		struct cpu_shrink_qlist *sq;
>> -
>> -		for_each_online_cpu(cpu) {
>> -			sq = per_cpu_ptr(&shrink_qlist, cpu);
>> -			raw_spin_lock_irqsave(&sq->lock, flags);
>> -			qlist_move_cache(&sq->qlist, &to_free, cache);
>> -			raw_spin_unlock_irqrestore(&sq->lock, flags);
>> -		}
>> -		qlist_free_all(&to_free, cache);
>> +	for_each_online_cpu(cpu) {
>> +		sq = per_cpu_ptr(&shrink_qlist, cpu);
>> +		raw_spin_lock_irqsave(&sq->lock, flags);
>> +		qlist_move_cache(&sq->qlist, &to_free, cache);
>> +		raw_spin_unlock_irqrestore(&sq->lock, flags);
>>   	}
>> -#endif
>> +	qlist_free_all(&to_free, cache);
>>   
>>   	raw_spin_lock_irqsave(&quarantine_lock, flags);
>>   	for (i = 0; i < QUARANTINE_BATCHES; i++) {
> 


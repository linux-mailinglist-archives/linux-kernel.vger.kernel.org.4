Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC7654B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLWC3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiLWC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:29:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953162C5;
        Thu, 22 Dec 2022 18:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D9B1B81F51;
        Fri, 23 Dec 2022 02:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B26C433EF;
        Fri, 23 Dec 2022 02:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671762553;
        bh=YUA7NW/YjEael4wnH+SUazl990K3DLH51CosWijVaXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CwPP7uSNfIBDnrSmOGAzJTtbTIGpVJAlg8hdLDCfH6V/RqpZC/QYhmjbW3CRvCG/k
         0VHOYfkynsELXiOhtb2B9rCYtMLSRu1IBByhgF+QckJ6f7RE7rrBSbB8xeyVqmJ9/i
         +3QhpEumGAzmk0ZL7Ys3p1vZKjNWChq19EwGDMAVkenlUZs62037gi6j3qML8SsfMb
         LvQ2NCTco8AtCeOPGRCjb4wzYiupLgNqN2moftVx6gmRkFUXhBrVNUWCSl5HUSeP/9
         czNT38cZUT5wsUZZ5/f+o0uAZt5+Cji081BAyr7a+5DIDTHpT6MkFAkrAe6LFCjVzn
         EhQC0AQTlH7Og==
Date:   Fri, 23 Dec 2022 11:29:08 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     wuqiang <wuqiang.matt@bytedance.com>, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] lib: objpool added: ring-array based lockless
 MPMC queue
Message-Id: <20221223112908.de0ce1febba4f314f379a8de@kernel.org>
In-Reply-To: <20221223004701.80fd132089e6a8b14531cf30@kernel.org>
References: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
        <20221212123153.190888-2-wuqiang.matt@bytedance.com>
        <20221223004701.80fd132089e6a8b14531cf30@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Dec 2022 00:47:01 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +/* try to retrieve object from slot */
> > +static inline void *objpool_try_get_slot(struct objpool_slot *os)
> > +{
> > +	uint32_t *ages = SLOT_AGES(os);
> > +	void **ents = SLOT_ENTS(os);
> > +	/* do memory load of head to local head */
> > +	uint32_t head = smp_load_acquire(&os->head);
> > +
> > +	/* loop if slot isn't empty */
> > +	while (head != READ_ONCE(os->tail)) {
> > +		uint32_t id = head & os->mask, prev = head;
> > +
> > +		/* do prefetching of object ents */
> > +		prefetch(&ents[id]);
> > +
> > +		/*
> > +		 * check whether this item was ready for retrieval ? There's
> > +		 * possibility * in theory * we might retrieve wrong object,
> > +		 * in case ages[id] overflows when current task is sleeping,
> > +		 * but it will take very very long to overflow an uint32_t
> > +		 */
> 
> We should make sure it is safe in theory. The hot path can be loose but
> it must be ensured before use. OS can be used very long time in some time
> (e.g. 10 years) and uint32 is too short ... (uint64 is OK)

OK, I understand what you concerned here. This means that the ages[id]
overflows *and* back to the same value during here. But must objpool_pop()
be called under preempt disabled? If not, it should be (and that must not
be a big overhead).

> > +		if (smp_load_acquire(&ages[id]) == head) {
> > +			/* node must have been udpated by push() */

Please correct me. In my understanding, since the size of ents[] is always
bigger than nr_objs, (tail & mask) == (head & mask) only if the ents[] is
full and no free object (thus no push() happens) or ents[] is empty
(in this case ages[id] != head). Thus the node is not updated if below
cmpxchg is succeeded.

> > +			void *node = READ_ONCE(ents[id]);
> > +			/* commit and move forward head of the slot */
> > +			if (try_cmpxchg_release(&os->head, &head, head + 1))
> > +				return node;
> > +		}
> > +
> > +		/* re-load head from memory and continue trying */
> > +		head = READ_ONCE(os->head);
> > +		/*
> > +		 * head stays unchanged, so it's very likely current pop()
> > +		 * just preempted/interrupted an ongoing push() operation

Since this can touch the other CPUs' slot, there should be another ongoing
push() running on the same slot (so no need to limit the preempt/interrupt
cases.) Also, this happens only when the push() is running on *the empty slot*.
Thus we can consider this is empty, and return NULL.

Can you update the comment above and make it clear that this exits here
because it is empty until ongoing push() is done.

Overall, some comments must be clear, but the code itself seems OK to me.

Thank you,

> > +		 */
> > +		if (head == prev)
> > +			break;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +/**
> > + * objpool_pop: allocate an object from objects pool
> 
> Ditto.
> 
> Thank you,
> 
> > + *
> > + * args:
> > + * @head: object pool
> > + *
> > + * return:
> > + *   object: NULL if failed (object pool is empty)
> > + *
> > + * objpool_pop can be nested, so can be used in any context.
> > + */
> > +void *objpool_pop(struct objpool_head *head)
> > +{
> > +	int i, cpu = raw_smp_processor_id();
> > +	void *obj = NULL;
> > +
> > +	for (i = 0; i < num_possible_cpus(); i++) {
> > +		obj = objpool_try_get_slot(head->cpu_slots[cpu]);
> > +		if (obj)
> > +			break;
> > +		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
> > +	}
> > +
> > +	return obj;
> > +}
> > +EXPORT_SYMBOL_GPL(objpool_pop);
> > +
> > +/**
> > + * objpool_fini: cleanup the whole object pool (releasing all objects)
> > + *
> > + * args:
> > + * @head: object pool to be released
> > + *
> > + */
> > +void objpool_fini(struct objpool_head *head)
> > +{
> > +	if (!head->cpu_slots)
> > +		return;
> > +
> > +	/* release percpu slots */
> > +	objpool_fini_percpu_slots(head);
> > +
> > +	/* call user's cleanup callback if provided */
> > +	if (head->release)
> > +		head->release(head, head->context);
> > +}
> > +EXPORT_SYMBOL_GPL(objpool_fini);
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

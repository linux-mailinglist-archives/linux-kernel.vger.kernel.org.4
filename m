Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E3678698
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjAWTl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjAWTlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6457DA6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674502832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjaS7acAKguGX9J/sL7TrgKaT9d72gve0LYaOvny/RI=;
        b=f2uWvGYSXj0Y1spPvaKJtFxs0ASP+IV4viHcwykigcnbCJhJURXpFn3AbpLlcxEOZYC4ug
        SJWPSOJLMCpNHZo/g8KD9lKbPevDY71Kn+McWUUBGz/A2FXP1Y4z4WcSdHMUFhY2UfGjKZ
        CcHG0GTC051TPf0AoI0vZA9y8lLuS1Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-7X0GtWCYNv-CM1Sjn3LXtQ-1; Mon, 23 Jan 2023 14:40:27 -0500
X-MC-Unique: 7X0GtWCYNv-CM1Sjn3LXtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 170BE3C38FE0;
        Mon, 23 Jan 2023 19:40:27 +0000 (UTC)
Received: from [10.22.34.140] (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C76092166B32;
        Mon, 23 Jan 2023 19:40:26 +0000 (UTC)
Message-ID: <cee8151d-97f3-b1e3-ee7a-ce78516e5090@redhat.com>
Date:   Mon, 23 Jan 2023 14:40:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND PATCH v2 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20230119040111.350923-1-longman@redhat.com>
 <20230119040111.350923-3-longman@redhat.com> <Y8ro6DxR1v0XlDs3@arm.com>
 <55978b11-5e7e-4b10-dff1-398275ec68b3@redhat.com> <Y87fAFIxd+NMFouM@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y87fAFIxd+NMFouM@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 14:24, Catalin Marinas wrote:
> On Fri, Jan 20, 2023 at 05:54:28PM -0500, Waiman Long wrote:
>> On 1/20/23 14:18, Catalin Marinas wrote:
>>>>    /*
>>>> @@ -633,6 +642,7 @@ static void __create_object(unsigned long ptr, size_t size,
>>>>    	object->count = 0;			/* white color initially */
>>>>    	object->jiffies = jiffies;
>>>>    	object->checksum = 0;
>>>> +	object->del_state = 0;
>>>>    	/* task information */
>>>>    	if (in_hardirq()) {
>>>> @@ -1470,9 +1480,22 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>>>>    	if (!get_object(object))
>>>>    		return;	/* Try next object */
>>>> +	raw_spin_lock_irq(&kmemleak_lock);
>>>> +	if (object->del_state & DELSTATE_REMOVED)
>>>> +		goto unlock_put;	/* Object removed */
>>>> +	object->del_state |= DELSTATE_NO_DELETE;
>>>> +	raw_spin_unlock_irq(&kmemleak_lock);
>>>> +
>>>>    	rcu_read_unlock();
>>>>    	cond_resched();
>>>>    	rcu_read_lock();
>>>> +
>>>> +	raw_spin_lock_irq(&kmemleak_lock);
>>>> +	if (object->del_state & DELSTATE_REMOVED)
>>>> +		list_del_rcu(&object->object_list);
>>>> +	object->del_state &= ~DELSTATE_NO_DELETE;
>>>> +unlock_put:
>>>> +	raw_spin_unlock_irq(&kmemleak_lock);
>>>>    	put_object(object);
>>>>    }
>>> I'm not sure this was the only problem. We do have the problem that the
>>> current object may be removed from the list, solved above, but another
>>> scenario I had in mind is the next object being released during this
>>> brief resched period. The RCU relies on object->next->next being valid
>>> but, with a brief rcu_read_unlock(), the object->next could be freed,
>>> reallocated, so object->next->next invalid.
>> Looking at the following scenario,
>>
>> object->next => A (removed)
>> A->next => B (removed)
>>
>> As object->next is pointing to A, A must still be allocated and not freed
>> yet. Now if B is also removed, there are 2 possible case.
>>
>> 1) B is removed from the list after the removal of A. In that case, it is
>> not possible that A is allocated, but B is freed.
>>
>> 2) B is removed before A. A->next can't pointed to B when it is being
>> removed. Due to weak memory ordering, it is possible that another cpu can
>> see A->next still pointing to B. In that case, I believe that it is still
>> within the grace period where neither A or B is freed.
>>
>> In fact, it is no different from a regular scanning of the object list
>> without ever called cond_resched().
> More like thinking out loud:
>
> The lockless RCU loop relies on object->next->next being valid within
> the grace period (A not freed). Due to weak memory ordering, the looping
> CPU may not observe the object->next update (removal of A) by another
> CPU, so it continues to loop over it. But since we do an
> rcu_read_unlock() in the middle of the loop, I don't think these
> assumptions are still valid, so A may be freed.
>
> What we need is that object->next reading for the following iteration
> either sees the updated object->next (B) or it sees A but the latter
> still around. I think this holds with the proposed
> kmemleak_cond_resched() since we now start a new grace period with
> rcu_read_lock() followed by taking and releasing kmemleak_lock. The
> latter would give us the memory ordering required since removing object
> A from the list does take the lock.
>
> So yeah, you are probably right, I just find it hard to get my head
> around ;). I still think it would be simpler with a single kmemleak_lock
> (no object->lock) but that's more involved than a simple fix.
>
> Assuming your (and my) reasoning above is correct:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I should have mentioned the fact that taking the kmemleak_lock will post 
some ordering guarantee since it is done after a new rcu_read_lock(). So 
yes, even if both A and B are removed from the object_list, they should 
still be around and not freed yet.

Thanks for your review.

Cheers,
Longman


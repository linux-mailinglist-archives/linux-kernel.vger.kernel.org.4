Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFD64CD87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiLNP5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305424F06
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671033275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9W8aVAy/4ZBcYPeetzRCLQ7B8m0kP0x8kl1DzjwZhCs=;
        b=LoH951CU3OBSStX4MeS+WbJBzyjv/OqPP5dAFqimINGC70nTeHL5eBaiMsxMhvNcV2fuZs
        rMcfEURVFOKitzbMFTVLkqmM6ogdFYPlq/xiuS5MUmDdPfiZQ1cdzKVzyB1k5Y41qAj+0U
        k7bAJCLW7rykmWkOpqv+GquO4Qy45Vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-88fXQywoNNqJalPplngpOw-1; Wed, 14 Dec 2022 10:54:31 -0500
X-MC-Unique: 88fXQywoNNqJalPplngpOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C794811E6E;
        Wed, 14 Dec 2022 15:54:31 +0000 (UTC)
Received: from [10.22.9.99] (unknown [10.22.9.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D079F2026D68;
        Wed, 14 Dec 2022 15:54:30 +0000 (UTC)
Message-ID: <b453f697-b21b-d80e-6c41-dfa260bb2220@redhat.com>
Date:   Wed, 14 Dec 2022 10:54:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20221210230048.2841047-1-longman@redhat.com>
 <20221210230048.2841047-3-longman@redhat.com> <Y5mwnc03h10r0rKK@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5mwnc03h10r0rKK@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 06:16, Catalin Marinas wrote:
> On Sat, Dec 10, 2022 at 06:00:48PM -0500, Waiman Long wrote:
>> Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
>> object iteration loop of kmemleak_scan()") fixes soft lockup problem
>> in kmemleak_scan() by periodically doing a cond_resched(). It does
>> take a reference of the current object before doing it. Unfortunately,
>> if the object has been deleted from the object_list, the next object
>> pointed to by its next pointer may no longer be valid after coming
>> back from cond_resched(). This can result in use-after-free and other
>> nasty problem.
> Ah, kmemleak_cond_resched() releases the rcu lock, so using
> list_for_each_entry_rcu() doesn't help.
>
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 8c44f70ed457..d3a8fa4e3af3 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1465,15 +1465,26 @@ static void scan_gray_list(void)
>>    * that the given object won't go away without RCU read lock by performing a
>>    * get_object() if necessaary.
>>    */
>> -static void kmemleak_cond_resched(struct kmemleak_object *object)
>> +static void kmemleak_cond_resched(struct kmemleak_object **pobject)
>>   {
>> -	if (!get_object(object))
>> +	struct kmemleak_object *obj = *pobject;
>> +
>> +	if (!(obj->flags & OBJECT_ALLOCATED) || !get_object(obj))
>>   		return;	/* Try next object */
> I don't think we can rely on obj->flags without holding obj->lock. We do
> have a few WARN_ON() checks without the lock but in all other places the
> lock should be held.

Good point. It is just an optimistic check and it is OK to be wrong. I 
think I may need to use data_race() macro to signify that racing can 
happen and it is fine.

>
> Another potential issue with re-scanning is that the loop may never
> complete if it always goes from the beginning. Yet another problem with
> restarting is that we may count references to an object multiple times
> and get more false negatives.
>
> I'd keep the OBJECT_ALLOCATED logic in the main kmemleak_scan() loop and
> retake the object->lock if cond_resched() was called
> (kmemleak_need_resched() returning true), check if it was freed and
> restart the loop. We could add a new OBJECT_SCANNED flag so that we
> skip such objects if we restarted the loop. The flag is reset during
> list preparation.
>
> I wonder whether we actually need the cond_resched() in the first loop.
> It does take a lot of locks but it doesn't scan the objects. I had a
> patch around to remove the fine-grained locking in favour of the big
> kmemleak_lock, it would make this loop faster (not sure what happened to
> that patch, I need to dig it out).
>
Thanks for the review. Another alternative way to handle that is to add 
an OBJECT_ANCHORED flag to indicate that this object shouldn't be 
deleted from the object list yet. Maybe also an OBJECT_DELETE_PENDING 
flag so that kmemleak_cond_resched() will delete it after returning from 
cond_resched() when set by another function that want to delete this 
object. All these checks and flag setting will be done with object lock 
held. How do you think?

Cheers,
Longman


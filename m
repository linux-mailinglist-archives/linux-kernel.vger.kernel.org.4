Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813D64EF90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiLPQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiLPQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A761505
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671208713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPGZ8V2aVqu2fvsMtT4AwXNxUpjMCKpVTRjQyLueouQ=;
        b=Pk5hUfbvKHmBWKMIxuiKv5CndAxI6qXTltenowoCpXdrCkD06k69c8GFoM6wa0XxGfna74
        fbKqLssLweAad3mYG8EAwKUQNHtwRCfOXKi6IbNSKzMRp/1x02Gybga7a9Jwh/z/WBr7uf
        xuPB9ouQOlIQRmSay3Wzh3UlbvJ6bls=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-gLKGBV85P-WR8QU7h6LtDg-1; Fri, 16 Dec 2022 11:38:30 -0500
X-MC-Unique: gLKGBV85P-WR8QU7h6LtDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F37D1C09064;
        Fri, 16 Dec 2022 16:38:29 +0000 (UTC)
Received: from [10.22.10.173] (unknown [10.22.10.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6722026D68;
        Fri, 16 Dec 2022 16:38:29 +0000 (UTC)
Message-ID: <7ea28f11-34af-c974-94fb-7e2481942e97@redhat.com>
Date:   Fri, 16 Dec 2022 11:38:28 -0500
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
 <b453f697-b21b-d80e-6c41-dfa260bb2220@redhat.com> <Y5xJOuVsQbITDq14@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5xJOuVsQbITDq14@arm.com>
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


On 12/16/22 05:32, Catalin Marinas wrote:
> On Wed, Dec 14, 2022 at 10:54:28AM -0500, Waiman Long wrote:
>> On 12/14/22 06:16, Catalin Marinas wrote:
>>> On Sat, Dec 10, 2022 at 06:00:48PM -0500, Waiman Long wrote:
>>>> Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
>>>> object iteration loop of kmemleak_scan()") fixes soft lockup problem
>>>> in kmemleak_scan() by periodically doing a cond_resched(). It does
>>>> take a reference of the current object before doing it. Unfortunately,
>>>> if the object has been deleted from the object_list, the next object
>>>> pointed to by its next pointer may no longer be valid after coming
>>>> back from cond_resched(). This can result in use-after-free and other
>>>> nasty problem.
>>> Ah, kmemleak_cond_resched() releases the rcu lock, so using
>>> list_for_each_entry_rcu() doesn't help.
> [...]
>>> Another potential issue with re-scanning is that the loop may never
>>> complete if it always goes from the beginning. Yet another problem with
>>> restarting is that we may count references to an object multiple times
>>> and get more false negatives.
>>>
>>> I'd keep the OBJECT_ALLOCATED logic in the main kmemleak_scan() loop and
>>> retake the object->lock if cond_resched() was called
>>> (kmemleak_need_resched() returning true), check if it was freed and
>>> restart the loop. We could add a new OBJECT_SCANNED flag so that we
>>> skip such objects if we restarted the loop. The flag is reset during
>>> list preparation.
> [...]
>> Thanks for the review. Another alternative way to handle that is to add an
>> OBJECT_ANCHORED flag to indicate that this object shouldn't be deleted from
>> the object list yet. Maybe also an OBJECT_DELETE_PENDING flag so that
>> kmemleak_cond_resched() will delete it after returning from cond_resched()
>> when set by another function that want to delete this object. All these
>> checks and flag setting will be done with object lock held. How do you
>> think?
> I think we are over-complicating this. The problems I see with deleting
> an object are that (1) only the object being deleted is locked (so that
> the corresponding memory block is not freed while scanning) and (2)
> kmemleak_cond_resched() releases the RCU lock briefly. A list_del_rcu()
> on the object next to the one being scanned (and locked) will leave the
> current object->next pointer dangling.

Yes, I believe that is the cause of the UAF error that I saw from KASAN.


> If we get rid of object->lock and just use kmemleak_lock instead, we can
> have a big lock around the scanning, released briefly in
> kmemleak_cond_resched(). A standard list_del() (not _rcu) could be run
> during the resched but it also updates the current object->next. Once
> the lock is re-acquired, the list traversal can continue safely. The
> current object cannot be freed due to get_object(). No need for
> restarting the loop.

The problem with a big lock (kmemleak_lock) is that we will be disabing 
interrupt for an extended period of time which is not ideal.

I have posted a v2 patch that drop the idea of restarting the loop. 
Instead, I just block the current object from being removed from the 
object_list to make sure its next pointer will point to a valid object.

>
> I don't think we'd miss much in terms of scalability for a debug
> feature. Object freeing already takes the kmemleak_lock, it's just that
> during scanning it will have to wait for the scanning loop to release
> it. We might as well release it within the loop on each iteration.
>
> So my proposal is to replace the rcu list traversal with the classic
> one and kmemleak_lock held (some functions like __find_and_get_object()
> will have to skip the lock). With this in place, we can subsequently
> remove all object->lock instances, just rely on the big lock (we do need
> to run lockdep if we do the latter separately, some nesting is a bit
> weird; my preference would be to remove the object->lock at the same
> time). We still need the rcu freeing in put_object() but for a
> completely different reason: the sl*b allocators don't like being called
> recursively, so we just use the RCU mechanism to free the kmemleak
> structures in a separate thread.

That was what I thought about when you said you wanted to use a big lock 
instead of object->lock in the last email. As I said above, we can't 
hold the kmemleak_lock with interrupt disabled for an extended period of 
time especially if RT tasks are running. So we may need to release the 
lock frequently like per dozen objects or so. I believe we still need 
rcu_read_lock() just to be safe.

Cheers,
Longman

>


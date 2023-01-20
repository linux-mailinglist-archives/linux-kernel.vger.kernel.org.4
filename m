Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F66760CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjATW4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjATW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21394DA8F6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674255275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSMfGcmcVhk0Uo6IE79LVhhz/BJL/6En61IwKDiYOrM=;
        b=ElSYG5Q1lBhd9UwimrfWDE86e4+dF+KxWcWDMI+l9wAA1zKlMx8ISNzLPBBGbqYawfiiC5
        1lAQdJ5XTlqHWEkn5ogIVYBq8bhLXx9SiJ74UQ2jHrF4CBt5PnF3gp1IykjodV5B7Z7QrQ
        vhB1SGsT+v5le3J67/jXV3hDgG4S/PI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-fbEc8iaaObGToB-glIOzXg-1; Fri, 20 Jan 2023 17:54:29 -0500
X-MC-Unique: fbEc8iaaObGToB-glIOzXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34B95101A521;
        Fri, 20 Jan 2023 22:54:29 +0000 (UTC)
Received: from [10.22.17.220] (unknown [10.22.17.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEF961121318;
        Fri, 20 Jan 2023 22:54:28 +0000 (UTC)
Message-ID: <55978b11-5e7e-4b10-dff1-398275ec68b3@redhat.com>
Date:   Fri, 20 Jan 2023 17:54:28 -0500
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y8ro6DxR1v0XlDs3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/23 14:18, Catalin Marinas wrote:
> Hi Waiman,
>
> Thanks for your effort on trying to fix this.
>
> On Wed, Jan 18, 2023 at 11:01:11PM -0500, Waiman Long wrote:
>> @@ -567,7 +574,9 @@ static void __remove_object(struct kmemleak_object *object)
>>   	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
>>   				   &object_phys_tree_root :
>>   				   &object_tree_root);
>> -	list_del_rcu(&object->object_list);
>> +	if (!(object->del_state & DELSTATE_NO_DELETE))
>> +		list_del_rcu(&object->object_list);
>> +	object->del_state |= DELSTATE_REMOVED;
>>   }
> So IIUC, this prevents the current object being scanned from being
> removed from the list during the kmemleak_cond_resched() call.

Yes, that is the point.


>
>>   /*
>> @@ -633,6 +642,7 @@ static void __create_object(unsigned long ptr, size_t size,
>>   	object->count = 0;			/* white color initially */
>>   	object->jiffies = jiffies;
>>   	object->checksum = 0;
>> +	object->del_state = 0;
>>   
>>   	/* task information */
>>   	if (in_hardirq()) {
>> @@ -1470,9 +1480,22 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>>   	if (!get_object(object))
>>   		return;	/* Try next object */
>>   
>> +	raw_spin_lock_irq(&kmemleak_lock);
>> +	if (object->del_state & DELSTATE_REMOVED)
>> +		goto unlock_put;	/* Object removed */
>> +	object->del_state |= DELSTATE_NO_DELETE;
>> +	raw_spin_unlock_irq(&kmemleak_lock);
>> +
>>   	rcu_read_unlock();
>>   	cond_resched();
>>   	rcu_read_lock();
>> +
>> +	raw_spin_lock_irq(&kmemleak_lock);
>> +	if (object->del_state & DELSTATE_REMOVED)
>> +		list_del_rcu(&object->object_list);
>> +	object->del_state &= ~DELSTATE_NO_DELETE;
>> +unlock_put:
>> +	raw_spin_unlock_irq(&kmemleak_lock);
>>   	put_object(object);
>>   }
> I'm not sure this was the only problem. We do have the problem that the
> current object may be removed from the list, solved above, but another
> scenario I had in mind is the next object being released during this
> brief resched period. The RCU relies on object->next->next being valid
> but, with a brief rcu_read_unlock(), the object->next could be freed,
> reallocated, so object->next->next invalid.

Looking at the following scenario,

object->next => A (removed)
A->next => B (removed)

As object->next is pointing to A, A must still be allocated and not 
freed yet. Now if B is also removed, there are 2 possible case.

1) B is removed from the list after the removal of A. In that case, it 
is not possible that A is allocated, but B is freed.

2) B is removed before A. A->next can't pointed to B when it is being 
removed. Due to weak memory ordering, it is possible that another cpu 
can see A->next still pointing to B. In that case, I believe that it is 
still within the grace period where neither A or B is freed.

In fact, it is no different from a regular scanning of the object list 
without ever called cond_resched().

Cheers,
Longman


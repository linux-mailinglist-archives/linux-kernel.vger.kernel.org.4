Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79F7699EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBPVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBPVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:08:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D632B632
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676581649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNLJXn22xb78IpIXt92TUj5hIfZFDC6wXrv8OqeGsqU=;
        b=QS5OBVsiJCAr5SZOJkDD+hzRcCO3KxlRBEJXztu6wK74nDl0YpraVWy/8ON0qcJWZQHE6+
        8xCD9Gr3dNXyYRA/1gZ+FvE1GOWJky4gO2qc9I8SFRDft+0AXB4UabG0ynLDkghDnM0HLc
        TPlJmuW8F6yR8c2/FWCAZgm8RwTxtRc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-2rduyUzGO96VvCDHSQ70TQ-1; Thu, 16 Feb 2023 16:07:26 -0500
X-MC-Unique: 2rduyUzGO96VvCDHSQ70TQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED6CF1C07560;
        Thu, 16 Feb 2023 21:07:25 +0000 (UTC)
Received: from [10.22.33.69] (unknown [10.22.33.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B131D492B0E;
        Thu, 16 Feb 2023 21:07:25 +0000 (UTC)
Message-ID: <0baab14d-abea-4248-e6d5-23c465f0a4a5@redhat.com>
Date:   Thu, 16 Feb 2023 16:07:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] locking/rwsem: Wake up all readers for wait queue
 waker
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20230213194832.832256-1-longman@redhat.com>
 <20230214030901.3250-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230214030901.3250-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 22:09, Hillf Danton wrote:
> On Mon, 13 Feb 2023 14:48:32 -0500 Waiman Long <longman@redhat.com>
>>   
>> @@ -1281,7 +1282,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
>>   	raw_spin_lock_irqsave(&sem->wait_lock, flags);
>>   
>>   	if (!list_empty(&sem->wait_list))
>> -		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
>> +		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q, false);
>>   
>>   	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
>>   	wake_up_q(&wake_q);
>> -- 
>> 2.31.1
> Downgrade is conceptually the right time to let all read waiters go
> regardless write waiter.

Still, a downgraded task is still in the read critical section and we 
shouldn't introduce arbitrary latency to that. Let's focus on the easy 
one and we can discuss about other possibility later.

Thanks,
Longman


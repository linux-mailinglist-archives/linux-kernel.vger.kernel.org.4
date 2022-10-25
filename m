Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A502560D44C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiJYTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiJYTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF342D70
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666724434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSbTyY7zGpX8KME5kgX7EAmxfdVlqZeBQMB1bp0O01s=;
        b=h/5kTKUJRc9NlSVg15IjekgKS7oJ7MR0qhVHR9E1m0fcTcl+XxdM/NefT9CWPMuSXCeDoG
        fWLbYcup23pkfD214TuCVMnEStrrcpbU61A6LKuYbe2dSTykv8zUNHRCtRTayMYN161OMn
        NrBnCcuNSlMxDGlR3elmJTd1nfQIAFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-OzXHSfwPMI22D5yr4mHpZQ-1; Tue, 25 Oct 2022 15:00:30 -0400
X-MC-Unique: OzXHSfwPMI22D5yr4mHpZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35214101E9B0;
        Tue, 25 Oct 2022 19:00:30 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6CE940C6EC6;
        Tue, 25 Oct 2022 19:00:29 +0000 (UTC)
Message-ID: <7dc61070-4696-4668-eaef-efae8d7fa271@redhat.com>
Date:   Tue, 25 Oct 2022 15:00:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/5] locking/rwsem: Limit # of null owner retries for
 handoff writer
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-3-longman@redhat.com>
 <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
 <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
 <Y1fG7nQxiLyKIhQ6@hirez.programming.kicks-ass.net>
 <20221025145843.2953-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221025145843.2953-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 10:58, Hillf Danton wrote:
>> @@ -1179,15 +1171,12 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   		if (waiter.handoff_set) {
>>   			enum owner_state owner_state;
>>   
>> -			preempt_disable();
>>   			owner_state = rwsem_spin_on_owner(sem);
>> -			preempt_enable();
>> -
>>   			if (owner_state == OWNER_NULL)
>>   				goto trylock_again;
>>   		}
> 	__up_write()
> 	{
> 	rwsem_clear_owner(sem);
> 	/*
> 	 If lockup can happen when a bound kworker gets preempted here by
> 	 a FIFO acquirer for write, this is a case of preemption deeper
> 	 than thought IMO
> 	*/
> 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
> 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
> 		rwsem_wake(sem);
>
A preempt_disable()/preempt_enable() pair has been added by commit 
48dfb5d2560 ("locking/rwsem: Disable preemption while trying for rwsem 
lock") to __up_write(). So that should not be a problem. However, that 
does make this change, if implemented, has dependency on the coexistence 
of the previous mentioned commit to be functionally complete.

Cheers,
Longman


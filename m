Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D774B7BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjGGUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGGUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE9DD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688761035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ja6I/wlCNGzetpjcUGRAM7IU4Hq6+cDPYt/XrUo8AY=;
        b=iaZ/AOTD87NCgXT71rL+RdBPAIQclqlNk4S2V4h/nhdEYW1wDDSYMaPG/dC0ubw/Wz+7lF
        qQyWThsnjME03+h3V1j2DOJQfZVWda2ur+tycer/kYXi/Ntys4IR/h6oQQBpRdcWtODhjo
        MUj8j0rzMHGNf5M1eZ9MM4G/sqvrGzs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-n7iVeSmpM_2NpZEW2qghzw-1; Fri, 07 Jul 2023 16:17:12 -0400
X-MC-Unique: n7iVeSmpM_2NpZEW2qghzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CA74185A78B;
        Fri,  7 Jul 2023 20:17:11 +0000 (UTC)
Received: from [10.22.34.12] (unknown [10.22.34.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFD18200B402;
        Fri,  7 Jul 2023 20:17:10 +0000 (UTC)
Message-ID: <d7f3f526-8ceb-7b23-dba0-ee83f9b78168@redhat.com>
Date:   Fri, 7 Jul 2023 16:17:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] refscale: Fix use of uninitalized wait_queue_head_t
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
References: <20230707175355.2442933-1-longman@redhat.com>
 <37d52a42-c6d5-4c4d-9879-53578c154d1f@paulmck-laptop>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <37d52a42-c6d5-4c4d-9879-53578c154d1f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/23 15:54, Paul E. McKenney wrote:
> On Fri, Jul 07, 2023 at 01:53:55PM -0400, Waiman Long wrote:
>> It was found that running the refscale test might crash the kernel once
>> in a while with the following error:
>>
>> [ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
>> [ 8569.952900] #PF: supervisor read access in kernel mode
>> [ 8569.952902] #PF: error_code(0x0000) - not-present page
>> [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
>> [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
>> [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
>> [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>>    :
>> [ 8569.952940] Call Trace:
>> [ 8569.952941]  <TASK>
>> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
>> [ 8569.952959]  kthread+0x10e/0x130
>> [ 8569.952966]  ret_from_fork+0x1f/0x30
>> [ 8569.952973]  </TASK>
>>
>> This is likely caused by the fact that init_waitqueue_head() is
>> called after the ref_scale_reader kthread is created. The kthread
>> can potentially try to use the waitqueue head before it is properly
>> initialized. The crash happened at
>>
>> 	static inline void __add_wait_queue(...)
>> 	{
>> 		:
>> 		if (!(wq->flags & WQ_FLAG_PRIORITY)) <=== Crash here
>>
>> The offset of flags from list_head entry in wait_queue_entry is -0x18. If
>> reader_tasks[i].wq.head.next is NULL as allocated reader_task structure
>> is zero initialized, the instruction will try to access address
>> 0xffffffffffffffe8 which is the fault address listed above.
>>
>> Fix this by initializing the waitqueue head first before kthread
>> creation.
>>
>> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Queued and pushed, thank you all!
>
> As always, I could not resist wordsmithing the commit log, please see
> below.

Thanks for the wordsmithing. I don't mind at all.

Cheers,
Longman

> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 933d3bf8f96d7cedf78081030e004d23aee2b56c
> Author: Waiman Long <longman@redhat.com>
> Date:   Fri Jul 7 13:53:55 2023 -0400
>
>      refscale: Fix uninitalized use of wait_queue_head_t
>      
>      Running the refscale test occasionally crashes the kernel with the
>      following error:
>      
>      [ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
>      [ 8569.952900] #PF: supervisor read access in kernel mode
>      [ 8569.952902] #PF: error_code(0x0000) - not-present page
>      [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
>      [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
>      [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
>      [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>        :
>      [ 8569.952940] Call Trace:
>      [ 8569.952941]  <TASK>
>      [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
>      [ 8569.952959]  kthread+0x10e/0x130
>      [ 8569.952966]  ret_from_fork+0x1f/0x30
>      [ 8569.952973]  </TASK>
>      
>      The likely cause is that init_waitqueue_head() is called after the call to
>      the torture_create_kthread() function that creates the ref_scale_reader
>      kthread.  Although this init_waitqueue_head() call will very likely
>      complete before this kthread is created and starts running, it is
>      possible that the calling kthread will be delayed between the calls to
>      torture_create_kthread() and init_waitqueue_head().  In this case, the
>      new kthread will use the waitqueue head before it is properly initialized,
>      which is not good for the kernel's health and well-being.
>      
>      The above crash happened here:
>      
>              static inline void __add_wait_queue(...)
>              {
>                      :
>                      if (!(wq->flags & WQ_FLAG_PRIORITY)) <=== Crash here
>      
>      The offset of flags from list_head entry in wait_queue_entry is
>      -0x18. If reader_tasks[i].wq.head.next is NULL as allocated reader_task
>      structure is zero initialized, the instruction will try to access address
>      0xffffffffffffffe8, which is exactly the fault address listed above.
>      
>      This commit therefore invokes init_waitqueue_head() before creating
>      the kthread.
>      
>      Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
>      Signed-off-by: Waiman Long <longman@redhat.com>
>      Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>      Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>      Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 1970ce5f22d4..71d138573856 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -1107,12 +1107,11 @@ ref_scale_init(void)
>   	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
>   
>   	for (i = 0; i < nreaders; i++) {
> +		init_waitqueue_head(&reader_tasks[i].wq);
>   		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
>   						  reader_tasks[i].task);
>   		if (torture_init_error(firsterr))
>   			goto unwind;
> -
> -		init_waitqueue_head(&(reader_tasks[i].wq));
>   	}
>   
>   	// Main Task
>


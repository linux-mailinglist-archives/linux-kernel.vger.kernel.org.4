Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE374B17D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGGNKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBB1737
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EggKBwzUqnd+oemu+sOZluKy6hIEM/b0yh51QTFGBVA=;
        b=Vu5A2r9xQsaOF3bzsQQjPmrzgyLJfYhJIQHiqBBh+8zBi7ufMn9nAr/KCcwGoxA5O59bR+
        yyitUqZp30eNqjaJOesTlebZCuZmQEKStFUiEQeIrKg/92l6t/dbPMH1jSEjAGZao770mi
        hlV2hIu5HkJ7w714MZ6+aUiFNHpaCM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-b-m9TsE5N2q0OmSuYaprgw-1; Fri, 07 Jul 2023 09:09:15 -0400
X-MC-Unique: b-m9TsE5N2q0OmSuYaprgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64ECB1044591;
        Fri,  7 Jul 2023 13:09:14 +0000 (UTC)
Received: from [10.22.34.12] (unknown [10.22.34.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A78C1121330;
        Fri,  7 Jul 2023 13:09:13 +0000 (UTC)
Message-ID: <cd306d1c-2f7f-b129-4ed6-700e9e821653@redhat.com>
Date:   Fri, 7 Jul 2023 09:09:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230707000117.2371697-1-longman@redhat.com>
 <CY8PR11MB713490FA7B31E495E8B5FB65892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CY8PR11MB713490FA7B31E495E8B5FB65892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/23 03:27, Zhuo, Qiuxu wrote:
>> From: Waiman Long <longman@redhat.com>
>> ...
>> Subject: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
>>
>> It was found that running the refscale test might sometimes crash the kernel
>> with the following error:
>>
>> [ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
>> [ 8569.952900] #PF: supervisor read access in kernel mode [ 8569.952902]
>> #PF: error_code(0x0000) - not-present page [ 8569.952904] PGD c4b048067
>> P4D c4b049067 PUD c4b04b067 PMD 0 [ 8569.952910] Oops: 0000 [#1]
>> PREEMPT_RT SMP NOPTI [ 8569.952916] Hardware name: Dell Inc.
>> PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021 [ 8569.952917] RIP:
>> 0010:prepare_to_wait_event+0x101/0x190
>>    :
>> [ 8569.952940] Call Trace:
>> [ 8569.952941]  <TASK>
>> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale] [ 8569.952959]
>> kthread+0x10e/0x130 [ 8569.952966]  ret_from_fork+0x1f/0x30
>> [ 8569.952973]  </TASK>
>>
>> This is likely caused by the fact that init_waitqueue_head() is called after the
>> ref_scale_reader kthread is created. So the kthread may try to use the
>> waitqueue head before it is properly initialized. Fix this by initializing the
>> waitqueue head first before kthread creation.
>>
>> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-
>> side synchronization")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/rcu/refscale.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c index
>> 1970ce5f22d4..e365d6f8c139 100644
>> --- a/kernel/rcu/refscale.c
>> +++ b/kernel/rcu/refscale.c
>> @@ -1107,12 +1107,11 @@ ref_scale_init(void)
>>   	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
>>
>>   	for (i = 0; i < nreaders; i++) {
>> +		init_waitqueue_head(&(reader_tasks[i].wq));
> Running checkpatch.pl tool with the " --strict" option, it complained that
> "CHECK: Unnecessary parentheses around reader_tasks[i].wq".
> I know that you just moved the code position. The tool should have
> complained the original code. 😊
>
> Other than that, this patch LGTM.
>
>      Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> Thanks!
> -Qiuxu

Thanks for the review. I will do --strict test next time.

Cheers,
Longman

>
>>   		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
>>   						  reader_tasks[i].task);
>>   		if (torture_init_error(firsterr))
>>   			goto unwind;
>> -
>> -		init_waitqueue_head(&(reader_tasks[i].wq));
>>   	}
>>
>>   	// Main Task
>> --
>> 2.31.1


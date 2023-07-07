Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DB74B36E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGGO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjGGO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520B1FE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688741819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiOAjwadAWrcb7BoEkfxT+CYoQ+BF4xaAyjip1hV5Xs=;
        b=Zs5tnBao6KyW3yjgqKWmYdIwSHI7uwQJDiv7BcjmvAiZ9YqSey9ZWdTGuBx8uIqpU7moa3
        NZJE7RfaVcVxb0ttszGNqwSZ3vaYZKZokUtDUCO9lrniENb3EoqVM5SbCK8T22t9XobWxM
        i9fHXCBTn6gRLh1fFUHs66RyIJ/jEV0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-IuoQqGI5NpuHDIjJsSoFHQ-1; Fri, 07 Jul 2023 10:56:53 -0400
X-MC-Unique: IuoQqGI5NpuHDIjJsSoFHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79C973C0F685;
        Fri,  7 Jul 2023 14:56:52 +0000 (UTC)
Received: from [10.22.34.12] (unknown [10.22.34.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2D2D2166B25;
        Fri,  7 Jul 2023 14:56:51 +0000 (UTC)
Message-ID: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
Date:   Fri, 7 Jul 2023 10:56:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707000117.2371697-1-longman@redhat.com>
 <y5g37s3yhsqtmdoqziwnsd4kxtudlpqwv2iunt372abpmdzrry@43e54c374j4s>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <y5g37s3yhsqtmdoqziwnsd4kxtudlpqwv2iunt372abpmdzrry@43e54c374j4s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On 7/7/23 10:07, Davidlohr Bueso wrote:
> On Thu, 06 Jul 2023, Waiman Long wrote:
>
>> It was found that running the refscale test might sometimes crash the
>> kernel with the following error:
>>
>> [ 8569.952896] BUG: unable to handle page fault for address: 
>> ffffffffffffffe8
>> [ 8569.952900] #PF: supervisor read access in kernel mode
>> [ 8569.952902] #PF: error_code(0x0000) - not-present page
>> [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
>> [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
>> [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 
>> 1.2.4 05/28/2021
>> [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>>  :
>> [ 8569.952940] Call Trace:
>> [ 8569.952941]  <TASK>
>> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
>> [ 8569.952959]  kthread+0x10e/0x130
>> [ 8569.952966]  ret_from_fork+0x1f/0x30
>> [ 8569.952973]  </TASK>
>>
>> This is likely caused by the fact that init_waitqueue_head() is called
>> after the ref_scale_reader kthread is created. So the kthread may try
>> to use the waitqueue head before it is properly initialized. Fix this
>> by initializing the waitqueue head first before kthread creation.
>>
>> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of 
>> read-side synchronization")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>
> Strange this wasn't reported sooner.

Red Hat does have a pretty large QE organization that run all sort of 
tests include this one pretty frequently. The race window is pretty 
small, but they did hit this once in a while.

Cheers,
Longman


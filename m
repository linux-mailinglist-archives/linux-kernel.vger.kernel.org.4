Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C745EC7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiI0P0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiI0P0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C3D589B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664292392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVAGjlc/ZsFlfgcuWgjlGuybatae8DkqOq+/0/8Qj3E=;
        b=cUTqPDt4Kt746e+mDvv1nGPmSSThiOqopRF3PjFOB7uAKa6Z656ZfdmjnW6cAsBmII3pPd
        U+XRlUtw+4JtgSUqJE2yAX4sSilNxiB5BLeTFeQZp6HDSaQ5L0iAxeoy2znLLHBjRBiEg/
        UTmlYAiVxAme1anmZoog91hMvlhHe+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-gVlJzQJ8Peu3EQ4SuO_U8A-1; Tue, 27 Sep 2022 11:26:31 -0400
X-MC-Unique: gVlJzQJ8Peu3EQ4SuO_U8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1360085A583;
        Tue, 27 Sep 2022 15:26:31 +0000 (UTC)
Received: from [10.22.9.237] (unknown [10.22.9.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C35152166B26;
        Tue, 27 Sep 2022 15:26:30 +0000 (UTC)
Message-ID: <be87a130-62ba-e0a7-1c5b-c48f1e5548e1@redhat.com>
Date:   Tue, 27 Sep 2022 11:26:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: locking/rwsem: RT throttling issue due to RT task hogging the cpu
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, "<boqun.feng"@gmail.com
References: <e1cb435a-4471-ac3a-344f-04448f167c9f@quicinc.com>
 <40d0decc-0565-1e13-3c12-ac963ebed429@redhat.com>
In-Reply-To: <40d0decc-0565-1e13-3c12-ac963ebed429@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 11:25, Waiman Long wrote:
>
> On 9/20/22 12:19, Mukesh Ojha wrote:
>> Hi,
>>
>> We are observing one issue where, sem->owner is not set and 
>> sem->count=6 [1] which means both RWSEM_FLAG_WAITERS and 
>> RWSEM_FLAG_HANDOFF bits are set. And if unfold the sem->wait_list we 
>> see the following order of process waiting [2] where [a] is waiting 
>> for write, while [b],[c] are waiting for read and [d] is the RT task 
>> for which waiter.handoff_set=true and it is continuously running on 
>> cpu7 and not letting the first write waiter [a] on cpu7.
>>
>> [1]
>>
>>   sem = 0xFFFFFFD57DDC6680 -> (
>>     count = (counter = 6),
>>     owner = (counter = 0),
>>
>> [2]
>>
>> [a] kworker/7:0 pid: 32516 ==> [b] iptables-restor pid: 18625 ==> 
>> [c]HwBinder:1544_3  pid: 2024 ==> [d] RenderEngine pid: 2032 cpu: 7 
>> prio:97 (RT task)
>>
>>
>> Sometime back, Waiman has suggested this which could help in RT task
>> leaving the cpu.
>>
>> https://lore.kernel.org/all/8c33f989-8870-08c6-db12-521de634b34e@redhat.com/ 
>>
>>
> Sorry for the late reply. There is now an alternative way of dealing 
> with this RT task hogging issue with the commit 48dfb5d2560d 
> ("locking/rwsem: Disable preemption while trying for rwsem lock"). 
> Could you try it to see if it can address your problem?

FYI, this commit is in the tip tree. It is not in the mainline yet.

Cheers,
Longman


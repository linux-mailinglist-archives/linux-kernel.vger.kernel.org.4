Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4846A4C21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjB0URd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB0URc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93DC29172
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677528993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mng9T753JSQII2hLKdsJMn7SufiPKs0785Plw1ARFuc=;
        b=DGG/Cs5S0KOOGvwxHEtxxTeLqheDRy899zHrpF6z1FkCFx45Foz9V5fm9ubPDYnZ0SxvIC
        0spJ1A5Mr6wmi/BptgQBglfsm8rgtawLlo1De0tYkJ6jJwpKuE2IO79T3iTBSgH457fb5B
        e6LUixIEOt8cvm12Q6i8LbgFxlVCo5g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-mTZRey5JPrmfAFlD5FQDNg-1; Mon, 27 Feb 2023 15:16:26 -0500
X-MC-Unique: mTZRey5JPrmfAFlD5FQDNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 972F129DD985;
        Mon, 27 Feb 2023 20:16:25 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FEF4C15BAD;
        Mon, 27 Feb 2023 20:16:25 +0000 (UTC)
Message-ID: <c126f079-88a2-4067-6f94-82f51cf5ff2b@redhat.com>
Date:   Mon, 27 Feb 2023 15:16:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
 <Y/uN+89FlTw45uiA@hirez.programming.kicks-ass.net>
 <943686ee-975d-a463-46d1-04b200ac19b1@redhat.com>
 <Y/yGZgz1cJ1+pTt5@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y/yGZgz1cJ1+pTt5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 05:31, Peter Zijlstra wrote:
>> I do have some concern that early lock transfer to a lock owner that has not
>> been woken up yet may suppress writer lock stealing from optimistic spinning
>> causing some performance regression in some cases. Let's see if the test
>> robot report anything.
> Ah yes, I suppose that is indeed a possibility. Given this is all under
> wait_lock and the spinner is not, I was hoping it would still have
> sufficient time to win. But yes, robots will tell us.
>
I run my rwsem locking microbenchmark on a 2-socket 96-thread x86-64
system with lock event turned on for 15 secs.

Before this patchset:

Running locktest with rwsem [runtime = 15s, r% = 50%, load = 100]
Threads = 96, Min/Mean/Max = 74,506/91,260/112,409
Threads = 96, Total Rate = 584,091 op/s; Percpu Rate = 6,084 op/s

rwsem_opt_fail=127305
rwsem_opt_lock=4252147
rwsem_opt_nospin=28920
rwsem_rlock=2713129
rwsem_rlock_fail=0
rwsem_rlock_fast=5
rwsem_rlock_handoff=280
rwsem_rlock_steal=1486617
rwsem_sleep_reader=2713085
rwsem_sleep_writer=4313369
rwsem_wake_reader=29876
rwsem_wake_writer=5829160
rwsem_wlock=127305
rwsem_wlock_fail=0
rwsem_wlock_handoff=2515

After this patchset:

Running locktest with rwsem [runtime = 15s, r% = 50%, load = 100]
Threads = 96, Min/Mean/Max = 26,573/26,749/26,833
Threads = 96, Total Rate = 171,184 op/s; Percpu Rate = 1,783 op/s

rwsem_opt_fail=1265481
rwsem_opt_lock=17939
rwsem_rlock=1266157
rwsem_rlock_fail=0
rwsem_rlock_fast=0
rwsem_rlock_handoff=0
rwsem_rlock_steal=551
rwsem_sleep_reader=1266157
rwsem_sleep_writer=1265481
rwsem_wake_reader=26612
rwsem_wake_writer=0
rwsem_wlock=1265481
rwsem_wlock_ehandoff=94
rwsem_wlock_fail=0
rwsem_wlock_handoff=94

So the locking rate is reduced to just 29.3% of the original. Looking at
the number of successful writer lock stealings from optimistic spinning
(rwsem_opt_lock), it is reduced from 4252147 to 17939. It is just about
0.4% of the original.

So for workloads that have a lot of writer contention, there will be
performance regressions. Do you mind if we try to keep the original
logic of my patchset to allow write lock acquisition in writer slow
path, but transfer the lock ownership in the wakeup path when handoff
is required. We can do this with some minor code changes on top of your
current patchset.

Regards,
Longman



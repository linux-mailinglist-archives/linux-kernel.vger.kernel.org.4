Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306163278C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKUPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiKUPMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FDE110D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669043080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sv5hMaEMumN3PQ3lEWFN4TGB8VlrdIqMMV1dBi+wtPE=;
        b=WR4dtzECLHjNkcK9HIlKSfBUYXMpH1zl5N4s3lWbHVIMsTLXgWfJzrYzcw1Ir9lAZHz9WK
        1l+yJ+dl8FZmASh5LA6bzmBEHMZwYtnNQCE6vVywok6HkrQKBGOekjuj9jWtxVk7Qf2y6U
        IEVHkjPA5fs5a1hcGRKcuPwT93cHQtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-fMiI_us6PoicCHE2Q28jtw-1; Mon, 21 Nov 2022 10:04:36 -0500
X-MC-Unique: fMiI_us6PoicCHE2Q28jtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D773857D12;
        Mon, 21 Nov 2022 15:04:36 +0000 (UTC)
Received: from [10.22.33.92] (unknown [10.22.33.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DB0D2024CB7;
        Mon, 21 Nov 2022 15:04:35 +0000 (UTC)
Message-ID: <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
Date:   Mon, 21 Nov 2022 10:04:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
References: <20221118193302.522399-1-longman@redhat.com>
 <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 11/21/22 05:38, Peter Zijlstra wrote:
> On Fri, Nov 18, 2022 at 02:33:02PM -0500, Waiman Long wrote:
>> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
>> do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
>> set. Unfortunately, some of the callers of do_set_cpus_allowed()
> 'some' ? There's only 3 or so, which one triggers this?

It happenned at __kthread_bind_mask() where do_set_cpus_allowed() is 
called with pi_lock held.

[ 1084.820105]  <TASK>
[ 1084.820110]  dump_stack_lvl+0x57/0x81
[ 1084.820117]  check_noncircular+0x103/0x120
[ 10[ 1084.820160]  lock_acquire+0xba/0x230
[ 1084.820164]  ? kfree+0x10f/0x380
[ 1084.820172]  ? do_set_cpus_allowed+0x40/0x60
[ 1084.820181]  rt_spin_lock+0x27/0xe0
[ 1084.820184]  ? kfree+0x10f/0x380
[ 1084.820188]  kfree+0x10f/0x380
[ 1084.820195]  do_set_cpus_allowed+0x40/0x60
[ 1084.820203]  kthread_bind_mask+0x4a/0x70
[ 1084.820211]  create_worker+0xfb/0x1a0
[ 1084.820220]  worker_thread+0x2e3/0x3c0
[ 1084.820226]  ? process_one_work+0x450/0x450
[ 1084.820230]  kthread+0x111/0x130
[ 1084.820236]  ? kthread_complete_and_exit+0x20/0x20
[ 1084.820244]  ret_from_fork+0x22/0x30
[ 1084.820258]  </TASK>
[ 1084.820260] BUG: sleeping function called from invalid context at 
kernel/locking/spinlock_rt.c:46

It shows up with PREEMPT_RT kernel.

>
>> may not be in a context where kfree() can be safely called. So the
>> following splats may be printed:
>>
>>     WARNING: possible circular locking dependency detected
>>     BUG: sleeping function called from invalid context
>>
>> To avoid these problems without leaking memory, the free cpumask is now
>> put into a lockless list to be reused in a later sched_setaffinity()
>> call instead.
> Urgh.. depending on which of the callsites it is, it's probably simpler
> to just rework the caller to not use do_set_cpus_allowed(), no?

Maybe. One thing that I am not clear about is why user_cpus_ptr is set 
in the first place.

Cheers,
Longman


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD545E61D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIVL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIVL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D11A1D66
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663847816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXHxih+IbJlBpItUiUsNTieYvbvInNzPCfL2NlPaMU8=;
        b=ZWQ7Z9fAMGJkS7tAA9YCM/sLa7lVluO+jyMlyLaqYNeKYUS4z5dRppzN/lAjxYoRQl+bgz
        6+PddmZGlOI9X/LUOH7xWHTjk0dqvPhLxhGhJUovuSGhs7cQiGkhc916y3VVIb1/lU4H6J
        8txlCHXuppWqkQ6eIFy97V+7pCNLkVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-DdNE36QCNrOPn7uiAkMj1Q-1; Thu, 22 Sep 2022 07:56:49 -0400
X-MC-Unique: DdNE36QCNrOPn7uiAkMj1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEFAA101E14E;
        Thu, 22 Sep 2022 11:56:48 +0000 (UTC)
Received: from [10.22.33.6] (unknown [10.22.33.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71F60140EBF5;
        Thu, 22 Sep 2022 11:56:47 +0000 (UTC)
Message-ID: <5da6ff25-bf96-743b-8d5c-152838044ecf@redhat.com>
Date:   Thu, 22 Sep 2022 07:56:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v9 0/7] sched: Persistent user requested affinity
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220916183217.1172225-1-longman@redhat.com>
 <Yywgq+NUZH+JuJpF@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yywgq+NUZH+JuJpF@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 04:45, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 02:32:10PM -0400, Waiman Long wrote:
>
>> Waiman Long (7):
>>    sched: Add __releases annotations to affine_move_task()
>>    sched: Use user_cpus_ptr for saving user provided cpumask in
>>      sched_setaffinity()
>>    sched: Enforce user requested affinity
>>    sched: Introduce affinity_context structure
>>    sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
>>    sched: Fix sched_setaffinity() and fork/clone() race
>>    sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
> I still think this is ordered all wrong. Esp. with that affinity context
> doing the right thing isn't onerous at all.
>
> So please, re-order this and fold all fixes back in so that it becomes
> a sane series. Basically patches 5 and 6 shouldn't exist, they fix
> issues created by the earlier patches.
>
Thanks for the suggestion. Will rework the series as suggested.

Cheers,
Longman


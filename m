Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C4A6EF618
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjDZOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbjDZOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5DF6EA1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682518432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rf30qPmkXFyg0eo0/oPK9xXJTsxFmQ7zB528P1kEZb8=;
        b=Rbzn3I7M0p9mLq/wL93Ea/yQphwMjqY5+XjdqPEwXvaQla6N17LyhMZC6dPdGbd09YORV7
        uvwOatKSakbSsvg3lgt11fPBM5xduzDB03K/1TOaN9LFOHREmGceKb2kKORajsIecfO1fp
        xUhEEwXiOsRGj30wqjBHr8YtNliHyXw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-EsePhSkiP9mKEUg0iLPFVQ-1; Wed, 26 Apr 2023 10:09:45 -0400
X-MC-Unique: EsePhSkiP9mKEUg0iLPFVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79E5A3815EED;
        Wed, 26 Apr 2023 14:05:51 +0000 (UTC)
Received: from [10.22.18.92] (unknown [10.22.18.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF52A40C2020;
        Wed, 26 Apr 2023 14:05:49 +0000 (UTC)
Message-ID: <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
Date:   Wed, 26 Apr 2023 10:05:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZEkRq9iGkYP/8T5w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 07:57, Juri Lelli wrote:
> On 04/04/23 13:31, Waiman Long wrote:
>> On 3/29/23 08:55, Juri Lelli wrote:
>>> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
>>> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
>>> as it has been reported to cause slowdowns in workloads that need to
>>> change cpuset configuration frequently and it is also not implementing
>>> priority inheritance (which causes troubles with realtime workloads).
>>>
>>> Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
>>> only for SCHED_DEADLINE tasks (other policies don't care about stable
>>> cpusets anyway).
>>>
>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> I am thinking that maybe we should switch the percpu rwsem to a regular
>> rwsem as there are cases where a read lock is sufficient. This will also
>> avoid the potential PREEMPT_RT problem with PI and reduce the time it needs
>> to take a write lock.
> I'm not a big fan of rwsems for reasons like
> https://lore.kernel.org/lkml/20230321161140.HMcQEhHb@linutronix.de/, so
> I'd vote for a standard mutex unless we have a strong argument and/or
> numbers.

That is fine for me too.

Cheers,
Longman


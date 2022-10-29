Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB916611F4F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2C1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2C1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:27:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377771D3A75
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:27:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mzjqc20fjzmV5s;
        Sat, 29 Oct 2022 10:22:36 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 10:27:32 +0800
Subject: Re: Regression on vcpu_is_preempted()
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <rohit.k.jain@oracle.com>
References: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
 <625ce99b-8ec3-f807-99ac-1dc32695deca@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <75cd0a42-bbe9-c0af-6759-0bab1ef4b08c@huawei.com>
Date:   Sat, 29 Oct 2022 10:27:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <625ce99b-8ec3-f807-99ac-1dc32695deca@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/28 18:21, Abel Wu wrote:
> Hi Miaohe,
> 
> On 10/28/22 4:48 PM, Miaohe Lin wrote:
>> Hi all scheduler experts:
>>    When we run java gc in our 8 vcpus guest *without KVM_FEATURE_STEAL_TIME enabled*, the output looks like below:
>>      With ParallelGCThreads=4 and ConcGCThreads=4, we have:
>>     G1 Young Generation: 1 times 1786 ms
>>     G1 Old Generation: 1 times 1022 ms
>>      With ParallelGCThreads=5 and ConcGCThreads=5, we have:
>>     G1 Young Generation: 1 times 1557 ms
>>     G1 Old Generation: 1 times 1020 ms
>>
>>    This meets our expectation. But *with KVM_FEATURE_STEAL_TIME enabled* in our guest, the output looks like this:
>>      With ParallelGCThreads=4 and ConcGCThreads=4, we have:
>>     G1 Young Generation: 1 times 1637 ms
>>     G1 Old Generation: 1 times 1022 ms
>>      With ParallelGCThreads=5 and ConcGCThreads=5, we have:
>>     G1 Young Generation: 1 times 2164 ms
>>                       ^^^^
>>     G1 Old Generation: 1 times 1024 ms
>>
>>    The duration of G1 Young Generation is far beyond our expectation when gc threads = 5. And we found the root cause
>> is that when KVM_FEATURE_STEAL_TIME is enabled *there are much more(3k+) cpu migrations for java gc threads*. It's due to
>> the below commit:
>>
>>    commit 247f2f6f3c706b40b5f3886646f3eb53671258bf
>>    Author: Rohit Jain <rohit.k.jain@oracle.com>
>>    Date:   Wed May 2 13:52:10 2018 -0700
>>
>>      sched/core: Don't schedule threads on pre-empted vCPUs
>>
>>      In paravirt configurations today, spinlocks figure out whether a vCPU is
>>      running to determine whether or not spinlock should bother spinning. We
>>      can use the same logic to prioritize CPUs when scheduling threads. If a
>>      vCPU has been pre-empted, it will incur the extra cost of VMENTER and
>>      the time it actually spends to be running on the host CPU. If we had
>>      other vCPUs which were actually running on the host CPU and idle we
>>      should schedule threads there.
>>
>>    When scheduler tries to select a CPU to run the gc thread, available_idle_cpu() will check whether vcpu_is_preempted().
>> It will choose other vcpu to run gc threads when the current vcpu is preempted. But the preempted vcpu has no other work
>> to do except continuing to do gc. In our guest, there are more vcpus than java gc threads. So there could always be some
>> available vcpus when scheduler tries to select a idle vcpu (runing on host). This leads to lots of cpu migrations and results
>> in regression.
> 

Hi Abel, many thanks for your reply. :)

> So you want the preempted idle cpus to run gc threads to maximize the
> gc throughput, but available_idle_cpu() keeps them from being selected.

Yes. The preempted idle cpus has nothing to do just as the other running on host idle cpus.

> In theory, load balancing will help spreading load to these cpus (and
> make them VMENTERed), so have you checked that the gc threads showed a
> tendency to stack on same cpus?
> .

When KVM_FEATURE_STEAL_TIME enabled, gc threads are migrated frequently between cpus without tendency to
stack on same cpus. But the loads of cpus look more balanced in this case. It looks like it's a tradeoff
between gc throughout and cpu load. Any thoughts?

Thanks,
Miaohe Lin


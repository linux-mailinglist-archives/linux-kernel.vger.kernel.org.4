Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9C5F88E1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJIC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJIC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:28:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04B3642A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:28:51 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MlQrP4jKZzpVbf;
        Sun,  9 Oct 2022 10:25:41 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 9 Oct
 2022 10:28:48 +0800
Message-ID: <d41afbd5-6040-50ec-c0a5-c52ae48f6515@huawei.com>
Date:   Sun, 9 Oct 2022 10:28:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] sched/cputime: Fix the time backward issue about
 /proc/stat
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <hucool.lihua@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20220928033402.181530-1-zhengzucheng@huawei.com>
 <YzQB8afi2rCPvuC1@hirez.programming.kicks-ass.net>
 <20220928121134.GA233658@lothringen>
 <5126b2dc-8624-babc-2e1e-58ac27927c31@huawei.com>
 <20220930121634.GA266766@lothringen>
From:   zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <20220930121634.GA266766@lothringen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/30 20:16, Frederic Weisbecker 写道:
> On Fri, Sep 30, 2022 at 10:43:58AM +0800, zhengzucheng wrote:
>> 在 2022/9/28 20:11, Frederic Weisbecker 写道:
>>> @@ -1024,20 +1045,20 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>>>    		 * add pending nohz time to the right place.
>>>    		 */
>>>    		if (state == VTIME_SYS) {
>>> -			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
>>> +			cpustat[CPUTIME_SYSTEM] += delta;
>>>    		} else if (state == VTIME_USER) {
>>>    			if (task_nice(tsk) > 0)
>>> -				cpustat[CPUTIME_NICE] += vtime->utime + delta;
>>> +				cpustat[CPUTIME_NICE] += delta;
>>>    			else
>>> -				cpustat[CPUTIME_USER] += vtime->utime + delta;
>>> +				cpustat[CPUTIME_USER] += delta;
>> “delta” has the same problem as vtime->utime, which varies with different
>> tasks. switching between different tasks may cause time statistics to be
>> reversed.
> I'm a bit confused, can you provide an example?
Chinese National Day holiday, sorry for not replying to you in time.

CONFIG_HZ=100
const struct kernel_cpustat *src = &kcpustat_cpu(cpu);
struct vtime *vtime = &tsk->vtime;
cpustat[CPUTIME_USER] += vtime->utime + delta;

first：
cat /proc/stat | grep cpu1
cpu1 319 0 496 41665 0 0 0 0 0 0
Task A is running on CPU 1，so vtime is A->vtime and delta is A's delta.
kcpustat_cpu_fetch_vtime: cpu=1 src->cpustat[CPUTIME_USER]=3189000000 
vtime->utime=900000 delta=100001
cpustat[CPUTIME_USER] = 3189000000 + 900000 + 100001 is 3,190,000,001, 
319 ticks

again：
cat /proc/stat | grep cpu1
cpu1 318 0 497 41674 0 0 0 0 0 0
Task B is running on CPU 1，so vtime is B->vtime and delta is B's delta.
kcpustat_cpu_fetch_vtime: cpu=1 src->cpustat[CPUTIME_USER]=3189000000 
vtime->utime=900000 delta=90000
cpustat[CPUTIME_USER] = 3189000000 + 900000 + 90000 is 3,189,990,000, 
318 ticks

The root cause is that the value of task B's "vtime->utime + delta" may 
be smaller than task A.
>
> Thanks.
>
>>>    		} else {
>>>    			WARN_ON_ONCE(state != VTIME_GUEST);
>>>    			if (task_nice(tsk) > 0) {
>>> -				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
>>> -				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
>>> +				cpustat[CPUTIME_GUEST_NICE] += delta;
>>> +				cpustat[CPUTIME_NICE] += delta;
>>>    			} else {
>>> -				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
>>> -				cpustat[CPUTIME_USER] += vtime->gtime + delta;
>>> +				cpustat[CPUTIME_GUEST] += delta;
>>> +				cpustat[CPUTIME_USER] += delta;
>>>    			}
>>>    		}
>>>    	} while (read_seqcount_retry(&vtime->seqcount, seq));
>>> .
> .

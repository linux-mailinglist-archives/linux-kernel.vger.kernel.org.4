Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7776121BB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ2JPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ2JPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:15:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310784661C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:15:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mztt31T62zmVWx;
        Sat, 29 Oct 2022 17:10:19 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 17:15:15 +0800
Subject: Re: Regression on vcpu_is_preempted()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <rohit.k.jain@oracle.com>,
        <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
 <Y1zrNKEUPRem/UUI@hirez.programming.kicks-ass.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d00f7b30-4b34-3d3d-98c5-d0db1a5d9c4f@huawei.com>
Date:   Sat, 29 Oct 2022 17:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y1zrNKEUPRem/UUI@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/10/29 16:58, Peter Zijlstra wrote:
> On Fri, Oct 28, 2022 at 04:48:21PM +0800, Miaohe Lin wrote:
>>   When scheduler tries to select a CPU to run the gc thread,
>>   available_idle_cpu() will check whether vcpu_is_preempted().  It
>>   will choose other vcpu to run gc threads when the current vcpu is
>>   preempted. But the preempted vcpu has no other work to do except
>>   continuing to do gc. In our guest, there are more vcpus than java gc
>>   threads. So there could always be some available vcpus when
>>   scheduler tries to select a idle vcpu (runing on host). This leads
>>   to lots of cpu migrations and results in regression.
>>
>>   I'm not really familiar with this mechanism. Is this a problem that
>>   needs to be fixed or improved? Or is this just expected behavior?
>>   Any response would be really appreciated!
> 
> This is pretty much expected behaviour. When a vCPU is preempted the
> guest cannot know it's state or latency. Typically in the overcomitted
> case another vCPU will be running on the CPU and getting our vCPU thread
> back will take a considerable amount of time.

I see. Many thanks for your kindly reply and explanation. :)

> 
> If you know you're not over-committed, perhaps you should configure your
> VM differently.

Do you have any suggestion about how should I configure my VM when it's not over-committed?

Thanks,
Miaohe Lin



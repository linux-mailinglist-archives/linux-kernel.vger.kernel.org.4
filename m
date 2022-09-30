Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1735F021A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiI3BGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI3BF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:05:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765E6C108
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:05:51 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MdsRH4PflzHqTp;
        Fri, 30 Sep 2022 09:03:07 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:05:26 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 09:05:25 +0800
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
To:     Feng Tang <feng.tang@intel.com>, Yu Liao <liaoyu15@huawei.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <len.brown@intel.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
 <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
 <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
 <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
 <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com> <YzY6e0UwDAyU1GrX@feng-clx>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <44206484-620d-abaf-4fb9-fc4ef1c9184f@huawei.com>
Date:   Fri, 30 Sep 2022 09:05:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YzY6e0UwDAyU1GrX@feng-clx>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/30 8:38, Feng Tang wrote:
> On Thu, Sep 29, 2022 at 11:52:28PM +0800, Yu Liao wrote:
>> On 2020/12/2 15:28, Zhang Rui wrote:
>>> On Mon, 2020-11-30 at 20:21 +0100, Thomas Gleixner wrote:
>>>> Feng,
>>>>
>>>> On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
>>>>> On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
>>>>>> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
>>>>>> Yes, that can happen. But OTOH, we should start to think about
>>>>>> the
>>>>>> requirements for using the TSC watchdog.
>>>
>>> My original proposal is to disable jiffies and refined-jiffies as the
>>> clocksource watchdog, because they are not reliable and it's better to
>>> use clocksource that has a hardware counter as watchdog, like the patch
>>> below, which I didn't sent out for upstream.
>>>
>>> >From cf9ce0ecab8851a3745edcad92e072022af3dbd9 Mon Sep 17 00:00:00 2001
>>> From: Zhang Rui <rui.zhang@intel.com>
>>> Date: Fri, 19 Jun 2020 22:03:23 +0800
>>> Subject: [RFC PATCH] time/clocksource: do not use refined-jiffies as watchdog
>>>
>>> On IA platforms, if HPET is disabled, either via x86 early-quirks, or
>>> via kernel commandline, refined-jiffies will be used as clocksource
>>> watchdog in early boot phase, before acpi_pm timer registered.
>>>
>>> This is not a problem if jiffies are accurate.
>>> But in some cases, for example, when serial console is enabled, it may
>>> take several milliseconds to write to the console, with irq disabled,
>>> frequently. Thus many ticks may become longer than it should be.
>>>
>>> Using refined-jiffies as watchdog in this case breaks the system because
>>> a) duration calculated by refined-jiffies watchdog is always consistent
>>>    with the watchdog timeout issued using add_timer(), say, around 500ms.
>>> b) duration calculated by the running clocksource, usually TSC on IA
>>>    platforms, reflects the real time cost, which may be much larger.
>>> This results in the running clocksource being disabled erroneously.
>>>
>>> This is reproduced on ICL because HPET is disabled in x86 early-quirks,
>>> and also reproduced on a KBL and a WHL platform when HPET is disabled
>>> via command line.
>>>
>>> BTW, commit fd329f276eca
>>> ("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping") is
>>> another example that refined-jiffies causes the same problem when ticks
>>> become slow for some other reason.
>>
>> Hi, Zhang Rui, we have met the same problem as you mentioned above. I have
>> tested the following modification. It can solve the problem. Do you have plan
>> to push it to upstream ?
> 
> Hi Liao Yu,
> 
> Could you provoide more details? Like, what ARCH is the platform (x86
> or others), client or sever, if sever, how many sockets (2S/4S/8S)?
> 
> The error kernel log will also be helpful.

Hi, Feng Tang,

It's a X86 Sever. lscpu print the following information:

Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   46 bits physical, 48 bits virtual
CPU(s):                          224
On-line CPU(s) list:             0-223
Thread(s) per core:              2
Core(s) per socket:              28
Socket(s):                       4
NUMA node(s):                    4
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           85
Model name:                      Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
Stepping:                        4
CPU MHz:                         3199.379
CPU max MHz:                     3800.0000
CPU min MHz:                     1000.0000
BogoMIPS:                        5000.00
Virtualization:                  VT-x
L1d cache:                       3.5 MiB
L1i cache:                       3.5 MiB
L2 cache:                        112 MiB
L3 cache:                        154 MiB
NUMA node0 CPU(s):               0-27,112-139
NUMA node1 CPU(s):               28-55,140-167
NUMA node2 CPU(s):               56-83,168-195
NUMA node3 CPU(s):               84-111,196-223

Part of the kernel log is as follows.

[    1.144402] smp: Brought up 4 nodes, 224 CPUs
[    1.144402] smpboot: Max logical packages: 4
[    1.144402] smpboot: Total of 224 processors activated (1121097.93 BogoMIPS)
[    1.520003] clocksource: timekeeping watchdog on CPU2: Marking clocksource
'tsc-early' as unstable because the skew is too large:
[    1.520010] clocksource:                       'refined-jiffies' wd_now:
fffb7210 wd_last: fffb7018 mask: ffffffff
[    1.520013] clocksource:                       'tsc-early' cs_now:
6606717afddd0 cs_last: 66065eff88ad4 mask: ffffffffffffffff
[    1.520015] tsc: Marking TSC unstable due to clocksource watchdog
[    5.164635] node 0 initialised, 98233092 pages in 4013ms
[    5.209294] node 3 initialised, 98923232 pages in 4057ms
[    5.220001] node 2 initialised, 99054870 pages in 4068ms
[    5.222282] node 1 initialised, 99054870 pages in 4070ms

Thanks,
Xiongfeng

> 
> Thanks,
> Feng
> 
>> Thanks,
>> Liao Yu
>>
>>>
>>> IMO, the right solution is to only use hardware clocksource as watchdog.
>>> Then even if ticks are slow, both the running clocksource and the watchdog
>>> returns real time cost, and they still match.
>>>
>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>> ---
>>>  kernel/time/clocksource.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>> index 02441ead3c3b..e7e703858fa6 100644
>>> --- a/kernel/time/clocksource.c
>>> +++ b/kernel/time/clocksource.c
>>> @@ -364,6 +364,10 @@ static void clocksource_select_watchdog(bool fallback)
>>>  		watchdog = NULL;
>>>  
>>>  	list_for_each_entry(cs, &clocksource_list, list) {
>>> +		/* Do not use refined-jiffies as clocksource watchdog */
>>> +		if (cs->rating <= 2)
>>> +			continue;
>>> +
>>>  		/* cs is a clocksource to be watched. */
>>>  		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY)
>>>  			continue;
>>
> .
> 

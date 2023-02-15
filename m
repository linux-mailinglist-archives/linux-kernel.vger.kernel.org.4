Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340896974A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBODFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBODFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:05:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA64222008
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:05:15 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PGjYX52CNzRs5G;
        Wed, 15 Feb 2023 11:02:40 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 11:05:12 +0800
Message-ID: <abe55a65-1ab9-39ca-2cca-3190c6ba2e21@huawei.com>
Date:   Wed, 15 Feb 2023 11:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <bp@alien8.de>, <jroedel@suse.de>,
        <vbabka@suse.cz>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <eric.devolder@oracle.com>, <tiwai@suse.de>,
        <keescook@chromium.org>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>, <xiexiuqi@huawei.com>,
        <kexec@lists.infradead.org>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
 <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
 <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
 <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
 <Y+wu5UJTzVIYrsbK@MiWiFi-R3L-srv>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y+wu5UJTzVIYrsbK@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/15 9:01, Baoquan He 写道:
> Add kexec list to CC.
>
> On 02/14/23 at 10:49am, Peter Zijlstra wrote:
>> On Tue, Feb 14, 2023 at 05:30:46PM +0800, Zeng Heng wrote:
>>
>>>> I never remember the shutdown paths -- do we force wipe the PMU
>>>> registers somewhere before this?
>>> I have checked the panic process, and there is no wipe operation for PMU
>>> registers,
>>>
>>> which causes the watchdog bites.
>>>
>>> Do you mean we should directly disable PMU registers instead of calling
>>> `iret_to_self` to
>>>
>>> consume blocked NMI interrupts ?
>> If you don't wipe the PMU, there will be many and continuous NMIs, a
>> single IRET-to-SELF isn't going to safe you.
>>
>> Anyway, I had a bit of a grep around and I find we have:
>>
>>    kernel/events/core.c:   register_reboot_notifier(&perf_reboot_notifier);
>>
>> which should end up killing all the PMU activity. Somewhere around there
>> there's also a CONFIG_KEXEC_CORE ifdef, so I'm thinking it gets called
>> on the panic->crash-kernel path too?
> No, reboot_notifier_list is only handled in kexec reboot/reboot path,
> please see kernel_restart_prepare() invocation. Kdump path only shutdown
> key component like cpu, interrupt controller.

I would replace iret_to_self() with perf_event_exit_cpu() in kdump shutdown

path (in native_machine_crash_shutdown()).


After test, I would send v4 later.

Thanks all,

Zeng Heng



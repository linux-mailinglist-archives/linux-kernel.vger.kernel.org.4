Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117366A0175
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBWDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBWDON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:14:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F5212AA;
        Wed, 22 Feb 2023 19:14:12 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PMdKM68dZzKmMq;
        Thu, 23 Feb 2023 11:09:11 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 23 Feb 2023 11:14:01 +0800
Message-ID: <0e26e06a-37af-8905-5b87-d1f96a74ab67@huawei.com>
Date:   Thu, 23 Feb 2023 11:14:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH v4] x86/kdump: terminate watchdog NMI interrupt to
 avoid kdump crashes
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <tiwai@suse.de>, <jolsa@kernel.org>, <vbabka@suse.cz>,
        <keescook@chromium.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <bp@alien8.de>, <bhe@redhat.com>,
        <eric.devolder@oracle.com>, <hpa@zytor.com>, <jroedel@suse.de>,
        <dave.hansen@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <x86@kernel.org>, <xiexiuqi@huawei.com>, <liaochang1@huawei.com>
References: <20230217120604.435608-1-zengheng4@huawei.com>
 <Y/ZMEesgPnRR3LsG@hirez.programming.kicks-ass.net>
 <87r0uh5yud.fsf@email.froward.int.ebiederm.org>
 <81f5d521-bc8a-4d1a-fe7e-55487f3d25b3@huawei.com>
In-Reply-To: <81f5d521-bc8a-4d1a-fe7e-55487f3d25b3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/23 10:29, Zeng Heng 写道:
>
> 在 2023/2/23 2:39, Eric W. Biederman 写道:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>>> On Fri, Feb 17, 2023 at 08:06:04PM +0800, Zeng Heng wrote:
>>>> If the cpu panics within the NMI interrupt context, there could be
>>>> unhandled NMI interrupts in the background which are blocked by 
>>>> processor
>>>> until next IRET instruction executes. Since that, it prevents nested
>>>> NMI handler execution.
>>>>
>>>> In case of IRET execution during kdump reboot and no proper NMIs 
>>>> handler
>>>> registered at that point (such as during EFI loader)
>> EFI loader?  kexec on panic is supposed to be kernel to kernel.
>> If someone is getting EFI involved that is a bug.
>
> In kdump path, kexec would start purgatory to verify the secondary 
> kernel by
>
> sha256. If verify passed, it would turn the control to EFI loader, and 
> call the second
>
> kernel to capture the environment as vmcore file.
>
> As the mail said, if panic appears within NMI context, we never exit 
> from that until
>
> EFI loader handles page fault exception and executes IRET instruction 
> when exit
>
> from PF. At this moment, processor would allow the blocked NMI 
> interrupt raise.
>
>
>>> This kills all of perf, including but not limited to the hardware
>>> watchdog. However, it does nothing to external NMI sources like the NMI
>>> button found on some HP machines.
>>>
>>> Still I suppose it is sufficient for the normal case.
>> I can't think of one why we don't just leave
>> NMIs deliberately disabled
>
Inative_machine_crash_shutdown() has called lapic_shutdown() to disable 
any kind of

irq, but EFI loader assumes there is no any residual NMIs in the background.


Here is the first version for this issue:

https://lore.kernel.org/all/20230110102745.2514694-1-zengheng4@huawei.com/

Zeng Heng

>
>> until the crash recover kernel figured out how to enable them safely.
>>
>

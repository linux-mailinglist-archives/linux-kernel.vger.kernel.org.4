Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA374B10A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGGMka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:40:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38719B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:40:26 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QyCbD44WxztQVn;
        Fri,  7 Jul 2023 20:37:28 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:40:22 +0800
Message-ID: <60c2ec19-9848-b7f0-f8af-53be0cbaf319@huawei.com>
Date:   Fri, 7 Jul 2023 20:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <arjan@linux.intel.com>, <ashok.raj@intel.com>,
        <ashok.raj@linux.intel.com>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <thomas.lendacky@amd.com>, <tony.luck@intel.com>,
        <tonyb@cybernetics.com>, <x86@kernel.org>,
        yangerkun <yangerkun@huawei.com>, Baoquan He <bhe@redhat.com>,
        <kexec@lists.infradead.org>, Baokun Li <libaokun1@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com> <87ttui91jo.ffs@tglx>
 <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com> <87lefs81og.ffs@tglx>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87lefs81og.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/7 18:18, Thomas Gleixner wrote:
> On Thu, Jul 06 2023 at 14:44, Baokun Li wrote:
>> On 2023/7/5 16:59, Thomas Gleixner wrote:
>>> +	/*
>>> +	 * If this is a crash stop which does not execute on the boot CPU,
>>> +	 * then this cannot use the INIT mechanism because INIT to the boot
>>> +	 * CPU will reset the machine.
>>> +	 */
>>> +	if (this_cpu)
>>> +		return false;

This does solve the problem of x86 VMs not waiting when they panic, so

Reported-and-tested-by: Baokun Li <libaokun1@huawei.com>

>> This patch does fix the problem of rebooting at panic, but the
>> exported stack stays at stop_this_cpu() like below, instead of showing
>> what the corresponding process is doing as before.
>>
>> PID: 681      TASK: ffff9ac2429d3080  CPU: 2    COMMAND: "fsstress"
>>    #0 [ffffb00200184fd0] stop_this_cpu at ffffffff89a4ffd8
>>    #1 [ffffb00200184fe8] __sysvec_reboot at ffffffff89a94213
>>    #2 [ffffb00200184ff0] sysvec_reboot at ffffffff8aee7491
>> --- <IRQ stack> ---
>>       RIP: 0000000000000010  RSP: 0000000000000018  RFLAGS: ffffb00200f8bd08
>>       RAX: ffff9ac256fda9d8  RBX: 0000000009973a85  RCX: ffff9ac256fda078
>>       RDX: ffff9ac24416e300  RSI: ffff9ac256fda9e0  RDI: ffffffffffffffff
>>       RBP: ffff9ac2443a5f88   R8: 0000000000000000   R9: ffff9ac2422eeea0
>>       R10: ffff9ac256fda9d8  R11: 0000000000549921  R12: ffff9ac2422eeea0
>>       R13: ffff9ac251cd23c8  R14: ffff9ac24269a800  R15: ffff9ac251cd2150
>>       ORIG_RAX: ffffffff8a1719e4  CS: 0206  SS: ffffffff8a1719c8
>> bt: WARNING: possibly bogus exception frame
>>
>> Do you know how this happened? I would be grateful if you could fix it.
> No, I don't. But there is clearly a hint:
>
>> bt: WARNING: possibly bogus exception frame
> So the exception frame seems to be corrupted. I have no idea why.
>
> The question is, whether this goes away when you revert that commit or not.
> I can't oracle that out from your report.
>
> Can you please revert 45e34c8af58f on top of Linus tree and verify that
> it makes the issue go away?
>
> Thanks,
>
>          tglx
Yes, the stop_this_cpu() issue persisted after I reverted 45e34c8af58f 
and it
has nothing to do with your patch, I will try to bisect to find out 
which patch
introduced the issue.

Thank you very much for helping locate and rectify the problem that the x86
VM panic does not wait!

Cheers!
-- 
With Best Regards,
Baokun Li
.

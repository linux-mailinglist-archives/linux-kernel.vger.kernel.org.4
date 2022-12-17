Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D364F886
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 10:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiLQJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 04:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 04:48:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D826F8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:48:50 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NZ1Kb0XJfzJpPM;
        Sat, 17 Dec 2022 17:45:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 17:48:47 +0800
Message-ID: <23c0aa08-1dc0-31df-90d2-3231c78768d1@huawei.com>
Date:   Sat, 17 Dec 2022 17:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] arm64: fix a concurrency issue in
 emulation_proc_handler()
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <haibinzhang@tencent.com>, <hewenliang4@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221209105556.47621-1-ruanjinjie@huawei.com>
 <Y5MXe89uK4ekeD+b@FVFF77S0Q05N>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <Y5MXe89uK4ekeD+b@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/9 19:09, Mark Rutland wrote:
> On Fri, Dec 09, 2022 at 06:55:56PM +0800, ruanjinjie wrote:
>> In emulation_proc_handler(), read and write operations are performed on
>> insn->current_mode. In the concurrency scenario, mutex only protects
>> writing insn->current_mode, and not protects the read. Suppose there are
>> two concurrent tasks, task1 updates insn->current_mode to INSN_EMULATE
>> in the critical section, the prev_mode of task2 is still the old data
>> INSN_UNDEF of insn->current_mode. As a result, two tasks call
>> update_insn_emulation_mode twice with prev_mode = INSN_UNDEF and
>> current_mode = INSN_EMULATE, then call register_emulation_hooks twice,
>> resulting in a list_add double problem.
>>
>> Call trace:
>>  __list_add_valid+0xd8/0xe4
>>  register_undef_hook+0x94/0x13c
>>  update_insn_emulation_mode+0xd0/0x12c
>>  emulation_proc_handler+0xd8/0xf4
>>  proc_sys_call_handler+0x140/0x250
>>  proc_sys_write+0x1c/0x2c
>>  new_sync_write+0xec/0x18c
>>  vfs_write+0x214/0x2ac
>>  ksys_write+0x70/0xfc
>>  __arm64_sys_write+0x24/0x30
>>  el0_svc_common.constprop.0+0x7c/0x1bc
>>  do_el0_svc+0x2c/0x94
>>  el0_svc+0x20/0x30
>>  el0_sync_handler+0xb0/0xb4
>>  el0_sync+0x160/0x180
> 
> The version queued in the arm64 for-next/core branch no longer has the list
> manipulation, but we do need to fix this for stable, and there is a remaining
> race on reading insn->current_mode in emulation_proc_handler().
Hi Mark, Should I send this patch to linux-stable?
> 
>> Fixes: af483947d472 ("arm64: fix oops in concurrently setting insn_emulation sysctls")
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/armv8_deprecated.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index fb0e7c7b2e20..d33e5d9e6990 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -208,10 +208,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>>  				  loff_t *ppos)
>>  {
>>  	int ret = 0;
>> -	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
>> -	enum insn_emulation_mode prev_mode = insn->current_mode;
>> +	struct insn_emulation *insn;
>> +	enum insn_emulation_mode prev_mode;
>>  
>>  	mutex_lock(&insn_emulation_mutex);
>> +	insn = container_of(table->data, struct insn_emulation, current_mode);
>> +	prev_mode = insn->current_mode;
>>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> 
> We don't strictly need to move the container_of(), but it makes no odds either
> way, and this looks good to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
>>  
>>  	if (ret || !write || prev_mode == insn->current_mode)
>> -- 
>> 2.25.1
>>
> 

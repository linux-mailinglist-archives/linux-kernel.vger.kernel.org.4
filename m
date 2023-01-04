Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625C865CB6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbjADBbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjADBbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:31:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2AD8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:31:41 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NmsV86T4wzRqht;
        Wed,  4 Jan 2023 09:30:08 +0800 (CST)
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 09:31:39 +0800
Subject: Re: [bug-report] possible performance problem in ret_to_user_from_irq
To:     Jens Axboe <axboe@kernel.dk>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
 <Y7P+MjPNA6Tg8JBr@shell.armlinux.org.uk>
 <50a5ebdb-4107-26cc-a2f6-da551d99ff38@kernel.dk>
 <Y7Q88aBpxfWRqzTe@shell.armlinux.org.uk>
 <1ecb9b0c-1103-650a-e32a-93110466b2ae@kernel.dk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <a8636a3f-c199-97b5-b9f1-a9fc399ec3b9@huawei.com>
Date:   Wed, 4 Jan 2023 09:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1ecb9b0c-1103-650a-e32a-93110466b2ae@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/3 22:59, Jens Axboe wrote:
> On 1/3/23 7:34?AM, Russell King (Oracle) wrote:
>> On Tue, Jan 03, 2023 at 07:25:26AM -0700, Jens Axboe wrote:
>>> On 1/3/23 3:06?AM, Russell King (Oracle) wrote:
>>>> On Mon, Dec 26, 2022 at 04:45:20PM +0800, Hui Tang wrote:
>>>>> hi folks.
>>>>>
>>>>> I found a performance problem which is introduced by commit
>>>>> 32d59773da38 ("arm: add support for TIF_NOTIFY_SIGNAL").
>>>>> After the commit,  any bit in the range of 0..15 will cause
>>>>> do_work_pending() to be invoked. More frequent do_work_pending()
>>>>> invoked possible result in worse performance.
>>>>>
>>>>> Some of the tests I've done? as follows:
>>>>> lmbench test			base		with patch
>>>>> ./lat_ctx -P 1 -s 0  2		7.3167		11.04
>>>>> ./lat_ctx -P 1 -s 16 2          8.0467		14.5367
>>>>> ./lat_ctx -P 1 -s 64 2		7.8667		11.43
>>>>> ./lat_ctx -P 1 -s 16 16		16.47		18.3667
>>>>> ./lat_pipe -P 1			28.1671		44.7904
>>>>>
>>>>> libMicro-0.4.1 test		base		with patch
>>>>> ./cascade_cond -E -C 200\
>>>>>  -L -S -W -N "c_cond_1" -I 100	286.3333	358
>>>>>
>>>>> When I adjust test bit, the performance problem gone.
>>>>> -	movs	r1, r1, lsl #16
>>>>> +	ldr	r2, =#_TIF_WORK_MASK
>>>>> +	tst	r1, r2
>>>>>
>>>>> Does anyone have a good suggestion for this problem?
>>>>> should just test _TIF_WORK_MASK, as before?
>>>>
>>>> I think it should be fine - but I would suggest re-organising the
>>>> TIF definitions so that those TIF bits that shouldn't trigger
>>>> do_work_pending are not in the first 16 bits.
>>>>
>>>> Note that all four bits in _TIF_SYSCALL_WORK need to stay within
>>>> an 8-bit even-bit-aligned range, so the value is suitable for an
>>>> immediate assembly constant.
>>>>
>>>> I'd suggest moving the TIF definitions for 20 to 19, and 4..7 to
>>>> 20..23, and then 8 to 4.
>>>
>>> Like this?
>>>
>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>> index aecc403b2880..7f092cb55a41 100644
>>> --- a/arch/arm/include/asm/thread_info.h
>>> +++ b/arch/arm/include/asm/thread_info.h
>>> @@ -128,15 +128,16 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>  #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
>>>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>>>  #define TIF_UPROBE		3	/* breakpointed or singlestepping */
>>> -#define TIF_SYSCALL_TRACE	4	/* syscall trace active */
>>> -#define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
>>> -#define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
>>> -#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
>>> -#define TIF_NOTIFY_SIGNAL	8	/* signal notifications exist */
>>> +#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
>>>
>>>  #define TIF_USING_IWMMXT	17
>>>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>>> -#define TIF_RESTORE_SIGMASK	20
>>> +#define TIF_RESTORE_SIGMASK	19
>>> +#define TIF_SYSCALL_TRACE	20	/* syscall trace active */
>>> +#define TIF_SYSCALL_AUDIT	21	/* syscall auditing active */
>>> +#define TIF_SYSCALL_TRACEPOINT	22	/* syscall tracepoint instrumentation */
>>> +#define TIF_SECCOMP		23	/* seccomp syscall filtering active */
>>> +
>>>
>>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>>
>> Yep, LGTM, thanks.
>
> Hui Tang, can you give it a whirl? Just checked and it applies to
> 5.10-stable as well, just with a slight offset.

Okay, I'll test it today.

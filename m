Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1C6DEC30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDLHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:01:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700161989
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:01:56 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PxDBt1sykzDsl5;
        Wed, 12 Apr 2023 15:01:10 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Apr
 2023 15:01:53 +0800
Message-ID: <1ceb1769-f01b-c417-e912-4ee1149dd0cb@huawei.com>
Date:   Wed, 12 Apr 2023 15:01:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
To:     Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <akpm@linux-foudation.org>, <ben-linux@fluff.org>,
        <wuchi.zero@gmail.com>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
 <20230410022226.181812-2-chenzhongjin@huawei.com>
 <d416428f-c846-b6b9-74da-f3571d92d38a@intel.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <d416428f-c846-b6b9-74da-f3571d92d38a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/11 3:34, Dave Hansen wrote:
> On 4/9/23 19:22, Chen Zhongjin wrote:
>> Syzbot has been reporting the problem of stack-out-of-bounds in
>> profile_pc for a long time:
>> https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
>>
>> profile_pc tries to get pc if current regs is inside lock function. For
>> !CONFIG_FRAME_POINTER it used a hack way to get the pc from stack, which
>> is not work with ORC. It makes profile_pc read illeagal address, return
>> wrong result, and frequently triggers KASAN.
>>
>> Since lock profiling can be handled with much better other tools, It's
>> reasonable to remove lock functions hack for !FRAME_POINTER kernel.
> OK, so let me make sure I understand what's going on:
>
> 1. This whole issue is limited to kernel/profile.c which is what drives
>     readprofile(8) and /proc/profile
> 2. This is removing code that got added in 2006:
> 	0cb91a229364 ("[PATCH] i386: Account spinlocks to the caller during
> profiling for !FP kernels")
> 3. This was an OK hack back in the day, but it outright breaks today
>     in some situations.  KASAN also didn't exist in 2006.
Yes, and whether KASAN is enabled it can make problem.
Some lock_function will save registers on stack (this may not happen in 
2006).
These registers can be recorded by profile and be read outside of kernel,
which is risky theoretically.
> 4. !CONFIG_FRAME_POINTER is probably even more rare today than it was in
>     2006
No. !CONFIG_FRAME_POINTER is more common today because of UNWINDER_ORC.
And that is why the bug is triggered more frequently.
> 5. Lock function caller information is available at _least_ from perf,
>     maybe other places too??  (What "much better other tools" are there?)

Yes, it's basically about perf function graph.

> Given all that, this patch suggests that we can remove the stack peeking
> hack.  The downside is that /proc/profile users will see their profiles
> pointing to the spinlock functions like they did in 2005.  The upside is
> that we won't get any more KASAN reports.
>
> If anyone complains, I assume we're just going to tell them to run 'perf
> --call-graph' and to go away (which also probably didn't exist in 2006).
>
> If I got all that right, the end result seems sane to me.  It would be
> _nice_ if you could make a more coherent changelog out of that and
> resend.  Also, considering that your two "profile" issues are quite
> independent, you can probably just resend the two patches separately.
Thanks for review and I'll send another version to provide better details.

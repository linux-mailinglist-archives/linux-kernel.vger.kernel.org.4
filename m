Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCA71F822
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjFBBpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjFBBpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:45:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC997;
        Thu,  1 Jun 2023 18:44:58 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QXQg354Tvz18M3R;
        Fri,  2 Jun 2023 09:40:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:44:55 +0800
Message-ID: <fa272c15-9f7c-df9c-41dd-bffc19acbf85@huawei.com>
Date:   Fri, 2 Jun 2023 09:44:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Borislav Petkov <bp@alien8.de>,
        Youquan Song <youquan.song@intel.com>
CC:     <tony.luck@intel.com>, <naoya.horiguchi@nec.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jane.chu@oracle.com>
References: <20230526063242.133656-1-wangkefeng.wang@huawei.com>
 <20230526070952.GAZHBbQNAWZJP6tOXv@nazgul.local>
 <e816734d-e6f5-b990-c86d-ac7d5f1c94c0@huawei.com>
In-Reply-To: <e816734d-e6f5-b990-c86d-ac7d5f1c94c0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 20:18, Kefeng Wang wrote:
> 
> 
> On 2023/5/26 15:09, Borislav Petkov wrote:
>> On Fri, May 26, 2023 at 02:32:42PM +0800, Kefeng Wang wrote:
>>> The best way to fix them is set MCE_IN_KERNEL_COPYIN for MC-Safe Copy,
>>> then let the core do_machine_check() to isolate corrupted page instead
>>> of doing it one-by-one.
>>
>> No, this whole thing is confused.
>>
>>   * Indicates an MCE that happened in kernel space while copying data
>>   * from user.
>>
>> #define MCE_IN_KERNEL_COPYIN
>>
>> This is a very specific exception type: EX_TYPE_COPY which got added by
>>
>>    278b917f8cb9 ("x86/mce: Add _ASM_EXTABLE_CPY for copy user access")
>>
>> but Linus then removed all such user copy exception points in
>>
>>    034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")
>>
>> So now that EX_TYPE_COPY never happens.
> 
> Is this broken the recover when kernel was copying from user space?
> 
> + Youquan  could you help to check it?
> 
>>
>> And what you're doing is lumping the handling for
>> EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE together and saying
>> that the MCE happened while copying data from user.
>>
>> And XSTATE_OP() is one example where this is not really the case.
>>
> 
> Oh, for XSTATE_OP(), it uses EX_TYPE_DEFAULT_MCE_SAFE, but I'm focus on 
> EX_TYPE_DEFAULT_MCE_SAFE, which use copy_mc (arch/x86/lib/copy_mc_64.S),
> like I maintained in changelog, CoW/Coredump/nvdimm/dax, they use 
> copy_mc_xxx function,  sorry for mixed them up.
> 
> 
>> So no, this is not correct.
> 
> so only add MCE_IN_KERNEL_COPYIN for EX_TYPE_DEFAULT_MCE_SAFE?
> 
> diff --git a/arch/x86/kernel/cpu/mce/severity.c 
> b/arch/x86/kernel/cpu/mce/severity.c
> index c4477162c07d..6d2587994623 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -293,11 +293,11 @@ static noinstr int error_context(struct mce *m, 
> struct pt_regs *regs)
>          case EX_TYPE_COPY:
>                  if (!copy_user)
>                          return IN_KERNEL;
> +               fallthrough;
> +       case EX_TYPE_DEFAULT_MCE_SAFE:
>                  m->kflags |= MCE_IN_KERNEL_COPYIN;
>                  fallthrough;

As mentioned above, I am focus on copy_mc_XXX calling, it will
abort if the exception fires when accessing the source, and we
want to isolate the corrupted src page, maybe we could a new flag
to indicate this scenario, the *Final Goals* is to let core
do_machine_check to deal with the corrupted src page.

Any suggestiong, thanks


> -
>          case EX_TYPE_FAULT_MCE_SAFE:
> -       case EX_TYPE_DEFAULT_MCE_SAFE:
>                  m->kflags |= MCE_IN_KERNEL_RECOV;
>                  return IN_KERNEL_RECOV;
> 
> Correct me if I am wrong, thanks for you reviewing.
> 
> 
>>

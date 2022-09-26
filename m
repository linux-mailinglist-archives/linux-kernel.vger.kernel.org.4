Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB885EA917
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIZOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiIZOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:51:51 -0400
Received: from mail-m118204.qiye.163.com (mail-m118204.qiye.163.com [115.236.118.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE7B81261B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:18:21 -0700 (PDT)
Received: from [192.168.31.11] (unknown [221.212.176.62])
        by mail-m118204.qiye.163.com (HMail) with ESMTPA id CCAA1A20452;
        Mon, 26 Sep 2022 21:18:18 +0800 (CST)
Message-ID: <0ed40d5b-a404-f424-c9c4-2adf1bf9750b@inclyc.cn>
Date:   Mon, 26 Sep 2022 21:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] x86/fpu: use __alignof__ to avoid UB in TYPE_ALIGN
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, ndesaulniers@google.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220925153151.2467884-1-me@inclyc.cn>
 <YzFqXbVptttrzoDe@hirez.programming.kicks-ass.net>
From:   YingChi Long <me@inclyc.cn>
In-Reply-To: <YzFqXbVptttrzoDe@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUNNSR1WGR4fGhpISxkYThoZVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6SDo4MjlOQjc5NhMiLThI
        SSsKFDFVSlVKTU1PSkJDSEtLS0tIVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUhDQk03Bg++
X-HM-Tid: 0a8379f2cee22d26kusnccaa1a20452
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems GCC __alignof__ is not evaluated to the minimum alignment of some 
TYPE,
and depends on fields of the struct.

 > Notably I think 'long long' has 4 byte alignment on i386 and some other
 > 32bit archs.

C11 _Alignof matches in the case (see godbolt link below). How about 
switch to
_Alignof?


Link: https://godbolt.org/z/T749MfM9o
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10360
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52023
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69560

On 2022/9/26 17:01, Peter Zijlstra wrote:
> On Sun, Sep 25, 2022 at 11:31:50PM +0800, YingChi Long wrote:
>> WG14 N2350 made very clear that it is an UB having type definitions with
>> in "offsetof". This patch change the implementation of macro
>> "TYPE_ALIGN" to builtin "__alignof__" to avoid undefined behavior.
>>
>> I've grepped all source files to find any type definitions within
>> "offsetof".
>>
>>      offsetof\(struct .*\{ .*,
>>
>> This implementation of macro "TYPE_ALIGN" seemes to be the only case of
>> type definitions within offsetof in the kernel codebase.
>>
>> Signed-off-by: YingChi Long <me@inclyc.cn>
>> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
>> ---
>>   arch/x86/kernel/fpu/init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
>> index 621f4b6cac4a..41425ba0b6b1 100644
>> --- a/arch/x86/kernel/fpu/init.c
>> +++ b/arch/x86/kernel/fpu/init.c
>> @@ -134,7 +134,7 @@ static void __init fpu__init_system_generic(void)
>>   }
>>   
>>   /* Get alignment of the TYPE. */
>> -#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
>> +#define TYPE_ALIGN(TYPE) __alignof__(TYPE)
> IIRC there's a problem with alignof() in that it will return the ABI
> alignment instead of that preferred or natural alignment for some types.
>
> Notably I think 'long long' has 4 byte alignment on i386 and some other
> 32bit archs.
>
> That said; please just replace the *one* instance of TYPE_ALIGN entirely
> and get rid of the thing.
>

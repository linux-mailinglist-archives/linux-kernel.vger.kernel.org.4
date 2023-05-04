Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21C6F6DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjEDOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjEDOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:36:12 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BEEED
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683210967;
        bh=e6G8zmvrdVR2e5lRA0ALVXcD6mKHFZiLmGlkNfwabp4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MQ//0mGegx1p37/gppiAjJOReivG+yMFSIh0nbey1N7jsMSJV0jnbJpylva+GHtjS
         yVdghX9CePc6vScheHUvk12bwapTVRZb4deNMwFcTWBzQkRmSCfurtE1I//4dNEGoX
         48ruR85w4ZokjKAuxHSF0KG1BDPHmwfEGauVqvi3oI5sW26l7RVpRgkXoyOABtgLFn
         rqM9REIW5SSduTi5EEF77tKm571GPkg/2cVpv9bcZhSNxIE4lZXlQ/KKGIp5D7OE+7
         Jp7B68SSLYECj08OP5xDDY8IqGackqkYqgajH7MvnyNkO5hM53Citee3/A2kZyLTO0
         gitVtauJ81HJw==
Received: from [172.16.0.73] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBxFg3z2nz11dF;
        Thu,  4 May 2023 10:36:07 -0400 (EDT)
Message-ID: <6605c787-941f-cf3c-b0eb-345a35a32cbb@efficios.com>
Date:   Thu, 4 May 2023 10:36:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/3] selftests/rseq: Implement
 rseq_unqual_scalar_typeof
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230503201324.1587003-1-mathieu.desnoyers@efficios.com>
 <20230504060923.GB1734100@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230504060923.GB1734100@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 02:09, Peter Zijlstra wrote:
> On Wed, May 03, 2023 at 04:13:22PM -0400, Mathieu Desnoyers wrote:
>> Allow defining variables and perform cast with a typeof which removes
>> the volatile and const qualifiers.
>>
>> This prevents declaring a stack variable with a volatile qualifier
>> within a macro, which would generate sub-optimal assembler.
>>
>> This is imported from the "librseq" project.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>   tools/testing/selftests/rseq/compiler.h | 27 +++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
>> index f47092bddeba..8dc7f881e253 100644
>> --- a/tools/testing/selftests/rseq/compiler.h
>> +++ b/tools/testing/selftests/rseq/compiler.h
>> @@ -33,4 +33,31 @@
>>   #define RSEQ_COMBINE_TOKENS(_tokena, _tokenb)	\
>>   	RSEQ__COMBINE_TOKENS(_tokena, _tokenb)
>>   
>> +#ifdef __cplusplus
>> +#define rseq_unqual_scalar_typeof(x)					\
>> +	std::remove_cv<std::remove_reference<decltype(x)>::type>::type
>> +#else
>> +/*
>> + * Use C11 _Generic to express unqualified type from expression. This removes
>> + * volatile qualifier from expression type.
>> + */
>> +#define rseq_unqual_scalar_typeof(x)					\
>> +	__typeof__(							\
>> +		_Generic((x),						\
>> +			char: (char)0,					\
>> +			unsigned char: (unsigned char)0,		\
>> +			signed char: (signed char)0,			\
>> +			unsigned short: (unsigned short)0,		\
>> +			signed short: (signed short)0,			\
>> +			unsigned int: (unsigned int)0,			\
>> +			signed int: (signed int)0,			\
>> +			unsigned long: (unsigned long)0,		\
>> +			signed long: (signed long)0,			\
>> +			unsigned long long: (unsigned long long)0,	\
>> +			signed long long: (signed long long)0,		\
>> +			default: (x)					\
>> +		)							\
>> +	)
> 
> FWIW, I like how the kernel version uses a little helper for the
> signed/unsigned pairs. Makes it a little more readable.

OK, will update for next round:

#define rseq_scalar_type_to_expr(type)                                  \
         unsigned type: (unsigned type)0,                                \
         signed type: (signed type)0

/*
  * Use C11 _Generic to express unqualified type from expression. This removes
  * volatile qualifier from expression type.
  */
#define rseq_unqual_scalar_typeof(x)                                    \
         __typeof__(                                                     \
                 _Generic((x),                                           \
                         char: (char)0,                                  \
                         rseq_scalar_type_to_expr(char),                 \
                         rseq_scalar_type_to_expr(short),                \
                         rseq_scalar_type_to_expr(int),                  \
                         rseq_scalar_type_to_expr(long),                 \
                         rseq_scalar_type_to_expr(long long),            \
                         default: (x)                                    \
                 )                                                       \
         )

Thanks,

Mathieu

> 
>> +#endif
>> +
>>   #endif  /* RSEQ_COMPILER_H_ */
>> -- 
>> 2.25.1
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


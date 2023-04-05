Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2E6D81CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjDEP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjDEP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:27:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 731AC4C31
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:27:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B9FB113E;
        Wed,  5 Apr 2023 08:28:33 -0700 (PDT)
Received: from [10.57.94.33] (unknown [10.57.94.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BDF93F6C4;
        Wed,  5 Apr 2023 08:27:46 -0700 (PDT)
Message-ID: <8905800b-a977-e821-01ea-a43333f46904@arm.com>
Date:   Wed, 5 Apr 2023 16:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/4] log2: make is_power_of_2() more generic
To:     Jani Nikula <jani.nikula@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     David Gow <davidgow@google.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230330104243.2120761-1-jani.nikula@intel.com>
 <20230330125041.83b0f39fa3a4ec1a42dfd95f@linux-foundation.org>
 <549987e4967d45159573901d330c96a0@AcuMS.aculab.com>
 <20230330151846.fdbc8edbfbaa6eaddb056dc7@linux-foundation.org>
 <87edp52ufk.fsf@intel.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <87edp52ufk.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 09:31, Jani Nikula wrote:
> On Thu, 30 Mar 2023, Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Thu, 30 Mar 2023 21:53:03 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
>>
>>>> But wouldn't all these issues be addressed by simply doing
>>>>
>>>> #define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
>>>>
>>>> ?
>>>>
>>>> (With suitable tweaks to avoid evaluating `n' more than once)
>>>
>>> I think you need to use the 'horrid tricks' from min() to get
>>> a constant expression from constant inputs.
>>
>> This
>>
>> --- a/include/linux/log2.h~a
>> +++ a/include/linux/log2.h
>> @@ -41,11 +41,11 @@ int __ilog2_u64(u64 n)
>>   * *not* considered a power of two.
>>   * Return: true if @n is a power of 2, otherwise false.
>>   */
>> -static inline __attribute__((const))
>> -bool is_power_of_2(unsigned long n)
>> -{
>> -	return (n != 0 && ((n & (n - 1)) == 0));
>> -}
>> +#define is_power_of_2(_n)				\
>> +	({						\
>> +		typeof(_n) n = (_n);			\
>> +		n != 0 && ((n & (n - 1)) == 0);		\
>> +	})
>>  
>>  /**
>>   * __roundup_pow_of_two() - round up to nearest power of two
>> _
>>
>> worked for me in a simple test.
>>
>> --- a/fs/open.c~b
>> +++ a/fs/open.c
>> @@ -1564,3 +1564,10 @@ int stream_open(struct inode *inode, str
>>  }
>>  
>>  EXPORT_SYMBOL(stream_open);
>> +
>> +#include <linux/log2.h>
>> +
>> +int foo(void)
>> +{
>> +	return is_power_of_2(43);
>> +}
>> _
>>
>>
>> foo:
>> # fs/open.c:1573: }
>> 	xorl	%eax, %eax	#
>> 	ret	
>>
>>
>> Is there some more tricky situation where it breaks?
> 
> It doesn't work with BUILD_BUG_ON_ZERO().

Like most programming problems, you just need another layer of
indirection! The below works for me in all the cases I could think of
(including __uint128_t).


#define __IS_POWER_OF_2(n) (n != 0 && ((n & (n - 1)) == 0))

#define _IS_POWER_OF_2(n, unique_n)				\
	({							\
		typeof(n) unique_n = (n);			\
		__IS_POWER_OF_2(unique_n);			\
	})

#define is_power_of_2(n)					\
	__builtin_choose_expr(__is_constexpr((n)),		\
			      __IS_POWER_OF_2((n)),		\
			      _IS_POWER_OF_2(n, __UNIQUE_ID(_n)))


Although Jani's original might be easier to understand.

Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BB5F0AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiI3LoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiI3Ln4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:43:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5D157B86;
        Fri, 30 Sep 2022 04:37:07 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mf7Pp4qR4z1P6lL;
        Fri, 30 Sep 2022 19:32:46 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 19:37:05 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 19:37:04 +0800
Subject: Re: [PATCH v4 4/8] kallsyms: Improve the performance of
 kallsyms_lookup_name()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
References: <20220920071317.1787-1-thunder.leizhen@huawei.com>
 <20220920071317.1787-5-thunder.leizhen@huawei.com> <Yyss3SWM0nTVnjT7@alley>
 <3c86335e-c5b8-b291-d0c2-9b69f912f900@huawei.com> <YywIcQzaGmV43zr6@alley>
 <5508d96b-1651-5192-4e46-9dd145abe3fb@huawei.com>
Message-ID: <3b32322b-7d99-4416-e77b-ed3917841e06@huawei.com>
Date:   Fri, 30 Sep 2022 19:37:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5508d96b-1651-5192-4e46-9dd145abe3fb@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/28 9:35, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/9/22 15:02, Petr Mladek wrote:
>> On Thu 2022-09-22 10:15:22, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2022/9/21 23:25, Petr Mladek wrote:
>>>> On Tue 2022-09-20 15:13:13, Zhen Lei wrote:
>>>>> Currently, to search for a symbol, we need to expand the symbols in
>>>>> 'kallsyms_names' one by one, and then use the expanded string for
>>>>> comparison. This process can be optimized.
>>>>>
>>>>> And now scripts/kallsyms no longer compresses the symbol types, each
>>>>> symbol type always occupies one byte. So we can first compress the
>>>>> searched symbol and then make a quick comparison based on the compressed
>>>>> length and content. In this way, for entries with mismatched lengths,
>>>>> there is no need to expand and compare strings. And for those matching
>>>>> lengths, there's no need to expand the symbol. This saves a lot of time.
>>>>> According to my test results, the average performance of
>>>>> kallsyms_lookup_name() can be improved by 20 to 30 times.
>>>>>
>>>>> The pseudo code of the test case is as follows:
>>>>> static int stat_find_name(...)
>>>>> {
>>>>> 	start = sched_clock();
>>>>> 	(void)kallsyms_lookup_name(name);
>>>>> 	end = sched_clock();
>>>>> 	//Update min, max, cnt, sum
>>>>> }
>>>>>
>>>>> /*
>>>>>  * Traverse all symbols in sequence and collect statistics on the time
>>>>>  * taken by kallsyms_lookup_name() to lookup each symbol.
>>>>>  */
>>>>> kallsyms_on_each_symbol(stat_find_name, NULL);
>>>>>
>>>>> The test results are as follows (twice):
>>>>> After : min=5250, max=  726560, avg= 302132
>>>>> After : min=5320, max=  726850, avg= 301978
>>>>> Before: min=170,  max=15949190, avg=7553906
>>>>> Before: min=160,  max=15877280, avg=7517784
>>>>>
>>>>> The average time consumed is only 4.01% and the maximum time consumed is
>>>>> only 4.57% of the time consumed before optimization.
>>>>>
>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> ---
>>>>>  kernel/kallsyms.c | 79 +++++++++++++++++++++++++++++++++++++++++++++--
>>>>>  1 file changed, 76 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>>>>> index 3e7e2c2ad2f75ef..2d76196cfe89f34 100644
>>>>> --- a/kernel/kallsyms.c
>>>>> +++ b/kernel/kallsyms.c
>>>>> @@ -87,6 +87,71 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
>>>>> +{
>>>>> +	int i, j, k, n;
>>>>> +	int len, token_len;
>>>>> +	const char *token;
>>>>> +	unsigned char token_idx[KSYM_NAME_LEN];
>>>>> +	unsigned char token_bak[KSYM_NAME_LEN];
>>>>
>>>> Why do we need two buffers? It should be possible to compress the name
>>>> in the same buffer as it is done in compress_symbols() in scripts/callsyms.c.
>>>
>>> Because the performance would be a little better. Now this function takes
>>> just over a microsecond. Currently, it takes about 250 microseconds on
>>> average to lookup a symbol, so adding a little more time to this function
>>> doesn't affect the overall picture. I'll modify and test it as you suggest
>>> below.
>>
>> We need to be careful about a stack overflow. I have seen that
>> KSYM_NAME_LEN might need to be increased to 512 because of
>> Rust support, see
>> https://lore.kernel.org/r/20220805154231.31257-6-ojeda@kernel.org
>>
>>>>> @@ -192,20 +257,28 @@ unsigned long kallsyms_lookup_name(const char *name)
>>>>>  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
>>>>>  		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
>>>>>  
>>>>> -		if (strcmp(namebuf, name) == 0)
>>>>> -			return kallsyms_sym_address(i);
>>>>> -
>>>>>  		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
>>>>>  			return kallsyms_sym_address(i);
>>>>
>>>> Hmm, it means that the speedup is not usable when kernel is compiled LLVM?
>>>> It might actually slow down the search because we would need to use
>>>> both fast and slow search?
>>>
>>> Theoretically, I don't think so. A string comparison was removed from the
>>> slow search. "if (name_len != len)" is faster than
>>> "if (strcmp(namebuf, name) == 0)". Even if they're equal,
>>> kallsyms_compress_symbol_name() only takes 1-2us, it doesn't affect the
>>> overall picture. The average lookup time before optimization is
>>> millisecond-level.
>>>
>>> Before: min=170,  max=15949190, avg=7553906
>>
>> Good point! I agree that the potential extra overhead is negligible
>> when using the old code as a fallback.
> 
> These days sleep better. When I got up this morning, my subconscious told me that
> compiled LLVM could also be optimized. In fact, the method is simple, that is,
> check whether the next token starts with '.' or '$' after being expanded.
> 
> I will post v7 before the holidays.

Sorry, I'm going to break my promise. A lot of code needs to be modified on
the tool side, to make sure that the first '.' or '$' will not be in the middle
or end of the expanded substring. The lab is powered off, so I can only post v7
after the holidays (one week).

> 
>>
>> Best Regards,
>> Petr
>> .
>>
> 

-- 
Regards,
  Zhen Lei

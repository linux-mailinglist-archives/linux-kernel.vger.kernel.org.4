Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08331627C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiKNLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiKNLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:30:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579E1F9E6;
        Mon, 14 Nov 2022 03:30:19 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9n7q4jPzzqSRM;
        Mon, 14 Nov 2022 19:26:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:30:17 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:30:16 +0800
Subject: Re: [PATCH v8 7/9] livepatch: Improve the search performance of
 module_kallsyms_on_each_symbol()
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221102084921.1615-1-thunder.leizhen@huawei.com>
 <20221102084921.1615-8-thunder.leizhen@huawei.com> <Y3HyrIwlZPYM8zYd@krava>
 <050b7513-4a20-75c7-0574-185004770329@huawei.com> <Y3IJ5GjrXBYDbfnA@krava>
 <ad637488-930e-33c1-558c-fc03d848afa8@huawei.com> <Y3IY6gzDtk1ze3u7@krava>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <955eebae-0b36-d13f-0199-2f1b32af7da6@huawei.com>
Date:   Mon, 14 Nov 2022 19:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3IY6gzDtk1ze3u7@krava>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 18:31, Jiri Olsa wrote:
> On Mon, Nov 14, 2022 at 06:00:38PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/11/14 17:27, Jiri Olsa wrote:
>>> On Mon, Nov 14, 2022 at 04:50:25PM +0800, Leizhen (ThunderTown) wrote:
>>>>
>>>> On 2022/11/14 15:47, Jiri Olsa wrote:
>>>>> On Wed, Nov 02, 2022 at 04:49:19PM +0800, Zhen Lei wrote:
>>>>>> Currently we traverse all symbols of all modules to find the specified
>>>>>> function for the specified module. But in reality, we just need to find
>>>>>> the given module and then traverse all the symbols in it.
>>>>> hi,
>>>>> sorry for delayed answer, I did not notice this until Stephen's email
>>>>> about merge issue with recent bpf change [1]
>>>>>
>>>>>> Let's add a new parameter 'const char *modname' to function
>>>>>> module_kallsyms_on_each_symbol(), then we can compare the module names
>>>>> we have use case for iterating all modules and their symbols when we
>>>>> want to resolve passed addresses for tracing
>>>>>
>>>>> we don't have 'modname' that we could pass, we need to iterate all modules
>>>>>
>>>>> so perhaps this could be made optional like with passing NULL for modname?
>>>> The deletion of modname was suggested by Petr Mladek. The reason is that
>>>> everyone passes modname as NULL, there was no actual demand at the time.
>>>> https://lkml.org/lkml/2022/9/20/682
>>>>
>>>>>> directly in this function and call hook 'fn' after matching. And the
>>>>>> parameter 'struct module *' in the hook 'fn' can also be deleted.
>>>>> we need 'struct module *' argument in the callback as well because we are
>>>>> taking the module reference if we trace function in it, so it wont get
>>>>> unloaded
>>>>>
>>>>> please let me know if I should do the change or can help in any way
>>>> It seems that we should take the module reference before invoking callback
>>>> and put it after it is called, without passing modname.
>>> we take the module ref only if we (callback) find the traced address in
>>> the module, we don't have the module object before
>>>
>>> jirka
>>>
>>
>> Do it in function module_kallsyms_on_each_symbol()?
>>
>> But I just saw that mutex_lock(&module_mutex) protection is already
>> provided in this function. So reference counting protection may not
>> be required.
> 
> we take the module ref so it won't unload even outside of the
> module_kallsyms_on_each_symbol function

There's another way to do it, but it's more time consuming.

struct module *__module_text_address(unsigned long addr);
struct module *__module_address(unsigned long addr);

Which way do you think is more appropriate?


> 
> jirka
> .
> 

-- 
Regards,
  Zhen Lei

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A26A47B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjB0RRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjB0RRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:17:38 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ADF233C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:17:32 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pWh7n-0005Ah-59; Mon, 27 Feb 2023 18:17:19 +0100
Message-ID: <5a05e758-3c26-875a-af3a-6d7c8ddde653@leemhuis.info>
Date:   Mon, 27 Feb 2023 18:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
Content-Language: en-US, de-DE
To:     Ard Biesheuvel <ardb@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
 <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
 <20230131150644.GA2605@willie-the-truck>
 <20230131150750.GB2605@willie-the-truck>
 <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
 <20230207112940.GA12147@willie-the-truck>
 <8c287b1d-476c-7b00-27f6-76c3a1a5fd46@leemhuis.info>
 <CAMj1kXGWEaQXoKj=DzG9XpVGi4t5zfE-RSG0BodVL-b47nsj-A@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAMj1kXGWEaQXoKj=DzG9XpVGi4t5zfE-RSG0BodVL-b47nsj-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677518252;838407aa;
X-HE-SMSGID: 1pWh7n-0005Ah-59
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.02.23 17:14, Ard Biesheuvel wrote:
> On Mon, 27 Feb 2023 at 16:08, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> On 07.02.23 12:29, Will Deacon wrote:
>>> On Tue, Jan 31, 2023 at 05:03:32PM +0100, Ard Biesheuvel wrote:
>>>> On Tue, 31 Jan 2023 at 16:07, Will Deacon <will@kernel.org> wrote:
>>>>> On Tue, Jan 31, 2023 at 03:06:44PM +0000, Will Deacon wrote:
>>>>>> On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
>>>>>>> On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>>>>>>> On 2022/12/27 17:26, Liu Shixin wrote:
>>>>>>>>> After I add a 10GB pmem device, I got the following error message when
>>>>>>>>> insert module:
>>>>>>>>>
>>>>>>>>>  insmod: vmalloc error: size 16384, vm_struct allocation failed,
>>>>>>>>>  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
>>>>>>>>>
>>>>>>>>> If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
>>>>>>>>> vmalloc region entirely. Although module_alloc() can fall back to a 2GB
>>>>>>>>> window if ARM64_MODULE_PLTS is set, the module region is still easily
>>>>>>>>> exhausted because the module region is located at bottom of vmalloc region
>>>>>>>>> and the vmalloc region is allocated from bottom to top.
>>>>>>>>>
>>>>>>>>> Skip module region if not calling from module_alloc().
>>>>>>>
>>>>>>> I'll assume this is for the arm tree.
>>>>>>>
>>>>>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>>>>>
>>>>>> This looks like the same issue previously reported at:
>>>>>>
>>>>>> https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/
>>>>>>
>>>>>> where Ard had a few suggestions but, afaict, they didn't help.
>>>>>>
>>>>
>>>> Thanks for the cc.
>>>>
>>>> So this is a bit clunky, and I wonder whether we wouldn't be better
>>>> off just splitting the vmalloc region into two separate regions: one
>>>> for the kernel and modules, and one for everything else. That way, we
>>>> lose one bit of entropy in the randomized placement, but the default
>>>> 48-bit VA space is vast anway, and even on 39-bit VA configs (such as
>>>> Android), I seriously doubt that we come anywhere close to exhausting
>>>> the vmalloc space today.
>>>
>>> That sounds like a good idea to me.
>>>
>>> Liu Shixin -- do you think you could have a go at implementing Ard's
>>> suggestion instead?
>>
>> Liu Shixin, did you ever look into realizing this idea?
>>
>> Or was some progress already made and I just missed it?
> 
> This patch
> 
> https://lore.kernel.org/all/20230223204101.1500373-1-ardb@kernel.org/
> 
> should fix the issue.

Great, many thx.

>> I'm asking, as the idea discussed afaics is not only supposed to fix the
>> regression you tried to address, but also one that is now three months
>> old and stalled since Mid-December -- which is really unfortunate, as
>> that's not how regressions should be handled. :-/
> 
> Is it documented anywhere how regressions should be handled?

https://docs.kernel.org/process/handling-regressions.html

Side note: that also mentions use of the "Link" tag. If the patch had
one, I'd noticed it and wouldn't bothered anyone here.

> The
> mailing list is flooded with hard to reproduce reports from users as
> well as automatic fuzzers and build bots, so I don't think it is
> entirely unreasonable to move unresponsive reporters to the back of
> the queue.

I do that sometimes, but fwiw, from what I can see it wasn't a reporter
that was unresponsive:

https://lore.kernel.org/linux-arm-kernel/c1ff5cae-7f56-7fdb-c832-ffbcc177535b@leemhuis.info/

But I might be missing something, sorry if I do. And there was the
festive season what complicated everything. Whatever, as long as this
this is fixed.

/me wonders if we should ask "chenxiang (M)" to test that patch, too;
but /me is not even totally sure it's the same problem

>> But well, it afaik was
>> caused by a patch from Ard, so it's obviously not your job to address
>> it. But it seems you were working on it.
> 
> We are all working together here, so please refrain from telling
> people what they should or should not be working on. (I am aware that
> you probably did not mean it that way, but things tend to get lost in
> translation very easily on the mailing list)

Maybe I found the wrong words, sorry.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

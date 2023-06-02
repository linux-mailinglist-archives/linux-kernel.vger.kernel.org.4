Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8A171FE71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjFBJ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjFBJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:59:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F06E7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:59:47 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QXddy6BKHzqTDv;
        Fri,  2 Jun 2023 17:55:02 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 17:59:44 +0800
Message-ID: <e9a70063-9c33-87b5-c0ae-fa60727b3964@huawei.com>
Date:   Fri, 2 Jun 2023 17:59:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] ARM: mm: Refactor __do_page_fault()
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
 <20210529034138.83384-2-wangkefeng.wang@huawei.com>
 <20210601143125.GB30436@shell.armlinux.org.uk>
 <CAMj1kXF9crOKFaGfzcj9T4n58XAr7n85YZO0x7J1DcRG2JrfcQ@mail.gmail.com>
 <CAMj1kXHXB4a6ug0kUSJpNrtpgQ_p1w52P=5JZthZGiuPCCqM0w@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXHXB4a6ug0kUSJpNrtpgQ_p1w52P=5JZthZGiuPCCqM0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/6/2 17:51, Ard Biesheuvel wrote:
> On Fri, 2 Jun 2023 at 11:49, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Tue, 1 Jun 2021 at 16:32, Russell King (Oracle)
>> <linux@armlinux.org.uk> wrote:
>>>
>>> On Sat, May 29, 2021 at 11:41:37AM +0800, Kefeng Wang wrote:
>>>> 1. cleanup access_error(), make vma flags set and check into
>>>>     __do_page_fault() and do_page_fault() directly.
>>>>
>>>> 2. drop fsr and task argument, instead, using vm_flags in
>>>>     __do_page_fault().
>>>>
>>>> 3. cleans up the multiple goto statements in __do_page_fault().
>>>>
>>>> 4. use current->mm directly in do_page_fault().
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>
>>> This patch is a really good example of something that is very difficult
>>> to review and see that there are no unintended changes.
>>>
>>> Many people have complained about my patches, where I create a series of
>>> many patches where each patch does exactly _one_ simple transformation to
>>> the code. This is a good example _why_ I do that - a step by step single
>>> transformation approach is way easier to review.
>>>
>>> Sorry, but I'm not able to sensibly review this patch, and therefore
>>> I won't apply it. Please split it into smaller changes.
>>>
>>
>> Agreed. If your commit message contains an enumeration of things the
>> patch does, it is a very strong hint that each of those things needs
>> to be a separate patch if at all possible.

Yes, already split it and the new version is merged,
> 
> Also, apologies for digging up this 2 year old thread :-) I did so
> unintentionally.

Never mind, thank for all kind of reviews :)
> 
> (Somehow, it turned up as new/unread in my LAKML folder)



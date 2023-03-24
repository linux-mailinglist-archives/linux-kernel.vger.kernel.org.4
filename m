Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8B6C7C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCXKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:09:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31606132E2;
        Fri, 24 Mar 2023 03:09:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.153])
        by gateway (Coremail) with SMTP id _____8BxONnqdh1krbAQAA--.25214S3;
        Fri, 24 Mar 2023 18:09:46 +0800 (CST)
Received: from [10.20.42.153] (unknown [10.20.42.153])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeXndh1kyR0LAA--.40938S3;
        Fri, 24 Mar 2023 18:09:44 +0800 (CST)
Subject: Re: [regression] Bug 217069 - Wake on Lan is broken on r8169 since
 6.2
To:     Huacai Chen <chenhuacai@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
 <3089214d-292b-885d-9bc1-c81d0101d5f0@leemhuis.info>
 <CAAhV-H5j29CnCN+F8Oz0qh1UCqp+CmL=aQXCSjqgX8CZ5sXTtg@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <b39064e3-4f8b-f607-b270-1e0c8539d391@loongson.cn>
Date:   Fri, 24 Mar 2023 18:09:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5j29CnCN+F8Oz0qh1UCqp+CmL=aQXCSjqgX8CZ5sXTtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxAeXndh1kyR0LAA--.40938S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFy5uw1xKr4fGF15Zr1fWFg_yoW5XF4kpF
        WYqFs8Kr4Dtr1UAws2y3W0gr4jvrs5try5ur9xWr48X3s0vFy3Xrn7KrW5uFy3Wr97Ga12
        gF1jvwna9ry5JaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jbDGOUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please try the following patch:

https://github.com/acpica/acpica/pull/784/commits/0e66e6aae972dac3833bdcbd223aa6a8b1733176


On 2023/3/24 下午5:50, Huacai Chen wrote:
> Hi, Thorsten,
> 
> I'm sorry I ignored this email, and Jianmin, could you please
> investigate this problem? Thank you.
> 
> Huacai
> 
> On Fri, Mar 24, 2023 at 5:46 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>>
>>> On 22.02.23 08:57, Thorsten Leemhuis wrote:
>>>>
>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>> kernel developer don't keep an eye on it, I decided to forward it by
>>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :
>>>
>>> An issue that looked like a network bug was now bisected and it turns
>>> out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
>>> event") which Huacai Chen provided. Could you take a look at the ticket
>>> linked above?
>>
>> Huacai Chen, did you look into this? Would be good to have this
>> regression fixed rather sooner than later, as it seems to annoy quite a
>> few people.
>>
>> Should we maybe simply revert the problematic change for now and reapply
>> it later once the root-issue was found and fixed?
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>
>>> FWIW, the whole story started like this:
>>>
>>>>> Ivan Ivanich 2023-02-22 00:51:52 UTC
>>>>>
>>>>> After upgrade to 6.2 having issues with wake on lan on 2 systems: -
>>>>> first is an old lenovo laptop from 2012(Ivy Bridge) with realtek
>>>>> network adapter - second is a PC(Haswell refresh) with PCIE realtek
>>>>> network adapter
>>>>>
>>>>> Both uses r8169 driver for network.
>>>>>
>>>>> On laptop it's not possible to wake on lan after poweroff On PC it's
>>>>> not possible to wake on lan up after hibernate but works after
>>>>> poweroff
>>>>>
>>>>> In both cases downgrade to 6.1.x kernel fixes the issue.
>>>
>>> Meanwhile a few others that ran into the same problem with NICs from
>>> different vendors joined the ticket
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.


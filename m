Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDB62535F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiKKGIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKKGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:08:18 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C7F5F84E;
        Thu, 10 Nov 2022 22:08:16 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxjrfO5m1jpwYGAA--.13978S3;
        Fri, 11 Nov 2022 14:08:14 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx5VbL5m1j27EQAA--.27161S2;
        Fri, 11 Nov 2022 14:08:12 +0800 (CST)
Subject: Re: [PATCH v6 1/2] soc: loongson: add GUTS driver for loongson-2
 platforms
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
References: <20221104024835.3570-1-zhuyinbo@loongson.cn>
 <57c9f565-e75b-0c8f-fdce-9dc8c334d50f@loongson.cn>
 <CACRpkda=-_a+gWQVk1vi4QJ30j-hzeraX-wr86RcQ9xne4-d6Q@mail.gmail.com>
 <574d58b2-0e9a-4fa0-84a8-caf39a9bc37a@app.fastmail.com>
 <CAAhV-H64s-2gNMd0-F21kUzieh5G-MbBnA0k6J8EP2_7SpevaA@mail.gmail.com>
 <0b2ca852-61b2-4e88-b389-f102994d5b2d@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <b9ec5b1c-053d-a2a7-81ab-bc8066eb9159@loongson.cn>
Date:   Fri, 11 Nov 2022 14:08:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0b2ca852-61b2-4e88-b389-f102994d5b2d@app.fastmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5VbL5m1j27EQAA--.27161S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw1fAF17KFykGr1DuryrXrb_yoW5AF1fpF
        WrtFnxCF4kGF43Ar1Iyw1Uuayrtw4ayr9IgF9Yg34kZF95ZFyIyFy0vFyruF4DXF1fKr4j
        vF18A348u3WkZF7anT9S1TB71UUUUbDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jsWrXUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/11/9 ÏÂÎç11:08, Arnd Bergmann Ð´µÀ:
> On Wed, Nov 9, 2022, at 14:50, Huacai Chen wrote:
>> On Wed, Nov 9, 2022 at 7:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Nov 9, 2022, at 11:15, Linus Walleij wrote:
>>>> On Wed, Nov 9, 2022 at 11:03 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>>>
>>>>> Hi maintainer,
>>>>>
>>>>> This patch I had verified that base on mainline 6.1-rc3 tree, it is
>>>>> okay, if no other issue, please you help me merge it to upstream.
>>>>
>>>> Aren't these loongarch maintainers listed in MAINTAINERS able to
>>>> merge this? Certainly Huacai can merge stuff to drivers/soc as
>>>> need be. drivers/soc is a bit shared between different archs.
>>>
>>> I'm generally happy to keep an eye on stuff in drivers/soc/ across
>>> architectures and merge it through the soc tree, especially for
>>> new platforms, but merging this through the loongarch tree works
>>> as well.
>> So drivers/soc is similar to drivers/platform that can be merged
>> through corresponding architecture trees?
> 
> Right, I think in both cases, there is no top-level subsystem
> maintainer, but the rules are specific to the second-level
> hierarchy: most parts of drivers/platform/ happen to go
> through the x86 platform maintainer trees, and for drivers/soc
> we merge most stuff through the soc tree, but a few parts
> of each have different maintainers.
> 
>>> Since the driver was already sent to soc@kernel.org, I can
>>> simply pick it up through patchwork[1] when I do my next round
>>> of merges. I'll leave this up to Huacai Chen and WANG Xuerui,
>>> let me know if you prefer to merge it through the loongarch
>>> tree.
>> I'm happy that this series be merged through your linux-arch tree, but
>> if it is better (I'm not sure which is better) to go through loongarch
>> tree I can also merge it later. However, I have some comments about
>> this version. :)
> 
> I would prefer the soc tree, and will just apply the
> patches from Yinbo Zhu directly this time as I already
> have them in my queue. If there are more than a few
> drivers/soc/loongarch/ patches in the future, maybe you can
> pick them up into a separate branch and forward those
> to soc@kernel.org.
> 
> Note that I have two separate roles here: I have the
> asm-generic tree that I maintain for patches to
> include/asm-generic as well as the occasional new
> architecture review as I did for loongarch.
> 
> The other one is the group maintained soc tree that
> is mainly for Arm device tree files, but also contains
> soc specific code (arch/arm/mach-*), defconfig files,
> drivers (drivers/{soc,firmware,memory,reset}). This is
> now extended to arch/riscv and occasionally other
> architectures as well, so drivers/soc/loongson fits
> well in here.
> 
>       Arnd
Hi Arnd Bergmann,

I had add v7 version patch and please help check and merge it.
in addition, I don't find apprioate branch in your tree for test, so
my patch was tested that base on 6.1-rc3 master branch.

BRs,
YinBo.
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE48611F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ2C04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2C0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:26:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06BE11D29BE;
        Fri, 28 Oct 2022 19:26:50 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxzNhpj1xjNTYDAA--.12170S3;
        Sat, 29 Oct 2022 10:26:49 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqFdoj1xjV6QGAA--.4731S2;
        Sat, 29 Oct 2022 10:26:49 +0800 (CST)
Subject: Re: [PATCH v4 1/2] clocksource: loongson2_hpet: add hpet driver
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20221026035752.32681-1-zhuyinbo@loongson.cn>
 <438f5df4-b076-4920-7bb3-095041c27eef@linaro.org>
 <9b4c904a-9277-504e-3bec-0b11331bbea4@loongson.cn>
 <a79acba3-19ff-6da4-4bbe-d5c5e455594a@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <a196f518-84d3-184e-a6f8-d59062cb5c1d@loongson.cn>
Date:   Sat, 29 Oct 2022 10:26:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a79acba3-19ff-6da4-4bbe-d5c5e455594a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqFdoj1xjV6QGAA--.4731S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtF4fArW7ZrWxKF4ftw4UCFg_yoWfuFb_GF
        1UAwn2kw45Gr9Yqr4qk34kA393tayUGry5J398tr47Ww1qyFy5ur1DZFyfAw1rGFnrGF13
        WrZYvr1S9r1q9jkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        j7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2
        IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84AC
        jcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8I
        j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r
        1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jetC7UUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/28 下午7:33, Krzysztof Kozlowski 写道:
> On 27/10/2022 23:54, Yinbo Zhu wrote:
>>
>>
>> 在 2022/10/26 下午10:20, Krzysztof Kozlowski 写道:
>>> On 25/10/2022 23:57, Yinbo Zhu wrote:
>>>> HPET (High Precision Event Timer) defines a new set of timers, which
>>>> are used by the operating system to schedule threads, interrupt the
>>>> kernel and interrupt the multimedia timer server. The operating
>>>> system can assign different timers to different applications. By
>>>> configuration, each timer can generate interrupt independently.
>>>>
>>>> The loongson2 HPET module includes a main count and three comparators
>>>> , all of which are 32 bits wide. Among the three comparators, only
>>>
>>> No blank line before coma.
>> You said that need blank line is need a blank space before comma?
> 
> No, I did not say that.
> 
Your meaning is no new lines before commas ?
I will do it.
> Best regards,
> Krzysztof
> 


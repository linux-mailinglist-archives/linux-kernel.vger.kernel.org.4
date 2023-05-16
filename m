Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD51E70426D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbjEPAuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPAuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:50:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D052330FA;
        Mon, 15 May 2023 17:50:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxJulm02JkyPoIAA--.15418S3;
        Tue, 16 May 2023 08:50:46 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxddFl02JkZfVhAA--.37515S3;
        Tue, 16 May 2023 08:50:45 +0800 (CST)
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn> <ZFkPZhF8QqScXAmH@surfacebook>
 <049c871d-c658-24c1-91e6-701098f5fc28@loongson.cn>
 <16913b76-0256-492a-ec90-d367f2b52cc3@loongson.cn>
 <ZGH4SPsu40Mt-Z8f@surfacebook>
 <109a8453-2172-a2ee-8672-8efb489e3dd9@loongson.cn>
 <CAHp75VemyP8-yBS494zQLiQqnH+SPPjxVsrn1J-Rbj9=SqRm1g@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <c2fab3d8-4026-45f4-5c90-f85d2b39b6c3@loongson.cn>
Date:   Tue, 16 May 2023 08:50:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VemyP8-yBS494zQLiQqnH+SPPjxVsrn1J-Rbj9=SqRm1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxddFl02JkZfVhAA--.37515S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZrW7Zr17tw4fZw45uryxuFg_yoWDCrX_Zr
        4akF1xCrWUJ3ykGr1kZws3GFWDua1UJ390qF4vqr45Z3srGF48GF1Du3Zag3Z8Ka45XFnx
        Cr45WF4jkr1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        w7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2
        IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84AC
        jcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF
        6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14
        v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY
        64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
        Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UC_M3UUUUU=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/15 下午9:54, Andy Shevchenko 写道:
> On Mon, May 15, 2023 at 3:01 PM zhuyinbo <zhuyinbo@loongson.cn> wrote:
>> 在 2023/5/15 下午5:15, andy.shevchenko@gmail.com 写道:
>>> Mon, May 15, 2023 at 04:14:00PM +0800, zhuyinbo kirjoitti:
>>>> 在 2023/5/11 下午3:18, zhuyinbo 写道:
>>>>> 在 2023/5/8 下午11:04, andy.shevchenko@gmail.com 写道:
> 
> ...
> 
>>>>>>> +config SPI_LOONGSON_CORE
>>>>>>> +    tristate "Loongson SPI Controller Core Driver Support"
>>>>>>
>>>>>> Does it need to be visible to the user?
>>>>
>>>> I try to set it invisible that by removing the SPI_LOONGSON_CORE Kconfig
>>>> or removing "tristate "Loongson SPI Controller Core Driver Support" that
>>>> will cause spi-core driver doesn't be compiled or compiled fail issue,
>>>> so I will still set it visible to the user.
>>>
>>> Making a symbol selectable only can be achieved by removing the description
>>> (near to tristate directive), have you tried that?
>>
>> Is it like this ?
> 
> Yes.


okay, I got it.

Thanks.
> 


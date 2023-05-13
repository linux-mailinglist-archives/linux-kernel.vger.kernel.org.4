Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858EE701496
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjEMGQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 02:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 02:16:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2A6B1BD3;
        Fri, 12 May 2023 23:16:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxyOkoK19khmkIAA--.14525S3;
        Sat, 13 May 2023 14:16:08 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxi7YnK19kOG1ZAA--.26362S3;
        Sat, 13 May 2023 14:16:07 +0800 (CST)
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
 <ZFnOZptCM7JDFTQz@finisterre.sirena.org.uk>
 <CAHp75VcqQR0fFdkWG2QgXG0+SnKDs6_Zze6GMt+pHHEdE+8hkg@mail.gmail.com>
 <f03977b9-884c-93a1-d1cf-81e6fcf51dfc@loongson.cn>
 <CAHp75VeUiR_V0P6QhhqKGcoJKHviCC8wJZf+3KVBtWj+4q-=ig@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <c965a906-952c-2592-dad6-9d4eb3dffa66@loongson.cn>
Date:   Sat, 13 May 2023 14:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeUiR_V0P6QhhqKGcoJKHviCC8wJZf+3KVBtWj+4q-=ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxi7YnK19kOG1ZAA--.26362S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUv01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4
        v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY
        67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2js
        IE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1VW
        lDUUUUU==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/12 下午5:40, Andy Shevchenko 写道:
> On Fri, May 12, 2023 at 11:12 AM zhuyinbo <zhuyinbo@loongson.cn> wrote:
>> 在 2023/5/10 下午3:03, Andy Shevchenko 写道:
> 
> ...
> 
>> so, I think it is better
>> to confiure clk and mode separately.
> 
> Agree, but at the same time you can split the conditional bodies to
> the separate functions. In this case the indentation of each of them
> can be decreased.


okay, I got it.

Thanks.
> 


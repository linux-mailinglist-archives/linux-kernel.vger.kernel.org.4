Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4494608373
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJVBza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJVBzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:55:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0ADB03E0;
        Fri, 21 Oct 2022 18:55:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Cxbbd9TVNjdJEBAA--.1931S3;
        Sat, 22 Oct 2022 09:55:09 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuB8TVNj9SYDAA--.12586S2;
        Sat, 22 Oct 2022 09:55:09 +0800 (CST)
Subject: Re: [PATCH v1 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        zhuyinbo@loongson.cn, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221021012728.22373-1-zhuyinbo@loongson.cn>
 <CACRpkdbBW1YNGfec2jEPsUGwqosc8TwwSP9ft+he5KWPf0otvw@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <ad677eaa-60e1-c72c-a4e3-f28c92e12942@loongson.cn>
Date:   Sat, 22 Oct 2022 09:55:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbBW1YNGfec2jEPsUGwqosc8TwwSP9ft+he5KWPf0otvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuB8TVNj9SYDAA--.12586S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF4DCr1fZryfXFW3ZrW3GFg_yoW8WF18pF
        W3Cwn8KFWkGr4Ivw45JrZYqFWkCr97X3ZrCFsIk3s7WF9xX3Z3Gw4fKFn8C3ykuFy8J3ZF
        vFW5A3sruF1DK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b4kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc80
        4VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
        AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
        cVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x8Erc
        xFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/21 下午5:45, Linus Walleij 写道:
> Hi Yinbo,
> 
> thanks for your patch!
> 
> On Fri, Oct 21, 2022 at 3:27 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>> The loongson2 SoC has a few pins that can be used as GPIOs or take
>> multiple other functions. Add a driver for the pinmuxing.
>>
>> There is currently no support for GPIO pin pull-up and pull-down.
>>
>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> (...)
> 
>> +static int loongson2_pmx_set_mux(struct pinctrl_dev *pcdev, unsigned int func_num,
>> +                             unsigned int group_num)
>> +{
>> +       struct loongson2_pinctrl *pctrl = pinctrl_dev_get_drvdata(pcdev);
>> +       unsigned long reg = (unsigned long)pctrl->reg_base +
>> +                               loongson2_pmx_groups[group_num].reg;
>> +       unsigned int mux_bit = loongson2_pmx_groups[group_num].bit;
>> +       unsigned int val;
>> +       unsigned long flags;
>> +
>> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>> +       val = readl((void *)reg);
>> +       if (func_num == 0)
>> +               val &= ~(1<<mux_bit);
>> +       else
>> +               val |= (1<<mux_bit);
>> +       writel(val, (void *)reg);
>> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> 
> Can you explain in the commit message or with a comment in the code
> why you have to use a raw spinlock for this?
> 
> We usually only use raw spinlocks for things like low level
> interrupt handlers...
> 
> My guess is that you can replace this with an ordinary spinlock.
I was refer other platform, eg. pinctrl-amd.c, if the ordinary spinlock 
was more appropriate I will use the ordinary spinlock.

TKs
Yinbo.
> 
> Yours,
> Linus Walleij
> 


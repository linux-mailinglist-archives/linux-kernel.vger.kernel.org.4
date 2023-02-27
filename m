Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067DB6A3641
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0ByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0ByM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:54:12 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F37BE3A7;
        Sun, 26 Feb 2023 17:54:11 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJPRCDfxjJ+oFAA--.5421S3;
        Mon, 27 Feb 2023 09:54:10 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC74+Dfxjqho+AA--.45347S3;
        Mon, 27 Feb 2023 09:54:06 +0800 (CST)
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver
 support
To:     Stephen Boyd <sboyd@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, liupeibao@loongson.cn,
        loongarch@lists.linux.dev, wanghongliang@loongson.cn
References: <20221129034157.15036-1-zhuyinbo@loongson.cn>
 <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org>
 <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn>
 <8332a1cf44b01f06bdd5db9dc5d7f387.sboyd@kernel.org>
 <01ee3dc6-a868-fd2b-93aa-11e6bdfcc9df@loongson.cn>
 <9e8952c9415973dc7276185e3cdf5ae7.sboyd@kernel.org>
 <d92223a0-6d4c-33ea-1473-3d40bdd0ad9e@loongson.cn>
 <834da7dc-bb5d-3427-43e5-938e40a2d180@loongson.cn>
 <6c497d2d70d215a86be178fc08546f4d.sboyd@kernel.org>
 <d2519ebc-8f71-1cf0-9ec8-a65a7f094853@loongson.cn>
 <19ce51bd94685e2bed6cbc20467e5705.sboyd@kernel.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9c31d4a5-15ca-99fa-73c7-d764221f369d@loongson.cn>
Date:   Mon, 27 Feb 2023 09:54:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <19ce51bd94685e2bed6cbc20467e5705.sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxC74+Dfxjqho+AA--.45347S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr4rGr43ArykCFyxAF4UXFb_yoW8XFyUpr
        W8Cay2yF4Dtr4jvws293ZxZa4jyw1xJF1j9r1rJw1Dua4qkryxAr4DuF15uFZrJrsxGw40
        qr40k3y7uFyjvrJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI
        0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCj
        c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8FAp5UUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/25 上午3:10, Stephen Boyd 写道:
> Quoting zhuyinbo (2023-02-22 18:16:49)
>> 在 2023/2/23 上午5:00, Stephen Boyd 写道:
>>> Quoting zhuyinbo (2023-02-21 21:10:14)
>>>>>>> yes, the use of dts doesn't require the use of CLK_OF_DECLARE and can
>>>>>>> use platform_driver_register
>>>>>>>
>>>>>>> but my drvier not use platform_driver_register to register clk and use
>>>>>>> CLK_OF_DECLARE to match of_clk_init.
>>>>>> of_clk_init() is there to register clks that are needed for early init,
>>>>>> i.e. the clockevent/clocksource or the root interrupt controller
>>>>>> (irqchip). Otherwise, it isn't necessary to register clks via
>>>>>> of_clk_init().
>>>>> okay, I got it.
>>>> and,  the time driver  get clock by CCF that ask loongson2 clock driver
>>>> use CLK_OF_DECLARE
>>>>
>>>> to match of_clk_init.   because  the timer_probe  is very early and the
>>>> timer driver was use TIMER_OF_DECLARE
>>>>
>>>> to match time_probe.
>>>>
>>> If you have a time driver that gets clks, register those early with
>>> CLK_OF_DECLARE_DRIVER() and then have a platform driver for the rest of
>>> the clk tree that registers clks later.
>> okay, I got it.  and this series patch I will use platform driver.
>> later, if the loongson2 time driver use the
>>
>> CLK_OF_DECLARE style I will make a alone time clk driver for it that
>> use  CLK_OF_DECLARE_DRIVER()
>>
> It can be the same file if you want. But then it can't be a module. Up
> to you what you want to do there.
okay, I got it.


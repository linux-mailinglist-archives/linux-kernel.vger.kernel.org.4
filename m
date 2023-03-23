Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF96C5BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCWBYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:24:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 041662F06E;
        Wed, 22 Mar 2023 18:24:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxPNpRqhtk5CcQAA--.12948S3;
        Thu, 23 Mar 2023 09:24:33 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeVOqhtkoQcKAA--.39350S3;
        Thu, 23 Mar 2023 09:24:33 +0800 (CST)
Subject: Re: [PATCH v15 2/2] clk: clk-loongson2: add clock controller driver
 support
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230321130710.20236-1-zhuyinbo@loongson.cn>
 <20230321130710.20236-2-zhuyinbo@loongson.cn>
 <26c4712672de6c4f70f88c6846bc892f.sboyd@kernel.org>
 <79ceb9c5-2657-ca9b-e017-5ec14acfcda1@loongson.cn>
 <55bea6244a6d41e3d7d38d6cb6d379e9.sboyd@kernel.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <e50268ba-5b9c-9b37-5302-89482eb600b4@loongson.cn>
Date:   Thu, 23 Mar 2023 09:24:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <55bea6244a6d41e3d7d38d6cb6d379e9.sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxAeVOqhtkoQcKAA--.39350S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWrKF4kKw4rZr15WF43CFy8Krg_yoW8JrWrpa
        43AFW5CF4kJFnFvr93tw4rWF1SvrWftFy3Gr12gryUu398J347WF18tFWYk3yxArs5AF10
        vayqqr4FkFn8ArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bTkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwI
        xGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
        wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07j1jgxUUUUU=
X-Spam-Status: No, score=3.6 required=5.0 tests=NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/22 下午11:16, Stephen Boyd 写道:
> Quoting zhuyinbo (2023-03-21 19:07:26)
>> 在 2023/3/22 上午7:42, Stephen Boyd 写道:
>>> Quoting Yinbo Zhu (2023-03-21 06:07:10)
>>>> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
>>>> new file mode 100644
>>>> index 000000000000..090810655511
>>>> --- /dev/null
>>>> +++ b/drivers/clk/clk-loongson2.c
>>>> @@ -0,0 +1,344 @@
> [....]
>>>> +
>>>> +static void __iomem *loongson2_pll_base;
>>> Why is this a global?
>> Normally, this should be an element in the structure, but since there is
>> only one
>>
>> element, It is directly defined as a global variable for use by other
>> function.
>>
> Ok. Globals are frowned upon but it's just a single pointers so I guess
> it's Ok.
>
>>>> +               return PTR_ERR(loongson2_pll_base);
>>>> +
>>>> +       loongson2_clocks_init(dev);
>>> Please inline this function here.
>> The loongson2_clocks_init had inline in this version, or do you mean something else ? Need to inline the probe?
> I mean get rid of the function loongson2_clocks_init() and move the code
> in that function into this probe function. With this patch the probe is
> split to two functions when it should be one function.

okay, I got it.


Thanks.


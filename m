Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EF15F829F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 05:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJHDAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 23:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJHDAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 23:00:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9933AB03;
        Fri,  7 Oct 2022 20:00:03 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTWus50BjQyEoAA--.19966S2;
        Sat, 08 Oct 2022 10:59:56 +0800 (CST)
Subject: Re: [PATCH v1 1/2] clocksource: loongson2_hpet: add hpet driver
 support
To:     WANG Xuerui <kernel@xen0n.name>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, zhuyinbo@loongson.cn
References: <20220930093510.10781-1-zhuyinbo@loongson.cn>
 <bc62d053-1e26-d7b7-3611-f0c9237d86f3@xen0n.name>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <1b1f167f-a9be-fc1c-ffe7-0fb1bdf7c429@loongson.cn>
Date:   Sat, 8 Oct 2022 10:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bc62d053-1e26-d7b7-3611-f0c9237d86f3@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTWus50BjQyEoAA--.19966S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fJw4xXrW7GFWfAw15XFb_yoW8tFy3pF
        4xG3Z8KrWDXr4fZwsxXryDCF98Cw1xJw15G3W7t3WkArykJF1jqr4jqa4Yg3W7Xr4rJ342
        vFZYqr1UuFyDAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/30 下午10:43, WANG Xuerui 写道:
> Hi,
> 
> On 9/30/22 17:35, Yinbo Zhu wrote:
>> HPET (High Precision Event Timer) defines a new set of timers, which
>> are used by the operating system to schedule threads, interrupt the
>> kernel and interrupt the multimedia timer server. The operating
>> system can assign different timers to different applications. By
>> configuration, each timer can generate interrupt independently.
>>
>> The loongson2 HPET module includes a main count and three comparators
>> , all of which are 32 bits wide. Among the three comparators, only
>> one comparator supports periodic interrupt, all three comparators
>> support non periodic interrupts.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   MAINTAINERS                          |   6 +
>>   arch/loongarch/kernel/time.c         |   3 +
>>   drivers/clocksource/Kconfig          |   9 +
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/loongson2_hpet.c | 332 +++++++++++++++++++++++++++
>>   5 files changed, 351 insertions(+)
>>   create mode 100644 drivers/clocksource/loongson2_hpet.c
> 
> Thanks for the contribution, but as HPET is a fairly common peripheral 
> that have well standardized behavior, why not simply add DT support to 
> the drivers/char/hpet.c and be done with it?
At present, the drivers/char/hpet.c doesn't support DT(dts parse) and
loongson2 soc wasn't belong to X86 or IA64 architecture, Although it is
an option to add DT support for this driver, I consider that the hpet
design of loongson2 series socs may not be universal. In addition, I
notice that mips and x86 have their own hpet drivers. In order to reduce
the impact on the public driver and make more flexible modifications to
the loongson2 hpet driver under its own architecture, a separate
loongson2 hpet driver was submitted.

config HPET
         bool "HPET - High Precision Event Timer" if (X86 || IA64)
         default n
         depends on ACPI
         help
           If you say Y here, you will have a miscdevice named 
"/dev/hpet/".  Each
           open selects one of the timers supported by the HPET.  The 
timers are
           non-periodic and/or periodic.


BRs
Yinbo Zhu.

> 


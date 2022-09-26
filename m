Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0507F5E99F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiIZG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiIZG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:57:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914E2AC6D;
        Sun, 25 Sep 2022 23:57:55 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbYRv2q4wzHqSq;
        Mon, 26 Sep 2022 14:55:39 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:57:53 +0800
Subject: Re: [PATCH -next 0/2] allow gpio simulator be used as interrupt
 controller
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220826080230.1712978-1-weiyongjun1@huawei.com>
 <CAMRc=Mc-m7JfDqM3ALy43T+S9DdpV8boEy+J6ruQZjLkqbZHPw@mail.gmail.com>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <557e3d18-057c-f787-d422-d54f6e4be36f@huawei.com>
Date:   Mon, 26 Sep 2022 14:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mc-m7JfDqM3ALy43T+S9DdpV8boEy+J6ruQZjLkqbZHPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/1 0:08, Bartosz Golaszewski wrote:
> On Fri, Aug 26, 2022 at 9:44 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>>
>> This series allow gpio simulator be used as interrupt controller, the use
>> case is mockup some device which using GPIO as interrupt controller, such
>> as mcp2515 CAN device. With the dts [1], we can mockup a mcp2515 device,
>> and trigger irq by following commands:
>>
>>  $ echo pull-down > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull
>>  $ echo pull-up > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull
>>
>>
>> --[1]---------------------------------------------------------
>> /dts-v1/;
>>
>> #include <dt-bindings/interrupt-controller/irq.h>
>>
>> / {
>>         clk24m: clk24m {
>>                 compatible = "fixed-clock";
>>                 clock-output-names = "clk24m";
>>                 clock-frequency = <24000000>;
>>                 #clock-cells = <0>;
>>         };
>>
>>         gpio-sim {
>>                 compatible = "gpio-simulator";
>>
>>                 bank0: bank0 {
>>                         gpio-controller;
>>                         #gpio-cells = <2>;
>>                         ngpios = <16>;
>>
>>                         interrupt-controller;
>>                         #interrupt-cells = <2>;
>>
>>                         line_b-hog {
>>                                 gpio-hog;
>>                                 gpios = <0 1>;
>>                                 input;
>>                                 line-name = "irq-sim";
>>                         };
> 
> Why do you need this hog? The GPIO will be marked as requested once
> the interrupt is taken by the driver.

Sorry for reply later.

It seems that only if driver request gpio with fwnode_gpiod_get_index()
marks GPIO as request one.

If driver using request_threaded_irq() request one irq, the requested
status will not be marked. We need to use hog or request by userspace
to mark as requested.

> 
>>                 };
>>         };
>>
>>         spi: spi {
>>                 compatible = "spi-mockup";
>>
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>
>>                 can0: can@1 {
>>                         compatible = "microchip,mcp2515";
>>                         reg = <1>;
>>                         clocks = <&clk24m>;
>>                         interrupt-parent = <&bank0>;
>>                         interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
>>                 };
>>
>>         };
>> };
>> ------------------------------><-----------------------------
>>
>> Wei Yongjun (2):
>>   genirq/irq_sim: Allow both one and two cell bindings
>>   gpio: sim: make gpio simulator can be used as interrupt controller
>>
>>  drivers/gpio/gpio-sim.c | 2 +-
>>  kernel/irq/irq_sim.c    | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> --
>> 2.34.1
>>
> 
> Can you add some info about this to the documentation?

Will do that

Thanks,
Wei Yongjun

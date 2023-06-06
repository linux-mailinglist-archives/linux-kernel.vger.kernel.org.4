Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8A72436E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbjFFM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjFFM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:58:30 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A5D19A7;
        Tue,  6 Jun 2023 05:58:12 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 878A65FD3B;
        Tue,  6 Jun 2023 15:58:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686056289;
        bh=MsK3KfXvwDDXjdR1K4Z8iNkLw2j81KfAr/Pv963g5nQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=XNGmWbqE+gcreM/m4zW6J26BakoZSNJ1Y7UnfbIw9z7G7YKoi3DATkZhYe9+KvPhu
         2P49UFRlrhrMN3fYX07Kg/T5p0K3mKhKsP0lqRGUqyojcU5dZ09UD1PAjgVc0NXULC
         6v3OhljNuIVARIzWLw3iEWTOV/heqky8m96JjJ7qhcIHDGNqfpOU7z+iX5dONzI1Qj
         zmI7xXpn0q65u1eqAYev0GayO4N3HSDbh1B/yW1vuDMF0aF/RM5JKmNQ6ArbAU/Cu8
         zejU5845t2Wd6JOK7opluSy32o+vwyy+cVeKN/XUwki515icEi47bCOAjdLHrRmGGz
         Jy2kLeaMttHuQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 15:58:07 +0300 (MSK)
Message-ID: <02c7e2b4-9087-fc73-bd57-0d4c12bbe203@sberdevices.ru>
Date:   Tue, 6 Jun 2023 15:53:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>, Vyacheslav <adeep@lexina.in>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in>
 <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
 <6910550a-b025-0d97-0b39-bc89b235541e@sberdevices.ru>
 <CAFBinCCk6OziOxt2AY1A25C=9_pibhHsDK0wJNZ_AyHMd=z6SQ@mail.gmail.com>
 <dcb05f27-4c6d-0544-ff0d-288a6848ccaf@sberdevices.ru>
 <CAFBinCCnAVveiYEOSq=KkBq0kRJti7eWgfRxqiTkQWe9i8mTzA@mail.gmail.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <CAFBinCCnAVveiYEOSq=KkBq0kRJti7eWgfRxqiTkQWe9i8mTzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 11:10:00 #21443593
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/23 23:18, Martin Blumenstingl wrote:
> Hi George,
>
> On Thu, Jun 1, 2023 at 10:56 PM George Stark <gnstark@sberdevices.ru> wrote:
> [...]
>> Here the test I promised:
>> Question: what's the real size of clock divder field in SAR_ADC_REG3 register in saradc in meson8 socs?
>> The current kernel code says 5 bits
>> The datasheet says 6 bit
>>
>> The parent clock of adc clock is 24Mhz
>> I can check it here by:
>>
>> # cat /sys/kernel/debug/clk/clk_summary
>>    xtal                                 4        4        1    24000000          0     0  50000         Y
>>       c1108680.adc#adc_div              1        1        0      1142858         0     0  50000         Y
>>          c1108680.adc#adc_en            1        1        0      1142858         0     0  50000         Y
>>
>> for divider width 5bit min adc clock is 24Mhz / 32 =  750KHZ
>> for divider width 6bit min adc clock is 24Mhz / 64 =  375KHz
>>
>> I suppose that the lower adc clock rate the higher measurement time
>> so I need to get measurement time at both clk freqs and the times differ so
>> 6bit divider is really applied
>>
>> I performed test at Odroid-C1, kernel 6.2-rc8
>> Two kernel patches must be applied:
>>
>> the topic starter patch and the helper patch at the end of the letter
>> In the helper patch I turn on CLOCK_ALLOW_WRITE_DEBUGFS to change clock rate from she shell
>> and use ktime_get_raw_ts64 to measure measurement time
>>
>> So the the test itself:
>> cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_voltage3_raw
>> [ 1781.226309] ==== freq: 1142858 time 42408000
>>
>> # echo 750000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
>> # cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_voltage3_raw
>> [ 1790.728656] ==== freq: 750000 time 49173000
>>
>> # echo 375000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
>> # cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_voltage3_raw
>> [ 1816.955477] ==== freq: 375000 time 68245000
>>
>> # cat /sys/kernel/debug/clk/clk_summary
>>    xtal                                 4        4        1    24000000          0     0  50000         Y
>>       c1108680.adc#adc_div              1        1        0      375000          0     0  50000         Y
>>          c1108680.adc#adc_en            1        1        0      375000          0     0  50000         Y
> These results looks excellent - thanks for sharing the test results!
> Could you please check one last thing:
> $ grep -i adc /sys/kernel/debug/meson-clk-msr/measure_summary
> It should confirm that the clock rate is 375kHz (or close to it, SoC
> internal clock measurement is not 100% precise)
Hello Martin

Looks like it works as expected:
# grep -i adc /sys/kernel/debug/meson-clk-msr/measure_summary
   sar_adc                 1140625    +/-3125Hz
# echo 375000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
# grep -i adc /sys/kernel/debug/meson-clk-msr/measure_summary
  sar_adc                  371875    +/-3125Hz

So I'm re-sending the patch with fixed commit message

-- 
Best regards
George

>
> Once we have that confirmation: can you please re-send the patch with
> the description updated so it's clear which SoC generations are
> affected and by stating that the fix was tested on a Meson8b Odroid-C1
> board.
>
>
> Thank you and best regards,
> Martin


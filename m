Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372A0717E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjEaLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjEaLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:37:25 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C4E8;
        Wed, 31 May 2023 04:37:21 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0A5605FD56;
        Wed, 31 May 2023 14:37:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685533039;
        bh=sbZRDG56hPIOzkNrYqptHD1M16aZFlNz8dicpHblK9c=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=lGO/LXW0zAg/oFZRQl6qF6g1JvO/wxAO9tqaA4tCpeWiXRuRmFlZsZpErm100gOzC
         HB4DQD64WsksKD2W0V8IDBM053e1Nrkc3NADDTgboXzh77lw7wMz0ja6lP4T69F5Sd
         EYF6c7U83SW2rX60lS6mifkjOBl5IHkNxsApjySWKY4EtOJJjnvmghzQHzJ/748B5o
         4XcKfCeYYxRfnyLV8nXbavS50N0RX/sh0XP0lkT2CEr43mKnkS/xLHn806hD5Eh7My
         dEAG7MSVM8ww9VY3FauUKhJFSQSZ2ng9CxTMoWuhlZ2C0av2BNFmKxnJ6pUI3df/Da
         jwLtn/leQmmgA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 31 May 2023 14:37:16 +0300 (MSK)
Message-ID: <b5a6eaec-c0eb-cd52-0657-756d5136707c@sberdevices.ru>
Date:   Wed, 31 May 2023 14:33:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <CAFBinCCk6OziOxt2AY1A25C=9_pibhHsDK0wJNZ_AyHMd=z6SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/31 06:02:00 #21385342
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

On 5/29/23 23:41, Martin Blumenstingl wrote:
> Hi George,
>
> On Mon, May 22, 2023 at 5:47 PM Старк Георгий Николаевич
> <GNStark@sberdevices.ru> wrote:
>> Hello Martin
>>
>> Actually you were right that my patch affects only meson8 family not the all new ones, my bad.
>> It's clear from the driver code meson_saradc.c and dts files.
>> I've made an experiment on a113l soc - changingclock_rate inmeson_sar_adc_param and measuring adc channel many times
>> and with low clockfrequency (priv->adc_clk) time of measurementis high
>> and vice versa. ADC_CLK_DIV field in SAR_ADC_REG3 is always zero.
> Thanks for sharing your findings!
>
>> I need to get s805 (meson8) board for example and made experiment on it.
> If you don't find any Meson8 (S802)/Meson8b (S805) or Meson8m2 (S812)
> board then please provide the code that you used for your experiment
> as a patch so I can give it a try on my Odroid-C1 (Meson8b).

Hello Martin

Thanks for the help! I managed to get Odroid-C1 myself. I think it'll be 
useful to test further patches.
By the way seems like the board and the sock are not popular anymore...

It remains only to build mainline kernel for meson8 to perform tests. 
Hope to be back soon.

Best regards
George

>
>
> Best regards,
> Martin
>


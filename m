Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE0746B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGDINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjGDINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:13:04 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CCE62;
        Tue,  4 Jul 2023 01:13:00 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 15CB010005F;
        Tue,  4 Jul 2023 11:12:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 15CB010005F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688458379;
        bh=7XFAwnT1ePpnDt0UOX9dZuZNHFe22x5+doAt9FfJ6NU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=lawcqspTELUqfIg51s4v19RXsSKoj50AK06pYiWvdgIuaCn3udFR5Bn+vzge3ppVe
         rJs313fdtqiV421M2znBnqrMt+EAp3OoGRJBXViKftcdjFZ+oIspVwq5XjA24TqtmD
         z8G7RbdHwTJkD6l1yW886qWCIl34Zr3B4bkuUTFKpaL/avZ/69cugvI1ylLR4gDwmt
         qgclgq/KCvd3IIn4BuyTTkqLjGu7YdWzRsuOed+/t+CPsvlWt5PlUI9JBkVqgz8k72
         yWpY1MKlK0a21tisMcyqOhiQ6YQPPTC2Vdy+XAjYps616svcjH42UKa80xHox7x0y9
         W2qAUXN3W3kPQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 11:12:58 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 11:12:50 +0300
Message-ID: <93dbcbb6-ee17-270c-328d-677e1e3338b3@sberdevices.ru>
Date:   Tue, 4 Jul 2023 11:08:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 5/5] meson saradc: support reading from channel 7 mux
 inputs
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
 <20230627224017.1724097-6-gnstark@sberdevices.ru>
 <20230702172116.00006f33@Huawei.com>
 <CAFBinCCLt-o_QX0izmtzs8MA=ETMAhEib3KDr-6Z66n__GVkyA@mail.gmail.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <CAFBinCCLt-o_QX0izmtzs8MA=ETMAhEib3KDr-6Z66n__GVkyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178412 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
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

Hello Martin, Jonathan

On 7/3/23 22:39, Martin Blumenstingl wrote:
> Hi Jonathan,
> 
> On Sun, Jul 2, 2023 at 11:21 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [...]
>>> @@ -235,6 +249,27 @@ enum meson_sar_adc_channel_index {
>>>        NUM_CHAN_7,
>>>        NUM_CHAN_TEMP,
>>>        NUM_CHAN_SOFT_TIMESTAMP,
>>
>> Silly question... Why does this device have timestamp channels?
>> It has no buffer support so they don't 'do anything'.
>> If it had then putting other channels after that might have broken
>> things if not done very carefully (hence I went looking)
> This question is probably for me (not George).
> The answer is simple: when I wrote the Meson SAR ADC driver I looked
> at various other drivers (but can't recall which ones exactly). One of
> them probably used a soft timestamp channel so I also added that to
> meson_saradc. Since "it didn't break anything" I thought it would be
> fine.
> 
> Newer SAR ADC IP blocks have buffer support, but that's not
> implemented in the driver (yet).
> So if I understand you correctly we can drop the soft timestamp
> channel (with a dedicated patch in this series)?

One short comment: newly-added channels probably won't support buffering 
because physically they all are read thru channel7. We'll be able to add 
buffering only to base old channels and they are still defined before
CHAN_SOFT_TIMESTAMP in channel array (if this is you're wary about).

> 
> 
> Best regards,
> Martin

-- 
Best regards
George

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241A6B92C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCNMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCNMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:12:53 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4FA0F21;
        Tue, 14 Mar 2023 05:12:32 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6213B5FD65;
        Tue, 14 Mar 2023 15:12:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678795950;
        bh=w3RTBim1Vx37finckZA+KqMI4p8SkyD3OYJF9V7g55g=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=qokZEkmxkR1n9wn74YZLDJqjd9WjNoZ03eAGfPgbgfAtWmyoFdOzwddKxzrZaMxX7
         oETrDazA3pfhhnVPimEFYKRbTrOu7qVNdDWI5mvH18ROMhRpbFZN7ErFfeHgMNwLIG
         UewRdIkRG6tBDZ/QKbygI2AFwZkWFI6p0GTMzQHt/AcWknq86MPN6CPNUtpGMhJSjY
         cavdu5Mct5DGwwElkAakRLRAtrzvS2HZCiavaTIn9cMODLvqG5ttrYdl0vj//IQ1JM
         ySpdWJHp7RGEd8LZyCr2bmhOxudMmrM/POn2JzovPPGLTfswdMV0rIQZPGS7ajdEYg
         /ILvAj4WugrNQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 14 Mar 2023 15:12:30 +0300 (MSK)
Message-ID: <3b920b9e-07dc-7bda-4fe1-d15d07e708cc@sberdevices.ru>
Date:   Tue, 14 Mar 2023 15:12:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] leds: add aw20xx driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <devicetree@vger.kernel.org>
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
 <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/14 06:01:00 #20942017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy. Thank you for review.
I have fixed most of your comments. Please take a look below.

On 2023-03-01 00:51, Andy Shevchenko wrote:
>> +       /* The output current of each LED (see p.14 of datasheet for formula) */
>> +       return (duty * global_imax_microamp) / 1000U;
> 
> units.h ?

These constants are needed to improve the accuracy of calculations.
units.h doesn’t have any helpful definitions to use here.

>> +static int aw200xx_set_imax(const struct aw200xx *const chip,
>> +                           u32 led_imax_microamp)
>> +{
>> +       struct imax_global {
>> +               u32 regval;
>> +               u32 microamp;
>> +       } imaxs[] = {
>> +               { 8,  3300 },
>> +               { 9,  6700 },
>> +               { 0,  10000 },
>> +               { 11, 13300 },
>> +               { 1,  20000 },
>> +               { 13, 26700 },
>> +               { 2,  30000 },
>> +               { 3,  40000 },
>> +               { 15, 53300 },
>> +               { 4,  60000 },
>> +               { 5,  80000 },
>> +               { 6,  120000 },
>> +               { 7,  160000 },
> 
> This looks a bit random. Is there any pattern on how value is
> connected to the register value?

There is no ability to create any pattern here, because this table data
doesn’t have any regularity.


-- 
Best Regards,
Kurbanov Martin


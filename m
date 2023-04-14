Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABB26E2098
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDNKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDNKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:19:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFA7EF8;
        Fri, 14 Apr 2023 03:19:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5052A6603221;
        Fri, 14 Apr 2023 11:19:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681467550;
        bh=VeLJmPRvnvEQ5IsnqXZVpDeqo2cwm0kmKEbVshVuBp8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D4l4IvXvCtqC3q5kEPR63kKHkXr3NXvxuaNRo9Tu3sa2jvRz7b6V543y+h/1EObv5
         UzpIhgf2ablwIZJHwB3fKsigC0ozALklq9Bu1D9+Bk635GloxxsT2oTvjFU+0E7m8a
         hux5psPRVFbuKQT/p1/o1MSsLzFyReEIeuvshJ6BUZ/1ywpiWV59Sht2JvsCOG+EKc
         fm9fWjVZn+XubQ2RVUMNyKx1Ll1e6qF2eJcAft3lXVL65oktw3u5RhmWgODO9O8Myh
         ZkC33DerM75vwRrpMwG+MTzFxteIVSodfbzBMp41kGdwTGH2beS9ACWzW4gLXXAIys
         VEMo3Vlw5OoMA==
Message-ID: <d1f54cd7-99c0-3d1c-460b-9f15f33b95c1@collabora.com>
Date:   Fri, 14 Apr 2023 12:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and
 MT6332
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>, pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
 <00c0b699-ba1a-951c-185a-ef8f09abf6f3@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <00c0b699-ba1a-951c-185a-ef8f09abf6f3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 16:15, Alexandre Mergnat ha scritto:
> On 12/04/2023 17:33, AngeloGioacchino Del Regno wrote:
>> Add basic code to turn on and off WLEDs and wire up MT6332 support
>> to take advantage of it.
>> This is a simple approach due to to the aforementioned PMIC supporting
>> only on/off status so, at the time of writing, it is impossible for me
>> to validate more advanced functionality due to lack of hardware.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/leds/leds-mt6323.c | 171 +++++++++++++++++++++++++++++++++++--
>>   1 file changed, 164 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
>> index 5d95dbd9a761..202b38ac32f6 100644
>> --- a/drivers/leds/leds-mt6323.c
>> +++ b/drivers/leds/leds-mt6323.c

..snip..

>> @@ -418,6 +538,7 @@ static int mt6323_led_probe(struct platform_device *pdev)
>>       int ret;
>>       unsigned int status;
>>       u32 reg;
>> +    u8 max_leds;
>>       leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
>>       if (!leds)
>> @@ -428,6 +549,7 @@ static int mt6323_led_probe(struct platform_device *pdev)
>>       leds->pdata = device_get_match_data(dev);
>>       regs = leds->pdata->regs;
>>       spec = leds->pdata->spec;
>> +    max_leds = spec->max_leds + spec->max_wleds;
> 
> I haven't access to the datasheet so I have to ask you:
> Why the max leds value is the addition of max led and wled ?
> 
> IMO, the datasheed give you the max supported led OR wled on its bus function to 
> the maximum supplied current by the PMIC (I assume LED or WLED have different 
> need). Or the PMIC has 2 bus, one for led and another for wled ?
> 

I don't have access to the datasheet for MT6332 as well - but anyway, the only
purpose of the max_leds variable is to validate the maximum number of 'reg'
spaces that we're supposed to read from devicetree, that's all.

The alternative would've been to check if there's any led, then any wled in the
mt6323_hwspec from platform data - then:

if only wleds, max_leds = wleds;
else if only leds, max_leds = leds;
else if leds and wleds, max_leds = leds + wleds;

You see that it doesn't make any sense to do such check, and we can go with
just adding wleds+leds.

Regards,
Angelo

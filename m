Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73703699324
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBPLcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBPLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:32:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6603D0AC;
        Thu, 16 Feb 2023 03:32:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m10so1537936wrn.4;
        Thu, 16 Feb 2023 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0R1ajwKOseY9LqTp2vMJbt3K/TQRkQ1RyCqkaLnpBE=;
        b=W6+5MP3XyfzuiWGTEuMw2frBxOlOcXJaorYYgKunq6tC6bbnjolXaWI1W1ER8VPUhQ
         ncO76D2Bkh5x9BytDvuq4t4oDQKet024tvfBsmBP54sfT/cJncUh8IjHQJT5hmYnST3a
         CZ+gswGo9MFYpAzc5Jb5mytDiYNNjYPWPXiIsrxSypd6s6cgPpvK3OhbDnga5rxXmaOe
         zR7+qBpD+hjlsSi+fnq88zwvIHD3TX2iA1xEEMuufe5sII9aLwqg/AfBuYIeYld/4IcL
         OzOvmGAd8GYczRywggqKEYkvdUlNjLVNFKlhHoPHItBY9mc0XXMzXhpe50UyengZjDzg
         nx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0R1ajwKOseY9LqTp2vMJbt3K/TQRkQ1RyCqkaLnpBE=;
        b=BTEl88MBpsnRmotZ2XP+MkrnQvpSUUgYuwCt7/qGezuNOop58amIMzLILSqVsrfVmR
         V2QlIa3veRu/7X01y1yFnlRrHJ/LPYzqydKXda1VJyoBmJA79Ng2XN0t2MLmBDYot2zL
         7JZqvNJyL7wSWA65Fr1KRTqKbu30aXHtuhCzgEIs2wrUk8ej2i+jOrlDSHMbij9Ath41
         9AiceTf4bkWcDVptkxt8DyhmrqBT6vqc6vOD+g5chrs1V66rmA6vKcYPD/Ud1GzzgNZf
         qNpVO80PrAZHY71OqA8E3mgOb2XVLt4zb4CwUnzpPzClLMyL6Y22ZFYEJ1X52LcnpfhH
         LL9w==
X-Gm-Message-State: AO0yUKU74kR+7UpDa7XVhyHCBclcZCm+AnqlYOqH7LnubSSiiU2A5FwA
        nZuokyIxa1eAFTY1gfiwW60=
X-Google-Smtp-Source: AK7set8ATgy0Dqd1n+/wZ03Pw/JgZf/gi75CTBpsr9fRq6GVo1wXIUuA3THcAydCTWCJ2CAJyiicZA==
X-Received: by 2002:adf:e19c:0:b0:2c5:617f:e348 with SMTP id az28-20020adfe19c000000b002c5617fe348mr1441741wrb.25.1676547132034;
        Thu, 16 Feb 2023 03:32:12 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z12-20020a056000110c00b002c563b124basm1225873wrw.103.2023.02.16.03.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:32:11 -0800 (PST)
Message-ID: <0d5d5d00-8569-a642-cca7-798c8d24a986@gmail.com>
Date:   Thu, 16 Feb 2023 12:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] hwrng: add driver for MediaTek TRNG SMC
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mingming Su <Mingming.Su@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <89865515728cb937b6591160ad9c30b4bcc8dd41.1676467500.git.daniel@makrotopia.org>
 <84de90f5-da77-d3f2-c14a-d2e5c53bbf1c@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <84de90f5-da77-d3f2-c14a-d2e5c53bbf1c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/2023 11:03, AngeloGioacchino Del Regno wrote:
> Il 15/02/23 14:27, Daniel Golle ha scritto:
>> Add driver providing kernel-side support for the Random Number
>> Generator hardware found on Mediatek SoCs which have a driver in ARM
>> TrustedFirmware-A allowing Linux to read random numbers using a
>> non-standard vendor-defined Secure Monitor Call.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Hello Daniel,
> 
> incidentally, I've also done some research on this one some months ago, when
> I was deep in adding support for the Helio X10 SoC (MT6795) on Xperia M5.
> 
> The rng-v2 is simply the same rng but hypervised by the TF-A... and the only
> difference is, well, as you're also pointing out, that we're using secure
> monitor calls instead of direct MMIO handling.
> 
> There's also not much more than what you've implemented here and the only kind
> of addition that we will ever see on this one will be about changing the SIP
> command (as some older SoCs use a different one)... so...
> 
> ...I don't think that adding an entirely new driver is worth the noise, hence
> I propose to simply add handling for the Secure RNG to mtk-rng.c instead: it's
> shorter and we would only need to address one if branch on that probe function
> to set a different callback.
> 
> The clock should then be optional for *some* of those "v2 handling" devices,
> as if I recall correctly, some do need the clock to be handled from Linux
> anyway... otherwise this v2 driver will be "soon" looking bloody similar to
> the "v1", adding a bit of code duplication around.
> 
> What do you think?
> 

That was exactly what I was thinking as well when I had a look at the driver. I 
propose to add it to mtk-rng.c. I don't see any value having a second driver for 
this.

Regards,
Matthias

> Regards,
> Angelo
> 
>> ---
>>   MAINTAINERS                         |  1 +
>>   drivers/char/hw_random/Kconfig      | 16 +++++++
>>   drivers/char/hw_random/Makefile     |  1 +
>>   drivers/char/hw_random/mtk-rng-v2.c | 74 +++++++++++++++++++++++++++++
>>   4 files changed, 92 insertions(+)
>>   create mode 100644 drivers/char/hw_random/mtk-rng-v2.c
>>
> 

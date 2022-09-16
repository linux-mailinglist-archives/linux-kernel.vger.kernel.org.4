Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC32A5BA785
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIPHd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIPHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:33:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C369F62;
        Fri, 16 Sep 2022 00:33:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 957C56601FA1;
        Fri, 16 Sep 2022 08:33:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663313614;
        bh=aWtRXRI7fxQBjROCdpFicK7krf9njG3Luudt99ZAeAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZTeH9hWylUWWDYAaQO0o4OhhOY5Bn9HdDkUrinzDSsrVSDTaTF8y8f0As5M9EBwxL
         o+fphIvpgDmSRDWkhdQW2JdY5dIHZoOYkFvcg07IT0EmNNtMCtqeb1FNP1qJkT2aQf
         N4FuWYkjCVAOPMA8taDAHbZ+CTUk8da4e2Fm7ssosj84DI9zREw4MdYG2QdsMPcV+5
         ECshjxW9VgHmAu3IRSR85tbWs7b1FPOo10Dhj/8h5PEPighiA48tLa0ydZDE/4ccKb
         l8N5X48BGQr2YJ6tcYKcVr7P7wIRwKuHQA4wcFI7FnoXhnFRXyjlTureF27e+giOPx
         ucoaa/7eiJCbA==
Message-ID: <ccd27ec5-6bce-0f5c-1b58-b7bfcbccdeed@collabora.com>
Date:   Fri, 16 Sep 2022 09:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9,4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-5-bchihi@baylibre.com>
 <8d6383e0-329e-ca91-6e79-85b3806a2af3@collabora.com>
 <CAGuA+ooEHPiHuGYXOh7s68HRTv9HSr-BexFsCLUPWTMQ3szCfg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGuA+ooEHPiHuGYXOh7s68HRTv9HSr-BexFsCLUPWTMQ3szCfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 18:58, Balsam CHIHI ha scritto:
> Hi Angelo,
> 
>>> +static int soc_temp_lvts_read_temp(void *data, int *temperature)
>>> +{
>>> +     struct soc_temp_tz *lvts_tz = (struct soc_temp_tz *)data;
>>> +     struct lvts_data *lvts_data = lvts_tz->lvts_data;
>>> +     struct device *dev = lvts_data->dev;
>>> +     unsigned int msr_raw;
>>> +
>>> +     msr_raw = readl(lvts_data->reg[lvts_tz->id]) & MRS_RAW_MASK;
>>> +     if (msr_raw == 0) {
>>> +             /* Prevents a false critical temperature trap */
>>> +             *temperature = 0;
>>> +             dev_dbg(dev, "LVTS not yet ready\n");
>>
>> ...and you're not returning an error code, despite this function was called
>> while LVTS is still not ready? :-)
>>
> 
> if I add "return -ENAVAIL;" here, I will get the following errors on boot :
> [    0.292094] thermal thermal_zone0: failed to read out thermal zone (-119)
> [    0.293019] thermal thermal_zone1: failed to read out thermal zone (-119)
> [    0.294158] thermal thermal_zone6: failed to read out thermal zone (-119)
> [    0.295697] thermal thermal_zone9: failed to read out thermal zone (-119)
> [    0.296600] thermal thermal_zone10: failed to read out thermal zone (-119)
> [    0.297698] thermal thermal_zone15: failed to read out thermal zone (-119)
> [    0.298625] thermal thermal_zone16: failed to read out thermal zone (-119)
> 
> I just preferred : *temperature = 0; to avoid a false critical temperature trap,
> and "return 0;" to suppress these errors.
> After that (first read at boot when LVTS is not fully ready),
> "msr_raw" will be always != 0.
> And I did not want to add a "delay" or a "sleep".
> Please let me know if you have any suggestions that could fix it in a
> better way.
> 

It's the wrong error number. You have to return -EAGAIN :-)

>>> +
>>> +     } else
>>> +             *temperature = lvts_raw_to_temp(&lvts_data->coeff, msr_raw);
>>> +
>>> +     return 0;
>>> +}
> 
> Best regards,
> Balsam


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D270F802
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjEXNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEXNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:49:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B089E;
        Wed, 24 May 2023 06:49:43 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBF796605943;
        Wed, 24 May 2023 14:49:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684936181;
        bh=eOWh+03SOK7Ma/sA2JICrBy2SCdrGT1dVFFRySHiFBI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O7Qsp6hFFseZyO9Y61woxfnLQ7oR35mF7vipm2dk/c4+9mVrNZYJLFloqs/vzkHst
         NrXlx5DLBKi34JaJdpL5g8XeVnpTlzsW4/xk3V8t+gXa2zuznY0LAqrLAYRYuHn3Ti
         lIHEczYNcFyW27XPdxT0t3G2zOmhyMPQlnJ11kywsGHd/Upwnl6hF1rPQq/216bbAC
         ArGaN+tOO9X4EZdXoDgRiujGsWcSvSn91tBjvfhmDXPbdKPlyHXdXkj2FpWBRBq+6W
         XsAVJZlkxnVTIZcYOkIfsV7BbB16dPeBJjBSKvtXvx/JnHNl21yGoHmRQmeIKqTU6b
         gnueVO9Dpr0Pw==
Message-ID: <cfa23203-1626-440b-ec27-efe56cb297d2@collabora.com>
Date:   Wed, 24 May 2023 16:49:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] ASoC: es8316: Increment max value for ALC Capture
 Target Volume control
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-2-cristian.ciocaltea@collabora.com>
 <5dbcbf84-602a-44de-ad99-268d4d5b4b2f@sirena.org.uk>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <5dbcbf84-602a-44de-ad99-268d4d5b4b2f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 13:30, Mark Brown wrote:
> On Wed, May 24, 2023 at 10:41:54AM +0300, Cristian Ciocaltea wrote:
> 
>> This means that either the hardware default is wrongly set to 0xB
>> instead of 0xA, or the specs are incorrect and instead of having the
>> range 0xA-0xF mapped to -1.5 dB, the single value 0xA should have been
>> mapped to -1.5 dB and the remaining range 0xB-0xF to 0 dB.
> 
>> Increment the max value allowed for ALC Capture Target Volume control,
>> so that it matches the hardware default.
> 
>> -	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 10, 0,
>> +	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 11, 0,
>>  		       alc_target_tlv),
> 
> The description above of what the control does doesn't seem to match
> what alc_target_tlv specifies - it is:
> 
>   static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_target_tlv, -1650, 150, 0);
> 
> which is saying that the value goes from -16.5dB up in steps of 1.5dB
> but your description above says that 0-10 map to -1.5dB and other values
> are 0dB.

My description above mentioned only the 0xA-0xF (10-15) range, anything
before that is fine and the implementation matches the specs:

0000 –> -16.5 dB
0001 –> -15.0 dB
0010 –> -13.5 dB
...
0111 –>  -6.0 dB
1000 –>  -4.5 dB
1001 –>  -3.0 dB

The inconsistency is here:
1010-1111 –> -1.5 dB

Since the hardware default is 1011 (11) instead of 1010 (10), I assumed
the specs could be wrong and probably should have provided the following
mappings:

1010 ->  -1.5 dB
1011-1111 -> 0 dB

> Presumably you can check the effects of changing the value?  It seems
> plausible that what's written in the code might be accurate and the
> higher values might actually change the gain but it'd be better to
> check.

I haven't noticed a (measurable) change in gain when switching between
10 and 11, but my testing equipment is also not that great. Will try to
improve the tests accuracy.

Thanks,
Cristian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD267CFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjAZPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjAZPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:21:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704A22A0E;
        Thu, 26 Jan 2023 07:20:54 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A20E16602E71;
        Thu, 26 Jan 2023 15:20:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674746414;
        bh=OywIBlYA1AVg3BlrPI6L6pWZL4oBO4rPFqy2frGycWI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KiXMxmmruai7/eenLApiVXIE+CXu0LMn3aKg4yB2g1ygPM/ZWlO4q4SFJnGsJUXSH
         Br7as0ozqq6NM6O4FvJIHj6YxpUHfBXXvEe4+EDd+xiCB5rGmJ9FpdK1E+t6TuWeyH
         LhMgFsTHP+sSAQfcQL844PnHHxZyI5r8fZD0PH2dDbIji0mpDI0n91T0jBuIIkK4sr
         +RNobIRQ/Ts5GWsJb1L8LcKdI0AcWxaAN04klcOhOaCc9l5i5CJCmRaB1oj6gH3EjG
         tvDT26nwSSCi7J8iYWzKz5YuO4h/W4xrO5HuVg0hVMvZ0guUdyWezdA865oDOzJsLk
         oAGUoNH4GRkgQ==
Message-ID: <231dc0a2-c900-1c71-49e2-d9fe55bc8af1@collabora.com>
Date:   Thu, 26 Jan 2023 16:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] pwm: mtk-disp: Disable shadow registers before
 setting backlight values
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        matthias.bgg@gmail.com, weiqing.kong@mediatek.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <20230123160615.375969-2-angelogioacchino.delregno@collabora.com>
 <20230126150203.dnsbw2l2fzyg3oi5@notapiano>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230126150203.dnsbw2l2fzyg3oi5@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/01/23 16:06, Nícolas F. R. A. Prado ha scritto:
> On Mon, Jan 23, 2023 at 05:06:14PM +0100, AngeloGioacchino Del Regno wrote:
>> If shadow registers usage is not desired, disable that before performing
>> any write to CON0/1 registers in the .apply() callback, otherwise we may
>> lose clkdiv or period/width updates.
>>
>> Fixes: cd4b45ac449a ("pwm: Add MediaTek MT2701 display PWM driver support")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/pwm/pwm-mtk-disp.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
>> index 692a06121b28..82b430d881a2 100644
>> --- a/drivers/pwm/pwm-mtk-disp.c
>> +++ b/drivers/pwm/pwm-mtk-disp.c
>> @@ -138,6 +138,19 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	high_width = mul_u64_u64_div_u64(state->duty_cycle, rate, div);
>>   	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
>>   
>> +	if (mdp->data->bls_debug && !mdp->data->has_commit) {
>> +		/*
>> +		 * For MT2701, disable double buffer before writing register
> 
> Not necessarily part of this series, but I guess it would make sense to remove
> the "For MT2701". It's no longer exclusive to that SoC and the condition in the
> if above makes it clear when this happens.

Thanks for the review and test!

Anyway, for that "For MT2701", well, it ... should actually be exclusive to that
SoC (and some others) because, in reality, MT8183, MT8186, MT8192, MT8195 and
also almost all MediaTek smartphone SoCs do have shadow registers which we should
use for the backlight.

The bls_debug writes that we do are to disable writing to shadow registers and
performing commits because this driver does not (yet) support mtk_mutex handling.

The right thing to do here would be to grab a mtk_mutex, lock it, write shadow
registers, perform "backlighting adjustment magic" in mediatek_drm, commit, unlock.

Now, the "backlighting adjustment magic" is something that we do not support (yet?)
in mediatek_drm, and it's also not really easy to implement: part of that magic
needs RGB ALS readings and implementation of some more IP, which serves the purpose
of, for example, adjusting the backlight PWM while taking account of some GAMMA
adjustments to enhance readability of the screen in direct sunlight, or to decrease
(slightly) power consumption of a display lit at night.

So... the current way that we're using right now (which is disabling the shadow
registers and performing direct writes to working registers to atomically set the
backlight) is something that *should* disappear in *a* future in which that "magic"
gets somehow properly implemented.

This 9k lines mail, just to say that "For MT2701" is technically exclusive to that
SoC, between the number of supported SoCs of this driver :-P

Cheers!
Andlo

> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> On MT8192 Asurada Spherion.
> 
> Thanks,
> Nícolas
> 


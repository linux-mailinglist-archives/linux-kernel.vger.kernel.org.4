Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB66AA564
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjCCXJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjCCXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:09:15 -0500
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA0BB93;
        Fri,  3 Mar 2023 15:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:References:In-Reply-To:Message-Id:Cc:To:Subject:From:
        Date:From:To:Subject:Date:Message-ID:Reply-To;
        bh=jP+DE2aGeRsiKby89SI01ZerumDxZelYSr+aKSJN/m0=; b=T1WQkKSmlCH8TgABX1xfiMaNX9
        8ks/E7QcjaEHAyg1RfCDCfUoaG+IXnaC2MItUs2U2PftpwLxCyv+8FUO4c8Qmm9iae+XuTn+jXWN3
        o3Na3/cvIsbWFoORdTrFPFbpd2EoM404ZhY/YpAEQH/w/TbTbAbrRBK3p6cnpy/parCWky2qARmKF
        FSDjBw9bQolLKCfdl30/jCh/IzD1J/ikDFWA8ICk5Cne1onGTLBvR6KVfGkHF0dqu/mF7Zi1Y1P9S
        32TuYaKHlUR2Ad243XkGanhOCiAnqVJPT+ArwqMT/VxjsYtT69uJzPmjO0yfkD5FKVmPbHU4RJfM5
        LHgKOLYA==;
Received: from [212.51.153.89] (helo=[192.168.12.54])
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pYDo1-00163h-1Q;
        Fri, 03 Mar 2023 22:23:13 +0000
Date:   Fri, 03 Mar 2023 23:23:07 +0100
From:   Lorenz Brun <lorenz@brun.one>
Subject: Re: [PATCH] pwm: mediatek: support inverted polarity
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Message-Id: <J6UYQR.PWF59DFFYYO71@brun.one>
In-Reply-To: <20230303211725.7wtxdxjqpxlrp77b@pengutronix.de>
References: <20230303205821.2285418-1-lorenz@brun.one>
        <20230303211725.7wtxdxjqpxlrp77b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 3 2023 at 22:17:25 +01:00:00, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Mar 03, 2023 at 09:58:21PM +0100, Lorenz Brun wrote:
>>  According to the MT7986 Reference Manual the Mediatek  PWM=20
>> controller
>>  doesn't appear to have support for inverted polarity.
>>=20
>>  This implements the same solution as in pwm-meson and just inverts=20
>> the
>>  duty cycle instead, which results in the same outcome.
>=20
> This idea is broken. This was recently discussed on the linux-pwm list
> and I hope will be fixed soon. See
> https://lore.kernel.org/linux-pwm/20230228093911.bh2sbp4tyfir2z5g@pengutr=
onix.de/T/#meda75ffbd4ef2048991ea2cd091c0c14b1bb09c2
>=20
Is the issue here emulating PWM_POLARITY_INVERSED by inverting the=20
period or the overflow issues?
This driver currently rejects PWM_POLARITY_INVERSED, but the problem is=20
that I have a board which inverts the output of the PWM peripheral=20
(low-side MOSFET for higher-voltage open-drain output), thus I need to=20
set the PWM node to output an inverted signal so that the final=20
open-drain output behaves correctly as the signal has been inverted=20
twice now.

In my specific case this logic could also be added to pwm-fan, but this=20
would lead to more complexity there as this type of circuit is=20
generally handled by the PWM driver.

> So this patch won't be accepted, still pointing out a style problem
> below.
>=20
>>  Signed-off-by: Lorenz Brun <lorenz@brun.one>
>>  ---
>>   drivers/pwm/pwm-mediatek.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
>>  index 5b5eeaff35da..6f4a54c8299f 100644
>>  --- a/drivers/pwm/pwm-mediatek.c
>>  +++ b/drivers/pwm/pwm-mediatek.c
>>  @@ -202,9 +202,7 @@ static int pwm_mediatek_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   			      const struct pwm_state *state)
>>   {
>>   	int err;
>>  -
>>  -	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>>  -		return -EINVAL;
>>  +	u64 duty_cycle;
>>=20
>>   	if (!state->enabled) {
>>   		if (pwm->state.enabled)
>>  @@ -213,7 +211,14 @@ static int pwm_mediatek_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   		return 0;
>>   	}
>>=20
>>  -	err =3D pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle,=20
>> state->period);
>>  +	// According to the MT7986 Reference Manual the peripheral does=20
>> not
>>  +	// appear to have the capability to invert the output. Instead=20
>> just
>>  +	// invert the duty cycle.
>=20
> Wrong commenting style, please stick to C-style comments (/* ... */)
I can fix that if I end up submitting a V2 of this patch, but this=20
didn't get picked up by checkpatch.

>=20
>>  +	duty_cycle =3D state->duty_cycle;
>>  +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
>>  +		duty_cycle =3D state->period - state->duty_cycle;
>>  +
>>  +	err =3D pwm_mediatek_config(pwm->chip, pwm, duty_cycle,=20
>> state->period);
>>   	if (err)
>>   		return err;
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> https://www.pengutronix.de/ |

Regards,
Lorenz



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2446C8FB1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCYRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:10:02 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0CC15F;
        Sat, 25 Mar 2023 10:10:01 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8C5C31C0AB2; Sat, 25 Mar 2023 18:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679764199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KJEOIv0WDWMx6CMw9Gy8zOmeN/VKM2AkbK4vySopPs=;
        b=HIaaxeRLph/qsIzkGwDGhtqURhzPwYdTiSuQmXU8b+N3ySDDdBDrUlGSKEoqQFAU5AG/tP
        NED7Sp+6DaeugqL5Tvda8PQZvhnU7MS2H1qQ9xwsU82X/kws7u/mY4n71LmeSq7l/bvf+L
        9mXq/0nYDuSz5Uz4By3u2Bfxsxt1ego=
Date:   Sat, 25 Mar 2023 18:09:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-leds@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v8 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Message-ID: <20230325170957.GA2904@bug>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-2-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230303095023.538917-2-quic_fenglinw@quicinc.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> @@ -61,6 +61,21 @@ config LEDS_MT6360
>  	  Independent current sources supply for each flash LED support torch
>  	  and strobe mode.
> =20
> +config LEDS_QCOM_FLASH
> +	tristate "LED support for flash module inside Qualcomm Technologies, In=
c. PMIC"
> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	depends on LEDS_CLASS && OF
> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> +	select REGMAP
> +	help
> +	  This option enables support for the flash module found in Qualcomm
> +	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
> +	  channels and each channel is programmable to support up to 1.5 A full
> +	  scale current. It also supports connecting two channels' output toget=
her
> +	  to supply one LED component to achieve current up to 2 A. In such cas=
e,
> +	  the total LED current will be split symmetrically on each channel and
> +	  they will be enabled/disabled at the same time.

"This can be built as a module, module will be called..."

> +static int qcom_flash_led_brightness_set(struct led_classdev *led_cdev,
> +					enum led_brightness brightness)
> +{
> +	struct led_classdev_flash *fled_cdev =3D lcdev_to_flcdev(led_cdev);
> +	struct qcom_flash_led *led =3D flcdev_to_qcom_fled(fled_cdev);
> +	u32 current_ma =3D brightness * led->max_torch_current_ma / LED_FULL;
> +	bool enable =3D !!brightness;
> +	int rc;
> +
> +	rc =3D set_flash_current(led, current_ma, TORCH_MODE);
> +	if (rc)
> +		return rc;

I'd not mind supporting more than one brightness level -- AFAICT hw can do =
that.

BR,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

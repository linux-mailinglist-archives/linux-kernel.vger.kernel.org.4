Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAE710DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjEYN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbjEYN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:56:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498F1A7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:56:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso6803155e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685022986; x=1687614986;
        h=in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:cc:to:from:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R62PgM/NG+1fMHvfOS2Ghe7VXPoy90ZRekVvwcI8bqQ=;
        b=EenrW+REfxFFoJ0vRoUWPr+q5jAs19nqDEaSBGJMACr7kgeMqWFR+7pSR2kmUhYHaI
         KYU7Rwg3nmNmJssMcUID6KE4RwP+muWDIuhvWIKpFPDJW0bLEnyUvYMMjy4pjJWR+x3U
         /Ju4VKfRQ6Z85hIr/UKcvsJMz7PmMBM0f4TrqfNhDa0/DR3aHDnN/BkVmA4T7hfQjVoi
         /tu88ItSTgrao+vI3p4+kHhMd0khudfWaY8GqgBvzK70CSqiHYNS4Pb8nU1qdkDl7QVj
         Zm2nEDqR02i/umejI6BDAtVlUEa0pamMMkGLmmCUB0Qhs7SVzltGXecO8nv78AGR+obz
         f3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685022986; x=1687614986;
        h=in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:cc:to:from:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R62PgM/NG+1fMHvfOS2Ghe7VXPoy90ZRekVvwcI8bqQ=;
        b=YNiw7PGbWv6AjQ/hrhrQv96EWFHqQqGwd2h3RA98HJa6kDrpXmMJOR/y+65xSxWrD2
         nqWGvqWSvGvM0nwmMGDg6xJPSpi7H0uSJmecXKeWBUQeFKjPktH7TsskMg6stCGwJ3DT
         PpJuat4gDhpPofr5BorxaG2HMqus2WFP0TZM5yiYGF4emE/t1DzaCUhyFFpmqNFVnzLW
         XC/XZD7RxaFORBJJtaHR4bj64aH3jkxRzNN7TxkrxAR9HTi3DCKG3ze4gl3smMWNt0X/
         aE4VFDaBOGhoalimdGK914hB8/hsUbaR7BvZEplxaSX/pFjmcDGaoU3bfPajR9k6+rSh
         HTnQ==
X-Gm-Message-State: AC+VfDysRheB5P54pPxkC/ANrxGYJBtz+CtjjnpkyvV6fgjcY4PtcvAF
        a6otUR7dBHY2HTh5PSIVASx/tA==
X-Google-Smtp-Source: ACHHUZ5spsLVEL4Q+ZuQ9+zvgUVjM6HPNbvB0dctuunc402q0sK3Q2Ba6LgV/grmwijEHUGhUX/ZdA==
X-Received: by 2002:a7b:c40a:0:b0:3f1:72fb:461a with SMTP id k10-20020a7bc40a000000b003f172fb461amr2571852wmi.2.1685022986669;
        Thu, 25 May 2023 06:56:26 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:ed59:2d5:ca3d:ee5c])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f605566610sm5867294wmi.13.2023.05.25.06.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 06:56:26 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 25 May 2023 15:56:25 +0200
Subject: Re: [PATCH v5 1/3] rtc: tps6594: Add driver for TPS6594 RTC
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     <andy.shevchenko@gmail.com>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <u-kumar1@ti.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <CSULDUAPQNFL.18PZXEW1IBRQM@burritosblues>
X-Mailer: aerc 0.14.0
References: <20230522163115.2592883-1-eblanc@baylibre.com>
 <20230522163115.2592883-2-eblanc@baylibre.com> <ZGzBe6O_mw_pdSkH@surfacebook>
In-Reply-To: <ZGzBe6O_mw_pdSkH@surfacebook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue May 23, 2023 at 3:36 PM CEST,  wrote:
> Mon, May 22, 2023 at 06:31:13PM +0200, Esteban Blanc kirjoitti:
> > TPS6594 PMIC is a MFD. This patch adds support for
> > the RTC found inside TPS6594 family of PMIC.
> >
> > Alarm is also supported.
>
> ...
>
> > +	help
> > +	  TI Power Management IC TPS6594 supports RTC functionality
> > +	  along with alarm. This driver supports the RTC driver for
> > +	  the TPS6594 RTC module.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called tps6594-rtc
>
> Grammar period at the end?

Thanks!

> > +#define TPS6594_GET_TIME_ON TPS6594_BIT_GET_TIME
> > +#define TPS6594_GET_TIME_OFF 0
>
> Not used.

Thanks.
>
> > +#define TPS6594_IT_ALARM_ON TPS6594_BIT_IT_ALARM
> > +#define TPS6594_IT_ALARM_OFF 0
>
> Used only once.

True. Is that a bad thing?

> > +#define TPS6594_AUTO_COMP_ON TPS6594_BIT_IT_ALARM
>
> No _OFF counterpart.
>
> That said the _OFF can be dropped completely. And the rest I see no value=
 to
> have, just use those bit definitions directly?

I was thinking it would make this more readable. I will remove them, no
problem.

> > +static int tps6594_rtc_alarm_irq_enable(struct device *dev,
> > +					unsigned int enabled)
> > +{
> > +	struct tps6594 *tps =3D dev_get_drvdata(dev->parent);
> > +	u8 val =3D 0;
>
> Redundant assignment.
>

Thanks!

> > +	// Read shadowed RTC registers.
> > +	ret =3D regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_da=
ta,
> > +			       NUM_TIME_REGS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	tm->tm_sec =3D bcd2bin(rtc_data[0]);
> > +	tm->tm_min =3D bcd2bin(rtc_data[1]);
> > +	tm->tm_hour =3D bcd2bin(rtc_data[2]);
> > +	tm->tm_mday =3D bcd2bin(rtc_data[3]);
> > +	tm->tm_mon =3D bcd2bin(rtc_data[4]) - 1;
> > +	tm->tm_year =3D bcd2bin(rtc_data[5]) + 100;
> > +	tm->tm_wday =3D bcd2bin(rtc_data[6]);
> > +
> > +	return ret;
>
> 	return 0;
>
> No?

`regmap_bulk_read` returns 0 on success so ret should be 0 here. I will
apply your suggestion anyway it is more readable. Thanks!

> > +static int tps6594_rtc_set_calibration(struct device *dev, int calibra=
tion)
> > +{
> > +	unsigned char comp_data[NUM_COMP_REGS];
> > +	struct tps6594 *tps =3D dev_get_drvdata(dev->parent);
> > +	__le16 value;
> > +	int ret;
> > +
> > +	/*
> > +	 * TPS6594 uses two's complement 16 bit value for compensation of RTC
> > +	 * crystal inaccuracies. One time every hour when seconds counter
> > +	 * increments from 0 to 1 compensation value will be added to interna=
l
> > +	 * RTC counter value.
> > +	 *
> > +	 * Valid range for compensation value: [-32767 .. 32767].
>
> This is defined naturally by the bits available, correct?

Your right. Maybe `calibration` argument should be an s16 instead of an
int?

> > +	 */
> > +	if (calibration < -32767 || calibration > 32767) {
>
> So, this can be S16_MIN / S16_MAX range. The question here is what the
> -32768 meaning is and why it can't be used.

I will rewrite it using this 2 macros.

This range [-32767,32767] is specified in the datasheet. As for why
-32768 can't be used I have no idea.

> > +		dev_err(dev, "RTC calibration value out of range: %d\n",
> > +			calibration);
> > +		return -EINVAL;
>
> -ERANGE

Ok, thanks.

> > +	}
>
> > +	value =3D (__le16)calibration;
> > +
> > +	comp_data[0] =3D value & 0xFF;
> > +	comp_data[1] =3D (value >> 8) & 0xFF;
>
> Of course these three lines is not what expected.
>
> 	value =3D cpu_to_le16();

Sorry for the mistake. I've tried to find more information on those type
but I did not realize there was specific functions/macros for them.

I have learn something today :)

> > +	// Update all the compensation registers in one shot.
> > +	ret =3D regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_COMP_LSB,
> > +				comp_data, NUM_COMP_REGS);
>
> 				&value, sizeof(value) ?

This is way cleaner indeed.

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	// Enable automatic compensation.
> > +	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > +			       TPS6594_BIT_AUTO_COMP);
> > +}

> > +	ret =3D regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_COMP_LSB, comp_=
data,
> > +			       NUM_COMP_REGS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	value =3D (__le16)comp_data[0] | ((__le16)comp_data[1] << 8);
> > +
> > +	*calibration =3D value;
>
> In the similar (complementary API) way as above.

Sure.

> > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
>
> Having
>
> 	struct device *dev =3D &pdev->dev;
>
> might make this and other lines shorter / neater.

Will do, thanks.

> > +					tps6594_rtc_interrupt, IRQF_ONESHOT,
> > +					TPS6594_IRQ_NAME_ALARM, &pdev->dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "Failed to request_threaded_irq\n");

Thanks for your review.

Best regards,

--
Esteban Blanc
BayLibre


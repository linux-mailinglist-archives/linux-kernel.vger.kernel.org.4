Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F36700D20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjELQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjELQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:37:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D78A7D;
        Fri, 12 May 2023 09:37:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so91145864a12.1;
        Fri, 12 May 2023 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683909431; x=1686501431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTY/iNPhSxqsOYVuVF5oPridnajCISLwpvB33cCStX4=;
        b=mQXoys12JvgdLa62LLYJLDzvL+tsH1KN3YfXhC27Z2LXWBDAyL4sAy6E0hG/t0xXtB
         AVAog6/+PYoXEq+ed3XdJqz2/jZ8xKjBID+qoLIW+tYcw+Nkkg9YeANhRjmh6ykQKPS7
         VGwn/KRajhXuvvdVaZ+xxI0jS9XS9zHsVX0eLKfyGJrLjlsuUmGxgmKGJ0FOVrHh9Qg3
         7qWI7PndkHVQAUgwyEduQJNWq5Uumwh06tB8TiJFMq6BwnRxIqhlKq4qs2Qi1WOwub6L
         FYybZIBV92FE15seZ946u1LrhcO/nVQIi7+XOAQWc4VbaUpVvfzWHH/Bkcnj5ESK9jEY
         IW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683909431; x=1686501431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTY/iNPhSxqsOYVuVF5oPridnajCISLwpvB33cCStX4=;
        b=P038aNADXZJfWX34r/tahcjvAdMvprrWC202dfJEKhsjcIixLfgCcnaxK6Qd+h+UlQ
         lFW58Ey6r4J8tSXKxpIGlXnrLsQss8h2K6RFLZuvATnWCTC+pdItLEslYGilzolcLmkr
         ZTsF8ZAy7z9oTGsHs088UNH75o4oXX0TFwGw1NPZeeR0/cEa2kdIc6yTpH6Was4m2YG2
         qx0eYk2ERzeOgvSYVgthOF5hTvF9HhS4+hQMBP7JdobOSUbm8MM/1JegcpPZ0NgDkFDU
         tErmYHl4NPlutGfqoG0yIZyoCzzblHZznSZogsAu45kQiF/JJmWB2sWoM0fZEPXXEfaI
         QGsw==
X-Gm-Message-State: AC+VfDxv0SJwv0exDizJzk1HeCgHHcY+oQlZ6lttRVJCGnM29u1ZZ5PH
        bnorG7JUaKKm3h/TkylY7lW2DNChES+9zQ==
X-Google-Smtp-Source: ACHHUZ6oEr96mBEftUGvQgedCvHzktnamXm3QY6YaaVsVAMNVUmfiCMwnVR7gm8jofdWN5YF0zwLWA==
X-Received: by 2002:a17:907:3e2a:b0:966:4973:b35 with SMTP id hp42-20020a1709073e2a00b0096649730b35mr17510063ejc.22.1683909431229;
        Fri, 12 May 2023 09:37:11 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id gv28-20020a1709072bdc00b00965cfc209d5sm5619198ejc.8.2023.05.12.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:37:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: dts: axp209: Add iio-hwmon node for internal
 temperature
Date:   Fri, 12 May 2023 18:37:09 +0200
Message-ID: <2679706.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <ZF4VSCxvb6ihw9JL@earth.li>
References: <cover.1681580558.git.noodles@earth.li> <3421275.QJadu78ljV@jernej-laptop>
 <ZF4VSCxvb6ihw9JL@earth.li>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 12. maj 2023 ob 12:30:32 CEST je Jonathan McDowell napisal(a):
> On Thu, May 11, 2023 at 06:11:49PM +0200, Jernej =C5=A0krabec wrote:
> > Dne sreda, 10. maj 2023 ob 14:02:28 CEST je Jonathan McDowell napisal(a=
):
> > > This adds a DT node to hook up the internal temperature ADC to the
> > > iio-hwmon driver. The various voltage + current ADCs are consumed and
> > > exposed by their respective drivers, but this is not and is always
> > > available. Naming chosen to match the axp20x_ prefix the power sensors
> > > use.
> >=20
> > Sorry for maybe obvious thing, but where are other ADC channels exposed?
>=20
> In the associated power drivers; e.g. axp20x_ac_power, axp20x_usb_power
> + axp20x_battery. The internal temperature is the only one that
> logically belongs to the chip as a whole rather than one of the
> subfunctions.
>=20
> root@chip:~# sensors
> axp20x_battery-isa-0000
> Adapter: ISA adapter
> in0:           0.00 V
> curr1:         0.00 A
>=20
> pmic_temp-isa-0000
> Adapter: ISA adapter
> temp1:        +42.5=C2=B0C
>=20
> axp20x_ac-isa-0000
> Adapter: ISA adapter
> in0:           0.00 V
> curr1:         0.00 A
>=20
> axp20x_usb-isa-0000
> Adapter: ISA adapter
> in0:           4.93 V  (min =3D  +4.00 V)
> curr1:       330.00 mA (max =3D  +0.00 A)

Right.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> > > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > > ---
> > >=20
> > >  arch/arm/boot/dts/axp209.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/axp209.dtsi
> > > b/arch/arm/boot/dts/axp209.dtsi
> > > index ca240cd6f6c3..469d0f7d5185 100644
> > > --- a/arch/arm/boot/dts/axp209.dtsi
> > > +++ b/arch/arm/boot/dts/axp209.dtsi
> > > @@ -48,6 +48,13 @@
> > >=20
> > >   * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
> > >   */
> > >=20
> > > +/ {
> > > +	pmic-temp {
> > > +		compatible =3D "iio-hwmon";
> > > +		io-channels =3D <&axp_adc 4>; /* Internal temperature */
> > > +	};
> > > +};
> > > +
> > >=20
> > >  &axp209 {
> > > =20
> > >  	compatible =3D "x-powers,axp209";
> > >  	interrupt-controller;
>=20
> J.





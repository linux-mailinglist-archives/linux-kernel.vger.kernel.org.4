Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DAF6EAA74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjDUMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDUMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:38:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E521BE1;
        Fri, 21 Apr 2023 05:38:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so11972585e9.3;
        Fri, 21 Apr 2023 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682080730; x=1684672730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCMAHFppmdE0h2eSE7SVA2p77VP5tfUEgylFBcE3w+A=;
        b=bnYWqIosWfJi7eLKizd2y9D7vRS6Y0vmFTABs+IaNG0Q9xxl8W15Y/rRlqZy5hTrBz
         vrS4WupH+7PXNkuzG1IJixXPbI0cJMDAA4KC2HAf6XsOtqrOT/QlreY4kwuZogKI5/2o
         NOOOlKiWsdCU8TSJNteaaysLAVFDzaU+QjtzBZfWhcSCgumdels25tW+H9R7fBu96ld3
         QwVC3DzWgd1YG7R0pIZC0Fh1Zi1pEn/JGzh4suqk1qG7pETstAawt8mt1FanPWK+0KHF
         kHjIrl13egkf4j03KRCTgi2iTtSc5OfLddgS0TYm2JZVQ6TJKl3MxzF5/7TKxw8HvkY6
         Gf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682080730; x=1684672730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCMAHFppmdE0h2eSE7SVA2p77VP5tfUEgylFBcE3w+A=;
        b=VRq+MI+iWSQGQJMQpJVznhLI/+fho33IsDg2UUpS90C9FYX0/wG2YtV7epFfLrUQeL
         AXsqUDhMOUvnNUW+OX+gHwzTBhpRH9cYAeK77/7i01xDM0ZenzezwqbDVJIq7qD69yyI
         vE7oQM7xPvy31MpD5we5zbFgtOJxhA8x1o+oCKf6eMgDZiZciJNGH4EY9LdYmSupclt9
         0/KU2H4E/dOT8KTmOb+sad79VW0U2iNuEoRx9cxTZhb0hAP/f/eAK0fo5qqV7P8SDUNQ
         R6/b6+NaV9NOu0J0Oqg4OIKq9nzJsrH8YyUChnbbD3idmmqI+Z871SuGw67bTzizd2bd
         c2MQ==
X-Gm-Message-State: AAQBX9etXHW6BopevPyiJGfseHBY5ni4IBZ9cizyHs/AYFNKadFJFgPH
        NJPXwcJHoe/dNb7UMDbH/Wc=
X-Google-Smtp-Source: AKy350bWSI4yUZ/Fus/xufW0w2UdGKgyzfF2T9heyFUrE4JvGhiMeEbXqHmCm3DFqwfPOXKBJd35YA==
X-Received: by 2002:a7b:c8c1:0:b0:3f1:7367:dd69 with SMTP id f1-20020a7bc8c1000000b003f17367dd69mr1881495wml.5.1682080730261;
        Fri, 21 Apr 2023 05:38:50 -0700 (PDT)
Received: from archbox.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b002feea065cc9sm4271300wrv.111.2023.04.21.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:38:49 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Fri, 21 Apr 2023 14:38:48 +0200
Message-ID: <12191318.O9o76ZdvQC@archbox>
In-Reply-To: <8914603.GXAFRqVoOG@phil>
References: <20230419171731.28641-1-frattaroli.nicolas@gmail.com>
 <8914603.GXAFRqVoOG@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday, 21 April 2023 13:58:58 CEST Heiko Stuebner wrote:
> Hi,
>=20
> Am Mittwoch, 19. April 2023, 19:17:31 CEST schrieb Nicolas Frattaroli:
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi index
> > ce7165d7f1a1..f589a4fdaccb 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
> > @@ -65,6 +65,17 @@ led_work: led-work {
> >=20
> >  		};
> >  =09
> >  	};
> >=20
> > +	nextrst_pin: nextrst-pin-regulator {
> > +		compatible =3D "regulator-fixed";
> > +		enable-active-high;
> > +		gpio =3D <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&nextrst_h>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-name =3D "nextrst";
> > +	};
> > +
>=20
> I agree with the sentiment and of course the rationale of the change,
> but not necessarily with the implementation ;-) .
>=20
> Why is this done as a regulator?
>=20
> If you want the nextrst line to be high, you could just use a gpio-hog
> for the line instead of doing a (fake?-)regulator.

Simply put: because I didn't know gpio hogs were a thing. I'll send a V2
to correct this. Thanks for pointing it out!

>=20
> For example the px30-ringneck.dtsi does something similar:
>=20
> &gpio2 {
>         /*
>          * The Qseven BIOS_DISABLE signal on the PX30-=B5Q7 keeps the
> on-module * eMMC powered-down initially (in fact it keeps the reset signal
> * asserted). BIOS_DISABLE_OVERRIDE pin allows to re-enable eMMC after * t=
he
> SPL has been booted from SD Card.
>          */
>         bios-disable-override-hog {
>                 gpios =3D <RK_PB5 GPIO_ACTIVE_LOW>;
>                 output-high;
>                 line-name =3D "bios_disable_override";
>                 gpio-hog;
>         };
> ...
> };
>=20
>=20
> Thanks
> Heiko

Kind regards,
Nicolas Frattaroli




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3EC65F108
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjAEQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjAEQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:22:04 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9A351305;
        Thu,  5 Jan 2023 08:22:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so91166764ejm.8;
        Thu, 05 Jan 2023 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU9BexSvyi2rD+vcAVXhDiB0sHcYopPemd1xbDcQCCM=;
        b=ZzmV1s9fsOiFn3LejpZMBW4u+pf0+ZsDVki4sSrDBfhDl+80zywTBkT2FEzzYYPBi8
         JmEKj/3Qtjl+IaRZADQxPPtnnv2nKTIrrFX2o2FHjpaitSARP8JPauqYKgrkHW1UvnDo
         c4f/TcKWlNL8MZgrKbZIB6+uzR7o51Romu8B8t0kqV685+x5Mh6USO9dHK+mR+2yHTS4
         SdXlYi99kkgubU0p0EGJppw545xOeurgrgnbHVfnJNVnrp/RMu67JcDiQF+Fy3dOHG+t
         Z1aQSAVwxxQiIVCyKOJiFkr6Xb6WAWvptnENqrE0UMtxZt/wJoSGIWImm4TGLjKgLw97
         fyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU9BexSvyi2rD+vcAVXhDiB0sHcYopPemd1xbDcQCCM=;
        b=ogUF30ASumonC2hjCCxu5CJQcwEb36+M9CrZScDjGvS9Rz1iiCLam+u7u0mHdIQB09
         FN8jQv49JZAmL8B9Dq/erlE2VhWATRrnZrLWrdTucCa+q45HzFRxvJCB3UlPkIm9iNPm
         bZyiIZlNMWEmVIpU6Hgm2kaGTmCv6KcGMIwlHiaqTBsq3IlCVpl7W5e4jTfAQGIt115d
         kIzuLTC0+BbkZ6eajOx5Lq87lIHbzl/4endKN0D+ExnbGpF8hFK9QHx+cTcbVSdSU/dm
         uZgg+zsfi94uIltj4XYhn0YDsQbYK9X9franL/s7iO+rCI6M/mG3CjhDUjs+NoDVWxkO
         SMuw==
X-Gm-Message-State: AFqh2krN9+raXJDm03N2Hs8Ow2odoG6kcJ5D4Lpx/Gw53EVP6KzHm+HK
        ae1cvbkk5hbLjEuS52P8Xc8=
X-Google-Smtp-Source: AMrXdXsD2peymLRAR8nXx7rxyHoJqIkfQ1+TstQthZ56mRCZ9BQTT+slxB9DzT9NnHO//D+Rg/RyuA==
X-Received: by 2002:a17:906:b108:b0:843:a9fe:f115 with SMTP id u8-20020a170906b10800b00843a9fef115mr46900892ejy.32.1672935722636;
        Thu, 05 Jan 2023 08:22:02 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r18-20020a170906549200b007c0b28b85c5sm16503224ejo.138.2023.01.05.08.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:22:01 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] riscv: dts: allwinner: d1: Add video engine node
Date:   Thu, 05 Jan 2023 17:21:58 +0100
Message-ID: <4767366.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <3b6ec431-70ac-cf68-6f46-9dc0affb1e68@sholland.org>
References: <20221231164628.19688-1-samuel@sholland.org> <Y7aiZdjI8L5h1Ca3@aptenodytes>
 <3b6ec431-70ac-cf68-6f46-9dc0affb1e68@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 05. januar 2023 ob 15:38:36 CET je Samuel Holland napisal=
(a):
> Hi Paul,
>=20
> On 1/5/23 04:11, Paul Kocialkowski wrote:
> > On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
> >> D1 contains a video engine which is supported by the Cedrus driver.
> >=20
> > Does it work "outside the box" without power domain management?
> > If not, it might be a bit confusing to add the node at this point.
>=20
> Yes, it does. All of the power domains are enabled by default. However,
> if the PPU series is merged first, I will respin this to include the
> power-domains property from the beginning.

I would rather see that merged before and having complete node right away.

I've been away, but I'll merge everything that's ready for sunxi tree until=
=20
end of the weekend.

Best regards,
Jernej

>=20
> Regards,
> Samuel
>=20
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>=20
> >>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>=20
> >> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> >> b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> >> dff363a3c934..4bd374279155 100644
> >> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> >> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> >> @@ -34,6 +34,17 @@ soc {
> >>=20
> >>  		#address-cells =3D <1>;
> >>  		#size-cells =3D <1>;
> >>=20
> >> +		ve: video-codec@1c0e000 {
> >> +			compatible =3D "allwinner,sun20i-d1-video-
engine";
> >> +			reg =3D <0x1c0e000 0x2000>;
> >> +			interrupts =3D <SOC_PERIPHERAL_IRQ(66)=20
IRQ_TYPE_LEVEL_HIGH>;
> >> +			clocks =3D <&ccu CLK_BUS_VE>,
> >> +				 <&ccu CLK_VE>,
> >> +				 <&ccu CLK_MBUS_VE>;
> >> +			clock-names =3D "ahb", "mod", "ram";
> >> +			resets =3D <&ccu RST_BUS_VE>;
> >> +		};
> >> +
> >>=20
> >>  		pio: pinctrl@2000000 {
> >>  	=09
> >>  			compatible =3D "allwinner,sun20i-d1-pinctrl";
> >>  			reg =3D <0x2000000 0x800>;





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2976F11E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbjD1GoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjD1GoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:44:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C044A2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:43:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so52729725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682664211; x=1685256211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31ZUiiLTP21TBfk/x6qc9G3WQJWlECoDzo5LSbdGdGw=;
        b=kFhjSdoq+UbCKEl0ne8AV/zQ34ktf7ne73V1ntaOjSvGFlRa+RDQ04sTJhEfxGOqw0
         IOwgYXIhEZZMw0KZiLbOl5qXW0axz89XEyJseEKqy4BCRRWKYx8ddUa3Ll0IF0gJesP1
         ai6TQ+WjiYq7iyIOQlB2uJnDS+1HwNnt3WcbKaIcKbXngiv0XvgcQBvrcTM5Nv2PHcag
         WyzHUcSDYbuEVm5CezCnrU1gFZ4FDJfTomk6kdTPl74pBVWxefXjoijRe5v5egeAWILC
         q0yRdQW1FXsvWaLJPP+sH6IO+X5aCpLX9oh9eu28gjv8wm3AJQJSnybZfJ+FP71JOP7a
         wYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682664211; x=1685256211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31ZUiiLTP21TBfk/x6qc9G3WQJWlECoDzo5LSbdGdGw=;
        b=Luf1c0VSLYQo9/4N/8ZEznXZdsV/1FyDLGTAi+HV+qfeAPm+E+4CbbzSl+GGV6jWqV
         Gyc7bHbOWRt8W1UKleKW7u9x1FsHKR/2IOe/L2zrgjsSl3dssQAywR6y6MR9wfTQEo9z
         B4ES1hepAC0kEx2fjxDhmVY4HvYyvIHbZFuaWaqGHE8XZe/vLy9Y45kyFNXW8Xn1q4c0
         lFNp5El6iP6O1fWgM1jZszw0/wim6KxuER5MWHLb6Oo7KiDXcSRyuYeXrOWCtuTXHY9J
         SoWM5R+W5fdemvA3IrImzjeeudZS8sMBZfWNqMsEA7mo28Ckrhc5+YNV5qqosbOi5yqN
         zb8Q==
X-Gm-Message-State: AC+VfDyE5Xhd2lYvFGT63HQXoQo7sIqJ+LM/aOFM0ZWtW33QFaTesQyp
        spkwXUtHce9XmYxyOWjt3Y0=
X-Google-Smtp-Source: ACHHUZ50d/5tJ8AolUzgSXoZARfdohMiCwyMBJRoq23f6K3jb9jKjOTUg7edaVAqYsxzSeQdzfyLqQ==
X-Received: by 2002:a1c:cc0f:0:b0:3f1:718d:a21c with SMTP id h15-20020a1ccc0f000000b003f1718da21cmr3083738wmb.31.1682664211045;
        Thu, 27 Apr 2023 23:43:31 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003f3270ddbd8sm795594wmg.37.2023.04.27.23.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 23:43:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        Roman Beranek <me@crly.cz>
Cc:     Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] arm64: dts: allwinner: a64: reset pll-video0 rate
Date:   Fri, 28 Apr 2023 08:43:29 +0200
Message-ID: <4477541.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20230427091611.99044-5-me@crly.cz>
References: <20230427091611.99044-1-me@crly.cz> <20230427091611.99044-5-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 27. april 2023 ob 11:16:08 CEST je Roman Beranek napisal(=
a):
> With pll-mipi as its source clock, the exact rate to which TCON0's data
> clock can be set to is constrained by the current rate of pll-video0.
> Unless changed on a request of another consumer, the rate of pll-video0
> is left as inherited from the bootloader.
>=20
> The default rate on reset is 297 MHz, a value preferable to what it is
> later set to in u-boot (294 MHz). This happens unintentionally though,
> as u-boot, for the sake of simplicity, rounds the rate requested by DE2
> driver (297 MHz) to 6 MHz steps.
>=20
> Reset the PLL to its default rate of 297 MHz.

Why would that be preferable? You actually dropped "clk: sunxi-ng: a64:=20
propagate rate change from pll-mipi" patch which would take care for adjust=
ing=20
parent rate to correct value.

Best regards,
Jernej

>=20
> Signed-off-by: Roman Beranek <me@crly.cz>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> e6a194db420d..cfc60dce80b0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -667,6 +667,9 @@ ccu: clock@1c20000 {
>  			clock-names =3D "hosc", "losc";
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
> +
> +			assigned-clocks =3D <&ccu CLK_PLL_VIDEO0>;
> +			assigned-clock-rates =3D <297000000>;
>  		};
>=20
>  		pio: pinctrl@1c20800 {





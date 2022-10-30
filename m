Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1438612A75
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ3L5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3L5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:57:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEDC75D;
        Sun, 30 Oct 2022 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667131028; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7jkshNTb9CiYN6d6S/xxo0roUtTTADG65mtz+EOG7s=;
        b=Z/Ghtw9wVpX8bc8gyui25gXnYgcieXCx+emBBtV/CVXNSv+4CVH1zPs77tDzAlr6nYOfb2
        KQAOKKcD5r4m0i/qCCafwJ2SQPkaFzUfY8OxhkHfK9TX5CpYS/ie6PC5hKwgq43FUDcOVo
        15SN73ZxIgqV25P8yQ0jcAz+lEFdM1M=
Date:   Sun, 30 Oct 2022 11:56:58 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/3] dt-bindings: ingenic,aic: Remove unnecessary
 clocks from schema
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tsbogend@alpha.franken.de,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <YIEKKR.ZFP16J137HGC3@crapouillou.net>
In-Reply-To: <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
        <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 28 oct. 2022 =E0 11:34:16 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The AIC needs only the first two clocks: "aic" is a gate that's used
> for gating the I2S controller when it's suspended, and "i2s" is the
> system clock, from which the bit and frame clocks are derived. Both
> clocks are therefore reasonably part of the AIC and should be passed
> to the OS.
>=20
> But the "ext" and "pll half" clocks are a little more questionable.
> It appears these bindings were introduced when the schema was first
> converted to YAML, but weren't present in the original .txt binding.
> They are intended to be the possible parent clocks of "i2s".
>=20
> The JZ4770 actually has three parents for its "i2s" clock, named
> "ext", "pll0", and "pll1" in the Linux driver. The JZ4780 has two
> parents but it doesn't have a "pll half" clock, instead it has an
> "i2s_pll" clock which behaves much differently to the actual
> "pll half" clock found on the JZ4740 & JZ4760. And there are other
> Ingenic SoCs that share the JZ4780's clock layout, eg, the X1000.
>=20
> Therefore, the bindings aren't really adequate for the JZ4770 and
> a bit misleading for the JZ4780. Either we should fix the bindings,
> or remove them entirely.
>=20
> This patch opts to remove the bindings. There is a good case to be
> made that "ext" and "pll half" don't belong here because they aren't
> directly used by the AIC. They are only used to set the parent of
> the "i2s" clock; they have no other effect on the AIC.
>=20
> A good way to think of it is in terms of how the AIC constrains
> clocks. The AIC can only generate the bit & frame clocks from the
> system clock in certain ratios. Setting the sample rate effectively
> constrains the frame clock, which, because of the clock dividers
> controlled by the AIC, translates to constraints on the "i2s" clock.
> Nothing in the AIC imposes a direct constraint on the parents of
> the "i2s" clock, and the AIC does not need to enable or disable
> the parents directly, so in principle the AIC doesn't need to be
> aware of the parent clocks at all.
>=20
> The choice of parent clock is still important, but the AIC doesn't
> have enough information to apply such constraints itself. The sound
> card does have that information because it knows how the AIC is
> connected to other components. We need to use other DT mechanisms
> to communicate those constraints at the sound card level, instead
> of passing the clocks through to the AIC, and inventing ad-hoc ways
> to plumb the constraints around behind the scenes.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Yes, it makes sense also because from a DT point of view, these clocks=20
were redundant information. It's enough to know the i2s clock to also=20
know its parents.

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  .../devicetree/bindings/sound/ingenic,aic.yaml         | 10=20
> ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml=20
> b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
> index d607325f2f15..c4f9b3c2bde5 100644
> --- a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
> +++ b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
> @@ -37,15 +37,11 @@ properties:
>      items:
>        - description: AIC clock
>        - description: I2S clock
> -      - description: EXT clock
> -      - description: PLL/2 clock
>=20
>    clock-names:
>      items:
>        - const: aic
>        - const: i2s
> -      - const: ext
> -      - const: pll half
>=20
>    dmas:
>      items:
> @@ -82,10 +78,8 @@ examples:
>        interrupts =3D <18>;
>=20
>        clocks =3D <&cgu JZ4740_CLK_AIC>,
> -               <&cgu JZ4740_CLK_I2S>,
> -               <&cgu JZ4740_CLK_EXT>,
> -               <&cgu JZ4740_CLK_PLL_HALF>;
> -      clock-names =3D "aic", "i2s", "ext", "pll half";
> +               <&cgu JZ4740_CLK_I2S>;
> +      clock-names =3D "aic", "i2s";
>=20
>        dmas =3D <&dmac 25 0xffffffff>, <&dmac 24 0xffffffff>;
>        dma-names =3D "rx", "tx";
> --
> 2.38.1
>=20



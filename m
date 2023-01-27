Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C467F10B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjA0WRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjA0WRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:17:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D00386602;
        Fri, 27 Jan 2023 14:17:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt14so17439405ejc.3;
        Fri, 27 Jan 2023 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaeS+1CpC8eMdmggdR+qBf5UZX/S+Ov1sK2rOHC/Hig=;
        b=eNJ84I8xpfXVY3tEEPztbJBDNsYDQqKEds6DPvBGsslPh8on31fBOoL4lPhfjA6udM
         s/riFkZF7ezUWo4t14NATMbH3KZxKfkS/1nRKLA2QjqmiwLLOV2uxWa4p+2uFgRpQOnv
         r5AJl7L9KenB7vFwzS0jLuP/NC4MXdZQ9V18IN/0aRXEksroLfcWPe2Obs9JvkQmD0hx
         TIzfIKC84DDzmLCQDx6trXmTVUWglZik8t3VcA1uN+gpCDsyBFJJ0xUAD112vulwN2Ts
         50juQir25a3MR4FumuDgfyy2rE3FmCqGgh+5KwGK3JRhfgiQuy4FGJcPH/GpeafyOg2f
         nKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaeS+1CpC8eMdmggdR+qBf5UZX/S+Ov1sK2rOHC/Hig=;
        b=pXbAQY+IOYkL+SOg6etXgscY1svhv45v0aCKCWbnS9BsxycOtpX3Nttr4SthMh9yHF
         jmi+bS34y52rMVcPlsWmRJzBdPosv4fQ3H7sOeNoN5cZFejvts6WSWYoS2KBMEzLe6xK
         pgO84fVBfiQq8DwJLb5BpPO+nkJPgRjKeP3dQ5QICL2RCFinsioJIiH/mRYekZ2PZADl
         7Hi/BUxIhYFgo2jWt6ZvPse7cgCocloJJFG2d/gU2AFAU1XgG7B7IKxZTovDAWCNXucj
         b6ErmTEnmkxuLLrWHPpIPM74l3oQPHLjNeJ9Q0/4IWapGhGRLmaZvKcMr/wnAZvNlvIe
         UAXg==
X-Gm-Message-State: AO0yUKV/DuOJguFW2Pv5AcH+utlLQgpnNJvDucwDf7IgStIOEQGU3I1l
        ywFyRDGkEg+jxQloLrB/lEU=
X-Google-Smtp-Source: AK7set9vJE70AagHNR0eFpYKeWUME1+H0riWJ/S8+/woOfeO/PElcAF45e8LlpKKRJq3Nev1K+B7Tg==
X-Received: by 2002:a17:906:9144:b0:878:7eb7:3488 with SMTP id y4-20020a170906914400b008787eb73488mr5843739ejw.21.1674857856018;
        Fri, 27 Jan 2023 14:17:36 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id e11-20020a1709062c0b00b0087bd629e9e4sm1513905ejh.179.2023.01.27.14.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:17:35 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add power controller node
Date:   Fri, 27 Jan 2023 23:17:34 +0100
Message-ID: <4773605.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20230126063419.15971-4-samuel@sholland.org>
References: <20230126063419.15971-1-samuel@sholland.org>
 <20230126063419.15971-4-samuel@sholland.org>
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

Dne =C4=8Detrtek, 26. januar 2023 ob 07:34:19 CET je Samuel Holland napisal=
(a):
> The Allwinner D1 family of SoCs contain a PPU power domain controller
> separate from the PRCM. It can power down the video engine and DSP, and
> it contains special logic for hardware-assisted CPU idle.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes in v2:
>  - Include a patch adding the device tree node
>=20
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> 3723612b1fd8..6fadcee7800f 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -799,6 +799,14 @@ tcon_tv0_out_tcon_top_hdmi: endpoint {
>  			};
>  		};
>=20
> +		ppu: power-controller@7001000 {
> +			compatible =3D "allwinner,sun20i-d1-ppu";
> +			reg =3D <0x7001000 0x1000>;
> +			clocks =3D <&r_ccu CLK_BUS_R_PPU>;
> +			resets =3D <&r_ccu RST_BUS_R_PPU>;
> +			#power-domain-cells =3D <1>;
> +		};
> +
>  		r_ccu: clock-controller@7010000 {
>  			compatible =3D "allwinner,sun20i-d1-r-ccu";
>  			reg =3D <0x7010000 0x400>;





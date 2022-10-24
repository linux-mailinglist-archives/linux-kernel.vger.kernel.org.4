Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699360AEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiJXPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiJXPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:24:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39922222A2;
        Mon, 24 Oct 2022 07:09:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a5so18625019edb.11;
        Mon, 24 Oct 2022 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYELRxnF68XUio0gSClzK4PTdwPd5dSjsPZvf3akxvw=;
        b=g35ZrmlqtuiI2gLfeTeMpXJZ3kCVRvy8RnV753qcsjIGK4bSlryu6Z391pafv17Nr+
         AB6dRZ6NfBBEtEe+LSEy9pS26cjY0KUif1dHZUEuAQgUWVKQvz6PmQzufD/UGapS5BFm
         wCdOhJWM606avxkmmZtdJ5wPTGgCiccYw0zmNsJkHc0QG2yU9eKRcpY//pPDTlpeLQut
         q8xcqdxbJotTcTRM2drgrOtT4KEjqQDNTAqWXL74fyP5xTrl4DQsZ2eYtfyatlGE829F
         axp5yZnSmgBErmT1aoedhX6/0z9gKrcU4WpU148Z/FYHavFe1/pxKPNwGjfs4HesXk+o
         mdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYELRxnF68XUio0gSClzK4PTdwPd5dSjsPZvf3akxvw=;
        b=vBcJ1Bq51eGbfHDUAhv9SXtK+gQqnPVtbU1/Z5isfukkwQL6MfaigCOVGdXyXsIf9T
         dqja35FcmkIxqB3/5b4NICUIvpu5oOCR2HCfThUN932M1h1CoFh6FiRNC6P5z/qhUy9H
         uiJ7hfL7jSANalW4xI0BuWdO09ki3ScxHEUwzbCdNritwC2anPo9ObAz6XVt/JyIRXsM
         arbRNKpqP+TrByePx96PeFRBPpsTXSXS1L0+k05/2Fhz1FEtL6Lf1/5xNrd+cBlk4C83
         N4Rpf7pQMTvSirJbLD9muJqfGCnjgTU5oSD89B2lr7dJKLCIRI4BG2uzBK2g/HnOm2+4
         4X6w==
X-Gm-Message-State: ACrzQf3NQ+KySp0yxKpeeRXU0YPtjkpbPODurTKgHzHnb3zQwVkQzBql
        LKXOfI2vktFIIn2nQxAtsxadv8GV/Y4=
X-Google-Smtp-Source: AMsMyM5kzXA9S+Kqkq44HNjvQWOrAElJsiMmpkEv4LVxapTlW4dy6xbooM/GzTxh0y6IrOQrRPYY0g==
X-Received: by 2002:a05:6402:528a:b0:454:8613:6560 with SMTP id en10-20020a056402528a00b0045486136560mr32011321edb.252.1666619578495;
        Mon, 24 Oct 2022 06:52:58 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b0077f4f63a6f4sm15617587ejc.112.2022.10.24.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:52:57 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:52:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com, anrao@nvidia.com
Subject: Re: [PATCH v3] arm64: tegra: Add Tegra234 SDMMC1 device tree node
Message-ID: <Y1aYt6mvD9NCPc9C@orome>
References: <7bf3f70a-4af6-c62a-75fc-89591d5de04b@linaro.org>
 <20221007165941.16539-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzwNODuKfDHQoYpG"
Content-Disposition: inline
In-Reply-To: <20221007165941.16539-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzwNODuKfDHQoYpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 10:29:41PM +0530, Prathamesh Shete wrote:
> Add device tree node for Tegra234 SDMMC1 instance.
> Add and enable SD card instance in device tree.
>=20
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  7 +++
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 60 +++++++++++++++++++
>  2 files changed, 67 insertions(+)

Applied, with some minor changes (see below).

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/a=
rm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
[...]
> +		mmc@3400000 {
> +			compatible =3D "nvidia,tegra194-sdhci", "nvidia,tegra234-sdhci";
> +			reg =3D <0x03400000 0x20000>;
> +			interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&bpmp TEGRA234_CLK_SDMMC1>,
> +				 <&bpmp TEGRA234_CLK_SDMMC_LEGACY_TM>;
> +			clock-names =3D "sdhci", "tmclk";
> +			assigned-clocks =3D <&bpmp TEGRA234_CLK_SDMMC1>,
> +					<&bpmp TEGRA234_CLK_PLLC4_MUXED>;

I've aligned these.

> +			assigned-clock-parents =3D
> +					  <&bpmp TEGRA234_CLK_PLLC4_MUXED>,

And put this on the previous line. checkpatch's character/row limit is
100, so let's use that.

> +					  <&bpmp TEGRA234_CLK_PLLC4_VCO_DIV2>;

> +			resets =3D <&bpmp TEGRA234_RESET_SDMMC1>;
> +			reset-names =3D "sdhci";
> +			interconnects =3D <&mc TEGRA234_MEMORY_CLIENT_SDMMCRA &emc>,
> +					<&mc TEGRA234_MEMORY_CLIENT_SDMMCWA &emc>;
> +			interconnect-names =3D "dma-mem", "write";
> +			iommus =3D <&smmu_niso1 TEGRA234_SID_SDMMC1A>;
> +			pinctrl-names =3D "sdmmc-3v3", "sdmmc-1v8";
> +			pinctrl-0 =3D <&sdmmc1_3v3>;
> +			pinctrl-1 =3D <&sdmmc1_1v8>;
> +			nvidia,pad-autocal-pull-up-offset-3v3-timeout =3D
> +								      <0x07>;
> +			nvidia,pad-autocal-pull-down-offset-3v3-timeout =3D
> +									<0x07>;
> +			nvidia,pad-autocal-pull-up-offset-1v8-timeout =3D <0x06>;
> +			nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D
> +									<0x07>;

Same here.

Thanks,
Thierry

--wzwNODuKfDHQoYpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNWmLcACgkQ3SOs138+
s6EPEhAArCthFJLRizBNMafRPRLeQdIn4Fb+3scor6my0Cmpk/H+g/axmMjnheIz
H2rFrVY8wo6EYi94ronDAdo0V5K2n7EMROdxeQy3oCbh2Iuo/TUiDbN6vgWQ9Xh1
ODDbc1DoEtS0ZRZj42DrjSENHUu3nM0Xim6wG0FxTWVJoDhHpCymw4jSe0HbZ9eu
rfnOXV1MGDw9RJQMhM6uoKUUgZzW6aNEHcVAHpvJ25G22kaV79pVQjzoXP7UuuOD
gckurjIZNz5iFvUTy8mJErcJms8txPg0kAEuEsAv/WtG5Hg0NMcSABOweJ6t87em
oVyuqVgAmO1xaXLxUbN0Sqs0n/8ca3J+1uguOB5chcuBIBcDbcQA7x+LZixEsS2S
uTMGBzCc7p9x36orTaqwRG8trFcINFmg68SVYJHiKbK4XNDJm505AJl8stlXNi1B
PwjeV/Cx/wLUoCpa06Xh7/3nQTW+KkL4gk0JRWlo9fsu32PhhwqRnSRENnIyq4oY
gIyEMLi2jt6mHojhJiYjS9JlPlMqLT+cjdyoiG/9A1cTtl9xokU3c0u0JgHZ3hUQ
B4sBeMEGU9VpdF/1fLUixzm2qvLCxprxKtXaAeiOzdPX2K9IcTp3L8xTGHw+OAhb
enofWbQ50GFh2bpuOkjWkQV7b0uHobQt90k7yZvWHpVw8O06o4k=
=YLVL
-----END PGP SIGNATURE-----

--wzwNODuKfDHQoYpG--

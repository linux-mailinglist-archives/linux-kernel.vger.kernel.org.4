Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4386B6BAB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCOIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCOIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:54:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4837113C9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:54:41 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2E31241B6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678870480;
        bh=HiWu2W94YYgRN40iF7FPu1SrLEkU/cI9C2mh8nOQZeA=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vOrjwafSqdM0RG4tkNFkrfoDmol0983zWXwUvyNNb6dmeiOq5653a5NM78ax/SsPt
         bp8EADdU3Z/e5b832dJ2uhO/Bahi3gowf5ADdMJhm1uv4sPQcBD2K/LaUFyM7d+gzp
         guWsTJleCKtjQKEK/Q3qBgsAD/h6voz3V5BQqd1T59EbXgPx+I2rm7dP2YyvOybQ2e
         BHcwUEQ2kYCReJ4rHmydxXZ4Ohi/1gHkEhjpK4pUkuvhAc0Ut6y9CMX/InLUGhDsJo
         pHoCYKAaIuS7PMcIUi9XJ2Wl7a8fo1rIu6T6Q6LRSibXmGzTS/MIyOtrGnTBpO8FQp
         gHHRu6V0+A/Gg==
Received: by mail-ed1-f69.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso26111906edt.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870479;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiWu2W94YYgRN40iF7FPu1SrLEkU/cI9C2mh8nOQZeA=;
        b=PsDO0Hlw2wv6jvZcQc8byhXQuBJS2ttvD11ZKp4/Bni0/DhSrBojhSUoWYUeUpGeXx
         eQx04Z/IyXTGMMFb19Xs2vkyV8cvPYZBoefr6NS9CivOLkUzeINItMUak7PD7/ThKEJ/
         CgE9QH06eLfRsix0P1Qhvjz9xFJmwrREs+ZJdskIxREfDE0ydfy+LHAPBhfmZ4Ho473I
         NEmKXNEVXdwdvL2oMnYBRBVTu44A4VX3vrqf64AN7iBU9rCbvTfz1hIsirYB51Q/NKTC
         uSLT6FlqtpaKQSnYqAstz4dx9CkJAYlE7P5x4jqNOzRkOC6NnD2QiubgOJgMv5siXhGG
         IHig==
X-Gm-Message-State: AO0yUKXXl6Dxn4n3gKgcxjm9VnZCZo8ixghiWfGh9UkMcKz8Y/IZDAYi
        7SbRtUbmy00Asjrhv8CiRfvq+ZH4F6QWXGEpcak9byIvVRYcVuECEJXljbUm4i2bK8jwI0QQF1U
        fejEnc2CXWsr5h/fAFwTPPtwSlagLWxCsWJrQwtfscg==
X-Received: by 2002:a17:906:2971:b0:881:23a:aba5 with SMTP id x17-20020a170906297100b00881023aaba5mr4890297ejd.11.1678870479811;
        Wed, 15 Mar 2023 01:54:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set/qa2HuVSNOw2hf3XmUa+m93olZa39OcmpjpQyaKyLZ0fcVXpPF+zL/J0+fHonODOddvRRVLA==
X-Received: by 2002:a17:906:2971:b0:881:23a:aba5 with SMTP id x17-20020a170906297100b00881023aaba5mr4890279ejd.11.1678870479505;
        Wed, 15 Mar 2023 01:54:39 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id m4-20020a509304000000b004fccef39ec9sm2048413eda.70.2023.03.15.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:54:38 -0700 (PDT)
Date:   Wed, 15 Mar 2023 09:54:37 +0100
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <johan@kernel.org>,
        <mani@kernel.org>
Subject: Re: [PATCH 1/3] drm/msm/adreno: Add Adreno A690 support
Message-ID: <20230315095437.187ac10c@gollum>
In-Reply-To: <20230315095008.7d650ebe@gollum>
References: <20230208034052.2047681-1-quic_bjorande@quicinc.com>
        <20230208034052.2047681-2-quic_bjorande@quicinc.com>
        <20230315095008.7d650ebe@gollum>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GGWg/YjOnTQy0UNl1WNw7rd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GGWg/YjOnTQy0UNl1WNw7rd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index ca38b837dedb..437515e46e5a 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -355,6 +355,20 @@ static const struct adreno_info gpulist[] =3D {
> >  		.init =3D a6xx_gpu_init,
> >  		.zapfw =3D "a640_zap.mdt",
> >  		.hwcg =3D a640_hwcg,
> > +	}, {
> > +		.rev =3D ADRENO_REV(6, 9, 0, ANY_ID),
> > +		.revn =3D 690,
> > +		.name =3D "A690",
> > +		.fw =3D {
> > +			[ADRENO_FW_SQE] =3D "a660_sqe.fw",
> > +			[ADRENO_FW_GMU] =3D "a690_gmu.bin",
> > +		},
> > +		.gmem =3D SZ_4M,
> > +		.inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > +		.init =3D a6xx_gpu_init,
> > +		.zapfw =3D "a690_zap.mdt",
> > +		.hwcg =3D a690_hwcg,
> > +		.address_space_size =3D SZ_16G,
> >  	},
> >  }; =20
>=20
> This needs
>=20
> MODULE_FIRMWARE("qcom/a660_sqe.fw");
> MODULE_FIRMWARE("qcom/a690_gmu.bin");
> MODULE_FIRMWARE("qcom/a690_zap.mbn");


Eek. That should be

MODULE_FIRMWARE("qcom/a690_zap.mdt");


>=20
> ...Juerg
>=20
>  =20
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.h
> > index b4f9b1343d63..da29bd392388 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -55,7 +55,7 @@ struct adreno_reglist {
> >  	u32 value;
> >  };
> > =20
> > -extern const struct adreno_reglist a615_hwcg[], a630_hwcg[], a640_hwcg=
[], a650_hwcg[], a660_hwcg[];
> > +extern const struct adreno_reglist a615_hwcg[], a630_hwcg[], a640_hwcg=
[], a650_hwcg[], a660_hwcg[], a690_hwcg[];
> > =20
> >  struct adreno_info {
> >  	struct adreno_rev rev;
> > @@ -272,6 +272,11 @@ static inline int adreno_is_a660(struct adreno_gpu=
 *gpu)
> >  	return gpu->revn =3D=3D 660;
> >  }
> > =20
> > +static inline int adreno_is_a690(struct adreno_gpu *gpu)
> > +{
> > +	return gpu->revn =3D=3D 690;
> > +};
> > +
> >  /* check for a615, a616, a618, a619 or any derivatives */
> >  static inline int adreno_is_a615_family(struct adreno_gpu *gpu)
> >  {
> > @@ -286,7 +291,8 @@ static inline int adreno_is_a660_family(struct adre=
no_gpu *gpu)
> >  /* check for a650, a660, or any derivatives */
> >  static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
> >  {
> > -	return gpu->revn =3D=3D 650 || gpu->revn =3D=3D 620 || adreno_is_a660=
_family(gpu);
> > +	return gpu->revn =3D=3D 650 || gpu->revn =3D=3D 620  || gpu->revn =3D=
=3D 690 ||
> > +	       adreno_is_a660_family(gpu);
> >  }
> > =20
> >  u64 adreno_private_address_space_size(struct msm_gpu *gpu); =20
>=20


--Sig_/GGWg/YjOnTQy0UNl1WNw7rd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmQRh80ACgkQD9OLCQum
Qrc2YRAAjOTspDuzpGhFACIBgWLDaVOfk/W1mrvvof8VG9j+tV3MeQPlcP9ynWRL
QFf2w9eNJPchsd6B0kZOcmA3UnSna4pjYoB4opW777d45QTSowdI9LjH8+XUXQbd
At9jc+1436AGoz5v3skB+1moSlzBG85y6r0tYG7GJ8jdm3b8iWydDr9j3yKPHvtK
qgqEB54MasKNBVl9DBo9Ug6zP7t4QLliwMbgLUe1yQXZFMLWQaHRPwCZnJ2M/Vo3
O/Xay7M/kjBXDzLCHv5HzrA3Cb0q5kS8yvdUrYN9F/mi3wc92ApSN57KTJzybkuS
gSguyERQclupty7/pBqYoJe2iTdMfYufAROsTan49q7cKFJW9la7PyV3yNOLa2EH
mavRY+Kl0T9Mr2pXqJ/6c/N3Jb27bjjq2xHejYyXpCI2NkmSMktrSDD47sgOAW4L
qR98YOrchNgW/XGYEDOFxQT8hGbFOiyZac0PU/qm5/yTXxHM7RWo9v2gux9UXjRt
p3Ln2/p8OfOFZCdYp3eXS1XDLFFbkxGOqXbUOf2mhnUvSVvMtrLIg00h8Lxqj8jE
15Hie6b47X6shyTyhm1u2rs6Q8Dw/b88//VOUBQuHHWBaSdYsd7+gH/gK0LG+CQS
sE99KAtdaT8xN15xO+3r42kRvn5E/Qu3q8qeI0oGWCUyxJ8tjkg=
=54KF
-----END PGP SIGNATURE-----

--Sig_/GGWg/YjOnTQy0UNl1WNw7rd--

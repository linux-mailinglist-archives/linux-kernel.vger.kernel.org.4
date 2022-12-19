Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4D65140C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiLSUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiLSUhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:37:33 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFEA63C7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:37:32 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id i20so9311106qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D121soTYfgdsSiMhqDo8vXYbl/2/UB4vZ7pkm+XbiQI=;
        b=KAx+X75c2L8IRTwtnT6HXVcOR3BXZjT7XpmjTK8mxw+h17ed9ekmlGtYac4lRZznaz
         w5eaXCjP8zJCDz4NgPFI3L6sVD7Y/tzL42HHbi80o1REoVsOiYssHbc+M2EMMiscGncU
         BU9jIjgMZfDUd/KvhAg+6+y4UyOoRM7qAjvqJRdNT41YJ9HbWoSJJW7/6S06EWjJvvnl
         Z1Y+cOVNZ3vlCib2fCy3+pxcID1wxbEnIi29E6cpM+NUBDIvAOaYSQYNl1Q3JkPuNBQg
         jDQe/bkLJWIGVDBxkls+AkK5YJL8VyhT3fIi+dmV3iogxvoKJAX9HIhbQ50e1xiH1QJL
         SRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D121soTYfgdsSiMhqDo8vXYbl/2/UB4vZ7pkm+XbiQI=;
        b=HK+x1y9RDsIfXcy7+XUTc6H2hzGltWRe1/Tv4THHVWTzbN1jMRzfRqtSQtdCfVZsDf
         hDPqNAeSblTHbGqCZPlzMbGV7HP5uwU7vmGqB63IPamO3PNwlyBN7BGPbOe5+hW6iHs0
         b/3zbOL9FCoZniVeN+xMADnv4V5hmJ2hp3cry0v2ZktKAIOj8wbnuSUiKmP03kiMIQTj
         O9MeUQfnpl8IMrIDMi33aUyyONUHrQ1nvSu0JJDQ4N6Unhzz7ncvJuBns/8UmM2dRqKk
         Buj0YWJnr426rdBlueg882XVLzra42ocjWxCccVxkKpKn2Hgp3UauCrzqdp6+33xpeBX
         rRZw==
X-Gm-Message-State: ANoB5pneZJQ4UMD7m7QeRMVUWJpCdwFy6LldUgEFSxDATJ5KIrNrp4/7
        tlES4gxXlVEHQInUc4m/0REDkg==
X-Google-Smtp-Source: AA0mqf4PjjR5YuPxd2C/7IlPqSW9LZaOvKOAJv5OLtKXoi+ebxjd5U92/z0usQVACJUbXl0WNxlbLA==
X-Received: by 2002:ac8:4b58:0:b0:3a7:f3c4:dcd1 with SMTP id e24-20020ac84b58000000b003a7f3c4dcd1mr55927556qts.23.1671482251893;
        Mon, 19 Dec 2022 12:37:31 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id c3-20020ac80543000000b003a6a7a20575sm6580988qth.73.2022.12.19.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:37:31 -0800 (PST)
Message-ID: <07747babe7f83a496f9cd82849c6c2386550ac28.camel@ndufresne.ca>
Subject: Re: [PATCH v1 3/9] media: verisilicon: Save bit depth for AV1
 decoder
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Mon, 19 Dec 2022 15:37:30 -0500
In-Reply-To: <20221219155616.848690-4-benjamin.gaignard@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-4-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 19 d=C3=A9cembre 2022 =C3=A0 16:56 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> Store bit depth information from AV1 sequence control.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 4500e1fc0f2c..8e93710dcfed 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -324,6 +324,25 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
> =20
> +static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx =3D container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_AV1_SEQUENCE:
> +		ctx->bit_depth =3D ctrl->p_new.p_av1_sequence->bit_depth;

That seems a little be weak, what happens if you change the bit_depth with =
a
non-request s_ctrl while its decoding ? To be this deserve a little bit of
protection, a something that validate and copy it at the start of the decod=
ing.

p.s. I know, VP9 seems similar, though arguably that was copied from jpeg, =
for
which it seems totally save to change the quality at run-time.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static const struct v4l2_ctrl_ops hantro_ctrl_ops =3D {
>  	.try_ctrl =3D hantro_try_ctrl,
>  };
> @@ -336,6 +355,12 @@ static const struct v4l2_ctrl_ops hantro_vp9_ctrl_op=
s =3D {
>  	.s_ctrl =3D hantro_vp9_s_ctrl,
>  };
> =20
> +static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops =3D {
> +	.try_ctrl =3D hantro_try_ctrl,
> +	.s_ctrl =3D hantro_av1_s_ctrl,
> +};
> +
> +
>  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>  					 V4L2_JPEG_ACTIVE_MARKER_COM | \
>  					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -513,6 +538,7 @@ static const struct hantro_ctrl controls[] =3D {
>  		.codec =3D HANTRO_AV1_DECODER,
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_AV1_SEQUENCE,
> +			.ops =3D &hantro_av1_ctrl_ops,
>  		},
>  	}, {
>  		.codec =3D HANTRO_AV1_DECODER,


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912D6513EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLSU3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiLSU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:28:52 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E7F8FD3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:28:50 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c7so9287483qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PECBBcrgpKAeHwq8TDeEP5JS5G3rnettIaoWdcM7j1Y=;
        b=W1blpq5+a9QGCDuj+ebjQo6UJdZOn1UG0Be52m8UmMOlWV4eArUHbQrV4nAvUDk3uK
         18Hd+tT1f90ljLLwwdiOXB/JrVt5gydloMRTRgFVzWBZYCrnIzZUQQME1rnbNYnmV3U+
         wKEJPFpa8x7FhOjyGiPqa7l6pNJqQMNyIWU+4WF56yCJvAR86MYf/XlzeUKaAAZQJ4xG
         lnjJJW/qdGxtKxk2QSd/tRh+foWvzkpNEC+XRtPkD4NrcjRVaq/apzufNhPgoREKu08a
         D42j5OURe9wKigUsFZBsQhrbkB1DNeTkFbLWtjvHQT2jhHLvlAa7KfPCiNqN02EYqckP
         tjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PECBBcrgpKAeHwq8TDeEP5JS5G3rnettIaoWdcM7j1Y=;
        b=y16TkLdywMJ3PW9zRzm+b5bFxApDKTjWKG1HpXzOBNo+oE0qkxSBJlU4U2HEUs4xai
         i84zrqwXuP3gareuIJdHTVK4dfdi0zjE9XlH4HdBK1QxzA6vO5QO4CT8mpENwndcyCvA
         p/Qyj1mcc/4wcYaBP7xj7BUYaruP76fToWjgbUnqz7r+ueZoA4tW0f66e+pLqg1SSQrw
         H7hGL/MtzRyRtkfVEJHv1gBnyP64n4gXhIX6w8MpH+6zinsw9jI017KonRQcXu0tWMv0
         vkShsy/HNt+2IZkrpY7rXn5/Ct+HpvXnfGgKlVcrYeTaDLf/fxQFehfsWa2rdKU+XmkC
         81Fg==
X-Gm-Message-State: ANoB5pmgYDXN35ReqsryuE09rFpYaZ+lRL1Mm8pWb1899vtQLHBhqa2h
        MBsUsxYjzb2CIeOxOfisEe1bWA==
X-Google-Smtp-Source: AA0mqf6aOuki7WAAYbi0dAxo2ur7bA3i9IwDBkMk78Jl1dEcj+6GgwyewWvr3HhJZnhoPSQ/KnGKMA==
X-Received: by 2002:a05:622a:5085:b0:3a7:e110:81e5 with SMTP id fp5-20020a05622a508500b003a7e11081e5mr54094898qtb.53.1671481730077;
        Mon, 19 Dec 2022 12:28:50 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id r3-20020ac85e83000000b0039953dcc480sm6478803qtx.88.2022.12.19.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:28:49 -0800 (PST)
Message-ID: <ab54d584ce30b99ace048da9b9c9ee317df1a5c5.camel@ndufresne.ca>
Subject: Re: [PATCH v1 2/9] media: verisilicon: Add AV1 decoder mode and
 controls
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Mon, 19 Dec 2022 15:28:48 -0500
In-Reply-To: <20221219155616.848690-3-benjamin.gaignard@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-3-benjamin.gaignard@collabora.com>
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
> Add AV1 decoder as new decoder mode to Hantro driver.
> Register needed AV1 controls for the decoder.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/hantro.h   |  3 +++
>  .../media/platform/verisilicon/hantro_drv.c   | 21 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/=
platform/verisilicon/hantro.h
> index 2989ebc631cc..61480825b856 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -38,6 +38,7 @@ struct hantro_postproc_ops;
>  #define HANTRO_H264_DECODER	BIT(18)
>  #define HANTRO_HEVC_DECODER	BIT(19)
>  #define HANTRO_VP9_DECODER	BIT(20)
> +#define HANTRO_AV1_DECODER	BIT(21)
>  #define HANTRO_DECODERS		0xffff0000
> =20
>  /**
> @@ -111,6 +112,7 @@ struct hantro_variant {
>   * @HANTRO_MODE_VP8_DEC: VP8 decoder.
>   * @HANTRO_MODE_HEVC_DEC: HEVC decoder.
>   * @HANTRO_MODE_VP9_DEC: VP9 decoder.
> + * @HANTRO_MODE_AV1_DEC: AV1 decoder
>   */
>  enum hantro_codec_mode {
>  	HANTRO_MODE_NONE =3D -1,
> @@ -120,6 +122,7 @@ enum hantro_codec_mode {
>  	HANTRO_MODE_VP8_DEC,
>  	HANTRO_MODE_HEVC_DEC,
>  	HANTRO_MODE_VP9_DEC,
> +	HANTRO_MODE_AV1_DEC,
>  };
> =20
>  /*
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..4500e1fc0f2c 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -498,6 +498,27 @@ static const struct hantro_ctrl controls[] =3D {
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_VP9_COMPRESSED_HDR,
>  		},
> +	}, {
> +		.codec =3D HANTRO_AV1_DECODER,
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_AV1_FRAME,
> +		},
> +	}, {
> +		.codec =3D HANTRO_AV1_DECODER,
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY,
> +			.dims =3D { V4L2_AV1_MAX_TILE_COUNT },
> +		},
> +	}, {
> +		.codec =3D HANTRO_AV1_DECODER,
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_AV1_SEQUENCE,
> +		},
> +	}, {
> +		.codec =3D HANTRO_AV1_DECODER,
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_AV1_FILM_GRAIN,
> +		},
>  	},
>  };
> =20


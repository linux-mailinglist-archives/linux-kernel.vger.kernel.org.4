Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7741D6685A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbjALVic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbjALVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:37:37 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A17FCC7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:30:00 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v127so16038243vsb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwy7mU0+l0AiZhA6hxeiY5zRnp3tXsX024ZI6mo01Ec=;
        b=wJSsshJi1QQUz/sGl6b2s1K8zWrRANk8pR+jycMKTpQ/gRPtZr1NrQekYtuFzroOlF
         KlxlNQPu7gwEGhl08Z41WcgmBi5QyyicUGlNb5N3dES4WWfTqJmejRScYZvXpr6+/zM2
         yTm7azIKE6DIbqxEm0H91tg5Nq7EIc/QZPbB1RgHURxNA4M4Vs08mx1tNbsY6RauQgqf
         fd8hABuUaGZQRIe+4erkCZtZIz19RKZ0ChhOzzzDz180lSSuVC8ryEpfkyEKfJziST6W
         EuEOECDgsQ6oa7kqBFAXscQkcc/iUfwnuNC6AKq6vWOPDUUlK8lLUJgQPGMg/yiDESqo
         vTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwy7mU0+l0AiZhA6hxeiY5zRnp3tXsX024ZI6mo01Ec=;
        b=1Zi6LGjeNinPvBkbePw9lrbMAk89gnECpSIOCtsq4Y67sarW2g1avDel9xZwPpdkDg
         tJxzybVk0XzTOAvVsux2m29cQmqcBj4YpVtsZgnIo6dsBoze2RlWwjQxKpXrbxNRM/yj
         q31yQbARx64rTLP8CWTsvhVin9mr/1rH4aWOe73ZZ3CQeCEoNMc5CedGP65/p1ugCVPr
         GVrmsBMVlR3iqPTOSNMmpz0tK25KAFOKTsU0sul4oYp8+2HfDpuu6GggszTnTnL9x3ed
         NcRqiIvPwyqZk8vP62a7go1fq4ZALgFJDlw2jEKl5c9WbvNtCnn0SNSwKHHT90NyOfHI
         888w==
X-Gm-Message-State: AFqh2kqKR89zPnW3SPW4FkK7BhNqUGolRQ3mpaSmMx9i0pgU4ybML7eY
        0CWws5cIfNdC0kZLxJd6NYo8kg==
X-Google-Smtp-Source: AMrXdXtXtA8Qby03OHi5tcAPMXq0UXNFP9YdKTxQGJYPz9FXBicVZcD69h3SC8TDiGqntscDHIT6Lg==
X-Received: by 2002:a05:6102:158c:b0:3c6:d639:f1ac with SMTP id g12-20020a056102158c00b003c6d639f1acmr34115219vsv.22.1673558999315;
        Thu, 12 Jan 2023 13:29:59 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b006fc2f74ad12sm11655317qkn.92.2023.01.12.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:29:58 -0800 (PST)
Message-ID: <d841827840b0a33b424d91aea46af33d30f5de7c.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/2] media: add RealVideo format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 12 Jan 2023 16:29:56 -0500
In-Reply-To: <ef8212602467151a6e20ccce3e7ef7adcd7a7c91.1673514352.git.ming.qian@nxp.com>
References: <cover.1673514352.git.ming.qian@nxp.com>
         <ef8212602467151a6e20ccce3e7ef7adcd7a7c91.1673514352.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

Le jeudi 12 janvier 2023 =C3=A0 17:18 +0800, Ming Qian a =C3=A9crit=C2=A0:
> RealVideo, or also spelled as Real Video, is a suite of proprietary
> video compression formats developed by RealNetworks -
> the specific format changes with the version.
> RealVideo codecs are identified by four-character codes.
> RV10 and RV20 are the H.263-based codecs.
> RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.
> RV60 is RealNetworks' proprietary HEVC-based codecs.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-compressed.rst     | 11 +++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
>  include/uapi/linux/videodev2.h                        |  1 +
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index a0230f357680..22035d92c788 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -237,6 +237,17 @@ Compressed Formats
>          Metadata associated with the frame to decode is required to be p=
assed
>          through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>  	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
> +    * .. _V4L2-PIX-FMT-RV:
> +
> +      - ``V4L2_PIX_FMT_RV``
> +      - 'RV00'
> +      - RealVideo, or also spelled as Real Video, is a suite of propriet=
ary
> +        video compression formats developed by RealNetworks -
> +        the specific format changes with the version.
> +        RealVideo codecs are identified by four-character codes.
> +        RV10 and RV20 are the H.263-based codecs.
> +        RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.
> +        RV60 is RealNetworks' proprietary HEVC-based codecs.

Much better description. Though you haven't commented or addressed my conce=
rn of
having 4 different CODECs under the same FMT. I thinks it would make more s=
ense
to export the four of them. Then driver can pick the set they support,
regardless if it requires special handling of not at the HW level. What do =
you
think ?

Even though unlikely considering the age of the CODECs, but having a single=
 FMT
for an encoder would just increase the encoder interface complexity (could
require a control to select which actual format to encode to).
> =20
>  .. raw:: latex
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 9b5b04b8aa69..c375261d169f 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1473,6 +1473,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_FWHT:		descr =3D "FWHT"; break; /* used in vicodec *=
/
>  		case V4L2_PIX_FMT_FWHT_STATELESS:	descr =3D "FWHT Stateless"; break; /=
* used in vicodec */
>  		case V4L2_PIX_FMT_SPK:		descr =3D "Sorenson Spark"; break;
> +		case V4L2_PIX_FMT_RV:		descr =3D "RealVideo"; break;
>  		case V4L2_PIX_FMT_CPIA1:	descr =3D "GSPCA CPiA YUV"; break;
>  		case V4L2_PIX_FMT_WNVA:		descr =3D "WNVA"; break;
>  		case V4L2_PIX_FMT_SN9C10X:	descr =3D "GSPCA SN9C10X"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 262ef10cfa02..0a7ddb023d7c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -740,6 +740,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 =
parsed slices */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC =
parsed slices */
>  #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenso=
n Spark */
> +#define V4L2_PIX_FMT_RV       v4l2_fourcc('R', 'V', '0', '0') /* RealVid=
eo */
> =20
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 Y=
UV */


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4A7406D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF0X3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0X3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:29:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39531730;
        Tue, 27 Jun 2023 16:29:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98e25fa6f5bso532283466b.3;
        Tue, 27 Jun 2023 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687908545; x=1690500545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTLlHzeVzmFSv260WpYR+JDo/t7d6UIr+DL3Zrgz+gI=;
        b=MkHxg/tRzu+NmFgdp1s8QcOlR/T5IbnMvr1QgwOX+u1t8EhB3hyizP2RpgcAG4vC3T
         ajsAC6ZaRgIn5odaiyB8hp3/6KBnuY7AQ/TOScjabepxp0GB8A8c6/PoSC9B6QOIQUcO
         6bPZl3rOiv0juGAr9xklhl//cvoyXntTnJJnVt9TGCdZVYStALoS7Oc5Un8FlOn/zEXA
         ajZg3DCYgnVNBP+tkGjoKfAXOEiX1dnz1Z1pNzq3xVGiu2MJjo5+Om2xyVgsvt6gQ2xA
         DeAXgUFRw0cv9YH9VbPjLpvIga4kGtKwFa/wfBfBOXOjGsvaanWcjO3XYHOtpV5g8dTZ
         pWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687908545; x=1690500545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTLlHzeVzmFSv260WpYR+JDo/t7d6UIr+DL3Zrgz+gI=;
        b=k6Doy13hDKFY6xUyZUmXixMl8GEpEA9uZAqWZE8vWy0AKMu00afT3gbtIdHT0XRpJM
         XTgfkHUprUZzI341t34hX0LHjXZYrxI5VP/MAutULzL/580/XJXFlSHiA0inVvNDkPvg
         pyPqnQh3L7o+LGHiSHQyXSvjzbYmwFlyUqWoZZ6LSDFp/WjWEuOCmuteO5gL4BBfN5F/
         2pGX2aCp+norOm9jawl6RqtOZxBearvOAerMwTg6Ie8oNcLfO0M9sbk47Kmnx++D8DPb
         rAAQB4iid8VA8LszAOp6f2QqCIctJyKTLj7HWEjQxHT1GTkGjY8kLoWYUxSrOdBFJbmS
         82dQ==
X-Gm-Message-State: AC+VfDzPs7UMvok9gdU0EG8n1ymj57Etx30vtBQw+sZuxbma0pnaBA8v
        9AKjPJBrnT3JeNbnM495lQI5R50EutFyk/gw3b3tBnPEfVRzr8xJ
X-Google-Smtp-Source: ACHHUZ5Rigm/EiE5W1SPmoMMTSqZ/AjJAZooAxQh7MPBQadZiYJmF+ofcl6Kc3U2Dha6v/EoUNuG8B3KIvcjbuCkPZs=
X-Received: by 2002:a17:907:1b0b:b0:982:8ec0:15a3 with SMTP id
 mp11-20020a1709071b0b00b009828ec015a3mr29557553ejc.67.1687908545121; Tue, 27
 Jun 2023 16:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230627082731.1769620-1-yqsun1997@gmail.com> <20230627140640.GA3605278@gnbcxd0016.gnb.st.com>
In-Reply-To: <20230627140640.GA3605278@gnbcxd0016.gnb.st.com>
From:   sun yq <yqsun1997@gmail.com>
Date:   Wed, 28 Jun 2023 07:28:54 +0800
Message-ID: <CAA0BgY_Lj+hQdevrgK8y=wLztddnh+npP-hWz_XaPbi-5mzwnQ@mail.gmail.com>
Subject: Re: [PATCH] OOB read and write in mdp_prepare_buffer
To:     yqsun1997@gmail.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Because there are many functions using the plane, increasing the max
number of the plane is to maximize the solution to all possible oob
places.

On Tue, Jun 27, 2023 at 10:06=E2=80=AFPM Alain Volmat <alain.volmat@foss.st=
.com> wrote:
>
> Hi,
>
> On Tue, Jun 27, 2023 at 04:27:31PM +0800, yqsun1997@gmail.com wrote:
> > From: yqsun1997 <yqsun1997@gmail.com>
> >
> > Because format in struct img_image_buffer max index is IMG_MAX_PLANES =
=3D=3D3,
> > The num_planes max index is 8.so will be OOB like in mdp_prepare_buffer=
.
>
> Similarly as your other patch, could you describe why you need to
> increase the IMG_MAX_PLANES while I suspect your driver only needs to
> deal with 3 planes.  While the maximum num_planes value that can be
> given by the user is 8, this has to be first compared to the configured
> format prior to reaching this function.
>
> >
> > static void mdp_prepare_buffer(struct img_image_buffer *b,
> >                                struct mdp_frame *frame, struct vb2_buff=
er *vb)
> > {
> >         struct v4l2_pix_format_mplane *pix_mp =3D &frame->format.fmt.pi=
x_mp;
> >         unsigned int i;
> >
> >         b->format.colorformat =3D frame->mdp_fmt->mdp_color;
> >         b->format.ycbcr_prof =3D frame->ycbcr_prof;
> >         for (i =3D 0; i < pix_mp->num_planes; ++i) {
> >                 u32 stride =3D mdp_fmt_get_stride(frame->mdp_fmt,
> >                         pix_mp->plane_fmt[i].bytesperline, i);
> >
> >                 b->format.plane_fmt[i].stride =3D stride;  //oob
> >                 ......
> >
> > Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
> > ---
> >  drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h b/dri=
vers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> > index ae0396806..e2e991a34 100644
> > --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> > +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> > @@ -11,7 +11,7 @@
> >
> >  #define IMG_MAX_HW_INPUTS    3
> >  #define IMG_MAX_HW_OUTPUTS   4
> > -#define IMG_MAX_PLANES               3
> > +#define IMG_MAX_PLANES               8
> >  #define IMG_MAX_COMPONENTS   20
> >
> >  struct img_crop {
> > --
> > 2.39.2
> >
>
> Regards,
> Alain

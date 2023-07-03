Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A972874563F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGCHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGCHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:42:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB28C1;
        Mon,  3 Jul 2023 00:42:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b698937f85so67109061fa.2;
        Mon, 03 Jul 2023 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688370176; x=1690962176;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1fo/4xJmI/v8Apxv9iZE5rA9bnr+7LUJRY6uhOPxrs=;
        b=XTuXbF9NC0ZLUFLxZHbCrh3BmMosYZaCcPoeLni+PwhvONO2MBefRwIVdNhR75bJKG
         XwZKEo9RjfCO7OaaiKzfTjv7G9R17HRp6865LFsLPbmgEc4c1ju6/W9CIOzeuvxOp3im
         IRhzqK25pn8mJWiUqycZyFM/wAT24ZmeUrQaE5kt+P71VKOl4Yl7aqkS4Mw6Vr8WElKy
         lUoWAojpHSEyjyXzzCrdbUWhothijb5FFlUGYgKjbmF4NL3VOmX3/gM4WrEuIximSsrn
         egoeVN2r20c+4kVR/tD+nan5IcPTGaHA46PrObKU8JfE634aoogYUPucgBf066n8gZOh
         XJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370176; x=1690962176;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1fo/4xJmI/v8Apxv9iZE5rA9bnr+7LUJRY6uhOPxrs=;
        b=ls/Eh1nGOiCrMRxq513E45c38xzm8DTaYkaV+gFzxtctx/UuxyfVIJjmfhGnMxTRzd
         +N0l2shONa5FTmKHtayfIjkMczI276gwRSJKMoGxAxJ8E6Omc2pd/ylPzA0XcAdqZGiV
         BTQCTW+19g7GsY9hTZCVLpW2s8czEv718Unw6KB6TTVfUJHoZc9looClnc/XboCINS58
         sL4DByPziFLkg10twWh9aYakpzNuJ+0kvk5FkBemt8KFVftJr1cW0Y7d5caqIjUse4OR
         FzNuJ5kWPTHvU+Y9vvUEQzndJaWXoMbmqxHxtWrZXDx2VbIsK2ZQTpH/NQnjoy1PGq1e
         /m/A==
X-Gm-Message-State: ABy/qLbiYMkhRqQqaX4rmdm7xt0GUZrXoD6l/JfHhYBzUlHEz6w2wTKI
        /6R7covTAqz76E+AU3NIK8k=
X-Google-Smtp-Source: APBJJlEihHpYEQV3HBBUGCrGICtVF/Y3mrZuaF6KRazeMHpNXruNvJsym66J/DOXgm+zAeWs8K9cRw==
X-Received: by 2002:a2e:900e:0:b0:2b6:e121:cf68 with SMTP id h14-20020a2e900e000000b002b6e121cf68mr2760105ljg.5.1688370176174;
        Mon, 03 Jul 2023 00:42:56 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id o6-20020a2e7306000000b002b6e77e87fcsm704378ljc.68.2023.07.03.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 00:42:55 -0700 (PDT)
Date:   Mon, 3 Jul 2023 10:42:46 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <quic_abhinavk@quicinc.com>, <contact@emersion.fr>,
        <laurent.pinchart@ideasonboard.com>, <sebastian.wick@redhat.com>,
        <ville.syrjala@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>
Subject: Re: [PATCH RFC v4 7/7] drm/msm/dpu: Use DRM solid_fill property
Message-ID: <20230703104246.7226953a@eldfell>
In-Reply-To: <20230630112649.263331b4@eldfell>
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
        <20230404-solid-fill-v4-7-f4ec0caa742d@quicinc.com>
        <20230630112649.263331b4@eldfell>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=0TNTkoqRYefLA_rwhlpF9P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=0TNTkoqRYefLA_rwhlpF9P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jun 2023 11:26:49 +0300
Pekka Paalanen <ppaalanen@gmail.com> wrote:

> On Thu, 29 Jun 2023 17:25:06 -0700
> Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>=20
> > Drop DPU_PLANE_COLOR_FILL_FLAG and check the DRM solid_fill property to
> > determine if the plane is solid fill. In addition drop the DPU plane
> > color_fill field as we can now use drm_plane_state.solid_fill instead,
> > and pass in drm_plane_state.alpha to _dpu_plane_color_fill_pipe() to
> > allow userspace to configure the alpha value for the solid fill color.
> >=20
> > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_plane.c
> > index 4476722f03bb..11d4fb771a1f 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -42,7 +42,6 @@
> >  #define SHARP_SMOOTH_THR_DEFAULT	8
> >  #define SHARP_NOISE_THR_DEFAULT	2
> > =20
> > -#define DPU_PLANE_COLOR_FILL_FLAG	BIT(31)
> >  #define DPU_ZPOS_MAX 255
> > =20
> >  /*
> > @@ -82,7 +81,6 @@ struct dpu_plane {
> > =20
> >  	enum dpu_sspp pipe;
> > =20
> > -	uint32_t color_fill;
> >  	bool is_error;
> >  	bool is_rt_pipe;
> >  	const struct dpu_mdss_cfg *catalog;
> > @@ -606,6 +604,17 @@ static void _dpu_plane_color_fill_pipe(struct dpu_=
plane_state *pstate,
> >  	_dpu_plane_setup_scaler(pipe, fmt, true, &pipe_cfg, pstate->rotation);
> >  }
> > =20
> > +static uint32_t _dpu_plane_get_fill_color(struct drm_solid_fill solid_=
fill)
> > +{
> > +	uint32_t ret =3D 0;
> > +
> > +	ret |=3D ((uint8_t) solid_fill.b) << 16;
> > +	ret |=3D ((uint8_t) solid_fill.g) << 8;
> > +	ret |=3D ((uint8_t) solid_fill.r); =20
>=20
> solid_fill.r, g and b are uint32_t, yes?
>=20
> What's the value encoding in the UAPI? That doc was missing.
>=20
> I wouldn't expect the UAPI to use 32-bit variables if it was
> essentially 8-bit, so this conversion looks wrong.
>=20
> Nominal color value 1.0 in u8 is 0xff. The same in u32 is probably
> 0xffffffff? So a simple cast to u8 won't work. You'd want to take the
> upper 8 bits instead.
>=20
>=20
> Thanks,
> pq
>=20
> > +
> > +	return ret;

Btw. if your driver format is ABGR, then this function leaves alpha as
zero. That's confusing.

It would be nice to mention the exact pixel format in the function name
so the consistency is easier to check in both here and in callers.


Thanks,
pq

> > +}
> > +
> >  /**
> >   * _dpu_plane_color_fill - enables color fill on plane
> >   * @pdpu:   Pointer to DPU plane object
> > @@ -977,9 +986,9 @@ void dpu_plane_flush(struct drm_plane *plane)
> >  	if (pdpu->is_error)
> >  		/* force white frame with 100% alpha pipe output on error */
> >  		_dpu_plane_color_fill(pdpu, 0xFFFFFF, 0xFF);
> > -	else if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG)
> > -		/* force 100% alpha */
> > -		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
> > +	else if (drm_plane_solid_fill_enabled(plane->state))
> > +		_dpu_plane_color_fill(pdpu, _dpu_plane_get_fill_color(plane->state->=
solid_fill),
> > +				plane->state->alpha);
> >  	else {
> >  		dpu_plane_flush_csc(pdpu, &pstate->pipe);
> >  		dpu_plane_flush_csc(pdpu, &pstate->r_pipe);
> > @@ -1024,7 +1033,7 @@ static void dpu_plane_sspp_update_pipe(struct drm=
_plane *plane,
> >  	}
> > =20
> >  	/* override for color fill */
> > -	if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG) {
> > +	if (drm_plane_solid_fill_enabled(plane->state)) {
> >  		_dpu_plane_set_qos_ctrl(plane, pipe, false);
> > =20
> >  		/* skip remaining processing on color fill */
> >  =20
>=20


--Sig_/=0TNTkoqRYefLA_rwhlpF9P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSie/YACgkQI1/ltBGq
qqdvWg/+IUlRh8UhRQkQoJS25uUvPZS8VcXCmrgzoWzMxdliGqBuuBZYtX4eY1gZ
3E1nEhYylI4RoAF6JuNzoHaegBpK8TmFcx60sj1Y8WQnH6DlWni3FsF/+4T9jwbn
IZDcOl3oihEsOPZgtbHvnpJgpqyVrGG+C7hVIvlLK4j8ngn1FC9aj63mTlluInlS
ER82vqXHRw+QXOYiyj2XmrylS36mXTambq0iJKYQLLIEz0hJvN6ZEBjd06GZWJTW
8R24cX6zSTNC9jY4F7aL21i8eUqLLa79/lYQ+kkv28ClsH2xZGr2R2+KiaDVOYaR
7n74EWWIMyt/f2XYdkzM2K+TMF6P61/CZy9nfW74YeoPadI4oJV5x2Sta3RqtqPH
TpUmikI9n+LwSEqDjXGmxbI+/xAqt5sfpS0wgBH11tD7R0f41LB98aw6zPcxlR4e
n4Rvdpow8UpOZv7WSXkLjkU0qto8DOEHANhCUBPFwuqybjlPjvi7w0dNSs7K32xj
BQiDoBOz2c+8tfpo3KqjJmkxk0r/E0wDwqIh/N/j8Uit6mmbPH62lkwZYLLBkOkg
mPMDAB8wj1lHazzbGJnvTCCXnsWlNv1eNWGelRHlGFaL7DuQPRZReU1SDfjhU2sH
+DXeGFF7jsTt1Muzt/ol9LhgrHTWsP5N1DtGWayklopgc9nZhJU=
=OtQx
-----END PGP SIGNATURE-----

--Sig_/=0TNTkoqRYefLA_rwhlpF9P--

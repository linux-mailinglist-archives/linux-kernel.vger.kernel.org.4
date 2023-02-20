Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0069C757
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjBTJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBTJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:08:28 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93889ED5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:08:26 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h9so310117ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NutlO2ATmThTH22YhjGR8PNsMsgJdYkW73y3XZaI7VQ=;
        b=byi+PooNk3PIYIfAKwj6AKM4Nu65rFPUN4mG3M0RIs59vrXayVZF5qCd+YOf/e7jhI
         XIrPDDx9s8vDe/zyuVRLpZOk1bVcvF7Vph7dkSiDoMO94nMFo5lmWX7JrW+qN9+o/sWT
         NsBypwj0eS96DkJSGt03jlHcYk9hhLsb7q53Cn0gE03hpcaj/5mxZjZKtn/xAex55dJX
         FEKKa/eCa4PSQuuVrUeIuuzbwMoHENDXCGPH0I2IXQMhKixC73Ck3EsIj0ILDAXiAWTo
         zUNPp5dU6wlDBmNtgtbWi01PXN3jgWW8pU+bZoczbayMc5B60zpjkuPbQ1DAenrHhliZ
         38ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NutlO2ATmThTH22YhjGR8PNsMsgJdYkW73y3XZaI7VQ=;
        b=445icyuLRDxt3jGGcMwGgbNOaV0usaKs92hSy2VdHzsJ55K2bnSXULB652uTbk1sxt
         gZE3aZ6m2CUZ+kpGNrh6zj3i8/jUcKHnkKT8Qod9QCdkyOHsNnM5Dcoa1l7/6NBuBfmn
         M0nIJiLAW6nXC4RrEp80fKygc2GpbumkFDXX8nA8ZCRDUFtshCcXfogw9kycqWwh44J6
         yWAYddvxfr4S5doe8tHyFfBTrht3GB84aVMUAuOORobBBkzRRjDv11q3GuEJb/RJLv81
         TLmkbWcbgOfMJcVCaUDoi7biO08mjUV7UgWSyySzCPWeEA/PGamlu48iwZ/Exme3t421
         eTow==
X-Gm-Message-State: AO0yUKXZzr2f491PeZ+jEokYnak1SRSzCZaXOjNPc8PsDaAzAvDYVyRZ
        NQcVEJ6EjSQ2RXe8Ih/aTR4=
X-Google-Smtp-Source: AK7set9vj0oSbid2209RUqLVAXqfe/ixnjc00eGOFHAclC3guZtwycp4QCicGkkUfgifM1tnuU8MCg==
X-Received: by 2002:a05:651c:2128:b0:293:fea:c912 with SMTP id a40-20020a05651c212800b002930feac912mr286371ljq.13.1676884104931;
        Mon, 20 Feb 2023 01:08:24 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id z7-20020a2e8847000000b00290517c661asm1529498ljj.40.2023.02.20.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:08:24 -0800 (PST)
Date:   Mon, 20 Feb 2023 11:08:20 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
Message-ID: <20230220110820.595cfa37@eldfell>
In-Reply-To: <20230218211608.1630586-11-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
        <20230218211608.1630586-11-robdclark@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3U5.kjZizK/N8hsnfPFgtqr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3U5.kjZizK/N8hsnfPFgtqr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Feb 2023 13:15:53 -0800
Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>=20
> Will be used in the next commit to set a deadline on fences that an
> atomic update is waiting on.
>=20
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++++
>  include/drm/drm_vblank.h     |  1 +
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 2ff31717a3de..caf25ebb34c5 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *=
crtc,
>  }
>  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> =20
> +/**
> + * drm_crtc_next_vblank_time - calculate the time of the next vblank
> + * @crtc: the crtc for which to calculate next vblank time
> + * @vblanktime: pointer to time to receive the next vblank timestamp.
> + *
> + * Calculate the expected time of the next vblank based on time of previ=
ous
> + * vblank and frame duration

Hi,

for VRR this targets the highest frame rate possible for the current
VRR mode, right?


Thanks,
pq

> + */
> +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime)
> +{
> +	unsigned int pipe =3D drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
> +	u64 count;
> +
> +	if (!vblank->framedur_ns)
> +		return -EINVAL;
> +
> +	count =3D drm_vblank_count_and_time(crtc->dev, pipe, vblanktime);
> +
> +	/*
> +	 * If we don't get a valid count, then we probably also don't
> +	 * have a valid time:
> +	 */
> +	if (!count)
> +		return -EINVAL;
> +
> +	*vblanktime =3D ktime_add(*vblanktime, ns_to_ktime(vblank->framedur_ns)=
);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_crtc_next_vblank_time);
> +
>  static void send_vblank_event(struct drm_device *dev,
>  		struct drm_pending_vblank_event *e,
>  		u64 seq, ktime_t now)
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index 733a3e2d1d10..a63bc2c92f3c 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *dev);
>  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
>  u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
>  				   ktime_t *vblanktime);
> +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime=
);
>  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
>  			       struct drm_pending_vblank_event *e);
>  void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,


--Sig_/3U5.kjZizK/N8hsnfPFgtqr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmPzOIQACgkQI1/ltBGq
qqee6hAAi3Ug/m6OCB4xFw6ghLUrut2lBjLcfLV9I6QcZDuvUxJcyFu7wRD7yhzN
Fw2klHyeYk7LWri8bmbWVVbMk++0+0CVee3hEEHwXw2NbaAdjB9BzDooXVbILcDY
u34uoxalVKuZ8fLvuSlaMxnIv3lbiHSlTZJecswIpOaQozLTebMPIieZ9tWZ+GYK
Id4/PnHFDjeAGwaEWzvQMkKXp65Pe+upngOxN8++KqmxCcp1ZPkX+xf0G7fv5Hhw
T3/aNBqHMlt4/cYQeOJLHF7KrNfoH6+jhziyyZjyNU7dVFgjscLMGdLMie/hE4+D
kd5IjnXjjOz4zEuQmYPCaVKVjl6ZcN4F4/JTds4L3ntI738IsilHDrgbAifBcVSD
rL5ScDT7r50+BivhEd86iTwcTra6X51ldX/kT0pDwmSrweWtHIk7dy0Iuaiez0HM
nnEbE1j6d2Kbev8dmR03tWbaEuNiJT2LR/jGsE9QGWJXbmKP+WaCHf5tKTWiiTXG
1jxpzEdqUq+dxNZdjABhGTdiygx1fdqm/d3o3PcqixFNePdNW39sovXGOcIfYhmJ
VIWJOg8oj6jFN4DVHPoV458LlgcJfT0lF4Z7GJ2/GrsWEZ5xSF0XKBx7xs3reI11
IM0SuH91apzu0hDMxT8juBWk0O6HukZEih/iTsVDYIWcsZTfdYA=
=hxHE
-----END PGP SIGNATURE-----

--Sig_/3U5.kjZizK/N8hsnfPFgtqr--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3F74777C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGDRID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGDRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A1E75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688490430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxitRDWtqKaSeISnWqetN+vP9rXpKkg2ERtZVvgyCDU=;
        b=O2qkVnSwsI1JNbinBKP85Q701qgtuCk6pWMjUNm005zWGObRZaD3ZoMJ0kUDuw8XjmoeA9
        DiboNPUEoRmN5nZOhf0+cfopasUSz3FQgNkHPm6ogr4y10m/cB2VkIBVLwu4y5q0ikqcId
        H+cuyW6c4+YMXjsywUE33X59DErQmbY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-hz55uu73NkOoorrzn95UoQ-1; Tue, 04 Jul 2023 13:07:09 -0400
X-MC-Unique: hz55uu73NkOoorrzn95UoQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb7ea6652bso5414729e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490428; x=1691082428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxitRDWtqKaSeISnWqetN+vP9rXpKkg2ERtZVvgyCDU=;
        b=RwfcDEc4PlHA0Jx1gK53LAAKYhfPi+c6rSCOGHnq+2DSnX2NJuOl+UHjApKb4D9MVt
         aSac8PNjjOi6lFTUaFimvEMQMGoEh/Vqfy9THXylwfsjmOOtTkKu9mrqGLFztaWu+Z4G
         8dlQMbyAUitpyHz7xhOTB/0yMHzI1Nv83uxa5o8r0VdPLFMseibb2/jYwqiaE0ogaTZ/
         UBultKZ7LxmNlE0GhsufbW7R1pC/cGviuzFNl3tMXnI06SrDS1uTkxnKSYlwafxAjQLz
         RcTagwHBeiWBzDf99iRqATB+aiiFVq6gKa99Vuy/r6C0WYSPupGYkQNmpB4rkcCCgyqA
         kn2A==
X-Gm-Message-State: ABy/qLbvSIhyjFlUNQCCCpaxURn35s8mRQi1a0jcXVZ4SIqzbw0nEcJW
        ILKHhYci0BhqWo3QbvNa7aV6WdTDCfwJlDnzBfC1QHW+ecPD7pCuWSrNZg8iG/5rRPXFA4Oh3zB
        91/41tVIFU/PghhWRG9Jiv1NK36dfz1UPNBMHQJT9
X-Received: by 2002:a19:500c:0:b0:4fb:745e:dd01 with SMTP id e12-20020a19500c000000b004fb745edd01mr9084733lfb.45.1688490428165;
        Tue, 04 Jul 2023 10:07:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtGg/VHsl594gLv/LD23psq2DZuofu/ztcmw5O3ofd1hrfk+5+Hy+SGLWPHtlMSbjFgCiDNab5FKJSs9aHqXk=
X-Received: by 2002:a19:500c:0:b0:4fb:745e:dd01 with SMTP id
 e12-20020a19500c000000b004fb745edd01mr9084715lfb.45.1688490427795; Tue, 04
 Jul 2023 10:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230701020917.143394-1-andrealmeid@igalia.com> <20230701020917.143394-2-andrealmeid@igalia.com>
In-Reply-To: <20230701020917.143394-2-andrealmeid@igalia.com>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Tue, 4 Jul 2023 19:06:56 +0200
Message-ID: <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Italo Nicola <italonicola@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <ppaalanen@gmail.com>, hwentlan@amd.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 4:09=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> From: Simon Ser <contact@emersion.fr>
>
> If the driver supports it, allow user-space to supply the
> DRM_MODE_PAGE_FLIP_ASYNC flag to request an async page-flip.
> Set drm_crtc_state.async_flip accordingly.
>
> Document that drivers will reject atomic commits if an async
> flip isn't possible. This allows user-space to fall back to
> something else. For instance, Xorg falls back to a blit.
> Another option is to wait as close to the next vblank as
> possible before performing the page-flip to reduce latency.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> v4: no changes
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 28 +++++++++++++++++++++++++---
>  include/uapi/drm/drm_mode.h       |  9 +++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index d867e7f9f2cd..dfd4cf7169df 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1286,6 +1286,18 @@ static void complete_signaling(struct drm_device *=
dev,
>         kfree(fence_state);
>  }
>
> +static void
> +set_async_flip(struct drm_atomic_state *state)
> +{
> +       struct drm_crtc *crtc;
> +       struct drm_crtc_state *crtc_state;
> +       int i;
> +
> +       for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +               crtc_state->async_flip =3D true;
> +       }
> +}
> +
>  int drm_mode_atomic_ioctl(struct drm_device *dev,
>                           void *data, struct drm_file *file_priv)
>  {
> @@ -1326,9 +1338,16 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>         }
>
>         if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC) {
> -               drm_dbg_atomic(dev,
> -                              "commit failed: invalid flag DRM_MODE_PAGE=
_FLIP_ASYNC\n");
> -               return -EINVAL;
> +               if (!dev->mode_config.async_page_flip) {
> +                       drm_dbg_atomic(dev,
> +                                      "commit failed: DRM_MODE_PAGE_FLIP=
_ASYNC not supported\n");
> +                       return -EINVAL;
> +               }
> +               if (dev->mode_config.atomic_async_page_flip_not_supported=
) {
> +                       drm_dbg_atomic(dev,
> +                                      "commit failed: DRM_MODE_PAGE_FLIP=
_ASYNC not supported with atomic\n");
> +                       return -EINVAL;
> +               }
>         }
>
>         /* can't test and expect an event at the same time. */
> @@ -1426,6 +1445,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>         if (ret)
>                 goto out;
>
> +       if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)
> +               set_async_flip(state);
> +
>         if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY) {
>                 ret =3D drm_atomic_check_only(state);
>         } else if (arg->flags & DRM_MODE_ATOMIC_NONBLOCK) {
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 46becedf5b2f..56342ba2c11a 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -949,6 +949,15 @@ struct hdr_output_metadata {
>   * Request that the page-flip is performed as soon as possible, ie. with=
 no
>   * delay due to waiting for vblank. This may cause tearing to be visible=
 on
>   * the screen.
> + *
> + * When used with atomic uAPI, the driver will return an error if the ha=
rdware
> + * doesn't support performing an asynchronous page-flip for this update.
> + * User-space should handle this, e.g. by falling back to a regular page=
-flip.
> + *
> + * Note, some hardware might need to perform one last synchronous page-f=
lip
> + * before being able to switch to asynchronous page-flips. As an excepti=
on,
> + * the driver will return success even though that first page-flip is no=
t
> + * asynchronous.

What would happen if one commits another async KMS update before the
first page flip? Does one receive EAGAIN, does it amend the previous
commit? What happens to the timing feedback?

This seems really risky to include tbh. I would prefer if we would not
add such special cases for now.

>   */
>  #define DRM_MODE_PAGE_FLIP_ASYNC 0x02
>  #define DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE 0x4
> --
> 2.41.0
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C096A4969
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjB0SPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjB0SPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:15:49 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7124495
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:15:46 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-17213c961dfso8383532fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kthqGc9HV1+cBVD65tJGeV3icobdW/IXIZ0JuA3FrL8=;
        b=lYckM1IRs9rKTPJansQK12xCrzQqLHSEAEz0U8EQZ5KlEC2GYtPE1Q68T+2aD+Z2/N
         Yg4gtNSULCKaJIHLZV1iFIDGXhEERqdg7mZaQCpKVWD86OIDc20uQDvbtvsZ1wxBh8DR
         vq8RnC5zPZw4yiF8ETZEJDSAxogkEBUchv5yKkf3Rnd14QbEp1u2tlU44b1WkI/r+Lln
         L1ZwoQIlfV8UjJ/VHMAwZPSmY7w5udoGEIlXEYX5F2lqCTE7tKa5b7JxCmKiI8jbKnfY
         D5jZ+prKhJizeyRPaKSIhmuK7T5aTPyFGtx3cX5r2WWV5yJVb738V79OsOPbmVCB2ZfT
         49+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kthqGc9HV1+cBVD65tJGeV3icobdW/IXIZ0JuA3FrL8=;
        b=jzsSpH9IRq1Bbf75zi6/fu60p/FeI6eSzwYvdyMRt+K/RM/U7MO7tHFXRA0ZxDliXZ
         GYSZf7N3d7NdnGdqnFgiaoHuzU+gjfxjUAmkH5FFjMX6nKbvLdI+poDsWbS2CjxVdp3V
         /ji8oTlz17Km4P/x7A+q1WtgUuH0lfctB4pWqg1uAjJgyOyDBVw3EE4iS93FBKPNytND
         onz97MgJkoRlAGEYFeEzt27ys8G1o1o45r+XNlowoMNdwQfxKb0JuqUjLmwqN9/TrVKj
         qrtnKogq4kVC2KGQmgbU08fUkA2e3i7YYlgVTRlwTgYn1ayuPmLl5/On4MfPlG2wrdVa
         S+nQ==
X-Gm-Message-State: AO0yUKXB2FNoTBIVB7CjmyYJjeJeSbv8BZ8BrHgTMxvmBv/G9MOPpDdN
        lh5DCq3+KDXE4E64XMLbmdDwUwHBf134S8U5QualLR2r
X-Google-Smtp-Source: AK7set+Ri0pJ646Cs1O36dk7bj0CewKmdMpJW7Ni/DCBcjC1K4lZ/4qSxJJbnKDXx/oHOUK7tOnbal73p58uN1fK7R4=
X-Received: by 2002:a05:6870:5b0a:b0:172:6f4:dcdf with SMTP id
 ds10-20020a0568705b0a00b0017206f4dcdfmr3879299oab.3.1677521746056; Mon, 27
 Feb 2023 10:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20230227173800.2809727-1-robdclark@gmail.com> <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
In-Reply-To: <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 27 Feb 2023 10:15:34 -0800
Message-ID: <CAF6AEGsT8_o+v0vzGu1nyh6Z82pj8FnGUdMFc0Lq+4OWoSjRBQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 27, 2023 at 9:57 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 2/27/23 20:38, Rob Clark wrote:
> ...
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> > +             /* get display info */
> > +             virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> > +                             num_scanouts, &num_scanouts);
> > +             vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> > +                                         VIRTIO_GPU_MAX_SCANOUTS);
> > +             if (!vgdev->num_scanouts) {
> > +                     /*
> > +                      * Having an EDID but no scanouts is non-sensical,
> > +                      * but it is permitted to have no scanouts and no
> > +                      * EDID (in which case DRIVER_MODESET and
> > +                      * DRIVER_ATOMIC are not advertised)
> > +                      */
> > +                     if (vgdev->has_edid) {
> > +                             DRM_ERROR("num_scanouts is zero\n");
> > +                             ret = -EINVAL;
> > +                             goto err_scanouts;
> > +                     }
> > +                     dev->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
>
> If it's now configurable by host, why do we need the
> CONFIG_DRM_VIRTIO_GPU_KMS?

Because a kernel config option makes it more obvious that
modeset/atomic ioctls are blocked.  Which makes it more obvious about
where any potential security issues apply and where fixes need to get
backported to.  The config option is the only thing _I_ want,
everything else is just a bonus to help other people's use-cases.

BR,
-R

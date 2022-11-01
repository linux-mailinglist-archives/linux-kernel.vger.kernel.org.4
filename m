Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985C8614C90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKAO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAO3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:29:55 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D705110B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:29:54 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12c8312131fso16982867fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+xCRx601mtoVLibkTpSK9YAYKRx4dB22ipYCRn77xA=;
        b=ZnbhHKUFkIEoOZF95AIjk86gAR6eM2JMM6kcdSjWXuxz69kMSxPQqCoTrh6WRavhjW
         ej8JjAo4UC5Ww6dNPUlVm+SO9eCW4gKnF2MnqOsVv0TEcZySLQEXNo5ik7n73ssB2LIx
         3qzEVO3DCg+kQl/PTuxOPiMsZ0uPrvrA5pFkxQZKObTsdilp1oLtY4JDE3lnl8fD2oeI
         7HjEf4TOFFb3xYaxhHxVRJeAFBf05dS2z/kq4ha4NSN4nj4UKb62rONvz2vdpRFI3Q+y
         YGV4ZWmzDMQZ/8ZC8dH11G2k0rnPbrHB1/uwuaVFI4Bgw7hsaB1EFK3tYguO62nFtZb3
         Jh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+xCRx601mtoVLibkTpSK9YAYKRx4dB22ipYCRn77xA=;
        b=bFNF6djC08rSJznWjtHp2N7+M4f3YGZYbM7VQobuYOiiFsN5RGHTjOCv10vk8EbQNh
         Lwzm7dy+WMhm8Fy06VMYvKohkWpkUC61qG7SzwPWrraBdrIT6RNn0R4i5V/5EKsIG3Dn
         5X9Mm0U9F2IlzDfpjp6UN2kOqE92C6fSincEfZMQvpDVxMpdTwIt2xdfjF2Nb4UwLIVg
         bsbusmKaZ4dZ6DAVebKzxRsy1vfgHUmwkYql9D0wGUucsLza3GGAQTuJelSGIi5uubjQ
         dmVy6xg5iC0DVK5WUKE/pbRYroWnm1t77yE8aVZsL8r7Tg+hWliGkhLL85hbPo2uxRvv
         8H2A==
X-Gm-Message-State: ACrzQf19OcXG262rAP2Y+7QQpJgi9MaJoJXLucVFsQD0piRmyKqb0b1c
        5srdshSE9+Ch5U0VipYQ7jL0RCF+2uuOiMm4g98=
X-Google-Smtp-Source: AMsMyM7C2E/7wXsA+awOfCZiQMYsQgktNankt/lnAfBWNBgwVIU9kXqYpoNCLmkbD+KmKE6iOglYmnXOACKEvaLJZqE=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr11402686oao.96.1667312993520; Tue, 01
 Nov 2022 07:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221031064918.14178-1-tiwai@suse.de>
In-Reply-To: <20221031064918.14178-1-tiwai@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Nov 2022 10:29:40 -0400
Message-ID: <CADnq5_NVo8wXXBx+iMMFAvuxr77t96fXF8Krw1_fPUOsOtJMzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Use a local mutex for bind/unbind protection
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 31, 2022 at 2:49 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> We used drm_modeset_lock_all() for protecting the audio component
> bind/unbind operations against the notification, but it seems leading
> to kernel WARNING and Oops.  Moreover, the use of
> drm_modeset_lock_all() is rather an overkill only for this
> protection.
>
> This patch introduces a new mutex that protects just the bind/unbind
> and the notify calls and replaces the drm_modeset_lock with it.
>
> Fixes: 34d84636e5e0 ("drm/radeon: Add HD-audio component notifier support (v4)")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1569
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied.  I will squash this in with 34d84636e5e0.

Alex

> ---
>  drivers/gpu/drm/radeon/radeon.h        |  1 +
>  drivers/gpu/drm/radeon/radeon_audio.c  | 21 ++++++++++++---------
>  drivers/gpu/drm/radeon/radeon_device.c |  1 +
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> index d82424525f5a..2e7161acd443 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -1799,6 +1799,7 @@ struct r600_audio {
>         struct radeon_audio_basic_funcs *funcs;
>         struct drm_audio_component *component;
>         bool component_registered;
> +       struct mutex component_mutex;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
> index 4ceb90556127..71b67d4efe08 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -181,8 +181,7 @@ static struct radeon_audio_funcs dce6_dp_funcs = {
>         .dpms = evergreen_dp_enable,
>  };
>
> -static void radeon_audio_component_notify(struct drm_audio_component *acomp,
> -                                         int port);
> +static void radeon_audio_component_notify(struct radeon_device *rdev, int port);
>
>  static void radeon_audio_enable(struct radeon_device *rdev,
>                                 struct r600_audio_pin *pin, u8 enable_mask)
> @@ -212,7 +211,7 @@ static void radeon_audio_enable(struct radeon_device *rdev,
>         if (rdev->audio.funcs->enable)
>                 rdev->audio.funcs->enable(rdev, pin, enable_mask);
>
> -       radeon_audio_component_notify(rdev->audio.component, pin->id);
> +       radeon_audio_component_notify(rdev, pin->id);
>  }
>
>  static void radeon_audio_interface_init(struct radeon_device *rdev)
> @@ -731,12 +730,16 @@ unsigned int radeon_audio_decode_dfs_div(unsigned int div)
>  /*
>   * Audio component support
>   */
> -static void radeon_audio_component_notify(struct drm_audio_component *acomp,
> -                                         int port)
> +static void radeon_audio_component_notify(struct radeon_device *rdev, int port)
>  {
> +       struct drm_audio_component *acomp;
> +
> +       mutex_lock(&rdev->audio.component_mutex);
> +       acomp = rdev->audio.component;
>         if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
>                 acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
>                                                  port, -1);
> +       mutex_unlock(&rdev->audio.component_mutex);
>  }
>
>  static int radeon_audio_component_get_eld(struct device *kdev, int port,
> @@ -787,11 +790,11 @@ static int radeon_audio_component_bind(struct device *kdev,
>         if (WARN_ON(!device_link_add(hda_kdev, kdev, DL_FLAG_STATELESS)))
>                 return -ENOMEM;
>
> -       drm_modeset_lock_all(dev);
> +       mutex_lock(&rdev->audio.component_mutex);
>         acomp->ops = &radeon_audio_component_ops;
>         acomp->dev = kdev;
>         rdev->audio.component = acomp;
> -       drm_modeset_unlock_all(dev);
> +       mutex_unlock(&rdev->audio.component_mutex);
>
>         return 0;
>  }
> @@ -805,11 +808,11 @@ static void radeon_audio_component_unbind(struct device *kdev,
>
>         device_link_remove(hda_kdev, kdev);
>
> -       drm_modeset_lock_all(dev);
> +       mutex_lock(&rdev->audio.component_mutex);
>         rdev->audio.component = NULL;
>         acomp->ops = NULL;
>         acomp->dev = NULL;
> -       drm_modeset_unlock_all(dev);
> +       mutex_unlock(&rdev->audio.component_mutex);
>  }
>
>  static const struct component_ops radeon_audio_component_bind_ops = {
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 17bfbbe906c8..2e13ce2b65d3 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1312,6 +1312,7 @@ int radeon_device_init(struct radeon_device *rdev,
>         mutex_init(&rdev->pm.mutex);
>         mutex_init(&rdev->gpu_clock_mutex);
>         mutex_init(&rdev->srbm_mutex);
> +       mutex_init(&rdev->audio.component_mutex);
>         init_rwsem(&rdev->pm.mclk_lock);
>         init_rwsem(&rdev->exclusive_lock);
>         init_waitqueue_head(&rdev->irq.vblank_queue);
> --
> 2.35.3
>

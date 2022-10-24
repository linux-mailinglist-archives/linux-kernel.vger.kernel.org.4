Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37C160B6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiJXTMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiJXTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:12:12 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB91814B8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:50:38 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13bd2aea61bso1926529fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30l5lqOYdv1hu91sboQ4QyKkjdkEWUElruOKi6s7Elk=;
        b=TEA4ySfWtQ68NLvBJbiENMd3Mnd+D1i+Nj7KOtT0D9Nuifc8D73tNPIw3ff1wY2MqB
         R3aak4txhnehP3B72M3nBlpph358xYMOsvwGOV8FU+0E23HLMlaSzXp4G53D5Hm/lVme
         0oNWKvvBXtW5xPqPLx4feCG1tHta07oOWjldpazIsaYhYYYWWpoytRTNiIxsCQfZ0y0C
         Npf1LNWYbvIJlhpd1lFDdMVEl/2Jpci9g7QU09ppNBjvRJijc8gjfs/gLzH7ZMakufQ9
         kR7mtILhCME7w8iRxhhFs1DemK8M/YpkCKbOj3R5z6+uCIOJG1GmYzuPHNVOtb22cXZc
         BnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30l5lqOYdv1hu91sboQ4QyKkjdkEWUElruOKi6s7Elk=;
        b=z9VmX0WzS9igXdQ67J05Il9mjK2NVUqSFUMkqd5zJBNcVgXRZe+JKvH2R5WTLkot5i
         DXe27hBBu0LsvoQPMLiSiUMliAGKPyw35Fy9J6KIWZYaow4IxT0hjF0mv7ZRrnB+ie+X
         T0CyLnKXy2PINU8AKcwI0tOvu5rZ+Nbd7E+X6Pva+6RnOokEF5I2c0eNcnucV9NJBrcF
         L7gfbGYUhXqnYcPqo5gD09s/dSAB2R7LZxy6m5dFMBeWpkPghjB4Qu5CQaC0gsFkp1nx
         rTHfORAwx78pyhYU+pvYWb1UdmnOMqmo7145eECjZNvqKx5KWPtRK8ksOZKFqKRpJ8jZ
         bkvw==
X-Gm-Message-State: ACrzQf1Onc/Ly0kWVx6Iw2oI0APPhx3aQ+bhdzL8RROL5WB0NsRe4L4N
        zMrAfXuZT3+eROmILNX2VnMGLn1iu1n1GNSvzkGzlIHm
X-Google-Smtp-Source: AMsMyM4uHsoal4/RNkZVoeM59YIpXXMatwWYNp/GXgB4jKW4yRe1fPs5cE7+bAOzXZOHUEjb+r74ZNw8F3ekcHATzhc=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr21206012oao.96.1666631736390; Mon, 24
 Oct 2022 10:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221024154055.21473-1-tiwai@suse.de>
In-Reply-To: <20221024154055.21473-1-tiwai@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Oct 2022 13:15:24 -0400
Message-ID: <CADnq5_N-4tWLQmxkCSjwp8wAftJ7zLizoHn=YL+EDbJtLd1O+w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Add HD-audio component notifier support (v4)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jim Qu <Jim.Qu@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
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

Applied.  Thanks!

Alex

On Mon, Oct 24, 2022 at 11:41 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> This patch adds the support for the notification of HD-audio hotplug
> via the already existing drm_audio_component framework to radeon
> driver.  This allows us more reliable hotplug notification and ELD
> transfer without accessing HD-audio bus; it's more efficient, and more
> importantly, it works without waking up the runtime PM.
>
> The implementation is rather simplistic: radeon driver provides the
> get_eld ops for HD-audio, and it notifies the audio hotplug via
> pin_eld_notify callback upon each radeon_audio_enable() call.
> The pin->id is referred as the port number passed to the notifier
> callback, and the corresponding connector is looked through the
> encoder list in the get_eld callback in turn.
>
> The bind and unbind callbacks handle the device-link so that it
> assures the PM call order.
>
> Also, as a gratis bonus, this patch "fixes" the regression by the
> recent change in HD-audio to be more strict for the HDMI/DP
> connection, too.  Since the HD-audio HDMI/DP codec requires both the
> connection bit and the valid ELD to be provided, it started failing on
> some RADEON gfx boards where the ELD update performed instably.  As
> this change switches the communication to a direct way between the
> audio and the graphics drivers, now the system receives the proper
> ELD, and the HDMI/DP hotplug starts working again.
>
> [ v2: fix the logic in radeon_audio_component_get_eld to walk the
>   connector list since that is where the EDID lives and we can
>   derive the encoder from the connector because the encoder has
>   not been assigned at this point (i.e., during monitor probe).
>
>   v3: the component binding is moved outside radeon_audio_init() and
>   _fini(), as those are called from suspend/resume, too.
>   Drop modeset lock calls that caused Oops.
>   Moved Kconfig change so that it can be applied on older kernels.
>
>   v4: revive drm_modeset_lock*() again, add the missing
>   device_link_remove() call at unbinding ]
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1569
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/gpu/drm/Kconfig                |   1 +
>  drivers/gpu/drm/radeon/radeon.h        |   7 ++
>  drivers/gpu/drm/radeon/radeon_audio.c  | 113 +++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/radeon_device.c |   3 +
>  4 files changed, 124 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 34f5a092c99e..fa986075e8fb 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -243,6 +243,7 @@ config DRM_RADEON
>          select DRM_KMS_HELPER
>          select DRM_TTM
>         select DRM_TTM_HELPER
> +       select SND_HDA_COMPONENT if SND_HDA_CORE
>         select POWER_SUPPLY
>         select HWMON
>         select BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> index 166c18d62f6d..d82424525f5a 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -79,6 +79,7 @@
>  #include <drm/ttm/ttm_execbuf_util.h>
>
>  #include <drm/drm_gem.h>
> +#include <drm/drm_audio_component.h>
>
>  #include "radeon_family.h"
>  #include "radeon_mode.h"
> @@ -1796,6 +1797,8 @@ struct r600_audio {
>         struct radeon_audio_funcs *hdmi_funcs;
>         struct radeon_audio_funcs *dp_funcs;
>         struct radeon_audio_basic_funcs *funcs;
> +       struct drm_audio_component *component;
> +       bool component_registered;
>  };
>
>  /*
> @@ -2994,6 +2997,10 @@ void radeon_irq_kms_set_irq_n_enabled(struct radeon_device *rdev,
>                                       bool enable, const char *name,
>                                       unsigned n);
>
> +/* Audio component binding */
> +void radeon_audio_component_init(struct radeon_device *rdev);
> +void radeon_audio_component_fini(struct radeon_device *rdev);
> +
>  #include "radeon_object.h"
>
>  #endif
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
> index 7c5e80d03fc9..4ceb90556127 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include <linux/gcd.h>
> +#include <linux/component.h>
>
>  #include <drm/drm_crtc.h>
>  #include "dce6_afmt.h"
> @@ -180,6 +181,9 @@ static struct radeon_audio_funcs dce6_dp_funcs = {
>         .dpms = evergreen_dp_enable,
>  };
>
> +static void radeon_audio_component_notify(struct drm_audio_component *acomp,
> +                                         int port);
> +
>  static void radeon_audio_enable(struct radeon_device *rdev,
>                                 struct r600_audio_pin *pin, u8 enable_mask)
>  {
> @@ -207,6 +211,8 @@ static void radeon_audio_enable(struct radeon_device *rdev,
>
>         if (rdev->audio.funcs->enable)
>                 rdev->audio.funcs->enable(rdev, pin, enable_mask);
> +
> +       radeon_audio_component_notify(rdev->audio.component, pin->id);
>  }
>
>  static void radeon_audio_interface_init(struct radeon_device *rdev)
> @@ -721,3 +727,110 @@ unsigned int radeon_audio_decode_dfs_div(unsigned int div)
>         else
>                 return 0;
>  }
> +
> +/*
> + * Audio component support
> + */
> +static void radeon_audio_component_notify(struct drm_audio_component *acomp,
> +                                         int port)
> +{
> +       if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
> +               acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
> +                                                port, -1);
> +}
> +
> +static int radeon_audio_component_get_eld(struct device *kdev, int port,
> +                                         int pipe, bool *enabled,
> +                                         unsigned char *buf, int max_bytes)
> +{
> +       struct drm_device *dev = dev_get_drvdata(kdev);
> +       struct drm_encoder *encoder;
> +       struct radeon_encoder *radeon_encoder;
> +       struct radeon_encoder_atom_dig *dig;
> +       struct drm_connector *connector;
> +       int ret = 0;
> +
> +       *enabled = false;
> +       list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> +               const struct drm_connector_helper_funcs *connector_funcs =
> +                       connector->helper_private;
> +               encoder = connector_funcs->best_encoder(connector);
> +
> +               if (!encoder)
> +                       continue;
> +               if (!radeon_encoder_is_digital(encoder))
> +                       continue;
> +               radeon_encoder = to_radeon_encoder(encoder);
> +               dig = radeon_encoder->enc_priv;
> +               if (!dig->pin || dig->pin->id != port)
> +                       continue;
> +               *enabled = true;
> +               ret = drm_eld_size(connector->eld);
> +               memcpy(buf, connector->eld, min(max_bytes, ret));
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct drm_audio_component_ops radeon_audio_component_ops = {
> +       .get_eld = radeon_audio_component_get_eld,
> +};
> +
> +static int radeon_audio_component_bind(struct device *kdev,
> +                                      struct device *hda_kdev, void *data)
> +{
> +       struct drm_device *dev = dev_get_drvdata(kdev);
> +       struct radeon_device *rdev = dev->dev_private;
> +       struct drm_audio_component *acomp = data;
> +
> +       if (WARN_ON(!device_link_add(hda_kdev, kdev, DL_FLAG_STATELESS)))
> +               return -ENOMEM;
> +
> +       drm_modeset_lock_all(dev);
> +       acomp->ops = &radeon_audio_component_ops;
> +       acomp->dev = kdev;
> +       rdev->audio.component = acomp;
> +       drm_modeset_unlock_all(dev);
> +
> +       return 0;
> +}
> +
> +static void radeon_audio_component_unbind(struct device *kdev,
> +                                         struct device *hda_kdev, void *data)
> +{
> +       struct drm_device *dev = dev_get_drvdata(kdev);
> +       struct radeon_device *rdev = dev->dev_private;
> +       struct drm_audio_component *acomp = data;
> +
> +       device_link_remove(hda_kdev, kdev);
> +
> +       drm_modeset_lock_all(dev);
> +       rdev->audio.component = NULL;
> +       acomp->ops = NULL;
> +       acomp->dev = NULL;
> +       drm_modeset_unlock_all(dev);
> +}
> +
> +static const struct component_ops radeon_audio_component_bind_ops = {
> +       .bind   = radeon_audio_component_bind,
> +       .unbind = radeon_audio_component_unbind,
> +};
> +
> +void radeon_audio_component_init(struct radeon_device *rdev)
> +{
> +       if (rdev->audio.component_registered ||
> +           !radeon_audio || !radeon_audio_chipset_supported(rdev))
> +               return;
> +
> +       if (!component_add(rdev->dev, &radeon_audio_component_bind_ops))
> +               rdev->audio.component_registered = true;
> +}
> +
> +void radeon_audio_component_fini(struct radeon_device *rdev)
> +{
> +       if (rdev->audio.component_registered) {
> +               component_del(rdev->dev, &radeon_audio_component_bind_ops);
> +               rdev->audio.component_registered = false;
> +       }
> +}
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index a556b6be1137..17bfbbe906c8 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1451,6 +1451,8 @@ int radeon_device_init(struct radeon_device *rdev,
>                         goto failed;
>         }
>
> +       radeon_audio_component_init(rdev);
> +
>         r = radeon_ib_ring_tests(rdev);
>         if (r)
>                 DRM_ERROR("ib ring test failed (%d).\n", r);
> @@ -1513,6 +1515,7 @@ void radeon_device_fini(struct radeon_device *rdev)
>         rdev->shutdown = true;
>         /* evict vram memory */
>         radeon_bo_evict_vram(rdev);
> +       radeon_audio_component_fini(rdev);
>         radeon_fini(rdev);
>         if (!pci_is_thunderbolt_attached(rdev->pdev))
>                 vga_switcheroo_unregister_client(rdev->pdev);
> --
> 2.35.3
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70EB647526
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLHRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLHRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:50:45 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B0AD338
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:50:42 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1442977d77dso2676755fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcDib7bnYJl/Unwetka3jeGow0uypTS8xDJA3Nr+9ew=;
        b=l06xBHdQVkajTuW7VX6uuHvMIl1RK9SMqeMSWCTAKB5XUhqLqmc9mAymE2iOCDxYAO
         syHdyaUequqZSnvWv/kMv9oBmyfZMlcyPvA1+GFuNTEdiCTZNZ7sGFR8FzU+cQxuRqSK
         8ZPzeFuAjqnvFSMqTKQ5YTPFgsTS06BCqqOloaW5P2/GsqHm7MPOqxwz5pl84x4INS30
         WN+wShP+a52htV46LnSO3BuboU5LOPC1AZvUZPORjoz48ahBPnmica10L6fee7Xm6Gwl
         mFu/C6F1c7WFEKR/pcT8wo96eCRhvfc7EsD48dEKFL8Yfe22jE+BXtmKyQPXrgsdT5nn
         BYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcDib7bnYJl/Unwetka3jeGow0uypTS8xDJA3Nr+9ew=;
        b=cOO1QNL+qDdmJ9VHae4La+wdaUIm502TrROzXlanvbULpg/oMtOPhN8oWupXANJmyY
         Fw5LSHUzlro28DURUswlzbvKl4oWVEihdiy/rHjNsU2PDifPc9DqUthCN1oQfVH1WgBw
         9qOkRFEm36KGKZRj6XOsnbrMwTYyXls3JF2BecpoOSHtZ/3jvrIcYDWku2vLb//giBMo
         peN/sWbXujkv4+aRvIkXd4nQozvNp55MSLQaAAwVkjY/GpsCHFvQAiL9cSjMQD69xr6v
         nzuwBTf737ClEpBCwHqkv3PmYvdApkdbEQ6RfD04x5YZUDcL1AD3tQxw2SoVS2wsJmJp
         VW4A==
X-Gm-Message-State: ANoB5pl5I3iqY41BF8si+tE7Y8za/gI9Oe/RopZCZhHbcGkCIDxlUFrW
        qrY/O0OHd3qcrwxIUwh3/RiXmSVPiNKnJH2y5G8=
X-Google-Smtp-Source: AA0mqf45SvHm6kzi6ZeuT3Fspud9r0wFsO3c0zqTSaFW8u5+a19GLvzh8KfOeGWpOGfak5/ALktSWVh2t9AukR9HO/4=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr43749954oab.46.1670521842232; Thu, 08
 Dec 2022 09:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20221206073156.43453-1-xurui@kylinos.cn>
In-Reply-To: <20221206073156.43453-1-xurui@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Dec 2022 12:50:30 -0500
Message-ID: <CADnq5_ONUkteQrhgMVfst5UCK5+GjVQaj-=-ABo8bYczeGCRLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Retry DDC probing on DVI on failure if we got
 an HPD interrupt
To:     xurui <xurui@kylinos.cn>
Cc:     alexander.deucher@amd.com, tzimmermann@suse.de,
        guchun.chen@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sam@ravnborg.org, aurabindo.pillai@amd.com, cssk@net-c.es,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

On Wed, Dec 7, 2022 at 3:09 AM xurui <xurui@kylinos.cn> wrote:
>
> HPD signals on DVI ports can be fired off before the pins required for
> DDC probing actually make contact, due to the pins for HPD making
> contact first. This results in a HPD signal being asserted but DDC
> probing failing, resulting in hotplugging occasionally failing.

It seems like DP should get a similar fix.

>
> Rescheduling the hotplug work for a second when we run into an HPD
> signal with a failing DDC probe usually gives enough time for the rest
> of the connector's pins to make contact, and fixes this issue.

This looks reasonable.  Please address the kernel test robot reports.

Thanks,

Alex

>
> Signed-off-by: xurui <xurui@kylinos.cn>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 22 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index cfb262911bfc..dd8d414249a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -997,13 +997,33 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
>                 }
>         }
>
> +       if (amdgpu_connector->detected_hpd_without_ddc) {
> +               force = true;
> +               amdgpu_connector->detected_hpd_without_ddc = false;
> +       }
> +
>         if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
>                 ret = connector->status;
>                 goto exit;
>         }
>
> -       if (amdgpu_connector->ddc_bus)
> +       if (amdgpu_connector->ddc_bus) {
>                 dret = amdgpu_display_ddc_probe(amdgpu_connector, false);
> +
> +               /* Sometimes the pins required for the DDC probe on DVI
> +                * connectors don't make contact at the same time that the ones
> +                * for HPD do. If the DDC probe fails even though we had an HPD
> +                * signal, try again later
> +                */
> +               if (!dret && !force &&
> +                   amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
> +                       DRM_DEBUG_KMS("hpd detected without ddc, retrying in 1 second\n");
> +                       amdgpu_connector->detected_hpd_without_ddc = true;
> +                       schedule_delayed_work(&adev->hotplug_work,
> +                                             msecs_to_jiffies(1000));
> +                       goto exit;
> +               }
> +       }
>         if (dret) {
>                 amdgpu_connector->detected_by_load = false;
>                 amdgpu_connector_free_edid(connector);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 37322550d750..bf009de59710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -535,6 +535,7 @@ struct amdgpu_connector {
>         void *con_priv;
>         bool dac_load_detect;
>         bool detected_by_load; /* if the connection status was determined by load */
> +       bool detected_hpd_without_ddc; /* if an HPD signal was detected on DVI, but ddc probing failed */
>         uint16_t connector_object_id;
>         struct amdgpu_hpd hpd;
>         struct amdgpu_router router;
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus

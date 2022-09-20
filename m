Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E4F5BEAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiITQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiITQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:09:34 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED06C748
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:09:26 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127ba06d03fso4925572fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ak/BTYCEqn8/gk40fTo/S/aYr9+8Izr7lnhdGq7bmAY=;
        b=IRONn0fwCOKADd82WVLuW6to0tPKkHo5ICanCh6D+wwaYH6qRMoyszQeiyJAVvshXh
         xEE8pvuxnrDGZcJ8Ro6nDqSFB3SIgwlGSynjk5H5GNVcouMRDySniX1TqMwIZgtx4geq
         4U9wt0wbMAJU50/DfRGw4TEoi3CftW2rgvSLcbO+IYIxfN8gpbLCJlZvp9aL+pSD7rhM
         AaJpEhI2rV6TTcqZAV7I6P0nqP8pkbhs8m08AsK2Q2bAxfQSROjS+XYi5zv6ruu9N8sv
         M5pr/aw6PuI0B4hcpjn0NrjM1/WgouV0HFLvDtPWH4CCPmetbEVntmRh8D83m6MlVBzP
         sygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ak/BTYCEqn8/gk40fTo/S/aYr9+8Izr7lnhdGq7bmAY=;
        b=xT+oXrHNO+/+kIEDjeDCyWeaJl7VqqeKxl0AjDhxdf7LnqqpTCjmW4VQjU28XHVtyK
         orGfSBMM6S2Ni9DNcoIvDDwf+Mrj9qDl5cJIxTRNpCLxbXygXX3t58FjxYH/TrNE+UDC
         5L9PWIRsgMYUSa3fjdHETZfUB7xDNcnFiWODvhyvy9TVGbeg+xRua1TRLQ32AVM7IZB8
         vShU1DO1e+0SZyDesoVhzrm5QFvSF2iEesNfcgyQacpC4CNvlQIPSKP7fR4w1G7WltqN
         AfAoz9k4GFsbWPFGopMDuIz4cqw5lhojTImYio94/u893UqOk/evLNdNKxRapE9TdVYn
         lotA==
X-Gm-Message-State: ACrzQf0MQI9yGIqyxnjkC1dfPEKOtJzEKCTzQQoEQVmOO7rnVlM/fwn1
        QseyP7QvFIS++pk3neIohh6LJNAJULYiTrU9EvM=
X-Google-Smtp-Source: AMsMyM7HTtAqMDQIoo+e30SxRamT6lecvmPZDgAUHviZPjloGPSN1YYmwDdxL+lJH8uBrokRWNVp4LTfI5veZ8SjIhI=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr2548247oam.96.1663690165330; Tue, 20
 Sep 2022 09:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220920092453.16022-1-hongao@uniontech.com>
In-Reply-To: <20220920092453.16022-1-hongao@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 20 Sep 2022 12:09:14 -0400
Message-ID: <CADnq5_MvCho_Ue3zyNf0tBd3iYqPKyDdveK9LhZwuYGNYiqQ2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix initial connector audio value
To:     hongao <hongao@uniontech.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
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

Applied.  Thanks!

Alex

On Tue, Sep 20, 2022 at 6:34 AM hongao <hongao@uniontech.com> wrote:
>
> This got lost somewhere along the way, This fixes
> audio not working until set_property was called.
>
> Signed-off-by: hongao <hongao@uniontech.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index e4054e10a2c2..5d2e3328dd83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1655,10 +1655,12 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                                                    adev->mode_info.dither_property,
>                                                    AMDGPU_FMT_DITHER_DISABLE);
>
> -                       if (amdgpu_audio != 0)
> +                       if (amdgpu_audio != 0) {
>                                 drm_object_attach_property(&amdgpu_connector->base.base,
>                                                            adev->mode_info.audio_property,
>                                                            AMDGPU_AUDIO_AUTO);
> +                               amdgpu_connector->audio = AMDGPU_AUDIO_AUTO;
> +                       }
>
>                         subpixel_order = SubPixelHorizontalRGB;
>                         connector->interlace_allowed = true;
> @@ -1763,6 +1765,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                                 drm_object_attach_property(&amdgpu_connector->base.base,
>                                                            adev->mode_info.audio_property,
>                                                            AMDGPU_AUDIO_AUTO);
> +                               amdgpu_connector->audio = AMDGPU_AUDIO_AUTO;
>                         }
>                         drm_object_attach_property(&amdgpu_connector->base.base,
>                                                    adev->mode_info.dither_property,
> @@ -1811,6 +1814,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                                 drm_object_attach_property(&amdgpu_connector->base.base,
>                                                            adev->mode_info.audio_property,
>                                                            AMDGPU_AUDIO_AUTO);
> +                               amdgpu_connector->audio = AMDGPU_AUDIO_AUTO;
>                         }
>                         drm_object_attach_property(&amdgpu_connector->base.base,
>                                                    adev->mode_info.dither_property,
> @@ -1856,6 +1860,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                                 drm_object_attach_property(&amdgpu_connector->base.base,
>                                                            adev->mode_info.audio_property,
>                                                            AMDGPU_AUDIO_AUTO);
> +                               amdgpu_connector->audio = AMDGPU_AUDIO_AUTO;
>                         }
>                         drm_object_attach_property(&amdgpu_connector->base.base,
>                                                    adev->mode_info.dither_property,
> --
> 2.20.1
>

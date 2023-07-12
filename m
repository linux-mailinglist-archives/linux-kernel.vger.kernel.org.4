Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D2875045E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGLKYc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 06:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGLKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:24:30 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0799312E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:24:30 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-576a9507a9bso8672607b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689157469; x=1691749469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AfbwBwJNjshQnNKOif9aDI46gRnwtqlbKQaRDBJ9bU=;
        b=NBvxnnWDcmNiIPO00c8lULAJIjmQE82JS6soIZFZEYFly5rSh0bv8QfN7GIIloIn7m
         mYsKB1QXED6MfOMfnUTqCveBevUS4sdZD3FGv3h9VE38RAWvmVy5fLGjXLFzmNlZH/+w
         HJdLTvXjDctnmtsfOseiShJJmO7iGFk2OzW9CB2r19ACsa2+ttHcA/Blvfw27vf5S3Z1
         EACOW4UGgWKFynidrXTxnsAfeaTxjj/CKAEH+Nwa1qeLvKv/dH4HU9mA7m/3IKkVOV2y
         9EEzUrXlQvB9mv3IVac61uxH+r9J7YCMDY8PrxBssvcjoukmot50s8B7+sLFkadnulCQ
         xYkQ==
X-Gm-Message-State: ABy/qLbXv0KH1P0BJyYtg0RX7Gs6keqSjN8ggJ0b1bKiEq0Y6D8cHF/4
        sCRVZzpW3rmOU+lu3YtKCT/J7qwehZnXOg==
X-Google-Smtp-Source: APBJJlEud7/gJonqVmbEkevocGFdsnQChTxRsTW7rZ/Idf/Sky8qFIaFQDNbEBbYwYsectD8Ps3Y2g==
X-Received: by 2002:a0d:cbd7:0:b0:56f:f0db:759a with SMTP id n206-20020a0dcbd7000000b0056ff0db759amr1836273ywd.13.1689157469047;
        Wed, 12 Jul 2023 03:24:29 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id i67-20020a0df846000000b005772f3fc0acsm1086144ywf.44.2023.07.12.03.24.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 03:24:28 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-577ddda6ab1so8949167b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:24:28 -0700 (PDT)
X-Received: by 2002:a81:92d3:0:b0:56f:f83f:618 with SMTP id
 j202-20020a8192d3000000b0056ff83f0618mr1642975ywg.19.1689157467952; Wed, 12
 Jul 2023 03:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230609170941.1150941-1-javierm@redhat.com> <20230609170941.1150941-6-javierm@redhat.com>
In-Reply-To: <20230609170941.1150941-6-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 12:24:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbQ8VAVPdLLpgV97=uY85-PfKWMmzyXpFZ6d=iJ2JOAQ@mail.gmail.com>
Message-ID: <CAMuHMdWbQ8VAVPdLLpgV97=uY85-PfKWMmzyXpFZ6d=iJ2JOAQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/ssd130x: Remove hardcoded bits-per-pixel in ssd130x_buf_alloc()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Thanks for your patch!

On Fri, Jun 9, 2023 at 7:09 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The driver only supports OLED controllers that have a native DRM_FORMAT_C1

DRM_FORMAT_R1 (colormap is fixed to white-on-black).

> pixel format and that is why it has harcoded a division of the width by 8.

hardcoded.

> But the driver might be extended to support devices that have a different
> pixel format. So it's better to use the struct drm_format_info helpers to
> compute the size of the buffer, used to store the pixels in native format.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -150,9 +150,16 @@ static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
>  {
>         unsigned int page_height = ssd130x->device_info->page_height;
>         unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
> +       const struct drm_format_info *fi;
> +       unsigned int pitch;
>
> -       ssd130x->buffer = kcalloc(DIV_ROUND_UP(ssd130x->width, 8),
> -                                 ssd130x->height, GFP_KERNEL);
> +       fi = drm_format_info(DRM_FORMAT_C1);

DRM_FORMAT_R1.

> +       if (!fi)
> +               return -EINVAL;
> +
> +       pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
> +
> +       ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
>         if (!ssd130x->buffer)
>                 return -ENOMEM;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

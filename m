Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA97762311C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiKIRKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiKIRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B5A17423
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668013752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=upBhh3tf2YeJs0Ui54TR2IQ+XSYjRkdPr1fWGChfdYU=;
        b=KlpN8OusSYsLPc4uXdeIpNjRaEG7D1KCsAcRqua9bUDWR960cLYRH9gZbubLMxmd3mhuPF
        sbWvSiogCBsyaVWI5G6pILW1YzWJteddkSxkPoWGp0liI/VMGzpey+Wnf9HJ6MIbeDQO16
        Um5Dw2rOaVXvmho+RAb4bC+VmUdoNJg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-F8Mkw76PNq-Fbpoz2q1kpQ-1; Wed, 09 Nov 2022 12:09:11 -0500
X-MC-Unique: F8Mkw76PNq-Fbpoz2q1kpQ-1
Received: by mail-qt1-f197.google.com with SMTP id c19-20020a05622a059300b003a51d69906eso12807702qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upBhh3tf2YeJs0Ui54TR2IQ+XSYjRkdPr1fWGChfdYU=;
        b=4eZwDKly+51CEmZFYkXjgurF3Eye+RnC35MkffyJ9aQoJYjk9pLZvEJTgernrHW/pY
         3M6/87KboRuMW2QyxsD8h0UDN8ThNPqZtZx0F/Gbd/skLag3SMk/Pvkp3Z9f7yLQoXih
         hdR8wQF0rFLLcmTwYuYv+AUVd57ehj0kK4c/m+EEYIVQaipTvBgWc0hMXnvjqyOrzAWf
         Ml55vawwJopmHuuG7GxSzF3ChyrB2PMQfH/SZh0ZQgx2GGX1ZpDotXMRluzokpnc1WCH
         EzlE3jB0r3YwXulqXM4JkMfmR4CIIVTXHM1126zex6KDw06/ftteuINEM2iseNZF8dUK
         pQnw==
X-Gm-Message-State: ACrzQf29iybJXB7UwkWUtjElzeukjoyd9e4rXbNfWHHblFboJvZDXhWA
        NkoiRJWM6GBHkgI+vZGZm2cvkwVLb0+q/oeRhwq9tLe4YZ9Ergw8zvrVJ51fOwFuz5fDQiXZoWw
        mcP2fllbvfDhb3BOFTjuOjbrOH5YLys31yny38eIE
X-Received: by 2002:a05:622a:1015:b0:3a4:f0c4:e8ff with SMTP id d21-20020a05622a101500b003a4f0c4e8ffmr49327078qte.141.1668013750479;
        Wed, 09 Nov 2022 09:09:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6CER2NjfL6gW2cHCg7k6TFxpFj9M4CDm+qG78yLBTsXX/dUFY9/GnHR1vrOryl4ljnTR9BetCm7ikms3WUPIU=
X-Received: by 2002:a05:622a:1015:b0:3a4:f0c4:e8ff with SMTP id
 d21-20020a05622a101500b003a4f0c4e8ffmr49327064qte.141.1668013750303; Wed, 09
 Nov 2022 09:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20221031163211.13228-1-antoniospg100@gmail.com> <20221104220424.41164-1-antoniospg100@gmail.com>
In-Reply-To: <20221104220424.41164-1-antoniospg100@gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 9 Nov 2022 18:08:59 +0100
Message-ID: <CACO55tt0skPqe2YNrq3qnMvsUa1cT2db2zt718yF4S4hLnqC0Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/nouveau: Add support to control backlight using
 bl_power for nva3.
To:     Antonio Gomes <antoniospg100@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 11:04 PM Antonio Gomes <antoniospg100@gmail.com> wrote:
>
> From: antoniospg <antoniospg100@gmail.com>
>
> Summary:
>
> * Add support to turn on/off backlight when changing values in bl_power
>   file. This is achieved by using function backlight_get_brightness()
>   in nva3_set_intensity to get current brightness.
>
> Test plan:
>
> * Turn off:
> echo 1 > /sys/class/backlight/nv_backlight/bl_power
>
> * Turn on:
> echo 0 > /sys/class/backlight/nv_backlight/bl_power
>
> Signed-off-by: antoniospg <antoniospg100@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index a2141d3d9b1d..5c82f5189b79 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -263,7 +263,11 @@ nva3_set_intensity(struct backlight_device *bd)
>         u32 div, val;
>
>         div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
> -       val = (bd->props.brightness * div) / 100;
> +
> +       val = backlight_get_brightness(bd);
> +       if (val)
> +               val = (val * div) / 100;
> +
>         if (div) {
>                 nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
>                           val |
> --
> 2.25.1
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

btw, i'll fix up the name with the one from the Email From field, so
you won't have to send it out again.


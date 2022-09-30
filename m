Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C15F0D65
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiI3OVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiI3OUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505E4B514F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:20:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc7so9416430ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Qmhw/xvm52V9JeMhrCZ4QdfkWP6FtOLW3fI49wxSg5A=;
        b=WmLVs0TVUi9h5JUoYO3o2oJG0kF5hKWGPBnaIQjuqBGkFyD2xGC/n9DnqnZNC5oT2m
         xPoGmEoybMS080J9SO3uVChRxY9triUbx+DgkIx8SxCrqIVijAMlWUTtqm3MT/tYDw87
         gOZxTn+eBlAaBE6/xxUSAl0ky3sLCGIurURNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Qmhw/xvm52V9JeMhrCZ4QdfkWP6FtOLW3fI49wxSg5A=;
        b=0ztxFzwlOvMNQFTFO76a/z0FUXt80OxCb06Cen89LWVLvTWOYRKnAKd0/l8gdKnTrs
         puMKrFlhwrk2pXRrMT8ktU8x9DlPxQvRGm5jDKWAydFwj90MpdYXVv7qmMCD6u6b3rnc
         Wpxj8Md6Gi8KZTQurXEbJZhcME/TMWCAfvgANStqUjER3lQr+gzOlayWkI9CJzBpf51Z
         mpOW7Ft0upGJpspySLeVbSHtMwIey9HJgMRZDagEiTBKHot4H5vTXxanF4Gm2f4OjnLh
         D4fCHK3bH0FSBeNM7Cu0nn7l71vGI+9IMDucRrhSLIC6OSy0EcrKjL4l4M3RML711jDP
         gTyg==
X-Gm-Message-State: ACrzQf1dt/8h5Y8zPsmt4OAOA/nnDWRfiFtNT8kYv36c/lWpuyPTYJ89
        6aFFto6IPQ61HgOvSAsQgjfcJdgg7fRq/PsU
X-Google-Smtp-Source: AMsMyM4alJjI3IMWD6QkY/klCeo61UkhdQOju6Tb79nhJOQrEjdJAZ803p4u/5kIHulKtdyYMWvsLA==
X-Received: by 2002:a17:906:dc95:b0:782:f2a8:7e45 with SMTP id cs21-20020a170906dc9500b00782f2a87e45mr6292286ejc.424.1664547646707;
        Fri, 30 Sep 2022 07:20:46 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id f13-20020a17090660cd00b0077a7c01f263sm1246712ejk.88.2022.09.30.07.20.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:20:45 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso4601985wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:20:45 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id
 n13-20020a05600c500d00b003b50234d7e9mr6041734wmr.57.1664547644935; Fri, 30
 Sep 2022 07:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220930042506.2529522-1-jason.yen@paradetech.corp-partner.google.com>
In-Reply-To: <20220930042506.2529522-1-jason.yen@paradetech.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Sep 2022 07:20:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoyhpoRpQpv5dNYy0qEJcu=JRw=1TKynX-5ecjLJoibw@mail.gmail.com>
Message-ID: <CAD=FV=XoyhpoRpQpv5dNYy0qEJcu=JRw=1TKynX-5ecjLJoibw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ps8640: Add software to support aux defer
To:     Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 29, 2022 at 9:25 PM Jason Yen
<jason.yen@paradetech.corp-partner.google.com> wrote:
>
> This chip can not handle aux defer if the host directly program
> its aux registers to access edid/dpcd. So we need let software
> to handle the aux defer situation.
>
> Signed-off-by: Jason Yen <jason.yen@paradetech.corp-partner.google.com>
> ---
>
> Changes in v2:
> - Add aux defer handler
> - Remove incorrect statements
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 31e88cb39f8a..76ada237096d 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -286,7 +286,6 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
>         }
>
>         switch (data & SWAUX_STATUS_MASK) {
> -       /* Ignore the DEFER cases as they are already handled in hardware */
>         case SWAUX_STATUS_NACK:
>         case SWAUX_STATUS_I2C_NACK:
>                 /*
> @@ -303,6 +302,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
>         case SWAUX_STATUS_ACKM:
>                 len = data & SWAUX_M_MASK;
>                 break;
> +       case SWAUX_STATUS_DEFER:
> +       case SWAUX_STATUS_I2C_DEFER:
> +               if (is_native_aux)
> +                       msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
> +               else
> +                       msg->reply |= DP_AUX_I2C_REPLY_DEFER;
> +               len = data & SWAUX_M_MASK;
> +               break;

This seems fine to me now. There is nothing too controversial here but
I'll still give this a few days on the list for anyone else to speak
up. I'll plan to land it midway through next week unless anything
comes up.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C164C2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiLNDap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLNDao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:30:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99E26ABF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:30:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d14so20706735edj.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDIYxbymFv4ExXchmCkI4LYR05zQxY8kxJXJs+vKWhE=;
        b=amOmrkPDirnMZdhsYPPQyQy8LvoH+zAQuTtBq9fi7ll/oPlNFmCPtXhOiUwc9SR+Ku
         fgoQbC+I8/nkQaV2QdV0ZnHgviUCqfI/3g7Rr0skGttzNuDJ3Rq0NFHC5kFCGxtO5S9v
         EL07799F1IBfoVDYygZ88V1JDw2P7ZUaThV1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDIYxbymFv4ExXchmCkI4LYR05zQxY8kxJXJs+vKWhE=;
        b=n0aaW9DuXJ7E/Qsu6gq8FyIglKQxLSN7zCJ9dxonGkCiiyt1PTs/WxIoXOOldB2Pc5
         eSHvoI8q9tcQRqvaVlDJ2O4zCr9WG+CH8H8htKLMsDAX1PBNQt5wyWOeLZiqDPBjl/Iq
         d0usGQ7bCxJvmnzcQ18R1GKVxhgCa9Z8Vo+Bfm9sBDiz8VDoqMm71eNIlqM1YDbo05/4
         Z53UiG3PFcRVjljvcW1VUp39oLR8On0DRgp/4AaZWgdqsiwvpL9Zg1fn+vNl8uKyVX48
         7T9z+TALO6HV4Y65toLDWyuyhjT2Ck/dj8NoeG1i3SACtXJlua3DRHkgt3WMRoViinpG
         WZDg==
X-Gm-Message-State: ANoB5pl2OdqKUqeXAfbICTyVLM9QrPe8SrN/lIru2u+iOXbsE1Nz9AIT
        grI2DYseO0GemAzK/JOvGJdgMel9mCjtoq2G2rxjtw==
X-Google-Smtp-Source: AA0mqf42lw3r3MiAwR64FwuywzgtufLy8qMXr4mAIFBaGD2kXn9II5KWB1Z2vVbFTEBEWQkMmknhKzhR5V6Jf4O8ykk=
X-Received: by 2002:a05:6402:d78:b0:46b:a177:9d84 with SMTP id
 ec56-20020a0564020d7800b0046ba1779d84mr36382907edb.134.1670988641234; Tue, 13
 Dec 2022 19:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20221109095227.3320919-1-treapking@chromium.org>
In-Reply-To: <20221109095227.3320919-1-treapking@chromium.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 14 Dec 2022 11:30:30 +0800
Message-ID: <CAEXTbpf+6n9KWRkQEbQVxsBjd65Rs0voH=JNHk5BaoE_55-yuw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Guard bridge power in IRQ handler
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        allen chen <allen.chen@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping on this patch.

Regards,
Pin-yen

On Wed, Nov 9, 2022 at 5:52 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Add a pair of pm_runtime_get_if_in_use and pm_runtime_put_sync in the
> interrupt handler to make sure the bridge won't be powered off during
> the interrupt handlings. Also remove the irq_lock mutex because it's not
> guarding anything now.
>
> Fixes: ab28896f1a83 ("drm/bridge: it6505: Improve synchronization between extcon subsystem")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 21a9b8422bda..e7f7d0ce1380 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -412,7 +412,6 @@ struct it6505 {
>          * Mutex protects extcon and interrupt functions from interfering
>          * each other.
>          */
> -       struct mutex irq_lock;
>         struct mutex extcon_lock;
>         struct mutex mode_lock; /* used to bridge_detect */
>         struct mutex aux_lock; /* used to aux data transfers */
> @@ -2494,10 +2493,8 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>         };
>         int int_status[3], i;
>
> -       mutex_lock(&it6505->irq_lock);
> -
> -       if (it6505->enable_drv_hold || !it6505->powered)
> -               goto unlock;
> +       if (it6505->enable_drv_hold || pm_runtime_get_if_in_use(dev) <= 0)
> +               return IRQ_HANDLED;
>
>         int_status[0] = it6505_read(it6505, INT_STATUS_01);
>         int_status[1] = it6505_read(it6505, INT_STATUS_02);
> @@ -2515,16 +2512,14 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>         if (it6505_test_bit(irq_vec[0].bit, (unsigned int *)int_status))
>                 irq_vec[0].handler(it6505);
>
> -       if (!it6505->hpd_state)
> -               goto unlock;
> -
> -       for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
> -               if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
> -                       irq_vec[i].handler(it6505);
> +       if (it6505->hpd_state) {
> +               for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
> +                       if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
> +                               irq_vec[i].handler(it6505);
> +               }
>         }
>
> -unlock:
> -       mutex_unlock(&it6505->irq_lock);
> +       pm_runtime_put_sync(dev);
>
>         return IRQ_HANDLED;
>  }
> @@ -3277,7 +3272,6 @@ static int it6505_i2c_probe(struct i2c_client *client,
>         if (!it6505)
>                 return -ENOMEM;
>
> -       mutex_init(&it6505->irq_lock);
>         mutex_init(&it6505->extcon_lock);
>         mutex_init(&it6505->mode_lock);
>         mutex_init(&it6505->aux_lock);
> --
> 2.38.1.431.g37b22c650d-goog
>

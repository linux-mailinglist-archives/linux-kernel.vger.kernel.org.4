Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0C609C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJXIHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJXIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:07:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6F60CAD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:07:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m15so28147096edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJyKcXirmoJHw04J67wvkLB1zRITu1b/Yf9TAcTCa00=;
        b=q/C+ZzlNYEf+623922EqBJSjLs5+oESif0J1/ZbzPMo6jck0mxCmuwOqLatGixRbf5
         CHplhHPSRJIVV+6sfQIpO5P7wlPhPkoGNxcLWLeVK1o8XZd5hWd9YGgvex3vu9WKchvO
         9pqE1s/mtvo6oAqD54hHtip7WTic/4jSzPqlu6gidAsYxon5ge+nYg9mfyfgMcdymzLr
         TqMUdDEsrK47YujQ5QeuPsHVfyaeNMC6ygKRvlL3uOIzXt2xkSezcIgzEn24T4wt7aY3
         HnjDKwJVXzPuPgfACQoc4h1GeFxNrduCCkR13ruSbhtbuzU9O1LrUUfA8JNWch6UUZMD
         QGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJyKcXirmoJHw04J67wvkLB1zRITu1b/Yf9TAcTCa00=;
        b=hFetvAq5pgWQtBo/beuhK8/UTywRqWKVRIGxUJsQt2Wm27de3r1vcn391hL6Esp6Np
         flfInsHdEWjpzkvFtdYJ7OL9+rLNBMY0klYPPb+vYSfra+WNcP6tpgqNDaA56t6SZlaQ
         Nw5SyMXOypBHzxPqYBJ0jx7ruxjWmHOn+SyZmum8e8OboE+Df5C2+SMLkfRq2VnJ3zrq
         TKOe9OjUMyZ33h9kiuAxN6TuMSM+6dHbWKpoUPxZ626ykvImHAJj5UJ8c9uzQ30ZpvVy
         O0N1A3XkVWPj2GzrFgHoDUCJ23QWGowwsfMAYuSWh1yRNsj1ExvVeF98iduIWeN6Y0TC
         a1uA==
X-Gm-Message-State: ACrzQf2abuJbu70hzmsIm1N+4gKvkSv10VXUafAUEY8aVFSoDfrDLGQv
        jhv7HXbxY+Rq8yf9hITbWzbrrCCf/I+SdoHRpSCZdQ==
X-Google-Smtp-Source: AMsMyM5FOZfIhyX3k0OFsulBbrJ2OmOnll7BloxuDQAQqp73e/PkTjOKcE9T8rfsh7ftAaDYyMdjZUqrVX1Z58X4RFU=
X-Received: by 2002:a05:6402:2402:b0:45c:a1ce:94d8 with SMTP id
 t2-20020a056402240200b0045ca1ce94d8mr28808767eda.50.1666598854484; Mon, 24
 Oct 2022 01:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221013110411.1674359-1-treapking@chromium.org> <20221013110411.1674359-4-treapking@chromium.org>
In-Reply-To: <20221013110411.1674359-4-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 24 Oct 2022 10:07:23 +0200
Message-ID: <CAG3jFytZ9cqNZLXfegtW=AO=3NAKiVCmSpAwmf1H4u60xo50CQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: it6505: Improve synchronization
 between extcon subsystem
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 at 13:04, Pin-yen Lin <treapking@chromium.org> wrote:
>
> Originally, the it6505 relies on a short sleep in the IRQ handler and a
> long sleep to make sure it6505->lane_swap and it6505->lane_count is
> configured in it6505_extcon_work and it6505_detect, respectively.
>
> Use completion and additional DPCD read to remove the unnecessary waits,
> and use a different lock for it6505_extcon_work and the threaded IRQ
> handler because they no longer need to run exclusively.
>
> The wait time of the completion is usually less than 10ms in local
> experiments, but leave it larger here just in case.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> Changes in v2:
> - Add the empty line back
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 4b6061272599..0de44c651c60 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -412,6 +412,7 @@ struct it6505 {
>          * Mutex protects extcon and interrupt functions from interfering
>          * each other.
>          */
> +       struct mutex irq_lock;
>         struct mutex extcon_lock;
>         struct mutex mode_lock; /* used to bridge_detect */
>         struct mutex aux_lock; /* used to aux data transfers */
> @@ -440,7 +441,7 @@ struct it6505 {
>         enum hdcp_state hdcp_status;
>         struct delayed_work hdcp_work;
>         struct work_struct hdcp_wait_ksv_list;
> -       struct completion wait_edid_complete;
> +       struct completion extcon_completion;
>         u8 auto_train_retry;
>         bool hdcp_desired;
>         bool is_repeater;
> @@ -2316,8 +2317,8 @@ static void it6505_irq_hpd(struct it6505 *it6505)
>                              it6505->hpd_state ? "high" : "low");
>
>         if (it6505->hpd_state) {
> -               wait_for_completion_timeout(&it6505->wait_edid_complete,
> -                                           msecs_to_jiffies(6000));
> +               wait_for_completion_timeout(&it6505->extcon_completion,
> +                                           msecs_to_jiffies(1000));
>                 it6505_aux_on(it6505);
>                 if (it6505->dpcd[0] == 0) {
>                         it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
> @@ -2493,8 +2494,7 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>         };
>         int int_status[3], i;
>
> -       msleep(100);
> -       mutex_lock(&it6505->extcon_lock);
> +       mutex_lock(&it6505->irq_lock);
>
>         if (it6505->enable_drv_hold || !it6505->powered)
>                 goto unlock;
> @@ -2524,7 +2524,7 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>         }
>
>  unlock:
> -       mutex_unlock(&it6505->extcon_lock);
> +       mutex_unlock(&it6505->irq_lock);
>
>         return IRQ_HANDLED;
>  }
> @@ -2701,9 +2701,12 @@ static void it6505_extcon_work(struct work_struct *work)
>                  */
>                 if (ret)
>                         it6505_poweron(it6505);
> +
> +               complete_all(&it6505->extcon_completion);
>         } else {
>                 DRM_DEV_DEBUG_DRIVER(dev, "start to power off");
>                 pm_runtime_put_sync(dev);
> +               reinit_completion(&it6505->extcon_completion);
>
>                 drm_helper_hpd_irq_event(it6505->bridge.dev);
>                 memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
> @@ -3274,6 +3277,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
>         if (!it6505)
>                 return -ENOMEM;
>
> +       mutex_init(&it6505->irq_lock);
>         mutex_init(&it6505->extcon_lock);
>         mutex_init(&it6505->mode_lock);
>         mutex_init(&it6505->aux_lock);
> @@ -3329,7 +3333,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
>         INIT_WORK(&it6505->link_works, it6505_link_training_work);
>         INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
>         INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
> -       init_completion(&it6505->wait_edid_complete);
> +       init_completion(&it6505->extcon_completion);
>         memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
>         it6505->powered = false;
>         it6505->enable_drv_hold = DEFAULT_DRV_HOLD;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

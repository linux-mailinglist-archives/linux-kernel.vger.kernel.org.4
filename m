Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0EA609BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJXH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJXH4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:56:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577915D105
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:56:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a13so28193977edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwWQb8oemB4+jz+zwrXGcKHoP4NnD8EJpRvthEA+8Xk=;
        b=mgc9eBnmWDCw/KI1b91Hzr+SXtXXihZ/IZ9Xf8LZFla/f4O2nMMhiJcxnD5FHTUO28
         ddZDYlhmLoY3rz9RezoehbyUY5h3vvGLTYJWNpSdV15+LS0vYKA9CHdUbQCHLFAffqwy
         Sx/Tn2r5KJ/Xen6DU4SyJiS3ToqUcyttByQZ8Q5MToumbr/lWg3mKJOnMWa/T1BLKei2
         G5aw8oQ8sYmsEDkHbRMOG/QzUhxM1tH1H6HRVyvCb18c7wY2csgSfgenX/JsVdGScI48
         M8omtLWbBOmopwbnZ9IUqsSFuWgKPiv8x+IoEZsv6KeGkFGDbbSatsjmvTlA82lpOLvk
         cobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwWQb8oemB4+jz+zwrXGcKHoP4NnD8EJpRvthEA+8Xk=;
        b=8H6nUobnLXlj7SFDuFhBvz3MxLAqBXlIp8YfgfAW1DAx61Zet0t7UkR+XS0wdtli7p
         X19o+1fsfSCQ1YS2Nw9ChdRcTCuqLxbDKt9PpQUwW1MVYC48sK+OQ6Ae7HIQrcP9lwvW
         7LQUYlhZbjq3YC6+QGiUSmI2HRcspJUTLDCOiZSJoqDM1r4BNCpIT0J9QiYpSzh84xwq
         SjRlt1RHeOPpJEXw+0YAKpY6tOmywQn298c0F2Fe8dFTRwnmDP4K9CQdjqu29fzj/sry
         dLTQqrsQFCFd889qNCavq8yCgkylP/h8vzppSeAV1LOGLq4bEiHtO/hxyh8y9Gg1uocf
         AAmA==
X-Gm-Message-State: ACrzQf3VYee+c10xImG9/iQ0EGaYsVgC056e2lJ1+Epm5vWVkX0c4LOI
        lZKRoUEGKQ2/8DjiEuUmeOEcH/n9lATNrleay4L+bg==
X-Google-Smtp-Source: AMsMyM6iTIpIj01086FgzlaMlYcgrK55GCiS7dDyxU3CMtDClj3564oTprjeQT+ELvW3jRF4OVfa+S60/W69KvNmfAg=
X-Received: by 2002:a05:6402:2402:b0:45c:a1ce:94d8 with SMTP id
 t2-20020a056402240200b0045ca1ce94d8mr28776441eda.50.1666598186547; Mon, 24
 Oct 2022 00:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221013110411.1674359-1-treapking@chromium.org> <20221013110411.1674359-3-treapking@chromium.org>
In-Reply-To: <20221013110411.1674359-3-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 24 Oct 2022 09:56:15 +0200
Message-ID: <CAG3jFyskXfbX=rTye9ygT36kKmqJRr0rO1eQrKSr1V7hOHxDcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: it6505: Setup links in it6505_irq_hpd
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
> Move the DPCD read and link setup steps to HPD IRQ handler to remove
> an unnecessary dependency between .detect callback and the HPD IRQ
> handler before registering it6505 as a DRM bridge. This is safe because
> there is always a .detect call after each HPD IRQ handler triggered by
> the drm_helper_hpd_irq_event call.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> Changes in v2:
> - Remove redundant spaces in it6505_detect
> - Read sink count in it6505_irq_hpd
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 80 +++++++++++++----------------
>  1 file changed, 35 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index f7f6c3e20fae..4b6061272599 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -725,28 +725,6 @@ static void it6505_calc_video_info(struct it6505 *it6505)
>                              DRM_MODE_ARG(&it6505->video_info));
>  }
>
> -static int it6505_drm_dp_link_probe(struct drm_dp_aux *aux,
> -                                   struct it6505_drm_dp_link *link)
> -{
> -       u8 values[3];
> -       int err;
> -
> -       memset(link, 0, sizeof(*link));
> -
> -       err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
> -       if (err < 0)
> -               return err;
> -
> -       link->revision = values[0];
> -       link->rate = drm_dp_bw_code_to_link_rate(values[1]);
> -       link->num_lanes = values[2] & DP_MAX_LANE_COUNT_MASK;
> -
> -       if (values[2] & DP_ENHANCED_FRAME_CAP)
> -               link->capabilities = DP_ENHANCED_FRAME_CAP;
> -
> -       return 0;
> -}
> -
>  static int it6505_drm_dp_link_set_power(struct drm_dp_aux *aux,
>                                         struct it6505_drm_dp_link *link,
>                                         u8 mode)
> @@ -1456,11 +1434,19 @@ static void it6505_parse_link_capabilities(struct it6505 *it6505)
>         int bcaps;
>
>         if (it6505->dpcd[0] == 0) {
> -               it6505_aux_on(it6505);
> -               it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
> -                               ARRAY_SIZE(it6505->dpcd));
> +               dev_err(dev, "DPCD is not initialized");
> +               return;
>         }
>
> +       memset(link, 0, sizeof(*link));
> +
> +       link->revision = it6505->dpcd[0];
> +       link->rate = drm_dp_bw_code_to_link_rate(it6505->dpcd[1]);
> +       link->num_lanes = it6505->dpcd[2] & DP_MAX_LANE_COUNT_MASK;
> +
> +       if (it6505->dpcd[2] & DP_ENHANCED_FRAME_CAP)
> +               link->capabilities = DP_ENHANCED_FRAME_CAP;
> +
>         DRM_DEV_DEBUG_DRIVER(dev, "DPCD Rev.: %d.%d",
>                              link->revision >> 4, link->revision & 0x0F);
>
> @@ -2323,19 +2309,32 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
>  static void it6505_irq_hpd(struct it6505 *it6505)
>  {
>         struct device *dev = &it6505->client->dev;
> +       int dp_sink_count;
>
>         it6505->hpd_state = it6505_get_sink_hpd_status(it6505);
>         DRM_DEV_DEBUG_DRIVER(dev, "hpd change interrupt, change to %s",
>                              it6505->hpd_state ? "high" : "low");
>
> -       if (it6505->bridge.dev)
> -               drm_helper_hpd_irq_event(it6505->bridge.dev);
> -       DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
> -                            it6505->sink_count);
> -
>         if (it6505->hpd_state) {
>                 wait_for_completion_timeout(&it6505->wait_edid_complete,
>                                             msecs_to_jiffies(6000));
> +               it6505_aux_on(it6505);
> +               if (it6505->dpcd[0] == 0) {
> +                       it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
> +                                       ARRAY_SIZE(it6505->dpcd));
> +                       it6505_variable_config(it6505);
> +                       it6505_parse_link_capabilities(it6505);
> +               }
> +               it6505->auto_train_retry = AUTO_TRAIN_RETRY;
> +
> +               it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
> +                                            DP_SET_POWER_D0);
> +               dp_sink_count = it6505_dpcd_read(it6505, DP_SINK_COUNT);
> +               it6505->sink_count = DP_GET_SINK_COUNT(dp_sink_count);
> +
> +               DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
> +                                    it6505->sink_count);
> +
>                 it6505_lane_termination_on(it6505);
>                 it6505_lane_power_on(it6505);
>
> @@ -2363,6 +2362,9 @@ static void it6505_irq_hpd(struct it6505 *it6505)
>                 it6505_lane_off(it6505);
>                 it6505_link_reset_step_train(it6505);
>         }
> +
> +       if (it6505->bridge.dev)
> +               drm_helper_hpd_irq_event(it6505->bridge.dev);
>  }
>
>  static void it6505_irq_hpd_irq(struct it6505 *it6505)
> @@ -2625,26 +2627,14 @@ static enum drm_connector_status it6505_detect(struct it6505 *it6505)
>                 goto unlock;
>
>         if (it6505->enable_drv_hold) {
> -               status = it6505_get_sink_hpd_status(it6505) ?
> -                                       connector_status_connected :
> -                                       connector_status_disconnected;
> +               status = it6505->hpd_state ? connector_status_connected :
> +                                            connector_status_disconnected;
>                 goto unlock;
>         }
>
> -       if (it6505_get_sink_hpd_status(it6505)) {
> -               it6505_aux_on(it6505);
> -               it6505_drm_dp_link_probe(&it6505->aux, &it6505->link);
> +       if (it6505->hpd_state) {
>                 it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
>                                              DP_SET_POWER_D0);
> -               it6505->auto_train_retry = AUTO_TRAIN_RETRY;
> -
> -               if (it6505->dpcd[0] == 0) {
> -                       it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
> -                                       ARRAY_SIZE(it6505->dpcd));
> -                       it6505_variable_config(it6505);
> -                       it6505_parse_link_capabilities(it6505);
> -               }
> -
>                 dp_sink_count = it6505_dpcd_read(it6505, DP_SINK_COUNT);
>                 it6505->sink_count = DP_GET_SINK_COUNT(dp_sink_count);
>                 DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count:%d branch:%d",
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

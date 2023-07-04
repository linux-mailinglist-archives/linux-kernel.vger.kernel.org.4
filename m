Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA55747611
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGDQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:05:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E78E7A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:05:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so6679726276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688486724; x=1691078724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bIvavwh39cojjj0M3fvmyiHYK336zCUqmMtpFKq3o=;
        b=Edx4/t0jJNXA8jsWr5MU02zwuPSSLKouBlotiGVO2PEEKkYWspwsE2gmMAJ1YStbt6
         Vx2HhgcGeXS7F0/zp02eyLdLrWAS8yGBcttzJQWwVS0AOuf35FRjLAmvQqaPKsMlskKN
         MLIsdE+qEW2XzICZIVVUJQt3On/G43rhULaT5lj0YxS613ehByRGxvbLQBqTfwXkBmYO
         GS6hnVGQS+5wjc1ku0yhufRCvkIVPaA2pbl0ZflQxTmznTBfGyfag97Nk/Wl/8Pyp1GF
         AG01EEu0JswkjMoTz45AVfSotvsEZ2Q/6HBbhnc30qa6VI4AX5n57cXMIn0jlQWnvFDK
         p5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486724; x=1691078724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0bIvavwh39cojjj0M3fvmyiHYK336zCUqmMtpFKq3o=;
        b=TChVJQ/lh3c79cSjH1VOS3vxEkA5q/OX5RaBxv6XfgfN3jCCirXKRyTMc7bG4oEEH/
         8BMR744hYDIzBS0c/WFnNhmNY+ZHCGsWXQood4yP1P6VTX1HIPtT/ohWdbaductBSYBK
         d81peEGjw1YjRiulzvCt2YNmRnKROVfJG43mQmo7baWQHFKypQTB1jYk0O91Yi7sSyLA
         Y4ELPhGtmlsSxw1X5ZFVyCcSFCgfNIMkMg1cfh+1h87QzGX2pc5VtoWbAU96GLcBqSUC
         YIlpc4w348XGQOWJfpNVY3vlvjTBQFiFwzC4y69Rc9DB1+Bx9iT0W7JSg0xyT3U3ikFq
         zArg==
X-Gm-Message-State: ABy/qLZ9vwgPKot8W8o+6gQ6HLtNq1A4VaRBhsFbE0uo73n4fqUmrHVR
        TyDs+zcB1/kn+StnqbWeLd3Ppb1TWJAdRpt3WmA7fQ==
X-Google-Smtp-Source: APBJJlFq9JMvEVBMpVGYtKel274O4gRqs6omP9fI/C3ozbtpysUcbqdytZ8XTtZ+cmvgsLz4DMPYU7RNnZJ53AyW5qg=
X-Received: by 2002:a25:e789:0:b0:b9e:889:420f with SMTP id
 e131-20020a25e789000000b00b9e0889420fmr14225188ybh.12.1688486724644; Tue, 04
 Jul 2023 09:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230319125524.58803-1-aford173@gmail.com>
In-Reply-To: <20230319125524.58803-1-aford173@gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Wed, 5 Jul 2023 00:05:13 +0800
Message-ID: <CAMSo37Whxvp82i9hr-L-O4Qo9Pxkh5L+hFXqw9hNQ+asrD6oyA@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: adv7533: Fix adv7533_mode_valid for
 adv7533 and adv7535
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
        aford@beaconembedded.com, Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adam, All

On Sun, 19 Mar 2023 at 20:55, Adam Ford <aford173@gmail.com> wrote:
>
> When dynamically switching lanes was removed, the intent of the code
> was to check to make sure that higher speed items used 4 lanes, but
> it had the unintended consequence of removing the slower speeds for
> 4-lane users.
>
> This attempts to remedy this by doing a check to see that the
> max frequency doesn't exceed the chip limit, and a second
> check to make sure that the max bit-rate doesn't exceed the
> number of lanes * max bit rate / lane.
>
> Fixes: 9a0cdcd6649b ("drm/bridge: adv7533: remove dynamic lane switching from adv7533 bridge")
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>
> V2:  Fix whitespace in comment
>      Remove TODO comment
>      Add R-B from Robert.

With this change, the ACK android-mainline based hikey960 build failed
to show UI on the HDMI
monitor connected, but it works if I revert this change.
Here is the serial console output: http://ix.io/4zK8

Not sure if you have any idea what the problem is there,
and how to have it fixed.

Please let me know if you need any other information.

Thanks,
Yongqin Liu

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> index fdfeadcefe80..7e3e56441aed 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> @@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
>  enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
>                                         const struct drm_display_mode *mode)
>  {
> -       int lanes;
> +       unsigned long max_lane_freq;
>         struct mipi_dsi_device *dsi = adv->dsi;
> +       u8 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
>
> -       if (mode->clock > 80000)
> -               lanes = 4;
> -       else
> -               lanes = 3;
> -
> -       /*
> -        * TODO: add support for dynamic switching of lanes
> -        * by using the bridge pre_enable() op . Till then filter
> -        * out the modes which shall need different number of lanes
> -        * than what was configured in the device tree.
> -        */
> -       if (lanes != dsi->lanes)
> -               return MODE_BAD;
> +       /* Check max clock for either 7533 or 7535 */
> +       if (mode->clock > (adv->type == ADV7533 ? 80000 : 148500))
> +               return MODE_CLOCK_HIGH;
> +
> +       /* Check max clock for each lane */
> +       max_lane_freq = (adv->type == ADV7533 ? 800000 : 891000);
> +
> +       if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
> +               return MODE_CLOCK_HIGH;
>
>         return MODE_OK;
>  }
> --
> 2.34.1
>


--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

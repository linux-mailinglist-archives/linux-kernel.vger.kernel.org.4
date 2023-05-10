Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3D6FE83A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjEJXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:55:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAE30D3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:55:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ad819ab8a9so55519221fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683762905; x=1686354905;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRRc5cm+lCLNt6NOuK+2g/udHPs4KH+MR08zITk0G8k=;
        b=GcZWgxYpW7D7TQ25NGRi8UVNcYFhDxTezpuQz2+jDUN3kgPcpuhHcQ86bH015UyjH8
         WE3BIIrs63T84n9kHPnLnt//L/bH0qHE77RFh40FBoahN3MaCWcVl5lmm5EU44sA6Omb
         yznQlBDdLXTLW6T/DkCjG+gQ5ibfPTlyGRh5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683762905; x=1686354905;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRRc5cm+lCLNt6NOuK+2g/udHPs4KH+MR08zITk0G8k=;
        b=InanlIoWXRKdR/yAwW+ivlYIlKrvYwC8as1rxUQ/5/G6plSdqo+NfgX1uVt7Fyj22K
         X6MBCRlXQeam3EK8Ec35hRlka+NYyZ1R0/lahv3DT8V0knR8GG1MRqQOD04BcrnA+oRZ
         jIPsjPk9z30oLKXVWtq1nS4L2entZnfrMhzxofXbKg8gO595dbvUv26Y9gR4cqEjcS1R
         EE26oNpHki6bLOHAHKy0X+v+3VeyoLtdhrZTRMmsliwweoLPqERHu8gBCEsrANiipKby
         ozDLuB+JTLBafJWC4wd2q/QB5xMlnkL7KgUP29f+5YF28oto3GhuwSZpf7EKgKo1fExM
         kRhw==
X-Gm-Message-State: AC+VfDzAHgzMzWskkOEq7JTMca5HpaNSQ8cXGAz0XACtoXki47LXWHHm
        +4NTzSWt+EY0zTHKe9pKZpbgsyC5ZwQmZjXv/gVpGQ==
X-Google-Smtp-Source: ACHHUZ5iG+hjc6hPNOrzZ6MpilUrmK/xoSTR9Gpwz3JcxwOsCgl2+ZGXH4pujnW/iMjOt8Ju9di/kAYkG/rM61cEpnE=
X-Received: by 2002:a2e:80d1:0:b0:2ad:bedc:9961 with SMTP id
 r17-20020a2e80d1000000b002adbedc9961mr343846ljg.24.1683762904897; Wed, 10 May
 2023 16:55:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 May 2023 16:55:04 -0700
MIME-Version: 1.0
In-Reply-To: <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com> <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 May 2023 16:55:04 -0700
Message-ID: <CAE-0n53ywhgFhJXA9krBo-Ds6ezM0K8n6w0xnVZj+sTJ4qt9cA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged interrupts
 to hpd_enable/disable
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2023-05-10 13:31:04)
> The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
> pinmuxed into DP controller.

Was it? It looks more like it was done to differentiate between eDP and
DP, because internal_hpd is set only if DRM_BRIDGE_OP_HPD is set on the
bridge and we only set the bridge op if the connector type is DP. The
assumption looks like if you have DP connector_type, you have the gpio
pinmuxed for "dp_hot" mode, which isn't exactly true. We don't treat
that gpio as an irq either, because it isn't. Instead the gpio is muxed
to the mdss inside the SoC and then that generates an mdss interrupt
that's combined with non-HPD things like "video ready".

If that all follows, then I don't quite understand why we're setting
internal_hpd to false at all at runtime. It should be set to true at
some point, but ideally that point is during probe.

> HPD plug/unplug interrupts cannot be enabled until
> internal_hpd flag is set to true.
> At both bootup and resume time, the DP driver will enable external DP
> plugin interrupts and handle plugin interrupt accordingly. Unfortunately
> dp_bridge_hpd_enable() bridge ops function was called to set internal_hpd
> flag to true later than where DP driver expected during bootup time.
>
> This causes external DP plugin event to not get detected and display stays blank.
> Move enabling HDP plugin/unplugged interrupts to dp_bridge_hpd_enable()/disable() to
> set internal_hpd to true along with enabling HPD plugin/unplugged interrupts
> simultaneously to avoid timing issue during bootup and resume.
>
> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3e13acdf..71aa944 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>  {
>         struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>         struct msm_dp *dp_display = dp_bridge->dp_display;
> +       struct dp_display_private *dp;
> +
> +       dp = container_of(dp_display, struct dp_display_private, dp_display);
>
>         dp_display->internal_hpd = true;

Can we set internal_hpd to true during probe when we see that the hpd
pinmux exists? Or do any of these bits toggle in the irq status register
when the gpio isn't muxed to "dp_hot" or the controller is for eDP and
it doesn't have any gpio connection internally? I'm wondering if we can
get by with simply enabling the "dp_hot" pin interrupts
(plug/unplug/replug/irq_hpd) unconditionally and not worrying about them
if eDP is there (because the pin doesn't exist inside the SoC), or if DP
HPD is being signalled out of band through type-c framework.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E846A655B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCACQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCACQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:16:26 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28608305DB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:16:25 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536bbef1c5eso327578107b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MpqcIMBd2WSo0/P0DK6pbtSqbDc0TAI/eMMDgcg1TZQ=;
        b=NxPgCw/vamDZoC6wAFY0CZZqhAvRE+6GNrf2IQJUd2JkSWZXKVWV6kKpgWwEb0OuPo
         XaKvab+cusGgfUSMfwVgqQI2Mk0z6Tfd+sjDxIlar069TnmcHsII29VV8FuC/59XvDAE
         jmYzB8uOdfJfkn1912xcPkXrd2AQuW8/A8iqVeqIdXj/iqEcDgUBFKODKvYN8vqqY0YL
         GbW+3X/wGZvvZx08fiQ4cYhUBmV9UERTg9cBw+xYTdo9ox/4Wm9CPaGVhSeMNh9r6at9
         pKRnPlfhCB9BO4u9vkXsoV/nTL2UaKR6kuF+HpVeIpHCUXEuEMx4Z7gRdPYb75bX/L7A
         G7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpqcIMBd2WSo0/P0DK6pbtSqbDc0TAI/eMMDgcg1TZQ=;
        b=sD199YXqLwR2LJJt/9VccehFUnGGW6lhPq5dafWHj5rdTaCsSZ+ZTnjurAMnItHW2K
         y9kULdY8EXzDMavWAS3jo0Kr1L3MwOVi3NGeh5xCgaCUQ+P6Da7eZ/940WDn3Lfe3NrP
         92EiFv0BwOOMVIoeQnKbuV9P7e+OCuzhQd03wK4moyL20k2MtWWaf/wrhEnlQITP5gMg
         9AZEMpsOFFs7DhHH/MLSUH/uNm0Ayeo3RUx+/o2Fe74QDCHJxeoZ3cHVF987Gb7AvNmW
         /7KSG8FfkF5WjbH4uNG8Y7dU+F0EIxm5Swue4R4HyYm8QZQcL6t65MWsxLh+NWOTh+ps
         qNrw==
X-Gm-Message-State: AO0yUKUg0YfyhB1zPWSMAh+J3K+Abfrld9vf6zPdSXBKKu/S1NgvcLBh
        AoH4tzOh0hlHsZHYXUnv7TjKT3yj+pmoPDWtlo26xw==
X-Google-Smtp-Source: AK7set9Lp1Gh0mv/hx+7TRqP5+gdVfavRb+ucnWIMkd1Ht+MXDm9xptjUJoSoQMr+b9FBRyoF4PG1TI0vTGM/G+2nhA=
X-Received: by 2002:a81:b609:0:b0:52f:24ac:9575 with SMTP id
 u9-20020a81b609000000b0052f24ac9575mr2900807ywh.3.1677636984029; Tue, 28 Feb
 2023 18:16:24 -0800 (PST)
MIME-Version: 1.0
References: <1677629817-18891-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1677629817-18891-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Mar 2023 04:16:12 +0200
Message-ID: <CAA8EJpquZAhn+HswNxardN1fE8Zu1CKrCU5EiX=B8mGWuxfWnQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: check core_initialized flag at both
 host_init() and host_deinit()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 at 02:17, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> There is a reboot/suspend test case where system suspend is forced
> during system booting up. Since dp_display_host_init() of external
> DP is executed at hpd thread context, this test case may created a
> scenario that dp_display_host_deinit() from pm_suspend() run before
> dp_display_host_init() if hpd thread has no chance to run during
> booting up while suspend request command was issued. At this scenario
> system will crash at aux register access at dp_display_host_deinit()
> since aux clock had not yet been enabled by dp_display_host_init().
> Therefore we have to ensure aux clock enabled by checking
> core_initialized flag before access aux registers at pm_suspend.

Can a call to dp_display_host_init() be moved from
dp_display_config_hpd() to dp_display_bind()?

Related question: what is the primary reason for having
EV_HPD_INIT_SETUP and calling dp_display_config_hpd() via the event
thread? Does DP driver really depend on DPU irqs being installed? As
far as I understand, DP device uses MDSS interrupts and those IRQs are
available and working at the time of dp_display_probe() /
dp_display_bind().

>
> Changes in v2:
> -- at commit text, dp_display_host_init() instead of host_init()
> -- at commit text, dp_display_host_deinit() instead of host_deinit()
>
> Changes in v3:
> -- re arrange to avoid commit text line over 75 chars
>
> Fixes: 989ebe7bc446 ("drm/msm/dp: do not initialize phy until plugin interrupt received")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bde1a7c..1850738 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -460,10 +460,12 @@ static void dp_display_host_init(struct dp_display_private *dp)
>                 dp->dp_display.connector_type, dp->core_initialized,
>                 dp->phy_initialized);
>
> -       dp_power_init(dp->power, false);
> -       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
> -       dp_aux_init(dp->aux);
> -       dp->core_initialized = true;
> +       if (!dp->core_initialized) {
> +               dp_power_init(dp->power, false);
> +               dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
> +               dp_aux_init(dp->aux);
> +               dp->core_initialized = true;
> +       }
>  }
>
>  static void dp_display_host_deinit(struct dp_display_private *dp)
> @@ -472,10 +474,12 @@ static void dp_display_host_deinit(struct dp_display_private *dp)
>                 dp->dp_display.connector_type, dp->core_initialized,
>                 dp->phy_initialized);
>
> -       dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
> -       dp_aux_deinit(dp->aux);
> -       dp_power_deinit(dp->power);
> -       dp->core_initialized = false;
> +       if (dp->core_initialized) {
> +               dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
> +               dp_aux_deinit(dp->aux);
> +               dp_power_deinit(dp->power);
> +               dp->core_initialized = false;
> +       }
>  }
>
>  static int dp_display_usbpd_configure_cb(struct device *dev)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry

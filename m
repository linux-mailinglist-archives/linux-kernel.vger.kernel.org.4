Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7281266410E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjAJNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjAJNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:01:18 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370443A02;
        Tue, 10 Jan 2023 05:01:17 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id hw16so16509578ejc.10;
        Tue, 10 Jan 2023 05:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxx6b96F/GbifE+0yZegiyb9QfHT/zLsmW4yv+mj9W4=;
        b=rvmq/25LYh3cgC1DDpHNEpPmXLNePvJu/D/mdSNFrTmJaMDL5Qp9fXOBwPmR1WLn2d
         U6YtRttoizXMOCrilSsJMmnrR9GbUbVvBRexR1mLdCNi/S7COwSc3Q1D1tno+8LVYdwt
         laVRSSd5NdBfNpdW52dZMR9zMw2ffUSqKHG1/U/wIfNze7FNk64+tIjTyH01DkB3h3pd
         NDtKqZj0cKn2SOeaSNCuzIkXD5jIIaBzi/jRIFwY5zlTEi1hlwcKbkzwNUmCMFEL/Qlx
         YOjyTF8iR5yVArGM4kai+NOcakF63SCnvSapsOiwgt4Owxx3jo1XFFJuQSXBSpvlVCYu
         UMYA==
X-Gm-Message-State: AFqh2krKZzjkgaTESSKRQjKYv5RiFeo+qFOr9yjXGzjgOfp80nb9FDxF
        NxpZkO7aQEIWWv2cdRoD7urKuJHiL4BUOKoMvTSMMRjD
X-Google-Smtp-Source: AMrXdXtgYXCLfI52JRQ/Dqj47nuocYfJJLayKQtkWoAYrtYkneV3Nrnud3rZTOcoxNr6nWYeViLeGlUHMgYXuzRYhng=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr1277722ejx.509.1673355675867; Tue, 10
 Jan 2023 05:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
In-Reply-To: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 14:01:04 +0100
Message-ID: <CAJZ5v0hFrevTR4KkO0VDB8YQC60cgDkDKQT3kdQAk-VoOJoZhg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom: Remove duplicate set next trip
 point interrupt code
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:34 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> The tsens driver reprogram the next trip points in the irq
> handler. This function then call thermal_zone_device_update().
>
> However, thermal_zone_device_update() calls thermal_zone_set_trips()
> and from there it calls the backend 'set_trips' ops. This one in turn
> reprogram the next trip points (low/high).
>
> Consequently, the code setting the next trip points interrupt in the
> interrupt handle is not needed and could be removed.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>

I'm wondering what you wanted to say through these S-o-b tags.

I don't think you have to sign off your own patch again.

> ---
>  drivers/thermal/qcom/tsens.c | 46 +-----------------------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b5b136ff323f..58693ee8c430 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -472,52 +472,8 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>                         continue;
>                 if (!tsens_threshold_violated(priv, hw_id, &d))
>                         continue;
> -               ret = get_temp_tsens_valid(s, &temp);
> -               if (ret) {
> -                       dev_err(priv->dev, "[%u] %s: error reading sensor\n",
> -                               hw_id, __func__);
> -                       continue;
> -               }
>
> -               spin_lock_irqsave(&priv->ul_lock, flags);
> -
> -               tsens_read_irq_state(priv, hw_id, s, &d);
> -
> -               if (d.up_viol &&
> -                   !masked_irq(hw_id, d.up_irq_mask, tsens_version(priv))) {
> -                       tsens_set_interrupt(priv, hw_id, UPPER, disable);
> -                       if (d.up_thresh > temp) {
> -                               dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> -                                       hw_id, __func__);
> -                               tsens_set_interrupt(priv, hw_id, UPPER, enable);
> -                       } else {
> -                               trigger = true;
> -                               /* Keep irq masked */
> -                       }
> -               } else if (d.low_viol &&
> -                          !masked_irq(hw_id, d.low_irq_mask, tsens_version(priv))) {
> -                       tsens_set_interrupt(priv, hw_id, LOWER, disable);
> -                       if (d.low_thresh < temp) {
> -                               dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
> -                                       hw_id, __func__);
> -                               tsens_set_interrupt(priv, hw_id, LOWER, enable);
> -                       } else {
> -                               trigger = true;
> -                               /* Keep irq masked */
> -                       }
> -               }
> -
> -               spin_unlock_irqrestore(&priv->ul_lock, flags);
> -
> -               if (trigger) {
> -                       dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> -                               hw_id, __func__, temp);
> -                       thermal_zone_device_update(s->tzd,
> -                                                  THERMAL_EVENT_UNSPECIFIED);
> -               } else {
> -                       dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> -                               hw_id, __func__, temp);
> -               }
> +               thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
>
>                 if (tsens_version(priv) < VER_0_1) {
>                         /* Constraint: There is only 1 interrupt control register for all
> --
> 2.34.1
>

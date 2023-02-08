Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA65A68F41B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBHROJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBHROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:14:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5871C7FC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:14:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jg8so13190328ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNCNsQd95KkPPYVE5Xn6suXE13YKHSzEDImJA4YDVGk=;
        b=Crlcgrcx5e/Hl3G9vyX8MSvRJdSOZgNN67aBRcQZzZJ3f1M+kTzLTUL0L7J8W7NAqO
         QcwnIlGMqgY//2VLb5IjsH8hMGQbnUEOTEZv+hhuVpzXmqfunzAvlUjKWta6LPZVaegU
         aBS/AKq3HlszzzrRPLpvP9ityCtmkH9DrBbzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNCNsQd95KkPPYVE5Xn6suXE13YKHSzEDImJA4YDVGk=;
        b=Mj2o8h6+mqpcJFtcDRLPSZEfVzi93dB3DGNZEdt4V3CIbHekVZhnQNrdZeXRboCXhF
         d6LJjec6CArwy6V6VeRoL93oUH3oX+iJnUD9Am66wGrEtBtJ6Z/lxfcRraMW4bAoPR3U
         xYHXUTW6Xf3atA8XXtONNL4YCDoqX+/oAnntFVHdOKOfjVqPFQNhty+3npgk4FpmKR8h
         YotuedVsME+MbbMYWTZpPzYSOvkCNMoYKifpDZmCSc3HCtMHdb9YmcLa+QTjdYYhQdat
         KfAM2CS6DX0CbBXaU6GHIWWivXCqzlRqSIq3KDMHyzrlZ/qi/dLFyEn5wlxMHnWBDf60
         aiDg==
X-Gm-Message-State: AO0yUKVvN2/hesPGraGb+nqdsP49OdOwglA+lM8wwxHDJTzzHK8UU+DA
        N+PhsaPduxVNfBz6NvSiWSnDbuij/9nAZmZCkbc=
X-Google-Smtp-Source: AK7set8/U4UhL/j4Fs/QE14AtyEXqaSyxt3TF5OslrsSAKTU7toKowosqAtOKAO8HqK5S8XbNbtaPA==
X-Received: by 2002:a17:906:4408:b0:78d:f456:1ed0 with SMTP id x8-20020a170906440800b0078df4561ed0mr4147851ejo.33.1675876438676;
        Wed, 08 Feb 2023 09:13:58 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id kb18-20020a1709070f9200b0088ef3c38a52sm8667713ejc.19.2023.02.08.09.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:13:57 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id e3so715492wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:13:57 -0800 (PST)
X-Received: by 2002:adf:da42:0:b0:2c3:d98e:21 with SMTP id r2-20020adfda42000000b002c3d98e0021mr161800wrl.690.1675876437492;
 Wed, 08 Feb 2023 09:13:57 -0800 (PST)
MIME-Version: 1.0
References: <1675863724-28412-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1675863724-28412-1-git-send-email-quic_kalyant@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Feb 2023 09:13:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WbzmF_Jkwrcm27eqXaqNhGq_D=8yfCKqELET+=+EaLAA@mail.gmail.com>
Message-ID: <CAD=FV=WbzmF_Jkwrcm27eqXaqNhGq_D=8yfCKqELET+=+EaLAA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Reserve DSPPs based on user request
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 8, 2023 at 5:42 AM Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> This series will enable color features on sc7280 target which has
> primary panel as eDP
>
> The series removes DSPP allocation based on encoder type and allows
> the DSPP reservation based on user request via CTM.
>
> The series will release/reserve the dpu resources when ever there is
> a topology change to suit the new requirements.
>
> Kalyan Thota (4):
>   drm/msm/dpu: clear DSPP reservations in rm release
>   drm/msm/dpu: add DSPPs into reservation upon a CTM request
>   drm/msm/dpu: avoid unnecessary check in DPU reservations
>   drm/msm/dpu: reserve the resources on topology change
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 58 ++++++++++++++++-------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 +
>  3 files changed, 37 insertions(+), 25 deletions(-)

I tried out your changes, but unfortunately it seems like there's
something wrong. :( I did this:

1. Picked your 5 patches to the chromeos-5.15 tree (this series plus [1])

2. Put them on herobrine villager.

3. Booted up with no external display plugged in.

4. Tried to enable night light in the ChromeOS UI.

5. Night light didn't turn on for the internal display.


I also tried applying them to the top of msm-next (had to resolve some
small conflicts). Same thing, night light didn't work.


I thought maybe this was because the Chrome browser hasn't been
updated to properly use atomic_check for testing for night light, so I
hacked my herobrine device tree to not mark "mdss_dp" as "okay". Now
there's _only_ an eDP display. Same thing, night light didn't work.


I could only get night light to work for the internal display if I
plugged and unplugged an external display in.


Is the above the behavior that's expected right now?


[1] https://lore.kernel.org/all/1674814487-2112-1-git-send-email-quic_kalyant@quicinc.com/

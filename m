Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBE67DB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 02:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjA0BUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 20:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjA0BUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:20:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151E35A0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:20:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vw16so9759856ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CF01fh/f0hITGD+MQzyiKhCXqnGsvJyZ9uRxx+H98MU=;
        b=dvJ1aGnFt1pS3es/e/WqL8ToqRyNvrS6b+rH6MEGmZD2ICAYISfVAHWE3cpKE8+7AW
         rXDdDtrUF5/yOT3M2hz8YMcS3jrmIIqXTZdHjOHsFunoFUw51j2DqWgQxG4apAXVW7Mm
         c7mQEq8JDpOf+Mwf4us1d/to+qbbqh+uzkQzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CF01fh/f0hITGD+MQzyiKhCXqnGsvJyZ9uRxx+H98MU=;
        b=MA3OMVWElI+DjuiR6oG8Chv81x5ISD743mE+hNoPi5zGl5KUmwX2DsIFn76LKh/1HA
         rsTDQpqn+XWLceec0+9EDlkFTeVZkJ2Vxgrgz7laHxSBxKRB22xoVA/Auo1aIZqif9Kd
         HFxzPpyglZpEzhmINLPiuUqiDdTdyMfDUjs4LiVBm1pRLnrLQ52/40L6t3Hd+7XezisN
         tvCl9coOBeNAh4SuUooaDLcXRYYhyPfTqV5IlbB2NbbTMKzwmhAnCJ2EbJy4BE9BayMh
         UJ5G+3qyB28yMIq+hGsslw70kEhFBNPjuT2rjiX+RiG3PmVcqlnbwKgRRxz6lsYQsnVM
         8TDA==
X-Gm-Message-State: AO0yUKWgys1p7xwgnY1P4KijemN4eMBcHbKIorajcyBvLPvebZUMCu0+
        45mhVV7qy/C8C/tdf0FLTDCs5h6avbU9vGTPdpI=
X-Google-Smtp-Source: AK7set/CNgv2vlifgvsMDefYaYLLLRYqkpKODxzgdlWPzuQVEEOXnzcPujVUlP+6OBjt7mxVGWZobg==
X-Received: by 2002:a17:906:f1cb:b0:878:78bc:975c with SMTP id gx11-20020a170906f1cb00b0087878bc975cmr3234870ejb.36.1674782405969;
        Thu, 26 Jan 2023 17:20:05 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id cm20-20020a170907939400b0086f40238403sm1345630ejc.223.2023.01.26.17.20.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 17:20:05 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id m7so3628384wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:20:05 -0800 (PST)
X-Received: by 2002:a5d:6b51:0:b0:2bf:c5cc:e1d6 with SMTP id
 x17-20020a5d6b51000000b002bfc5cce1d6mr99974wrw.659.1674782025133; Thu, 26 Jan
 2023 17:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20230113155547.RFT.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
 <20230113155547.RFT.2.I4cfeab9d0e07e98ead23dd0736ab4461e6c69002@changeid>
In-Reply-To: <20230113155547.RFT.2.I4cfeab9d0e07e98ead23dd0736ab4461e6c69002@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Jan 2023 17:13:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_FhzyZFiJT3hYnURpuM7VvnR_RDBufCcwXu+H2obxgw@mail.gmail.com>
Message-ID: <CAD=FV=U_FhzyZFiJT3hYnURpuM7VvnR_RDBufCcwXu+H2obxgw@mail.gmail.com>
Subject: Re: [RFT PATCH 2/2] drm/msm/dsi: Stop unconditionally powering up DSI
 hosts at modeset
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 13, 2023 at 3:56 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> time"), we moved powering up DSI hosts to modeset time. This wasn't
> because it was an elegant design, but there were no better options.
>
> That commit actually ended up breaking ps8640, and thus was born
> commit ec7981e6c614 ("drm/msm/dsi: don't powerup at modeset time for
> parade-ps8640") as a temporary hack to un-break ps8640 by moving it to
> the old way of doing things. It turns out that ps8640 _really_ doesn't
> like its pre_enable() function to be called after
> dsi_mgr_bridge_power_on(). Specifically (from experimentation, not
> because I have any inside knowledge), it looks like the assertion of
> "RST#" in the ps8640 runtime resume handler seems like it's not
> allowed to happen after dsi_mgr_bridge_power_on()
>
> Recently, Dave Stevenson's series landed allowing bridges some control
> over pre_enable ordering. The meaty commit for our purposes is commit
> 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter
> bridge init order"). As documented by that series, if a bridge doesn't
> set "pre_enable_prev_first" then we should use the old ordering.
>
> Now that we have the commit ("drm/bridge: tc358762: Set
> pre_enable_prev_first") we can go back to the old ordering, which also
> allows us to remove the ps8640 special case.
>
> One last note is that even without reverting commit 7d8e9a90509f
> ("drm/msm/dsi: move DSI host powerup to modeset time"), if you _just_
> revert the ps8640 special case and try it out then it doesn't seem to
> fail anymore. I spent time bisecting / debugging this and it turns out
> to be mostly luck, so we still want this patch to make sure it's
> solid. Specifically the reason it sorta works these days is because
> we implemented wait_hpd_asserted() in ps8640 now, plus the magic of
> "pm_runtime" autosuspend. The fact that we have wait_hpd_asserted()
> implemented means that we actually power the bridge chip up just a wee
> bit earlier and then the bridge happens to stay on because of
> autosuspend and thus ends up powered before dsi_mgr_bridge_power_on().
>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 68 +++++----------------------
>  1 file changed, 11 insertions(+), 57 deletions(-)

Does anyone have any comments on this patch series? It would probably
make sense to wait to land until early in a kernel's release cycle, so
perhaps there is no hurry. That being said, it would still be good to
know what the plan is.

Abhinav: I think you're the one that was most concerned with removing
the special case for ps8640. Does that mean you'd be willing to review
this patch?

For whether or not the "tc358762" panel works with the MSM display
driver after this series, are the correct people on this thread?

Thanks!

-Doug

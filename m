Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F516F9DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 04:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjEHCL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEHCL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:11:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3441982;
        Sun,  7 May 2023 19:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B96861DF5;
        Mon,  8 May 2023 02:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4EEC433EF;
        Mon,  8 May 2023 02:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683511915;
        bh=W+BDWcTwbvNWQBCgt9uZZKh6zOCIi71k2crWd1L3W+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwpOfcoQzugMTe6nrRk10AeVJ9UQT/ItdgdISy7DTqoikrRz7Vrv19tbRp/olkgV8
         UBkjm8j7t9GSZPAgHoCls3WCNgnbSQXRf3ZhOdMELvr3rXsYAfpcEYG5Br5ho9atNt
         Z55/nHxH0BlmftEffctJVa/X4ADi1yAzrawwLAglJRzFJ1EUHjOYOlcV4FxZiBgXjU
         0q3LdRMHxvI7Yt17Ip2XdG0QclnuZjPEgGo93iPi4NuG6a3nBDbIl/QjhmTvpSv4fa
         RbizSWsueFK5ilHy2NvIztJrlGKzTk0eSEzrxhiJOKmAOBO7LUTWPxCnr8zjyMscRS
         2i8vHZAd7BNVw==
Date:   Sun, 7 May 2023 19:15:36 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Leonard Lausen <leonard@lausen.nl>
Cc:     regressions@lists.linux.dev,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH] Revert "drm/msm/dp: Remove INIT_SETUP delay"
Message-ID: <20230508021536.txtamifw2vkfncnx@ripper>
References: <ebbcd56ac883d3c3d3024d368fab63d26e02637a@lausen.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbcd56ac883d3c3d3024d368fab63d26e02637a@lausen.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 01:06:13AM +0000, Leonard Lausen wrote:
> This reverts commit e17af1c9d861dc177e5b56009bd4f71ace688d97.
> 
> Removing the delay of 100 units broke hot plug detection for USB-C displays on
> qcom sc7180 lazor devices. Lazor uses mdss for hot plug detection and declares
> dp_hot_plug_det in the dts. Other sc7180 based devices like aspire1 were not
> affected by the regression, as they do not rely on mdss and dp_hot_plug_det for
> hot plug detection.
> 
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> Tested-by: Leonard Lausen <leonard@lausen.nl> # Trogdor (sc7180)
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bde1a7ce442f..db9783ffd5cf 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1506,7 +1506,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>         dp = container_of(dp_display, struct dp_display_private, dp_display);
>  
>         if (!dp_display->is_edp)
> -               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
> +               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);

When booting with the cable connected on my X13s, 100 is long enough for
my display to time out and require me to disconnect and reconnect the
cable again.

Do we have any idea of why the reduction to 0 is causing an issue when
using the internal HPD?

Regards,
Bjorn

>  }
>  
>  bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
> -- 
> 2.30.2

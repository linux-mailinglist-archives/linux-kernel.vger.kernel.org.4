Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33698664739
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjAJRRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjAJRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:17:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD7354DA0;
        Tue, 10 Jan 2023 09:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8281BCE1799;
        Tue, 10 Jan 2023 17:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996A5C433D2;
        Tue, 10 Jan 2023 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673371016;
        bh=iwpyzqVQok4g2qkFvOCpfycpEy0u8yaiB88caR2d+yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFlSHcAy0NVD0oYNOUp4HIjmISXck5EjgZpyTmX54tPypcLovVkFVVpnudqYpDO9K
         UplsOHprYvZuBJWXROow17T1QSPJ9QZQ54qHZ7K+4lIImwm21BkKOyDX/y6aNRNvIE
         YOpOjPeo1MC8X78tpaaZcAaMnqfo/1PzI3LMkc9s/RTBpOn7HtDmwPMLtFlftePR1Z
         dAvWgG/yUp0DYlqlctwKty89d/SAmKWqT6wyI1dHKOOf4q5AptgEh75dVt0mY/JWx+
         HcyXcmbv91fqoUnJSNq1nvDjzZ57STNdv1N6O+WPWU7RKaEQSN9AqknmRWvvddHlxI
         yLxzhbWz+WeNg==
Date:   Tue, 10 Jan 2023 11:16:52 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>, Chia-I Wu <olvaffe@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Len Brown <len.brown@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Improve GPU reset sequence for Adreno GPU
Message-ID: <20230110171652.ur5zgdwvjj3kaimj@builder.lan>
References: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:18:26PM +0530, Akhil P Oommen wrote:
> 
> This is a rework of [1] using genpd instead of 'reset' framework.
> 
> As per the recommended reset sequence of Adreno gpu, we should ensure that
> gpucc-cx-gdsc has collapsed at hardware to reset gpu's internal hardware states.
> Because this gdsc is implemented as 'votable', gdsc driver doesn't poll and
> wait until its hw status says OFF.
> 
> So use the newly introduced genpd api (dev_pm_genpd_synced_poweroff()) to
> provide a hint to the gdsc driver to poll for the hw status and use genpd
> notifier to wait from adreno gpu driver until gdsc is turned OFF.
> 
> This series is rebased on top of linux-next (20221215) since the changes span
> multiple drivers.
> 
> [1] https://patchwork.freedesktop.org/series/107507/
> 

@Rob, please find the PM and gdsc implementation changes picked up here:

  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git tags/1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com

Regards,
Bjorn

> Changes in v5:
> - Capture all Reviewed-by tags
> 
> Changes in v4:
> - Update genpd function documentation (Ulf)
> 
> Changes in v3:
> - Rename the var 'force_sync' to 'wait (Stephen)
> 
> Changes in v2:
> - Minor formatting fix
> - Select PM_GENERIC_DOMAINS from Kconfig
> 
> Akhil P Oommen (4):
>   clk: qcom: gdsc: Support 'synced_poweroff' genpd flag
>   drm/msm/a6xx: Vote for cx gdsc from gpu driver
>   drm/msm/a6xx: Remove cx gdsc polling using 'reset'
>   drm/msm/a6xx: Use genpd notifier to ensure cx-gdsc collapse
> 
> Ulf Hansson (1):
>   PM: domains: Allow a genpd consumer to require a synced power off
> 
>  drivers/base/power/domain.c           | 26 ++++++++++++++++++++
>  drivers/clk/qcom/gdsc.c               | 11 +++++----
>  drivers/gpu/drm/msm/Kconfig           |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 46 ++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  7 ++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 +++++++---
>  drivers/gpu/drm/msm/msm_gpu.c         |  4 ---
>  drivers/gpu/drm/msm/msm_gpu.h         |  4 ---
>  include/linux/pm_domain.h             |  5 ++++
>  9 files changed, 97 insertions(+), 20 deletions(-)
> 
> -- 
> 2.7.4
> 

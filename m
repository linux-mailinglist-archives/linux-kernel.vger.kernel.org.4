Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66874C067
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 04:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGICac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 22:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGICaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 22:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4482D3;
        Sat,  8 Jul 2023 19:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4718960B33;
        Sun,  9 Jul 2023 02:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512C8C433C7;
        Sun,  9 Jul 2023 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688869828;
        bh=ItIXstYBIf26ydCVUwNTGQ8bzQETS0wWyOugToWg6xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rljtrtr6N1Xg7x+eEkOzkkjBTpfqiPR4gddlslCXE5hpN5FsiP7h8xeap44eWqx7D
         jzIcl1iLR7Li9APPIOpJX3KG/0FcUGDM+/TbcejzQVXKJpZpkkyfbzC+CnHsWC15pK
         LWqkJMdMOi4wX/qzJY6ZrnGjE8x57EyFcHyWYvJeRrgZLbveMHDhpwIKIhnCaL9p9X
         F+HoGbug16qmmnB/iPxbKnCwEjJGtHnZtuc7EV35Aj8uBpNd548gdqyVa4OJICoGGf
         V8y4mEfYhbSEaRcPCYy4LzXJbnUeZeHAHEByytT01QrAm5S0EsSKac3C2bW0KJMnJZ
         ShuMY4wtatn+g==
Date:   Sat, 8 Jul 2023 19:34:05 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] drm/msm/dp: remove pm_runtime_xxx() from
 dp_power.c
Message-ID: <fiq6zjzptjdnktdcofyqpaqf2gmddvkschebp7imlmfxatew3x@iaptll3dzfuf>
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-2-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688773943-3887-2-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:52:19PM -0700, Kuogee Hsieh wrote:
> Since both pm_runtime_resume() and pm_runtime_suspend() are not
> populated at dp_pm_ops. Those pm_runtime_get/put() functions within
> dp_power.c will not have any effects in addition to increase/decrease
> power counter. Also pm_runtime_xxx() should be executed at top
> layer.
> 

Getting/putting the runtime PM state affects the vote for the GDSC. So I
would suggest that you move this after patch 2, to not create a gap in
the git history of lacking GDSC votes.

Regards,
Bjorn

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_power.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
> index 5cb84ca..ed2f62a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_power.c
> +++ b/drivers/gpu/drm/msm/dp/dp_power.c
> @@ -152,8 +152,6 @@ int dp_power_client_init(struct dp_power *dp_power)
>  
>  	power = container_of(dp_power, struct dp_power_private, dp_power);
>  
> -	pm_runtime_enable(power->dev);
> -
>  	return dp_power_clk_init(power);
>  }
>  
> @@ -162,8 +160,6 @@ void dp_power_client_deinit(struct dp_power *dp_power)
>  	struct dp_power_private *power;
>  
>  	power = container_of(dp_power, struct dp_power_private, dp_power);
> -
> -	pm_runtime_disable(power->dev);
>  }
>  
>  int dp_power_init(struct dp_power *dp_power)
> @@ -173,11 +169,7 @@ int dp_power_init(struct dp_power *dp_power)
>  
>  	power = container_of(dp_power, struct dp_power_private, dp_power);
>  
> -	pm_runtime_get_sync(power->dev);
> -
>  	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
> -	if (rc)
> -		pm_runtime_put_sync(power->dev);
>  
>  	return rc;
>  }
> @@ -189,7 +181,6 @@ int dp_power_deinit(struct dp_power *dp_power)
>  	power = container_of(dp_power, struct dp_power_private, dp_power);
>  
>  	dp_power_clk_enable(dp_power, DP_CORE_PM, false);
> -	pm_runtime_put_sync(power->dev);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

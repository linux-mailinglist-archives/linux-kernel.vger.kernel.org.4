Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C015BB2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIPTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiIPTlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C10B602C;
        Fri, 16 Sep 2022 12:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1E2762704;
        Fri, 16 Sep 2022 19:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A04C433C1;
        Fri, 16 Sep 2022 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663357308;
        bh=abOH/0AmoJ5GaDO1EHkCbeHCNHqfGmKzUL4rbE6xHps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSqYefzeIDNDLoDv+tC3169gvScEydgtr+b4JvapK1eNB9lwNbbFuxzzrgtQrVuYu
         ClJncsVph6zFQQJIZF2ucpIiNCIp7F9hm1DfqHv8L68KDeiczYCQrucbY5bB/12G93
         fiRx6zAERa+OjyN6aK2AzMIP9nYvmjVWD7PvdBe6fmjO17t5zfqMJD5gnQ5GeGdY7m
         9T69c8SvTc+Bdgysl6B9d8h2hprfoHLrlzCCmIbjsdZ6IeRMZZ1Kw3tK4CldkUh3Oa
         3ioTJ1KZRoqkqIv1EF8f9Xjrg85aUyMMrPrHbjUj8sJCQRAa9NpyacbdFOwZHh76Uv
         n9DMdl1+rTC5A==
Date:   Fri, 16 Sep 2022 14:41:45 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdscs
Message-ID: <20220916194145.ec25i3ph3u6p5mhz@builder.lan>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
 <20220916102417.24549-3-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916102417.24549-3-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:54:17PM +0530, Rajendra Nayak wrote:
> The USB controllers on sc7280 do not retain the state when
> the system goes into low power state and the GDSCs are
> turned off. This results in the controllers reinitializing and
> re-enumerating all the connected devices (resulting in additional
> delay while coming out of suspend)
> Fix this by updating the .pwrsts for the USB GDSCs so they only
> transition to retention state in low power.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
> v2:
> *Updated the changelog
> *Updated .pwrsts for gcc_usb30_sec_gdsc
> 
>  drivers/clk/qcom/gcc-sc7280.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 7ff64d4d5920..7b6e5a86c11f 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -3126,7 +3126,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
>  	.pd = {
>  		.name = "gcc_usb30_prim_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  	.flags = VOTABLE,
>  };
>  
> @@ -3135,7 +3135,7 @@ static struct gdsc gcc_usb30_sec_gdsc = {
>  	.pd = {
>  		.name = "gcc_usb30_sec_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  	.flags = VOTABLE,
>  };
>  
> -- 
> 2.17.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEE6168C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiKBQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKBQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:28:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2AA11C11;
        Wed,  2 Nov 2022 09:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F08B823C0;
        Wed,  2 Nov 2022 16:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EACC433C1;
        Wed,  2 Nov 2022 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667406209;
        bh=KAUYkNDElfqZbLWslfyhLBCbvIgG2boL2USce5w0SuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNU/w5LmJ90ySCfOHvrPDP6sRkqfmFtNG4on+782B7kLkKejL9BAytAXWZrAWAfey
         cKGVROHBDvbVGrjUqSOVGW/ZGAS5DWu8LxPs9jVKysFgBtECNHmqufUMZyUOYeAR85
         7CQwrEX5ZMhB74+uvKHCz/NHVsX0+Zoe6tF4LqMvLCek73AA+p+MdB8nvrzvZc7Ed0
         OTw580ieh9+oJL/kTKZUEQgRA2flPodlhHRtBnAIkgkniIA9BDoXuCaq4G7Ei/+te1
         sUeDk7Bh6F0cvI1AJJOmP26rU/xDXIl8T1Psbxmagvv3qWTgvZFnrEbKaMy5LCRMYQ
         Ahx3IphMCRJ2w==
Date:   Wed, 2 Nov 2022 21:53:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: suppress probe-deferral
 error message
Message-ID: <20221102162316.GB10650@thinkpad>
References: <20221102152630.696-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102152630.696-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:26:30PM +0100, Johan Hovold wrote:
> Drivers should not be logging errors on probe deferral. Switch to using
> dev_err_probe() to log failures when parsing the devicetree to avoid
> errors like:
> 
> 	qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: get dt data failed: -517
> 
> when a channel is not yet available.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I did send a patch earlier for fixing this same issue but I did not use
dev_err_probe(). So yours is better.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index a3310bf061cb..c70615d2d771 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -1031,10 +1031,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
>  		return irq;
>  
>  	ret = adc_tm5_get_dt_data(adc_tm, node);
> -	if (ret) {
> -		dev_err(dev, "get dt data failed: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "get dt data failed\n");
>  
>  	ret = adc_tm->data->init(adc_tm);
>  	if (ret) {
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்

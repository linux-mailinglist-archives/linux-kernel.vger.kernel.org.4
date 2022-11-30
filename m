Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5A63CF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiK3G6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3G6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:58:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871C45EDA;
        Tue, 29 Nov 2022 22:58:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B407619FF;
        Wed, 30 Nov 2022 06:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AF6C433C1;
        Wed, 30 Nov 2022 06:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669791518;
        bh=UPn87SuCEaBIS5BcR3nzG+AStBcEMcDjQCg0b/Pfris=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkGfwcnDyw54vqozJHYqlMT7Siv1hrXyXBCYM4IYqISraXT0Q/fXwH/g9yJ63Wnx1
         XRBHgB1qxrACQCw0YFZFl5J5NekrTfYDlFkiNRNVrCAG0aByEbF0cJX0lV3F+AaBVF
         OPNGv2mo1ivIhWOQXb6VnrVEZ+0fvp4AOEDWyGQEIYhT/k9xUgL2YsHgF2AUuE48FM
         j3aDE0HMRD0LA9OuvRF0bOrEv09/JyKHSMxcgVeEcGuu/VMica32ug1LDohpZXgXE7
         XN7XUBLFuahhnmmMrHab55JBKixLyBRTkjCrRWLUAmCLf3l1qkYrNUnq+Nwzd5lZOW
         W6iSyWnxANjqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p0H3I-0007jD-1p; Wed, 30 Nov 2022 07:58:40 +0100
Date:   Wed, 30 Nov 2022 07:58:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: suppress probe-deferral
 error message
Message-ID: <Y4b/IO803WgKBLwB@hovoldconsulting.com>
References: <20221102152630.696-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152630.696-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Daniel, I noticed this one hasn't been picked up yet (at least it's not
in linux-next). Is this something you can do?

Johan

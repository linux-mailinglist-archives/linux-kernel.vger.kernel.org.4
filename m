Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6073661E015
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKFDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFDHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3618210570;
        Sat,  5 Nov 2022 20:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6811F60BD8;
        Sun,  6 Nov 2022 03:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A410C433D6;
        Sun,  6 Nov 2022 03:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667704020;
        bh=Jagm3MAZ1Z2GYUR/+6mlxL7KLe67vaL13GUEjcal0WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGcP6KYNzpVZLoNAFeCljsJ133ORZrXVTj1idBvGIi4GmwF8PlAzNUF3C5Okwxake
         MiQH/hCPJN5ofQ2klINVQ4VzKskri7YL5V63hxSzPLuUYQHa0sZpSrXzHYqUxE3j81
         Hji4ihFTKWJyYJqf8epwZqQm4uUJS40kZXvms3KxwTPzuDXA7ee5ejavlRbukw+SCE
         tkaTqmDB4XhB/3CF+jtc+2oBe///Gr/t5h0iZajqJKG8wRJTnXs4RmgJEyJfMxxuml
         a8Ri/+pe99V0OYEdxo9gIe8YXPFTDe7nVp8WVqIlEu0KV8Wo068a4yy+hdkJhUWg2w
         TavcbxFTWrOdw==
Date:   Sat, 5 Nov 2022 22:06:58 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     quic_jjohnson@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] soc: qcom: apr: Add check for idr_alloc and
 of_property_read_string_index
Message-ID: <20221106030658.lve7kqjgqmkeaaaq@builder.lan>
References: <20221007033240.42442-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007033240.42442-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:32:40AM +0800, Jiasheng Jiang wrote:
> As idr_alloc() and of_property_read_string_index() can return negative
> numbers, it should be better to check the return value and deal with
> the exception.
> Therefore, it should be better to use goto statement to stop and return
> error.
> 
> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v4 -> v5:
> 
> 1. Change dev_err and goto statements.
> 
> v3 -> v4:
> 
> 1. Change the title and remove the kfree.
> 
> v2 -> v3:
> 
> 1. Change the title and use goto statement to deal with the exception.
> 
> v1 -> v2:
> 
> 1. Add dev_err and put_device in order to maintain the code consistency.
> ---
>  drivers/soc/qcom/apr.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index b4046f393575..a942c8a8dde2 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -454,11 +454,21 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>  	adev->dev.driver = NULL;
>  
>  	spin_lock(&apr->svcs_lock);
> -	idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
> +	ret = idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
>  	spin_unlock(&apr->svcs_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "idr_alloc failed: %d\n", ret);
> +		put_device(&adev->dev);
> +		goto out;
> +	}
>  
> -	of_property_read_string_index(np, "qcom,protection-domain",
> -				      1, &adev->service_path);
> +	ret = of_property_read_string_index(np, "qcom,protection-domain",
> +					    1, &adev->service_path);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read second value of qcom,protection-domain\n");
> +		put_device(&adev->dev);
> +		goto out;
> +	}
>  
>  	dev_info(dev, "Adding APR/GPR dev: %s\n", dev_name(&adev->dev));
>  
> @@ -468,6 +478,7 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>  		put_device(&adev->dev);

This put_device() rolls back the call to device_register(). It should
therefor not be replicated in the newly introduced error paths.

Other than that, this looks good to me.

Thanks,
Bjorn

>  	}
>  
> +out:
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

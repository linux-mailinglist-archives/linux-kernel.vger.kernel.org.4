Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4861E98A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKGDXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiKGDXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:23:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014418D;
        Sun,  6 Nov 2022 19:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F38660E94;
        Mon,  7 Nov 2022 03:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F4FC433D6;
        Mon,  7 Nov 2022 03:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667791389;
        bh=pOxqdvUNwlSuddkrk73+R+1FtROmLMcWlByKk7dKqNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX+dffelzyzczZWahzTO5Lo9DCJVAJv02Ot7qHU/YJxG6zABnUwn5CYKi3v3lIyGj
         EmelS66jYBTmbtOoIX+nzp1u8hrNAKgZi7bOeQqEm2f/J13a9lxpOzNzUNrrpTGDzL
         irlyLMA+mTVAoYJZSF7YBnfC9AIOiL74zCZG3KhIoOC0tP7nEZlIXaEFo8XQKoDCbn
         dKNT2svommn8TQAuGUW2bEdK3b0tHnYCNBU3GQRvtffG2uyDb54HBqUesVDaQ9r0Gr
         LysLPuELmHUnEqCRu5KO73vXeeTQsFo/FOjbviD92D2dBu++pz+TxvxCATxcUe3W/E
         vcqrEq6d2sfKg==
Date:   Sun, 6 Nov 2022 21:23:07 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     quic_jjohnson@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] soc: qcom: apr: Add check for idr_alloc and
 of_property_read_string_index
Message-ID: <20221107032307.rcbdwqa7isljjk2q@builder.lan>
References: <20221107014403.3606-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107014403.3606-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:44:03AM +0800, Jiasheng Jiang wrote:
> As idr_alloc() and of_property_read_string_index() can return negative
> numbers, it should be better to check the return value and deal with
> the exception.
> Therefore, it should be better to use goto statement to stop and return
> error.
> 
> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks,
Bjorn

> ---
> Changelog:
> 
> v5 -> v6:
> 
> 1. Remove the put_device.
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
>  drivers/soc/qcom/apr.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index b4046f393575..cd44f17dad3d 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -454,11 +454,19 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>  	adev->dev.driver = NULL;
>  
>  	spin_lock(&apr->svcs_lock);
> -	idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
> +	ret = idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
>  	spin_unlock(&apr->svcs_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "idr_alloc failed: %d\n", ret);
> +		goto out;
> +	}
>  
> -	of_property_read_string_index(np, "qcom,protection-domain",
> -				      1, &adev->service_path);
> +	ret = of_property_read_string_index(np, "qcom,protection-domain",
> +					    1, &adev->service_path);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read second value of qcom,protection-domain\n");
> +		goto out;
> +	}
>  
>  	dev_info(dev, "Adding APR/GPR dev: %s\n", dev_name(&adev->dev));
>  
> @@ -468,6 +476,7 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>  		put_device(&adev->dev);
>  	}
>  
> +out:
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCA5F72E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJGCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:50:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DC6A98C4;
        Thu,  6 Oct 2022 19:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 227DEB81FFC;
        Fri,  7 Oct 2022 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4037DC433D6;
        Fri,  7 Oct 2022 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665111023;
        bh=ORPEnypLpt0CY7AfdhftEvJ2Y4FEEnin5kLxLXj4YHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VO2V2/gX+AuLkvEloTW+jeW4GSwL1VjQawyo9OVpXTGt5yjAIRpnfZQf2HWOI/n9L
         SyNhrcvy45SEqJOB//9F5rAj83BPH6cfJjSF7ZshRaGNYluP+2rU438SeMW1ZFmul/
         Z4Eb9XvPEoooUULtSd42RnPSX8tWAb2+3kSMvL1zKMPgKs8UEAA2NhorTvQQ8p094Q
         dAY+LFKO4N9mqQAiYLfuhiokEUVWTfIJk4b+a3dBqlagl04jIMcXS51mmUtElJhjN9
         NDGhmEqQ/coE1g1L2CwzytXzmefKG6k07i0/mDp6GHRg27LOejfqrtrVdoKXqC91AW
         9CW79Ndlx5yIA==
Date:   Thu, 6 Oct 2022 21:50:21 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     quic_jjohnson@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] soc: qcom: apr: Add check for idr_alloc and
 of_property_read_string_index
Message-ID: <20221007025021.vcy5x2rvvclxqgrz@builder.lan>
References: <20220914012252.1747659-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914012252.1747659-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 09:22:52AM +0800, Jiasheng Jiang wrote:
> As idr_alloc() and of_property_read_string_index() can return negative
> numbers, it should be better to check the return value and deal with
> the exception.
> Therefore, it should be better to use goto statement to deal with the
> exception.
> 

Thank you for your patch Jiasheng, just a few small requests below.

> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
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
>  drivers/soc/qcom/apr.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index b4046f393575..8101b92e352c 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -454,20 +454,33 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>  	adev->dev.driver = NULL;
>  
>  	spin_lock(&apr->svcs_lock);
> -	idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
> +	ret = idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
>  	spin_unlock(&apr->svcs_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "idr_alloc failed: %d\n", ret);
> +		goto error;
> +	}
>  
> -	of_property_read_string_index(np, "qcom,protection-domain",
> -				      1, &adev->service_path);
> +	ret = of_property_read_string_index(np, "qcom,protection-domain",
> +					    1, &adev->service_path);
> +	if (ret < 0) {
> +		dev_err(dev, "of_property_read_string_index failed: %d\n", ret);

I think "Failed to read second value of qcom,protection-domain" would be
more useful. Probably no need to include "ret".

> +		goto error;
> +	}
>  
>  	dev_info(dev, "Adding APR/GPR dev: %s\n", dev_name(&adev->dev));
>  
>  	ret = device_register(&adev->dev);
>  	if (ret) {
>  		dev_err(dev, "device_register failed: %d\n", ret);
> -		put_device(&adev->dev);
> +		goto error;
>  	}
>  
> +	goto end;

I unfortunately do not fancy the goto dance here. Please add
put_device() in each of the error cases above.

> +
> +error:
> +	put_device(&adev->dev);
> +end:

I would prefer this label to be named "out".

Thanks,
Bjorn

>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

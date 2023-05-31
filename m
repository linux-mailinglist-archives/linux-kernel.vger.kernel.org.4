Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC6717B29
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjEaJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjEaJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE701E65;
        Wed, 31 May 2023 02:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B11A636DF;
        Wed, 31 May 2023 09:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A371C433D2;
        Wed, 31 May 2023 09:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523838;
        bh=Fj4Up68ocllFYDr8AEcwK10DzhsFeDDh/2SD0hHn63I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SuMJ068wtQnL/QcjqiW3ztlo0rLRZCoQIR2WRjqHSTRbzqtBz5YopiI9Au0h4xzVi
         WZhfH1GlRTFk0UIwJ5FiRNS0jvmABuIff27p5jwXqvt8J/eu6Xc6L0Xmw5/g7hyy9B
         LuiBVkul4k//epH7qS4JloR41rehji9ajwCtoeYKPiOgVp4g1nDGbXcSTce/TVB9kp
         KaAeDXdkBXPpt3nO9vbFFrM4VcZcaZe2D7KToDCxe0CnBv8LcExy8REFGHb4FHjgKg
         C/q4fSaaa8OAQMpStKhRD68yM02RdZCzuAZEoQBevhdUoRHXU3vdrTzo9CnIiK3PRH
         r1FDKV4cYn2dQ==
Message-ID: <78819e4d-6eb1-8a71-2da0-0d4711103648@kernel.org>
Date:   Wed, 31 May 2023 11:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] soc: qcom: pmic: Fix resource leaks in
 device_for_each_child_node() loops
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230531085422.4963-1-luhongfei@vivo.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230531085422.4963-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.05.2023 10:54, Lu Hongfei wrote:
> The device_for_each_child_node loop in pmic_glink_altmode_probe should have
> fwnode_handle_put() before return which could avoid resource leaks.
> This patch could fix this bug.
> 
> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
This is the third revision of this patch, please version them accordingly.

You can pass `-vN` to git format-patch and it'll do the job for you.

Please also describe the changes since last revision below the --- line.

Konrad

>  drivers/soc/qcom/pmic_glink_altmode.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index df48fbea4b68..a7fc6570fa1e
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -395,7 +395,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  		ret = fwnode_property_read_u32(fwnode, "reg", &port);
>  		if (ret < 0) {
>  			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> -			return ret;
> +			goto err_node_put;
>  		}
>  
>  		if (port >= ARRAY_SIZE(altmode->ports)) {
> @@ -405,7 +405,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  
>  		if (altmode->ports[port].altmode) {
>  			dev_err(dev, "multiple connector definition for port %u\n", port);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_node_put;
>  		}
>  
>  		alt_port = &altmode->ports[port];
> @@ -420,33 +421,37 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  
>  		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
>  		if (ret)
> -			return ret;
> +			goto err_node_put;
>  
>  		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
>  		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
>  		alt_port->dp_alt.active = 1;
>  
>  		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
> -		if (IS_ERR(alt_port->typec_mux))
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
> +		if (IS_ERR(alt_port->typec_mux)) {
> +			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
>  					     "failed to acquire mode-switch for port: %d\n",
>  					     port);
> +			goto err_node_put;
> +		}
>  
>  		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
>  					       alt_port->typec_mux);
>  		if (ret)
> -			return ret;
> +			goto err_node_put;
>  
>  		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
> -		if (IS_ERR(alt_port->typec_switch))
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
> +		if (IS_ERR(alt_port->typec_switch)) {
> +			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
>  					     "failed to acquire orientation-switch for port: %d\n",
>  					     port);
> +			goto err_node_put;
> +		}
>  
>  		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
>  					       alt_port->typec_switch);
>  		if (ret)
> -			return ret;
> +			goto err_node_put;
>  	}
>  
>  	altmode->client = devm_pmic_glink_register_client(dev,
> @@ -455,6 +460,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  							  pmic_glink_altmode_pdr_notify,
>  							  altmode);
>  	return PTR_ERR_OR_ZERO(altmode->client);
> +
> +err_node_put:
> +	fwnode_handle_put(fwnode);
> +	return ret;
>  }
>  
>  static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {

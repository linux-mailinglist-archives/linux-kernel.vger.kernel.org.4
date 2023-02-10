Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791116927A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjBJUI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjBJUIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:08:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2947715E;
        Fri, 10 Feb 2023 12:08:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A5261E9D;
        Fri, 10 Feb 2023 20:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD69C4339B;
        Fri, 10 Feb 2023 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676059700;
        bh=Y0PuxjUxapJRByHXF+8ePe8IGau3NfsWMr+cn1W8RZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsbGvG5PcA/BJXZ/7gqJlAi2/pJFjmCEhIo6pCL5EEW5zSZSKM7zEZq4X1974RDhn
         nWxX6AFx1KCTybcn7oJzztQVvP/nkd/Q/9o0abB+7F9TxKrKHolfq4Usmas33GaatE
         geQSZJdjrhmRsWg0EvK3mZymmpKSR2hF+yOVehlga7iGCgi1luso+LNuplWGxTP4kO
         dS/wPGw0jF93rfbL2KzChXl84z7ucTEqUP+rzoaZAl+PtCjleNAPEsH0+VfRsPJ/RG
         rdKIbFMFGcgwHcDMBl4Evhj5tV+AFkdijqW3uznX6/QMnYZFcsEu/ovSO5/5e/nEZm
         f90Ovy25x5X/w==
Date:   Fri, 10 Feb 2023 12:10:29 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/11] soc: qcom: pmic_glink: register ucsi aux device
Message-ID: <20230210201029.wwle2j66cn7sv3v3@ripper>
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-4-71fea256474f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-4-71fea256474f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:02:07PM +0100, Neil Armstrong wrote:
> Only register UCSI on know working devices, like on the SM8450
> or Sm8550 which requires UCSI to get USB mode switch events.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 67 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index bb3fb57abcc6..c7f091f4a8c1 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2022, Linaro Ltd
>   */
>  #include <linux/auxiliary_bus.h>
> +#include <linux/of_device.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/rpmsg.h>
> @@ -11,12 +12,23 @@
>  #include <linux/soc/qcom/pdr.h>
>  #include <linux/soc/qcom/pmic_glink.h>
>  
> +enum {
> +	PMIC_GLINK_CLIENT_BATT = 0,
> +	PMIC_GLINK_CLIENT_ALTMODE,
> +	PMIC_GLINK_CLIENT_UCSI,
> +};
> +
> +#define PMIC_GLINK_CLIENT_DEFAULT	(BIT(PMIC_GLINK_CLIENT_BATT) |	\
> +					 BIT(PMIC_GLINK_CLIENT_ALTMODE))
> +
>  struct pmic_glink {
>  	struct device *dev;
>  	struct pdr_handle *pdr;
>  
>  	struct rpmsg_endpoint *ept;
>  
> +	unsigned int client_mask;
> +
>  	struct auxiliary_device altmode_aux;
>  	struct auxiliary_device ps_aux;
>  	struct auxiliary_device ucsi_aux;
> @@ -231,8 +243,19 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
>  	},
>  };
>  
> +/* Do not handle altmode for now on those platforms */
> +static const unsigned int pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> +							  BIT(PMIC_GLINK_CLIENT_UCSI);
> +
> +static const struct of_device_id pmic_glink_of_client_mask[] = {
> +	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{}
> +};
> +
>  static int pmic_glink_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
>  	struct pdr_service *service;
>  	struct pmic_glink *pg;
>  	int ret;
> @@ -249,12 +272,27 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  	mutex_init(&pg->client_lock);
>  	mutex_init(&pg->state_lock);
>  
> -	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
> -	if (ret)
> -		return ret;
> -	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
> -	if (ret)
> -		goto out_release_altmode_aux;
> +	match = of_match_device(pmic_glink_of_client_mask, &pdev->dev);
> +	if (match)
> +		pg->client_mask = *(const unsigned int *)match->data;

Make pmic_glink_sm8450_client_mask unsigned long instead, then it will
have the same size as void * and you don't need to dereference it
here...

> +	else
> +		pg->client_mask = PMIC_GLINK_CLIENT_DEFAULT;

Let's move these bits to pmic_glink_of_match[] to avoid having two
different of_device_id to keep in sync.

And hopefully we could have "qcom,pmic_glink" represent the case of
having all 3 bits set soon, and special case what you have as
"default" here...

Regards,
Bjorn

> +
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
> +		if (ret)
> +			return ret;
> +	}
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
> +		if (ret)
> +			goto out_release_ucsi_aux;
> +	}
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
> +		if (ret)
> +			goto out_release_altmode_aux;
> +	}
>  
>  	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
>  	if (IS_ERR(pg->pdr)) {
> @@ -278,9 +316,14 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  out_release_pdr_handle:
>  	pdr_handle_release(pg->pdr);
>  out_release_aux_devices:
> -	pmic_glink_del_aux_device(pg, &pg->ps_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
> +		pmic_glink_del_aux_device(pg, &pg->ps_aux);
>  out_release_altmode_aux:
> -	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
> +		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +out_release_ucsi_aux:
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
> +		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
>  
>  	return ret;
>  }
> @@ -291,8 +334,12 @@ static int pmic_glink_remove(struct platform_device *pdev)
>  
>  	pdr_handle_release(pg->pdr);
>  
> -	pmic_glink_del_aux_device(pg, &pg->ps_aux);
> -	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
> +		pmic_glink_del_aux_device(pg, &pg->ps_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
> +		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
> +		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
>  
>  	mutex_lock(&__pmic_glink_lock);
>  	__pmic_glink = NULL;
> 
> -- 
> 2.34.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C4D6196CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKDNDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:03:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C72E6B5;
        Fri,  4 Nov 2022 06:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62ACDB82C13;
        Fri,  4 Nov 2022 13:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF96C433C1;
        Fri,  4 Nov 2022 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667566985;
        bh=ALmCpjpCS/ykvSqX4/VELe+zMeNymU+i5MuqAZHypXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G3fHilcQA8RyN8jGm8bdU55iRzJaYCTyp7ByDi2850X8WSy+D8vIvtdNa2zDzJThq
         UEoOSYqULwIbuLzKHh14JCwLKxLDIEotnMr9OtLbmrgVcTqfOeQ/s+/Pv1d68J8z+A
         5yQf6z2REU00J95xIfrAcK1edgMttATSWmfUvrtgi+gihui/LTTHTKKwBklF3fmNDn
         ExZzktNOm10ZDMao0aMwyndMcy/SqAQs5Bv13sZDvN3IojeFKw+yoSxcpB52CL4+o+
         1MikUneJI30HxTMGXfs6H/ST0fB7hLZEY0Q37Dbzkht44Yl9eqM2EEhTO820c8nvf+
         6KNk7RiCCv0+A==
Message-ID: <0f9dbaa5-10b8-1126-6df9-e87e81d3abac@kernel.org>
Date:   Fri, 4 Nov 2022 15:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 5/5] remoteproc: pru: Configure firmware based on
 client setup
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221031073801.130541-1-danishanwar@ti.com>
 <20221031073801.130541-6-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221031073801.130541-6-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2022 09:38, MD Danish Anwar wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Client device node property firmware-name is now used to configure
> firmware for the PRU instances. The default firmware is also
> restored once releasing the PRU resource.
> 
> Co-developed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 3d1870e6b13b..15ffaeddd963 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -172,6 +172,23 @@ void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
>  	spin_unlock_irqrestore(&pru->rmw_lock, flags);
>  }
>  
> +/**
> + * pru_rproc_set_firmware() - set firmware for a pru core

s/pru/PRU

> + * @rproc: the rproc instance of the PRU
> + * @fw_name: the new firmware name, or NULL if default is desired
> + *
> + * Return: 0 on success, or errno in error case.
> + */
> +static int pru_rproc_set_firmware(struct rproc *rproc, const char *fw_name)
> +{
> +	struct pru_rproc *pru = rproc->priv;
> +
> +	if (!fw_name)
> +		fw_name = pru->fw_name;
> +
> +	return rproc_set_firmware(rproc, fw_name);
> +}
> +
>  static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>  {
>  	struct rproc *rproc;
> @@ -230,6 +247,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>  	struct rproc *rproc;
>  	struct pru_rproc *pru;
>  	struct device *dev;
> +	const char *fw_name;
>  	int ret;
>  
>  	rproc = __pru_rproc_get(np, index);
> @@ -256,11 +274,25 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>  	if (pru_id)
>  		*pru_id = pru->id;
>  
> +	ret = of_property_read_string_index(np, "firmware-name", index,
> +					    &fw_name);
> +	if (!ret) {
> +		ret = pru_rproc_set_firmware(rproc, fw_name);
> +		if (ret) {
> +			dev_err(dev, "failed to set firmware: %d\n", ret);
> +			goto err;
> +		}
> +	}
> +
>  	return rproc;
>  
>  err_no_rproc_handle:
>  	rproc_put(rproc);
>  	return ERR_PTR(ret);
> +
> +err:
> +	pru_rproc_put(rproc);
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(pru_rproc_get);
>  
> @@ -280,6 +312,8 @@ void pru_rproc_put(struct rproc *rproc)
>  
>  	pru = rproc->priv;
>  
> +	pru_rproc_set_firmware(rproc, NULL);
> +
>  	mutex_lock(&pru->lock);
>  
>  	if (!pru->client_np) {

Reviewed-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger

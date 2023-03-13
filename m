Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FE6B81F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCMT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMT6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E9A1BADB;
        Mon, 13 Mar 2023 12:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738A96147B;
        Mon, 13 Mar 2023 19:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97C1C433D2;
        Mon, 13 Mar 2023 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678737509;
        bh=taO+cR3Midqp85ZKRakRgyCYz8B3PQ+tWxSfiz94v3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gnxbu0nXMNf+WK0W8zjA0EhI+9soscZp/Qh3Q97tEhF51KfBpZITbXlJWGV3OZ9Bo
         hdqeH6VIys5D5KmTKeuEU3+EuSMCKgwYh67MIx0UBvNZOQ071XvpqKRH0fXsRhRHkT
         9kcMyIVfCyGXVwCMI5vA0jsykp/VU+nDscRWeSKpgRZMkioM4WyYg2P+0fsyiNCcQh
         R8jcP1vJiTnhzi10w5tsZZbb3nLBWzXWDbAPhabeU3n99BJkwICLz2HAILBGTB4WLK
         6VT77mJIXaLi+/lg29AHxHJcyC6fgCO+rq9dNbmpcicN2NSmfmVLwm+2alLLpAv4os
         3mkSMOOfJzfXw==
Message-ID: <eb633e38-7972-4655-63d1-80399bb3a80b@kernel.org>
Date:   Mon, 13 Mar 2023 21:58:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] interconnect: qcom: rpm: drop bogus pm domain attach
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313084953.24088-1-johan+linaro@kernel.org>
 <20230313084953.24088-3-johan+linaro@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230313084953.24088-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 13.03.23 10:49, Johan Hovold wrote:
> Any power domain would already have been attached by the platform bus
> code so drop the bogus power domain attach which always succeeds from
> probe.
> 
> This effectively reverts commit 7de109c0abe9 ("interconnect: icc-rpm:
> Add support for bus power domain").
> 
> Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
> Cc: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 6 ------
>   drivers/interconnect/qcom/icc-rpm.h | 1 -
>   drivers/interconnect/qcom/msm8996.c | 1 -
>   3 files changed, 8 deletions(-)
>  > diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 3b055cd893ea..c303ce22a7cd 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -496,12 +496,6 @@ int qnoc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	if (desc->has_bus_pd) {
> -		ret = dev_pm_domain_attach(dev, true);
> -		if (ret)
> -			goto err_disable_clks;
> -	}
> -
>   	provider = &qp->provider;
>   	provider->dev = dev;
>   	provider->set = qcom_icc_set;
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index a49af844ab13..02257b0d3d5c 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -91,7 +91,6 @@ struct qcom_icc_desc {
>   	size_t num_nodes;
>   	const char * const *clocks;
>   	size_t num_clocks;
> -	bool has_bus_pd;
>   	enum qcom_icc_type type;
>   	const struct regmap_config *regmap_cfg;
>   	unsigned int qos_offset;
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 25a1a32bc611..14efd2761b7a 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -1823,7 +1823,6 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>   	.num_nodes = ARRAY_SIZE(a0noc_nodes),
>   	.clocks = bus_a0noc_clocks,
>   	.num_clocks = ARRAY_SIZE(bus_a0noc_clocks),
> -	.has_bus_pd = true,
>   	.regmap_cfg = &msm8996_a0noc_regmap_config
>   };
> 
To make it a complete revert, I'll fold this in:

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 0badd2c75161..c80819557923 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -11,7 +11,6 @@
  #include <linux/of_device.h>
  #include <linux/of_platform.h>
  #include <linux/platform_device.h>
-#include <linux/pm_domain.h>
  #include <linux/regmap.h>
  #include <linux/slab.h>

Thanks,
Georgi


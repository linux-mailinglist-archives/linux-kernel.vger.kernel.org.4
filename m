Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC07302FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjFNPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbjFNPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883851FFF;
        Wed, 14 Jun 2023 08:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2434A64366;
        Wed, 14 Jun 2023 15:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03E9C433C0;
        Wed, 14 Jun 2023 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686755331;
        bh=tUXMAMLTrnJ2iEJIE1fN4T5eZcn5N+chLeoszAhmb6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMl5x6pkHX2lUz4yqlAtawJF3Whci7a2OcNFy04dO8+Apql56gpiSxaRf9f4TZlcw
         xFfsjYc79qdpHkicd+y5IsYxauMnBI1ZrFFWNtmovv5bh6GAFNY+ZyEDv3XKcvxm66
         jqv15dMj4zN67sswVLnwwItoKIPGax6m62RiLvALUd13OcHlIGIWaRLwDoZTEkhl+s
         k1zc+Pe7PkF5tnch5Gyn7NcV7AHCuXf80SJtflrYR2rq2yu1EcZxkwqfrMcTfHGh7H
         eXx32m5cjn6ut89XSVmD5Pf4R7kuNQxpx1k94BCgPnz/oGRC6WxsE4TvqwESTL/Yd1
         8u8H3vYEbvuLA==
Date:   Wed, 14 Jun 2023 08:12:13 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: Use of_reserved_mem_lookup()
Message-ID: <20230614151213.qiimwth3fkic5vct@ripper>
References: <20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:34:54AM +0200, Stephan Gerhold wrote:
> Reserved memory can be either looked up using the generic function
> of_address_to_resource() or using the special of_reserved_mem_lookup().
> The latter has the advantage that it ensures that the referenced memory
> region was really reserved and is not e.g. status = "disabled".
> 
> of_reserved_mem also supports allocating reserved memory dynamically at
> boot time. This works only when using of_reserved_mem_lookup() since
> there won't be a fixed address in the device tree.
> 
> Switch the code to use of_reserved_mem_lookup(), similar to
> qcom_q6v5_wcss.c which is using it already. There is no functional
> difference for static reserved memory allocations.
> 
> While at it this also adds two missing of_node_put() calls in
> qcom_q6v5_pas.c.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> See e.g. [1] for an example of dynamically allocated reserved memory.
> (This patch does *not* depend on [1] and is useful without as well...)
> 
> NOTE: Changes in qcom_q6v5_adsp.c and qcom_q6v5_pas.c are untested,
> I only checked qcom_q6v5_mss.c and qcom_wcnss.c on MSM8916/DB410c.
> The code changes are pretty similar for all of those though.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> ---
>  drivers/remoteproc/qcom_q6v5_adsp.c | 22 ++++++++--------
>  drivers/remoteproc/qcom_q6v5_mss.c  | 35 +++++++++++++++----------
>  drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
>  drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
>  4 files changed, 69 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 6777a3bd6226..948b3d00a564 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -14,8 +14,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -637,28 +637,26 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
>  
>  static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  {
> +	struct reserved_mem *rmem = NULL;
>  	struct device_node *node;
> -	struct resource r;
> -	int ret;
>  
>  	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
> +	if (node)
> +		rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +
>  	if (!node) {
> -		dev_err(adsp->dev, "no memory-region specified\n");
> +		dev_err(adsp->dev, "unable to resolve memory-region\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	of_node_put(node);
> -	if (ret)
> -		return ret;
> -
> -	adsp->mem_phys = adsp->mem_reloc = r.start;
> -	adsp->mem_size = resource_size(&r);

Aren't you missing a check for !rmem here? (The others has it)

Regards,
Bjorn

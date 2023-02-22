Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6B69FB2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjBVSnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBVSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:42:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC441B46
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:42:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c1so10125469plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey37LMUCgjy+2lrIm4/0QBCqLJaHnsaYYYuoP9hlsqs=;
        b=d+pCwtYLAafC3qo7zsv2TWVXcN/LDLDTbIunLFvhddN1eDBsc9mnplGCtZKEagN9RZ
         gBoLRqitllp5yw5NyZn1QOI/dK0GFd1EaKaLwQxPDcFKABP3E6OzVjqTaO/aqXu31rzC
         oKodSCom8E+iN/vBxndRzKg3RhLIatMrHk3rmSEPh3DfBEn7mzeD3q/EVu62daIN0nlH
         Xl4R0mXdogW3Un+VjrXF2znBm2AWiKchlVx/fvQSTT1PZ6tUQiPNvs7WXj8FZMZIHIf7
         IlcY942glqFJeCZF93Q+ac32I/bcZN5tb3gO1QAO9mBSjf0mHKJt3uzkZ/T2kjxzmwG+
         wYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey37LMUCgjy+2lrIm4/0QBCqLJaHnsaYYYuoP9hlsqs=;
        b=7MMZo5jUedXPLS/BG3LF+RtUB62qKncmeJNLkCfmSz/5ODFzHlFDe7Y+ILeM5Ovxvk
         +kVWprRfnEKCnPFkd4OpVmnVj+JU9NQcgUXrO49OGkSGatEQZal53ksDmfAH/py5HbvR
         Z8Orvjp67AmTWzaep06Bb5S7MsgjMXIAeSc/cc5ZcZP25sAz/dNUpQy5wEK7GIEDU5oo
         CD+IqbJtKJPTPbRxUAh/+Ni+vDsiGw+DJ6bfxoBq/1MUmvYzFZBH0+D8DQlirLKzmkZs
         hC42XJXp4Fz4tFBiH1fTtwQPHb/5OaO53yfKsFgApJ+FmBkt+xbl+dhh+YM+n3HopTWH
         WJvQ==
X-Gm-Message-State: AO0yUKXACzEEs2YY2Xhv1LnAmGDegpHQlIId2Kp2ad5SM5zCOgn/n7CL
        OrwuFn/SUYaxeUcYCaupmHRdcw==
X-Google-Smtp-Source: AK7set/RYHHKmw+O7sDn+2vH0kXe+nzW1HvuMex9F5RXuptbW26d0MXDMNbzFQSv4vl9iHqzp9HJcQ==
X-Received: by 2002:a05:6a20:698e:b0:c7:24c5:fb90 with SMTP id t14-20020a056a20698e00b000c724c5fb90mr10291163pzk.27.1677091297987;
        Wed, 22 Feb 2023 10:41:37 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:78a7:1e00:32c7:e2c0])
        by smtp.gmail.com with ESMTPSA id k184-20020a6384c1000000b004fb26a80875sm3290121pgd.22.2023.02.22.10.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:41:37 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:41:35 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers: remoteproc: xilinx: fix carveout names
Message-ID: <20230222184135.GB909075@p14s>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-3-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213211825.3507034-3-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:18:25PM -0800, Tanmay Shah wrote:
> If the unit address is appended to node name of memory-region,
> then adding rproc carveouts fails as node name and unit-address
> both are passed as carveout name (i.e. vdev0vring0@xxxxxxxx). However,
> only node name is expected by remoteproc framework. This patch moves
> memory-region node parsing from driver probe to prepare and
> only passes node-name and not unit-address
> 
> Fixes: 6b291e8020a8 ("drivers: remoteproc: Add Xilinx r5 remoteproc driver")
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changelog:
>   - This is first version of this change, however posting as part of the series
>     that has version v3. The v2 of the series could be found at following link.
> 
> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 87 ++++++-------------------
>  1 file changed, 20 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 2db57d394155..81af2dea56c2 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -61,8 +61,6 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
>   * @np: device node of RPU instance
>   * @tcm_bank_count: number TCM banks accessible to this RPU
>   * @tcm_banks: array of each TCM bank data
> - * @rmem_count: Number of reserved mem regions
> - * @rmem: reserved memory region nodes from device tree
>   * @rproc: rproc handle
>   * @pm_domain_id: RPU CPU power domain id
>   */
> @@ -71,8 +69,6 @@ struct zynqmp_r5_core {
>  	struct device_node *np;
>  	int tcm_bank_count;
>  	struct mem_bank_data **tcm_banks;
> -	int rmem_count;
> -	struct reserved_mem **rmem;
>  	struct rproc *rproc;
>  	u32 pm_domain_id;
>  };
> @@ -239,21 +235,31 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  {
>  	struct rproc_mem_entry *rproc_mem;
>  	struct zynqmp_r5_core *r5_core;
> +	struct device_node *rmem_np;
>  	struct reserved_mem *rmem;
>  	int i, num_mem_regions;
>  
>  	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> -	num_mem_regions = r5_core->rmem_count;
> +
> +	num_mem_regions = of_property_count_elems_of_size(r5_core->np, "memory-region",
> +							  sizeof(phandle));
>  
>  	for (i = 0; i < num_mem_regions; i++) {
> -		rmem = r5_core->rmem[i];
>

Extra line

Everyone else in the remoteproc subsystem is using of_phandle_iterator_next(),
please do the same.  It is easier to maintain and you don't have to call
of_node_put() after each iteration. 


> -		if (!strncmp(rmem->name, "vdev0buffer", strlen("vdev0buffer"))) {
> +		rmem_np = of_parse_phandle(r5_core->np, "memory-region", i);
> +
> +		rmem = of_reserved_mem_lookup(rmem_np);
> +		if (!rmem) {
> +			of_node_put(rmem_np);
> +			return -EINVAL;
> +		}
> +
> +		if (!strcmp(rmem_np->name, "vdev0buffer")) {
>  			/* Init reserved memory for vdev buffer */
>  			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
>  								 rmem->size,
>  								 rmem->base,
> -								 rmem->name);
> +								 rmem_np->name);
>  		} else {
>  			/* Register associated reserved memory regions */
>  			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
> @@ -261,16 +267,20 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  							 rmem->size, rmem->base,
>  							 zynqmp_r5_mem_region_map,
>  							 zynqmp_r5_mem_region_unmap,
> -							 rmem->name);
> +							 rmem_np->name);
>  		}
>  
> -		if (!rproc_mem)
> +		if (!rproc_mem) {
> +			of_node_put(rmem_np);

When moving to of_phandle_iterator_next(), of_node_put(it.node) has to be
called on error conditions.  Other drivers don't do it, something I will fix in
the next cycle.

>  			return -ENOMEM;
> +		}
>  
>  		rproc_add_carveout(rproc, rproc_mem);
>  
>  		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
>  			rmem->name, rmem->base, rmem->size);
> +
> +		of_node_put(rmem_np);
>  	}
>  
>  	return 0;
> @@ -726,59 +736,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>  	return 0;
>  }
>  
> -/**
> - * zynqmp_r5_get_mem_region_node()
> - * parse memory-region property and get reserved mem regions
> - *
> - * @r5_core: pointer to zynqmp_r5_core type object
> - *
> - * Return: 0 for success and error code for failure.
> - */
> -static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> -{
> -	struct device_node *np, *rmem_np;
> -	struct reserved_mem **rmem;
> -	int res_mem_count, i;
> -	struct device *dev;
> -
> -	dev = r5_core->dev;
> -	np = r5_core->np;
> -
> -	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> -							sizeof(phandle));
> -	if (res_mem_count <= 0) {
> -		dev_warn(dev, "failed to get memory-region property %d\n",
> -			 res_mem_count);
> -		return 0;
> -	}
> -
> -	rmem = devm_kcalloc(dev, res_mem_count,
> -			    sizeof(struct reserved_mem *), GFP_KERNEL);
> -	if (!rmem)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < res_mem_count; i++) {
> -		rmem_np = of_parse_phandle(np, "memory-region", i);
> -		if (!rmem_np)
> -			goto release_rmem;
> -
> -		rmem[i] = of_reserved_mem_lookup(rmem_np);
> -		if (!rmem[i]) {
> -			of_node_put(rmem_np);
> -			goto release_rmem;
> -		}
> -
> -		of_node_put(rmem_np);
> -	}
> -
> -	r5_core->rmem_count = res_mem_count;
> -	r5_core->rmem = rmem;
> -	return 0;
> -
> -release_rmem:
> -	return -EINVAL;
> -}
> -
>  /*
>   * zynqmp_r5_core_init()
>   * Create and initialize zynqmp_r5_core type object
> @@ -806,10 +763,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	for (i = 0; i < cluster->core_count; i++) {
>  		r5_core = cluster->r5_cores[i];
>  
> -		ret = zynqmp_r5_get_mem_region_node(r5_core);
> -		if (ret)
> -			dev_warn(dev, "memory-region prop failed %d\n", ret);
> -
>  		/* Initialize r5 cores with power-domains parsed from dts */
>  		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>  						 1, &r5_core->pm_domain_id);
> -- 
> 2.25.1
> 

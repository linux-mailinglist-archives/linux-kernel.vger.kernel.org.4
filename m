Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAB6CA6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC0OGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjC0OGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:06:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE64558A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A69B8070D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58394C433EF;
        Mon, 27 Mar 2023 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679925943;
        bh=BFTRXvPzd2UP/67KL2aRfzjjJzVmw6h/2onxkOy80qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shYVo1u5O6GTglq5fdBwcNGGW/PE74wA1ALVG+4Dyi1TJgsRfY3tfuouar8Ib+bCJ
         Byd2HSG9pS53PHH3yH1W4/F13j0Yk4Yq7+7nV8XJyV8Q7JbgPxLKhgQXs8h9+sXReI
         cDXc2J+/iQ1tiav+TyE/tTLmODFbb7z3/0b1v9yRx4MRMV3jFO2SKus0tA6FP61JU0
         1GPBmE6xN/nM2ZwJr6iIxGfgK2h6FtOZnW4geZUO/F7eP+UIHEh8Mzzv45bR1UUtD1
         1iKExhGR8oN//qAcKhaKbqHFiyYIK5NYlPa3gbf0orpI0oFB43rveTZtO/NmJJWa9t
         +HqZkO4IRyz3A==
Date:   Mon, 27 Mar 2023 15:05:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>, robin.murphy@arm.com,
        ilkka@os.amperecomputing.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix and refactor device mapping resource
Message-ID: <20230327140536.GB31752@willie-the-truck>
References: <1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Robin and Ilkka, as they contribute most to this driver]

On Thu, Feb 16, 2023 at 04:17:50PM +0800, Jing Zhang wrote:
> The devm_platform_ioremap_resource() won't let the platform device
> claim resource when the ACPI companion device has already claimed it.
> If CMN-ANY except CMN600 is ACPI companion device, it will return
> -EBUSY in devm_platform_ioremap_resource(), and the driver cannot be
> successfully installed.
> 
> So let ACPI companion device call arm_cmn_acpi_probe and not claim
> resource again. In addition, the arm_cmn_acpi_probe() and
> arm_cmn_of_probe() functions are refactored to make them compatible
> with both CMN600 and CMN-ANY.
> 
> Fixes: 61ec1d875812 ("perf/arm-cmn: Demarcate CMN-600 specifics")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 1deb61b..beb3b37 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2206,7 +2206,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>  	return 0;
>  }
>  
> -static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
> +static int arm_cmn_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>  {
>  	struct resource *cfg, *root;
>  
> @@ -2214,12 +2214,21 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>  	if (!cfg)
>  		return -EINVAL;
>  
> -	root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!root)
> -		return -EINVAL;
> +	/* If ACPI defines more than one resource, such as cmn-600, then there may be
> +	 * a deviation between ROOTNODEBASE and PERIPHBASE, and ROOTNODEBASE can
> +	 * be obtained from the second resource. Otherwise, it can be considered that
> +	 * ROOT NODE BASE is PERIPHBASE. This is compatible with cmn-600 and cmn-any.
> +	 */
> +	if (pdev->num_resources > 1) {
> +		root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!root)
> +			return -EINVAL;
>  
> -	if (!resource_contains(cfg, root))
> -		swap(cfg, root);
> +		if (!resource_contains(cfg, root))
> +			swap(cfg, root);
> +	} else {
> +		root = cfg;
> +	}
>  	/*
>  	 * Note that devm_ioremap_resource() is dumb and won't let the platform
>  	 * device claim cfg when the ACPI companion device has already claimed
> @@ -2227,17 +2236,30 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>  	 * appropriate name, we don't really need to do it again here anyway.
>  	 */
>  	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
> -	if (!cmn->base)
> -		return -ENOMEM;
> +	if (IS_ERR(cmn->base))
> +		return PTR_ERR(cmn->base);
>  
>  	return root->start - cfg->start;
>  }
>  
> -static int arm_cmn600_of_probe(struct device_node *np)
> +static int arm_cmn_of_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>  {
>  	u32 rootnode;
> +	int ret;
> +
> +	cmn->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cmn->base))
> +		return PTR_ERR(cmn->base);
>  
> -	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
> +	/* If of_property_read_u32() return EINVAL, it means that device tree has
> +	 * not define root-node, and root-node will return 0, which is compatible
> +	 * with cmn-600 and cmn-any.
> +	 */
> +	ret = of_property_read_u32(pdev->dev.of_node, "arm,root-node", &rootnode);
> +	if (ret == -EINVAL)
> +		return 0;
> +
> +	return rootnode;
>  }
>  
>  static int arm_cmn_probe(struct platform_device *pdev)
> @@ -2255,16 +2277,11 @@ static int arm_cmn_probe(struct platform_device *pdev)
>  	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
>  	platform_set_drvdata(pdev, cmn);
>  
> -	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
> -		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
> -	} else {
> -		rootnode = 0;
> -		cmn->base = devm_platform_ioremap_resource(pdev, 0);
> -		if (IS_ERR(cmn->base))
> -			return PTR_ERR(cmn->base);
> -		if (cmn->model == CMN600)
> -			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
> -	}
> +	if (has_acpi_companion(cmn->dev))
> +		rootnode = arm_cmn_acpi_probe(pdev, cmn);
> +	else
> +		rootnode = arm_cmn_of_probe(pdev, cmn);
> +
>  	if (rootnode < 0)
>  		return rootnode;
>  
> -- 
> 1.8.3.1
> 

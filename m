Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C480F656C52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiL0PLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiL0PLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:11:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37ACE60;
        Tue, 27 Dec 2022 07:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 571A16119F;
        Tue, 27 Dec 2022 15:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFB9C433F0;
        Tue, 27 Dec 2022 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672153893;
        bh=DHLRnGECifdavsvYK5VFXIuHRMp7XChg8MchINFR/Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0cs3nNgJMh+lStCiVtmD4AqgBJSb18dB3d8fI0vne6+tEKmcZ+cuB2rKUbE5goJB
         puXU7zd3URnsyN8r1QwMr+Ceh8M+4R2bk1OJEyFEuvE/gd4EFgIwzAD3BuOCvF1RC3
         Jfeik2yits8prTqa09xl+ZTS/eqdzXkekOD0xZyyuB7b9h/rAa/d2V48Y1dolHEHes
         wBq/kaeXKoSXqedq1uVSjuq3RWzb/n2d3gO1ShqYo1bZeykuEYouE/t0fv4uLD1Q8e
         OGosodtuPPM7bvWspAuqw6FozNWUCdu6sY5eUV/BItrkfqtbVvQ8o76AuIRKw4jOMB
         FOnx3JI8zakmg==
Date:   Tue, 27 Dec 2022 09:11:31 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.levinsky@xilinx.com
Subject: Re: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
Message-ID: <20221227151131.hkezt4j2om5volnu@builder.lan>
References: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:16:43PM -0700, Mathieu Poirier wrote:
> Multi-cluster remoteproc designs typically have the following DT
> declaration:
> 
> 	remoteproc_cluster {
> 		compatible = "soc,remoteproc-cluster";
> 
>                 core0: core0 {
> 			compatible = "soc,remoteproc-core"
>                         memory-region;
>                         sram;
>                 };
> 
>                 core1: core1 {
> 			compatible = "soc,remoteproc-core"
>                         memory-region;
>                         sram;
>                 }
>         };
> 
> A driver exists for the cluster rather than the individual cores
> themselves so that operation mode and HW specific configurations
> applicable to the cluster can be made.
> 
> Because the driver exists at the cluster level and not the individual
> core level, function rproc_get_by_phandle() fails to return the
> remoteproc associated with the phandled it is called for.
> 
> This patch enhances rproc_get_by_phandle() by looking for the cluster's
> driver when the driver for the immediate remoteproc's parent is not
> found.
> 

Can you please help me understand why zynqmp_r5_remoteproc_probe()
invokes devm_of_platform_populate() to create platform_device instances
for the clusters?

Why can't the platform_device for the cluster be used as parent for both
remoteprocs and then the driver deal with the subnodes within the
driver?

Regards,
Bjorn

> Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 1cd4815a6dd1..91f82886add9 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/idr.h>
>  #include <linux/elf.h>
>  #include <linux/crc32.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_ring.h>
> @@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
>  #ifdef CONFIG_OF
>  struct rproc *rproc_get_by_phandle(phandle phandle)
>  {
> +	struct platform_device *cluster_pdev;
>  	struct rproc *rproc = NULL, *r;
> +	struct device_driver *driver;
>  	struct device_node *np;
>  
>  	np = of_find_node_by_phandle(phandle);
> @@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  	list_for_each_entry_rcu(r, &rproc_list, node) {
>  		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
>  			/* prevent underlying implementation from being removed */
> -			if (!try_module_get(r->dev.parent->driver->owner)) {
> +
> +			/*
> +			 * If the remoteproc's parent has a driver, the
> +			 * remoteproc is not part of a cluster and we can use
> +			 * that driver.
> +			 */
> +			driver = r->dev.parent->driver;
> +
> +			/*
> +			 * If the remoteproc's parent does not have a driver,
> +			 * look for the driver associated with the cluster.
> +			 */
> +			if (!driver) {
> +				cluster_pdev = of_find_device_by_node(np->parent);
> +				if (!cluster_pdev) {
> +					dev_err(&r->dev, "can't get parent\n");
> +					break;
> +				}
> +
> +				driver = cluster_pdev->dev.driver;
> +				put_device(&cluster_pdev->dev);
> +			}
> +
> +			if (!try_module_get(driver->owner)) {
>  				dev_err(&r->dev, "can't get owner\n");
>  				break;
>  			}
> -- 
> 2.25.1
> 

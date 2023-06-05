Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857ED722B59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjFEPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjFEPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEEB98
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F619614EF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18036C433EF;
        Mon,  5 Jun 2023 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685979557;
        bh=nGZByq5rYm6j8RgkfeF5E+iIwCQoLWm00aQCv+OFO4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuQCtaaTf8Xi0dnviLvtK4ER+WyrbreZ3l8CDfOTUCFEcsSUOnybqscz+GlroOnXj
         8mYn4BQbE7FX+wA7lLeWFgxSbJ9CCWt08imMavQyRgSUsgGzmp34qEWZlzjtK1NXN+
         3g7eV44N+JhCaXP2Khe2nVJ3/rgQvBpGehIQ7aKFQC/kpJM3qUN29EZleFkqpawO/U
         vBl3tjV7FENtJ66HP9aJhwmkKVzulZwGiSj3a75MwTWI+EsAKfRtLH+gJafEfc/k0K
         fIliVDfbGpFM5y6oPHx3T1+7QY/ZIVhoexeC8W3hjpi7UsQuq1+Y3vCtIe5qr8Idvk
         QeDg2WQtd1ThQ==
Date:   Mon, 5 Jun 2023 08:39:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Li Yang <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] bus: fsl-mc: fsl-mc-allocator: Initialize mc_bus_dev
 before use
Message-ID: <20230605153915.GB2480995@dev-arch.thelio-3990X>
References: <20230605112025.80061-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230605112025.80061-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 01:20:24PM +0200, Uwe Kleine-König wrote:
> Fixes a clang compiler warning:
> 
> >> drivers/bus/fsl-mc/fsl-mc-allocator.c:108:12: warning: variable 'mc_bus_dev' is uninitialized when used here [-Wuninitialized]
>                    dev_err(&mc_bus_dev->dev, "resource mismatch\n");
> 
> Fixes: b3134039c5b3 ("bus: fsl-mc: fsl-mc-allocator: Improve error reporting")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306021936.OktTcMAT-lkp@intel.com/
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/bus/fsl-mc/fsl-mc-allocator.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> index 0ad68099684e..991273f956ce 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -103,14 +103,15 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
>  	struct fsl_mc_resource *resource;
>  	int error = -EINVAL;
>  
> +	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
> +	mc_bus = to_fsl_mc_bus(mc_bus_dev);
> +
>  	resource = mc_dev->resource;
>  	if (!resource || resource->data != mc_dev) {
>  		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
>  		goto out;
>  	}
>  
> -	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
> -	mc_bus = to_fsl_mc_bus(mc_bus_dev);
>  	res_pool = resource->parent_pool;
>  	if (res_pool != &mc_bus->resource_pools[resource->type]) {
>  		dev_err(&mc_bus_dev->dev, "pool mismatch\n");
> 
> base-commit: 59272ad8d9e8ea6398a96f8c6d62da284bf2ae6e
> -- 
> 2.39.2
> 

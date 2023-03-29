Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3A6CD79B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjC2KZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2KZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:25:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA622125;
        Wed, 29 Mar 2023 03:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 568CBB82233;
        Wed, 29 Mar 2023 10:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924BFC433D2;
        Wed, 29 Mar 2023 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680085545;
        bh=0cMG6bHX7Yqr5TdtMRpR+wLldqDh5d48ZBc9aV3rya0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RH5cMEq1TxDcu997zF75ZqnDOdV41aWE3bQ01z358ENbF2sL6JwR5vbUnaadL9BY/
         kWjW7m7LwrkwhtWK/pSeWgURZl5CAR2pPUeVfwM+hWigMAXOJy/dmBF3F8NV5hqio3
         l9pNa0meCYxQb3BcZ/m6ztTHZPeD4MffUwVB/wf0=
Date:   Wed, 29 Mar 2023 12:25:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        rdunlap@infradead.org, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, pieter.jansen-van-vuuren@amd.com,
        pablo.cascon@amd.com, git@amd.com
Subject: Re: [PATCH v10 2/7] iommu: Add iommu probe for CDX bus
Message-ID: <ZCQSJmcb7W4dT2yS@kroah.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
 <20230313132636.31850-3-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313132636.31850-3-nipun.gupta@amd.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 06:56:31PM +0530, Nipun Gupta wrote:
> Add CDX bus to iommu_buses so that IOMMU probe is called
> for it.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..0025a631b8e1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -28,6 +28,7 @@
>  #include <linux/fsl/mc.h>
>  #include <linux/module.h>
>  #include <linux/cc_platform.h>
> +#include <linux/cdx/cdx_bus.h>
>  #include <trace/events/iommu.h>
>  #include <linux/sched/mm.h>
>  #include <linux/msi.h>
> @@ -129,6 +130,9 @@ static struct bus_type * const iommu_buses[] = {
>  #ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>  	&host1x_context_device_bus_type,
>  #endif
> +#ifdef CONFIG_CDX_BUS
> +	&cdx_bus_type,
> +#endif
>  };

Note, this prevents the ability for this struct bus_type from being
moved into read-only memory in the future.  But hopefully that will be
fixed up eventually, you are in good company with some other busses
here...

Other than that, this series looks good, I'll queue this up through my
tree for now as I seem to collect new subsystems.  Feel free to send
future patches through me as well until you get tired of that and want
to send stuff to Linus directly.

thanks,

greg k-h

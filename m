Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED96DEACB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLEx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLExS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F3C55BD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8061A62DF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC99C433D2;
        Wed, 12 Apr 2023 04:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681275173;
        bh=tBKou5eZiQRLKIUxQunvsX1cbH8KIFfhzoyODEPVwEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTv5n/BFPQuZE4tgfuBcw+k0fyYtjjzg4nI2zlE8N/3LWT2PH51HZi35BfZlsl+W+
         Nn4uPbSmMEkWjz3jga2460zwqwniBRNEA56PorbNOHSz7U9cfI9BOqNGVmUxiBMrSL
         bPJ8ybVIVEwyvImMJwQP7nGIr0s/JpLfHbG+u/q/YtBbTcUpcGcE2bhogaStz9jSem
         OsNVMiTPfg4Atg8YhputFGjJpB14a/xqY8exLiY0AlDj8rtOG32hT+25uYZ3yI5dWg
         tshoNn4LAxbLsnYGWCzvHCDItiAFqU/fbSwCeIGRtBJ3nsSkNa+xSQPF07bjJq/kDU
         VbL1/lfM7N59A==
Date:   Wed, 12 Apr 2023 10:22:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] dmaengine: idxd: Add enable/disable device IOPF
 feature
Message-ID: <ZDY5IYL5NMGEOihl@matsya>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411064815.31456-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-23, 14:47, Lu Baolu wrote:
> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
> driver.
> 
> At present, missing IOPF enabling/disabling doesn't cause any real issue,
> because the IOMMU driver places the IOPF enabling/disabling in the path
> of SVA feature handling. But this may change.

Acked-by: Vinod Koul <vkoul@kernel.org>

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Link: https://lore.kernel.org/r/20230324120234.313643-2-baolu.lu@linux.intel.com
> ---
>  drivers/dma/idxd/init.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 640d3048368e..09ef62aa0635 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -516,6 +516,27 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
>  	idxd->sva = NULL;
>  }
>  
> +static int idxd_enable_sva(struct pci_dev *pdev)
> +{
> +	int ret;
> +
> +	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> +	if (ret)
> +		return ret;
> +
> +	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> +	if (ret)
> +		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> +
> +	return ret;
> +}
> +
> +static void idxd_disable_sva(struct pci_dev *pdev)
> +{
> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> +}
> +
>  static int idxd_probe(struct idxd_device *idxd)
>  {
>  	struct pci_dev *pdev = idxd->pdev;
> @@ -530,7 +551,7 @@ static int idxd_probe(struct idxd_device *idxd)
>  	dev_dbg(dev, "IDXD reset complete\n");
>  
>  	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> -		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
> +		if (idxd_enable_sva(pdev)) {
>  			dev_warn(dev, "Unable to turn on user SVA feature.\n");
>  		} else {
>  			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> @@ -578,21 +599,19 @@ static int idxd_probe(struct idxd_device *idxd)
>  	if (device_pasid_enabled(idxd))
>  		idxd_disable_system_pasid(idxd);
>  	if (device_user_pasid_enabled(idxd))
> -		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
> +		idxd_disable_sva(pdev);
>  	return rc;
>  }
>  
>  static void idxd_cleanup(struct idxd_device *idxd)
>  {
> -	struct device *dev = &idxd->pdev->dev;
> -
>  	perfmon_pmu_remove(idxd);
>  	idxd_cleanup_interrupts(idxd);
>  	idxd_cleanup_internals(idxd);
>  	if (device_pasid_enabled(idxd))
>  		idxd_disable_system_pasid(idxd);
>  	if (device_user_pasid_enabled(idxd))
> -		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
> +		idxd_disable_sva(idxd->pdev);
>  }
>  
>  static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> @@ -710,7 +729,7 @@ static void idxd_remove(struct pci_dev *pdev)
>  	pci_free_irq_vectors(pdev);
>  	pci_iounmap(pdev, idxd->reg_base);
>  	if (device_user_pasid_enabled(idxd))
> -		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> +		idxd_disable_sva(pdev);
>  	pci_disable_device(pdev);
>  	destroy_workqueue(idxd->wq);
>  	perfmon_pmu_remove(idxd);
> -- 
> 2.34.1

-- 
~Vinod

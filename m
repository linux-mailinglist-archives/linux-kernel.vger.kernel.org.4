Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93368193D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjA3ScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjA3Sbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:31:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 855F94523C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:30:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D9561FB;
        Mon, 30 Jan 2023 10:22:41 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3421B3F71E;
        Mon, 30 Jan 2023 10:21:58 -0800 (PST)
Message-ID: <cb346a22-6548-f9d8-1d8a-f0d01cd0d0f7@arm.com>
Date:   Mon, 30 Jan 2023 18:21:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
References: <cover.1674753627.git.robin.murphy@arm.com>
 <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
 <Y9f+8RkvJUPOrGg9@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y9f+8RkvJUPOrGg9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-30 17:31, Jason Gunthorpe wrote:
> On Thu, Jan 26, 2023 at 06:26:16PM +0000, Robin Murphy wrote:
>> Much as I'd like to remove iommu_present(), the final remaining users
>> are proving stubbornly difficult to clean up, so kick that can down
>> the road and just rework it to preserve the current behaviour without
>> depending on bus ops.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This below might help. You might need to ask Thierry for help on the
> problematic stuff in tegra. Really we should finish the series here
> and organize things so that the domain allocation is defered until a
> client is present.

mrk_drm doesn't even allocate, it relies on the DMA API domain; it also 
only runs on DT systems where IOMMU dependency ordering has been 
enforced by core code for a very long time now. I sent a patch simply 
removing that check back at the time of the rest of my iommu_present() 
cleanup, and it just got resoundingly ignored :(

Thanks,
Robin.

> https://lore.kernel.org/linux-iommu/20220106022053.2406748-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index cd5b18ef79512c..e5c257e41f4933 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -353,9 +353,6 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>   	if (drm_firmware_drivers_only())
>   		return -ENODEV;
>   
> -	if (!iommu_present(&platform_bus_type))
> -		return -EPROBE_DEFER;
> -
>   	pdev = of_find_device_by_node(private->mutex_node);
>   	if (!pdev) {
>   		dev_err(drm->dev, "Waiting for disp-mutex device %pOF\n",
> @@ -709,6 +706,9 @@ static int mtk_drm_probe(struct platform_device *pdev)
>   	int ret;
>   	int i;
>   
> +	if (!device_iommu_mapped(dev))
> +		return -EPROBE_DEFER;
> +
>   	private = devm_kzalloc(dev, sizeof(*private), GFP_KERNEL);
>   	if (!private)
>   		return -ENOMEM;

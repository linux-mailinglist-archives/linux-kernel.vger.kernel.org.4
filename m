Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC268EC03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjBHJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:48:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C41EE3A7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:48:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61F00FEC;
        Wed,  8 Feb 2023 01:49:07 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9822F3F8C6;
        Wed,  8 Feb 2023 01:48:22 -0800 (PST)
Message-ID: <384ef4c4-3dc5-b9e6-d9be-09d611dacbc0@arm.com>
Date:   Wed, 8 Feb 2023 09:48:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_iommu/ipmmu-vmsa=3a_use=c2=a0devm=5fpla?=
 =?UTF-8?Q?tform=5fget=5fand=5fioremap=5fresource=28=29?=
Content-Language: en-GB
To:     ye.xingchen@zte.com.cn, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <202302081605554841069@zte.com.cn>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <202302081605554841069@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-08 08:05, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

Not exactly - it also returns the resource data to the caller, which is 
not needed here. Please use the regular devm_platform_ioremap_resource() 
in such cases - it's silly to call the overcomplicated function that 
does two things when you only ever need one of the things.

Thanks,
Robin.

> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index bdf1a4e5eae0..aca7ca8b5543 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -967,7 +967,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
>   static int ipmmu_probe(struct platform_device *pdev)
>   {
>   	struct ipmmu_vmsa_device *mmu;
> -	struct resource *res;
>   	int irq;
>   	int ret;
> 
> @@ -987,8 +986,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>   		return ret;
> 
>   	/* Map I/O memory and request IRQ. */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mmu->base = devm_ioremap_resource(&pdev->dev, res);
> +	mmu->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>   	if (IS_ERR(mmu->base))
>   		return PTR_ERR(mmu->base);
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712FB680CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjA3MEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjA3MEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB40C13DE2;
        Mon, 30 Jan 2023 04:04:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD01916F8;
        Mon, 30 Jan 2023 04:04:50 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C0B3F71E;
        Mon, 30 Jan 2023 04:04:06 -0800 (PST)
Message-ID: <741920ba-8637-5e28-695c-699b46351590@arm.com>
Date:   Mon, 30 Jan 2023 12:04:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Content-Language: en-GB
To:     Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
        joro@8bytes.org, will@kernel.org
Cc:     matthias.bgg@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230130102722.133271-3-abailon@baylibre.com>
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

On 2023-01-30 10:27, Alexandre Bailon wrote:
> Currently, the driver can allocate an unmanaged iommu domain.
> But, this only works for SoC having multiple bank or multiple iova region.

That is for good reason - there is only a single pagetable per bank, so 
if there are multiple devices assigned to a single bank, they cannot 
possibly be attached to different domains at the same time. Hence why 
the banks are modelled as groups.

Thanks,
Robin.

> This updates the driver to also support unmanaged iommu domain if
> MTK_UNMANAGED_DEVICE is set in the iommu id.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>   drivers/iommu/mtk_iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2badd6acfb23d..5884a1ad409a0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -858,9 +858,15 @@ static int mtk_iommu_get_group_id(struct device *dev, const struct mtk_iommu_pla
>   static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   {
>   	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct list_head *hw_list = c_data->hw_list;
>   	struct iommu_group *group;
>   	int groupid;
> +	int i;
> +
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		if (MTK_M4U_UNMANAGED(fwspec->ids[i]))
> +			return iommu_group_alloc();
>   
>   	data = mtk_iommu_get_frst_data(hw_list);
>   	if (!data)

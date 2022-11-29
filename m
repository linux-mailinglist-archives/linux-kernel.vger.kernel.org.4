Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8663BF52
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiK2LsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiK2LsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:48:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E3AD2B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:48:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC6B2D6E;
        Tue, 29 Nov 2022 03:48:21 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5EF03F73D;
        Tue, 29 Nov 2022 03:48:13 -0800 (PST)
Message-ID: <da0f6ffc-efa2-66cf-770b-1fd007894f3a@arm.com>
Date:   Tue, 29 Nov 2022 11:48:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] iommu/mediatek: Fix crash on isr after kexec()
Content-Language: en-GB
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-28 22:16, Ricardo Ribalda wrote:
> If the system is rebooted via isr(), the IRQ handler might be triggerd
> before the domain is initialized. Resulting on an invalid memory access
> error.
> 
> Fix:
> [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> [    0.501166] Call trace:
> [    0.501174]  report_iommu_fault+0x28/0xfc
> [    0.501180]  mtk_iommu_isr+0x10c/0x1c0

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> To: Yong Wu <yong.wu@mediatek.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: iommu@lists.linux.dev
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v2:
> - Also print the error message if !dom (Thanks Yong)
> - Link to v1: https://lore.kernel.org/r/20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org
> ---
>   drivers/iommu/mtk_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2ab2ecfe01f8..3d913ab5029c 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>   		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
>   	}
>   
> -	if (report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
> +	if (!dom || report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
>   			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>   		dev_err_ratelimited(
>   			bank->parent_dev,
> 
> ---
> base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> change-id: 20221125-mtk-iommu-13023f971298
> 
> Best regards,

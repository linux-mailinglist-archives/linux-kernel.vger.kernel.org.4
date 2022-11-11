Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C63625E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiKKPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiKKPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:19:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29D958291C;
        Fri, 11 Nov 2022 07:18:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15CD1FB;
        Fri, 11 Nov 2022 07:18:24 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 546EA3F73D;
        Fri, 11 Nov 2022 07:18:16 -0800 (PST)
Message-ID: <d677f7c1-8c99-4bb0-d363-7a538b38a83a@arm.com>
Date:   Fri, 11 Nov 2022 15:18:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/8] iommu/arm-smmu: Add definition for
 ARM_SMMU_CB_FSRRESTORE
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
 <20221111145919.221159-4-angelogioacchino.delregno@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221111145919.221159-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 2:59 pm, AngeloGioacchino Del Regno wrote:
> In preparation for adding a proper context bank reset sequence in
> qcom_iommu, add a definition for the implementation defined Fault
> Status Restore register (FSRRESTORE).

It's not implementation defined, it's architectural. But I don't follow 
why we should need this. If we're resetting FSR, we don't need to 
restore any previous value to it; all we want to do is clear it, which 
we do already via its own mechanism.

Thanks,
Robin.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 703fd5817ec1..5015138799c5 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -219,6 +219,7 @@ enum arm_smmu_cbar_type {
>   					 ARM_SMMU_FSR_TF |		\
>   					 ARM_SMMU_FSR_IGN)
>   
> +#define ARM_SMMU_CB_FSRRESTORE		0x5c
>   #define ARM_SMMU_CB_FAR			0x60
>   
>   #define ARM_SMMU_CB_FSYNR0		0x68

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84227145C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjE2Hzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2Hzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:55:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37798A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:55:47 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E8386605961;
        Mon, 29 May 2023 08:55:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685346945;
        bh=oTdocyJ/fdDvVOM9bvypLnMcp07pgkCobWwO3/e/PV4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kAYZU6QnU8eMMuQkF3n6TdkQrOGmMBu2uqnpRWntRDxezgkByhD/fLa7ahKyLEOGK
         GKy8qGnV4BeNJ+mMcSvN8TdjueJNMaOKKkIwpEfCMKHYyEohHQEQDZq95k5EjAigye
         kWCctLWRaq6Gd0o7LmjBzDPQ/gCeJ5EonmisQZ16WXKwcuKnkRp1JpKiN2VBCyp/ds
         /LGzACi6NDMsoEdhlIkInp4NGNd39vXdyFMzYozA1K0FmlI0n8GGKmlzwJOCfSQFEF
         iQCowGSzSsXzDINBB2eN+8/NvBUzty91CEEuM6e/hIUremjnzoIcoi0xo0CbSKWENN
         BkeVcrYoOxICg==
Message-ID: <cc053ab0-1ed3-0d2c-204d-a5ae85b759a5@collabora.com>
Date:   Mon, 29 May 2023 09:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC] iommu/mediatek: Flush IOTLB completely only if domain
 has been attached
To:     Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230526085402.394239-1-wenst@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230526085402.394239-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 10:53, Chen-Yu Tsai ha scritto:
> If an IOMMU domain was never attached, it lacks any linkage to the
> actual IOMMU hardware. Attempting to do flush_iotlb_all() on it will
> result in a NULL pointer dereference. This seems to happen after the
> recent IOMMU core rework in v6.4-rc1.
> 
>      Unable to handle kernel read from unreadable memory at virtual address 0000000000000018
>      Call trace:
>       mtk_iommu_flush_iotlb_all+0x20/0x80
>       iommu_create_device_direct_mappings.part.0+0x13c/0x230
>       iommu_setup_default_domain+0x29c/0x4d0
>       iommu_probe_device+0x12c/0x190
>       of_iommu_configure+0x140/0x208
>       of_dma_configure_id+0x19c/0x3c0
>       platform_dma_configure+0x38/0x88
>       really_probe+0x78/0x2c0
> 
> Check if the "bank" field has been filled in before actually attempting
> the IOTLB flush to avoid it. The IOTLB is also flushed when the device
> comes out of runtime suspend, so it should have a clean initial state.
> 
> Fixes: 08500c43d4f7 ("iommu/mediatek: Adjust the structure")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Not only ARM SMMU does this, others are doing the same, some in a different
form (walking a list)... So I agree with this being a valid fix.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> I think this is a valid fix, but I'm not very familiar with the hardware
> or the design of the driver. The ARM SMMU drivers seem to do this as well.
> 
>   drivers/iommu/mtk_iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index aecc7d154f28..e93906d6e112 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -781,7 +781,8 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
>   {
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>   
> -	mtk_iommu_tlb_flush_all(dom->bank->parent_data);
> +	if (dom->bank)
> +		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
>   }
>   
>   static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16166248E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjAILri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjAILrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:47:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E181D120
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:47:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5D51042;
        Mon,  9 Jan 2023 03:48:12 -0800 (PST)
Received: from [10.57.77.32] (unknown [10.57.77.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8F9E3F67D;
        Mon,  9 Jan 2023 03:47:28 -0800 (PST)
Message-ID: <99695d77-e54f-3270-ee9a-9b3cbb3296e5@arm.com>
Date:   Mon, 9 Jan 2023 11:47:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/iova: Fix alloc iova overflows issue
Content-Language: en-GB
To:     yf.wang@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:IOMMU DMA-API LAYER" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Ning Li <Ning.Li@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>
References: <20230109083429.25622-1-yf.wang@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230109083429.25622-1-yf.wang@mediatek.com>
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

On 2023-01-09 08:34, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> In __alloc_and_insert_iova_range, there is an issue that retry_pfn
> overflows. The value of iovad->anchor.pfn_hi is ~0UL, then when
> iovad->cached_node is iovad->anchor, curr_iova->pfn_hi + 1 will
> overflow. As a result, if the retry logic is executed, low_pfn is
> updated to 0, and then new_pfn < low_pfn returns false to make the
> allocation successful.
> 
> This issue occurs in the following two situations:
> 1. The first iova size exceeds the domain size. When initializing
> iova domain, iovad->cached_node is assigned as iovad->anchor. For
> example, the iova domain size is 10M, start_pfn is 0x1_F000_0000,
> and the iova size allocated for the first time is 11M. The
> following is the log information, new->pfn_lo is smaller than
> iovad->cached_node.
> 
> Example log:
> [  223.798112][T1705487] sh: [name:iova&]__alloc_and_insert_iova_range
> start_pfn:0x1f0000,retry_pfn:0x0,size:0xb00,limit_pfn:0x1f0a00
> [  223.799590][T1705487] sh: [name:iova&]__alloc_and_insert_iova_range
> success start_pfn:0x1f0000,new->pfn_lo:0x1efe00,new->pfn_hi:0x1f08ff
> 
> 2. The node with the largest iova->pfn_lo value in the iova domain
> is deleted, iovad->cached_node will be updated to iovad->anchor,
> and then the alloc iova size exceeds the maximum iova size that can
> be allocated in the domain.
> 
> Adding judgment that retry_pfn must be greater than iovad->start_pfn
> can fix this issue.

Hmm, indeed that's a sneaky little bug - thanks for the thorough 
analysis - but couldn't we avoid the overflow entirely? I don't have the 
complete logic paged in, but superficially it seems like:

	retry_pfn = curr_iova->pfn_hi;
	...
		retry_pfn <= limit_pfn
	...
		low_pfn = retry_pfn + 1;

should still work, shouldn't it?

Thanks,
Robin.

> Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   drivers/iommu/iova.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index a44ad92fc5eb..0073206c2a95 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -209,7 +209,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
>   
>   	if (high_pfn < size || new_pfn < low_pfn) {
> -		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> +		if (low_pfn == iovad->start_pfn &&
> +		    retry_pfn >= iovad->start_pfn && retry_pfn < limit_pfn) {
>   			high_pfn = limit_pfn;
>   			low_pfn = retry_pfn;
>   			curr = iova_find_limit(iovad, limit_pfn);

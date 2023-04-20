Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF06E907A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjDTKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjDTKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:40:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F4993C32
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:39:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6401480;
        Thu, 20 Apr 2023 03:39:57 -0700 (PDT)
Received: from [10.57.22.118] (unknown [10.57.22.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 860623F587;
        Thu, 20 Apr 2023 03:39:12 -0700 (PDT)
Message-ID: <e9b912ee-6b49-f369-82ff-daff49dc7511@arm.com>
Date:   Thu, 20 Apr 2023 11:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu/iova: Optimize iova_magazine_alloc()
Content-Language: en-GB
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230418062518.852-1-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230418062518.852-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-18 07:25, Zhen Lei wrote:
> Only the member 'size' needs to be initialized to 0. Clearing the array
> pfns[], which is about 1 KiB in size, not only wastes time, but also
> causes cache pollution.

Makes sense to me.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/iova.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index fe452ce466429a7..c970b9a2819d7bb 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -647,7 +647,13 @@ struct iova_rcache {
>   
>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   {
> -	return kzalloc(sizeof(struct iova_magazine), flags);
> +	struct iova_magazine *mag;
> +
> +	mag = kmalloc(sizeof(struct iova_magazine), flags);

Nit: maybe sizeof(*mag) is preferable?

> +	if (mag)
> +		mag->size = 0;
> +
> +	return mag;
>   }
>   
>   static void iova_magazine_free(struct iova_magazine *mag)

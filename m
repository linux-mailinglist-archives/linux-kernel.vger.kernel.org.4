Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A65B6DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiIMNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIMNBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:01:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7C2228C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:01:37 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MRk8c22yWz67K73;
        Tue, 13 Sep 2022 21:00:16 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 15:01:35 +0200
Received: from [10.48.155.86] (10.48.155.86) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 13 Sep
 2022 14:01:34 +0100
Message-ID: <4740744e-2e12-520d-8598-188b8d2ebd6b@huawei.com>
Date:   Tue, 13 Sep 2022 14:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: Fix module config properly
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.155.86]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 12:47, Robin Murphy wrote:
> IOMMU_IOVA is intended to be an optional library for users to select as
> and when they desire. Since it can be a module now, this means that
> built-in code which has chosen not to select it should not fail to link
> if it happens to have selected as a module by someone else. Replace
> IS_ENABLED() with IS_REACHABLE() to do the right thing.

Hi Robin,

Recently you mentioned "I wonder if we couldn't replace the IS_ENABLED() 
with IS_REACHABLE() and restore some of the previously-conditional 
selects", and pointed me to 84db889e6d82 as an example of when a 
conditional select was made unconditional.

So will you also restore some previously-conditional selects next?

To me, it seems that any user of IOVA API selects IOMMU_IOVA always.

thanks,
John

> 
> CC: Thierry Reding <thierry.reding@gmail.com>
> Reported-by: John Garry <john.garry@huawei.com>
> Fixes: 15bbdec3931e ("iommu: Make the iova library a module")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Phrased as a fix for the sake of complete honesty, but it seems
> everyone's been making do for years already so by now it's really
> just more of an enhancement.
> 
>   include/linux/iova.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 8f97a43be834..fe18c3e6a725 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -75,7 +75,7 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>   	return iova >> iova_shift(iovad);
>   }
>   
> -#if IS_ENABLED(CONFIG_IOMMU_IOVA)
> +#if IS_REACHABLE(CONFIG_IOMMU_IOVA)
>   int iova_cache_get(void);
>   void iova_cache_put(void);
>   


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE47314F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244866AbjFOKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbjFOKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:13:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E9E12710;
        Thu, 15 Jun 2023 03:13:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87FDC1FB;
        Thu, 15 Jun 2023 03:14:19 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABFA3F71E;
        Thu, 15 Jun 2023 03:13:32 -0700 (PDT)
Message-ID: <36565295-ebaa-2a66-3389-ba5eb714ab34@arm.com>
Date:   Thu, 15 Jun 2023 11:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "Revert "Revert "arm64: dma: Drop cache
 invalidation from arch_dma_prep_coherent()"""
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>
Cc:     andersson@kernel.org, amit.pundir@linaro.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sumit.semwal@linaro.org, Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 00:59, Douglas Anderson wrote:
> This reverts commit 7bd6680b47fa4cd53ee1047693c09825e212a6f5.
> 
> When booting a sc7180-trogdor based device on mainline, I see errors
> that look like this:
> 
>   qcom_scm firmware:scm: Assign memory protection call failed -22
>   qcom_rmtfs_mem 94600000.memory: assign memory failed
>   qcom_rmtfs_mem: probe of 94600000.memory failed with error -22
> 
> The device still boots OK, but WiFi doesn't work.
> 
> The failure only seems to happen when
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y. When I don't have that set then
> everything is peachy. Presumably something about the extra
> initialization disagrees with the change to drop cache invalidation.

AFAICS init_on_alloc essentially just adds __GFP_ZERO to the page 
allocation. This should make no difference to a DMA allocation given 
that dma_alloc_attrs explicitly zeros its allocation anyway. However... 
for the non-coherent case, the DMA API's memset will be done through the 
non-cacheable remap, while __GFP_ZERO can leave behind cached zeros for 
the linear map alias. Thus what I assume must be happening here is that 
"DMA" from the firmware is still making cacheable accesses to the buffer 
and getting those zeros instead of whatever actual data which was 
subsequently written non-cacheably direct to RAM. So either the firmware 
still needs fixing to make non-cacheable accesses, or the SCM driver 
needs to correctly describe it as coherent.

Thanks,
Robin.

> Fixes: 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()""")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   arch/arm64/mm/dma-mapping.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3cb101e8cb29..5240f6acad64 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -36,7 +36,22 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>   {
>   	unsigned long start = (unsigned long)page_address(page);
>   
> -	dcache_clean_poc(start, start + size);
> +	/*
> +	 * The architecture only requires a clean to the PoC here in order to
> +	 * meet the requirements of the DMA API. However, some vendors (i.e.
> +	 * Qualcomm) abuse the DMA API for transferring buffers from the
> +	 * non-secure to the secure world, resetting the system if a non-secure
> +	 * access shows up after the buffer has been transferred:
> +	 *
> +	 * https://lore.kernel.org/r/20221114110329.68413-1-manivannan.sadhasivam@linaro.org
> +	 *
> +	 * Using clean+invalidate appears to make this issue less likely, but
> +	 * the drivers themselves still need fixing as the CPU could issue a
> +	 * speculative read from the buffer via the linear mapping irrespective
> +	 * of the cache maintenance we use. Once the drivers are fixed, we can
> +	 * relax this to a clean operation.
> +	 */
> +	dcache_clean_inval_poc(start, start + size);
>   }
>   
>   #ifdef CONFIG_IOMMU_DMA

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB6731445
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbjFOJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343700AbjFOJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:40:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E5563A93
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:39:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA20B1FB;
        Thu, 15 Jun 2023 02:39:57 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5317E3F71E;
        Thu, 15 Jun 2023 02:39:12 -0700 (PDT)
Message-ID: <685ec543-56d0-7a9c-4a15-3072746c2f91@arm.com>
Date:   Thu, 15 Jun 2023 10:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu: export iommu_set_default_translated function
Content-Language: en-GB
To:     Anvesh Jain P <quic_ajainp@quicinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
References: <20230615093308.24989-1-quic_ajainp@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230615093308.24989-1-quic_ajainp@quicinc.com>
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

On 2023-06-15 10:33, Anvesh Jain P wrote:
> export iommu_set_default_translated function to be used by other modules.

Which modules? The only reason these functions are public at all is to 
support the legacy x86 command-line options. No *new* code outside the 
core API should have any reason to be messing with core API policy. If 
an IOMMU driver needs to special-case particular devices we have 
.def_domain_type for that.

Thanks,
Robin.

> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..1b4a5db58d66 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2730,6 +2730,7 @@ void iommu_set_default_translated(bool cmd_line)
>   		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>   	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   }
> +EXPORT_SYMBOL_GPL(iommu_set_default_translated);
>   
>   bool iommu_default_passthrough(void)
>   {
> 
> base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644

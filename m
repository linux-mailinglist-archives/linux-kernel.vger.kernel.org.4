Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990A071FDDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjFBJ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjFBJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:28:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E038B1A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:27:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D849A1063;
        Fri,  2 Jun 2023 02:28:29 -0700 (PDT)
Received: from [10.57.84.31] (unknown [10.57.84.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52CD43F7BD;
        Fri,  2 Jun 2023 02:27:43 -0700 (PDT)
Message-ID: <88a9afd9-eb2d-55b0-e65e-dec209a5bba3@arm.com>
Date:   Fri, 2 Jun 2023 10:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Handle the failure case of
 dmar_reenable_qi()
To:     Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230602020520.224465-1-yanfei.xu@intel.com>
 <20230602020520.224465-2-yanfei.xu@intel.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230602020520.224465-2-yanfei.xu@intel.com>
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

On 2023-06-02 03:05, Yanfei Xu wrote:
> dmar_reenable_qi() may not succeed. Check and return when it fails.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8096273b034c..e9188d045609 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2967,10 +2967,14 @@ static int init_iommu_hw(void)
>   {
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu = NULL;
> +	int ret;
>   
> -	for_each_active_iommu(iommu, drhd)
> +	for_each_active_iommu(iommu, drhd) {
>   		if (iommu->qi)
> -			dmar_reenable_qi(iommu);
> +			ret = dmar_reenable_qi(iommu);
> +		if (ret)

Nit: either this should be inside the previous condition, or you need to 
initialise ret to 0.

Thanks,
Robin.

> +			return ret;
> +	}
>   
>   	for_each_iommu(iommu, drhd) {
>   		if (drhd->ignored) {

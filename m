Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF540674AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjATEeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjATEds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:33:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC5BCE36
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189169; x=1705725169;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oCO75c7hpSpf7YAc/etqBp/Xdevy0oa9hctB/aBK/D8=;
  b=fQsJpVixa78uxTdi2+os6+rsDwY7sB1EJCMxsOs4JbbiXljcvbgZ6L68
   N/JlhTC+TKBVX7Imsd0RNbD1ZBxKoIJpdVJFRxICPZbNE/JBjKu5Q2Zyk
   PfAJO6Afjfhalj4mIw0ZuVqninzGZGfR1B5n+EUKxf0xOGdBL+LNoz1yv
   3dF3mg3wP/QTsAqOHqdmS67iGkqa7Hm669NgACStTpEgoczQoOv1t4bLV
   YYEjs6ov/lgbyIe+kD/QMt0tdYER+qyT/RnvrXlN3dDmEVFZ1cpl6d1+s
   cv0DUIWAYVJLczbi8A/WvhqcPEu/ilm0UjLVsotOvxPHkd5GVA4T+2io5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411472481"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="411472481"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:55:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="660114044"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="660114044"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.185.248]) ([10.252.185.248])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:55:48 -0800
Message-ID: <379823f4-d1c3-8943-4afe-e33f4d21785c@linux.intel.com>
Date:   Thu, 19 Jan 2023 16:55:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH V2 3/7] iommu/vt-d: Support Enhanced Command Interface
To:     kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230118205006.3182907-1-kan.liang@linux.intel.com>
 <20230118205006.3182907-4-kan.liang@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230118205006.3182907-4-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/19 4:50, kan.liang@linux.intel.com wrote:
> +#ifdef CONFIG_INTEL_IOMMU
> +#define ecmd_get_status_code(res)	((res & 0xff) >> 1)
> +
> +/*
> + * Function to submit a command to the enhanced command interface. The
> + * valid enhanced command descriptions are defined in Table 47 of the
> + * VT-d spec. The VT-d hardware implementation may support some but not
> + * all commands, which can be determined by checking the Enhanced
> + * Command Capability Register.
> + *
> + * Return values:
> + *  - 0: Command successful without any error;
> + *  - Negative: software error value;
> + *  - Nonzero positive: failure status code defined in Table 48.
> + */
> +int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
> +{
> +	unsigned long flags;
> +	u64 res;
> +	int ret;
> +
> +	if (!cap_ecmds(iommu->cap))
> +		return -ENODEV;
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +
> +	res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
> +	if (res & DMA_ECMD_ECRSP_IP) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	/*
> +	 * Unconditionally write the operand B, because
> +	 * - There is no side effect if an ecmd doesn't require an
> +	 *   operand B, but we set the register to some value.
> +	 * - It's not invoked in any critical path. The extra MMIO
> +	 *   write doesn't bring any performance concerns.
> +	 */
> +	dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
> +	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
> +
> +	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
> +		      !(res & DMA_ECMD_ECRSP_IP), res);
> +
> +	if (res & DMA_ECMD_ECRSP_IP) {
> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}
> +
> +	ret = ecmd_get_status_code(res);
> +err:
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_INTEL_IOMMU */

Can we remove the "#ifdef CONFIG_INTEL_IOMMU"? Or if this is currently
only intel-iommu specific, how about moving it to drivers/iommu/intel
/iommu.c?

--
Best regards,
baolu

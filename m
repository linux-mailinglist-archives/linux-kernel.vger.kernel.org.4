Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7E673A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjASNZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjASNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:24:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF25B5A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674134684; x=1705670684;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0rqq/hTud1TpM3IRmZ08IsKip23yN4USGI5J2nOh+I4=;
  b=KpD4TZwvc7RqrIj75/wpDXFtsRJLPWp6oQWWLkd9WrxTnl61z3Rd3nEi
   P8oYK7NlGcg09L4xhdPzcBXFZxjU8U4AOQR/YoKNEdWZ80Uh+t7zipwID
   SKU8wEDtBid5FVdpRTXTDss0TzI7lhYN+Cbzaw1NUcfw1rXSdU/L5ra4+
   1sduP7xirEr9Mq1alGbftkhd5gn/D+ONMLYKQ62V4Qp1AqolP7FYdxUPN
   wHrsEJETwbXoiBALaKsBGe7fUD3/XLmACjSEL8MX+jKP+B37/FRj4Ddbr
   5WaYmj0TfyDuC3Yy24UaqUMjLOWKIHXHXcHgs295fiESBe1VGMy4iFYDe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327359467"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="327359467"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="728663472"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="728663472"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jan 2023 05:24:43 -0800
Received: from [10.212.175.76] (kliang2-mobl1.ccr.corp.intel.com [10.212.175.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2CC53580AE0;
        Thu, 19 Jan 2023 05:24:32 -0800 (PST)
Message-ID: <b9619bee-7f5c-81db-710d-20550ea01517@linux.intel.com>
Date:   Thu, 19 Jan 2023 08:24:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 3/7] iommu/vt-d: Support Enhanced Command Interface
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230118205006.3182907-1-kan.liang@linux.intel.com>
 <20230118205006.3182907-4-kan.liang@linux.intel.com>
 <379823f4-d1c3-8943-4afe-e33f4d21785c@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <379823f4-d1c3-8943-4afe-e33f4d21785c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-19 3:55 a.m., Baolu Lu wrote:
> On 2023/1/19 4:50, kan.liang@linux.intel.com wrote:
>> +#ifdef CONFIG_INTEL_IOMMU
>> +#define ecmd_get_status_code(res)    ((res & 0xff) >> 1)
>> +
>> +/*
>> + * Function to submit a command to the enhanced command interface. The
>> + * valid enhanced command descriptions are defined in Table 47 of the
>> + * VT-d spec. The VT-d hardware implementation may support some but not
>> + * all commands, which can be determined by checking the Enhanced
>> + * Command Capability Register.
>> + *
>> + * Return values:
>> + *  - 0: Command successful without any error;
>> + *  - Negative: software error value;
>> + *  - Nonzero positive: failure status code defined in Table 48.
>> + */
>> +int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
>> +{
>> +    unsigned long flags;
>> +    u64 res;
>> +    int ret;
>> +
>> +    if (!cap_ecmds(iommu->cap))
>> +        return -ENODEV;
>> +
>> +    raw_spin_lock_irqsave(&iommu->register_lock, flags);
>> +
>> +    res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
>> +    if (res & DMA_ECMD_ECRSP_IP) {
>> +        ret = -EBUSY;
>> +        goto err;
>> +    }
>> +
>> +    /*
>> +     * Unconditionally write the operand B, because
>> +     * - There is no side effect if an ecmd doesn't require an
>> +     *   operand B, but we set the register to some value.
>> +     * - It's not invoked in any critical path. The extra MMIO
>> +     *   write doesn't bring any performance concerns.
>> +     */
>> +    dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
>> +    dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa <<
>> DMA_ECMD_OA_SHIFT));
>> +
>> +    IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
>> +              !(res & DMA_ECMD_ECRSP_IP), res);
>> +
>> +    if (res & DMA_ECMD_ECRSP_IP) {
>> +        ret = -ETIMEDOUT;
>> +        goto err;
>> +    }
>> +
>> +    ret = ecmd_get_status_code(res);
>> +err:
>> +    raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
>> +
>> +    return ret;
>> +}
>> +#endif /* CONFIG_INTEL_IOMMU */
> 
> Can we remove the "#ifdef CONFIG_INTEL_IOMMU"? 

In dmar.c, no, there will be a compiler warning when the
CONFIG_INTEL_IOMMU is not set.

> Or if this is currently
> only intel-iommu specific, how about moving it to drivers/iommu/intel
> /iommu.c?
> 

Yes, it should OK to move it to iommu.c to avoid the "#ifdef
CONFIG_INTEL_IOMMU". Now, it's intel-iommu specific.

Thanks,
Kan

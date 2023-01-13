Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F396699DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbjAMOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbjAMONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABC69523
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673619175; x=1705155175;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bgR5ummVsveUjZeTs1DpxvmSSGDvw4EF1HbWfjVN/8A=;
  b=AAHzebDMISlWfDB0fjOnTRnFu/eSr07XPjVpvgOo42FvCZneWD9rtt/8
   NRyp+R1F6oc2Y40VWSqEOxe8aUfARbr4KJJEfR4XDRjduc8AqZNAtpqLh
   lOpoOrU57+PQ020EeWjB88SAskLRnTW0ZVL/oTonpKfHSgHUk/604I3ZM
   yYqj/os+pQIZgjCmJgpj3OTq05cEtwB0RjDqQI4jEPkhNwU5Bwcz3qYTF
   midQwRaf8vFI2Ix67JJ5xWQMaoYipn+gQKDeHDzDb3j7QiHvRnCSbTT3C
   T7MHdEwG1Cc759JPdtxXbquEz8/apiAk1tCKC8jotoXVyl7od06yki53Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324057611"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324057611"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:12:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="832078121"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="832078121"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.190.181]) ([10.252.190.181])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:12:51 -0800
Message-ID: <a84ac37c-2b03-35f2-2275-442b448cf6b5@linux.intel.com>
Date:   Fri, 13 Jan 2023 22:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH 3/7] iommu/vt-d: Support Enhanced Command Interface
To:     kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-4-kan.liang@linux.intel.com>
 <6783f737-2701-77e3-ce83-8d287be51cf6@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6783f737-2701-77e3-ce83-8d287be51cf6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/13 21:55, Baolu Lu wrote:
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
>> +int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
>> +             u64 oa, bool has_ob, u64 ob)
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
>> +    if (has_ob)
>> +        dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
> 
> The ecmds that require a Operand B are statically defined in the spec,
> right? What will it look like if we define a static ignore_ob(ecmd)?

Or simply remove has_ob parameter? The least case is an unnecessary
write to a register. It's fine as far as I can see since we should avoid
using it in any critical path.

--
Best regards,
baolu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05B66A285
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjAMTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAMTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:02:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD16544F5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673636561; x=1705172561;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=aEv5uAlD9RlVQZ3sj9LjdydEotF2GW9AB0fhi/QMapo=;
  b=SxphojMj6IpPnBOH9XuilTFldmGoNlLGRUN+tgrNtBm8z24vmBhTsQRj
   5AhEO36s6L43jRBmIGAwDeNUc4cStW/8NBXsM2+Ff8Y9KKA4R+Lfg47iB
   PHtReNq+XyF377InBWVcEXH4QU9Z0WRUFG9EC+A3fmvLw0X9VHevxyyPx
   EjTfcF8xwSHb9K7zmxoBV4xKYGkSGTlNR39kXkjnnG+Nss+bh0iewWZJB
   daASjuoF0OLQyVKmHjsmLcygLTd7CwnJspuQ0DTiPO2Hmswqt3jI01pyg
   6rwGjrzVgUrkoTckj7wGYvhDAN6c0opkP2+Vn6U6tEZk4uCsfFeryU8NL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386415289"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="386415289"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608249972"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608249972"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 11:02:38 -0800
Received: from [10.209.118.210] (kliang2-mobl1.ccr.corp.intel.com [10.209.118.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ACA6358068A;
        Fri, 13 Jan 2023 11:02:36 -0800 (PST)
Message-ID: <9b4f4602-55c6-40cd-5bf9-a47c16cec1a3@linux.intel.com>
Date:   Fri, 13 Jan 2023 14:02:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] iommu/vt-d: Support Enhanced Command Interface
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-4-kan.liang@linux.intel.com>
 <6783f737-2701-77e3-ce83-8d287be51cf6@linux.intel.com>
 <a84ac37c-2b03-35f2-2275-442b448cf6b5@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <a84ac37c-2b03-35f2-2275-442b448cf6b5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-13 9:12 a.m., Baolu Lu wrote:
> On 2023/1/13 21:55, Baolu Lu wrote:
>>> +/*
>>> + * Function to submit a command to the enhanced command interface. The
>>> + * valid enhanced command descriptions are defined in Table 47 of the
>>> + * VT-d spec. The VT-d hardware implementation may support some but not
>>> + * all commands, which can be determined by checking the Enhanced
>>> + * Command Capability Register.
>>> + *
>>> + * Return values:
>>> + *  - 0: Command successful without any error;
>>> + *  - Negative: software error value;
>>> + *  - Nonzero positive: failure status code defined in Table 48.
>>> + */
>>> +int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
>>> +             u64 oa, bool has_ob, u64 ob)
>>> +{
>>> +    unsigned long flags;
>>> +    u64 res;
>>> +    int ret;
>>> +
>>> +    if (!cap_ecmds(iommu->cap))
>>> +        return -ENODEV;
>>> +
>>> +    raw_spin_lock_irqsave(&iommu->register_lock, flags);
>>> +
>>> +    res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
>>> +    if (res & DMA_ECMD_ECRSP_IP) {
>>> +        ret = -EBUSY;
>>> +        goto err;
>>> +    }
>>> +
>>> +    if (has_ob)
>>> +        dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
>>
>> The ecmds that require a Operand B are statically defined in the spec,
>> right? What will it look like if we define a static ignore_ob(ecmd)?
> 

If so, I think we have to maintain a table of ecmd in the ignore_ob(),
and check the given ecmd at runtime, right?
That sounds hard to maintain and low efficiency with more and more ecmds
are introduced.

> Or simply remove has_ob parameter? The least case is an unnecessary
> write to a register. It's fine as far as I can see since we should avoid
> using it in any critical path.

I was told in the internal review that a MMIO write may trigger a VM
exit, if in a guest. We should avoid such unnecessary MMIO write.

For PMU, right, I don't think we use it at critical path. Now the PMU is
the only customer for ecmd. I think the extra MMIO write can be tolerant.

I will remove has_ob and add some comments in V2.

Thanks,
Kan

> 
> -- 
> Best regards,
> baolu

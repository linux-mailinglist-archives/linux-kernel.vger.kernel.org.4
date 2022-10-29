Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2375661214B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ2IMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2IMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:12:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437C5C9F9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667031129; x=1698567129;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0l8conNN1TjxcoCVVzLHCVgHjFaZt6Qyb2532sp6hBU=;
  b=aaavpMVJvBJAyntBjbba0VWwyKf8IZ8fURbwF+L+wLN6IeHoZ313qqiK
   TgPkSISxYDCwZ8YpIHnH/dJCCSlG9jckfmsto3kx9SnrwC1Gwq0wIjFW6
   f3q8qsfn5vNwZQSVPaZuBs2NLeF/806AYuXSYZk3z/MQslH/d39dA/sLY
   N6HV05xIj1nfFjM36Wx9F/7Jj2MFNiQzqtu/6nM8NWEycdDiYvzaywE19
   V0F68zfj2A9PS3s0JdXNU2RP6gP2Av5sN/DHHcrYB6o6LmQD/i8P6XoZU
   QGg7No0mFNZqSSYAriDqzp4/HTK1S0VZ0+SUPtfThfDGHvz0nC3DjGlm1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="335297537"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="335297537"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:12:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="878230034"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="878230034"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:12:06 -0700
Message-ID: <1ea0d41c-906a-38a0-adb8-60a7b63ad65b@linux.intel.com>
Date:   Sat, 29 Oct 2022 16:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Scarlett Gourley <scarlett@arista.com>,
        James Sewart <jamessewart@arista.com>,
        Jack O'Sullivan <jack@arista.com>
Content-Language: en-US
To:     Lennert Buytenhek <buytenh@wantstofly.org>
References: <Y1eZbXKdJDoS8loC@wantstofly.org>
 <028e2c63-939b-af31-88b9-b479b41ce67c@linux.intel.com>
 <Y1o/EhV+XLgA9s2r@wantstofly.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH,RFC] iommu/vt-d: Convert dmar_fault IRQ to a threaded IRQ
In-Reply-To: <Y1o/EhV+XLgA9s2r@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/27 16:19, Lennert Buytenhek wrote:
>>> iommu/amd already uses a threaded IRQ handler for its I/O page fault
>>> reporting, and so it already has this advantage.
>>>
>>> When IRQ remapping is enabled, iommu/vt-d will try to set up its
>>> dmar_fault IRQ handler from start_kernel() -> x86_late_time_init()
>>> -> apic_intr_mode_init() -> apic_bsp_setup() ->
>>> irq_remap_enable_fault_handling() -> enable_drhd_fault_handling(),
>>> which happens before kthreadd is started, and trying to set up a
>>> threaded IRQ handler this early on will oops.  However, there
>>> doesn't seem to be a reason why iommu/vt-d needs to set up its fault
>>> reporting IRQ handler this early, and if we remove the IRQ setup code
>>> from enable_drhd_fault_handling(), the IRQ will be registered instead
>>> from pci_iommu_init() -> intel_iommu_init() -> init_dmars(), which
>>> seems to work just fine.
>> At present, we cannot do so. Because the VT-d interrupt remapping and
>> DMA remapping can be independently enabled. In another words, it's a
>> possible case where interrupt remapping is enabled while DMA remapping
>> is not.
> Is there a way I can test this easily?
> 
> I think we should be able to handle the "interrupt remapping enabled
> but DMA remapping disabled" case in the same way, by registering the
> dmar_fault IRQ sometime after kthreadd has been started.  I don't think
> the dmar_fault handler performs any function that is critical for the
> operation of the IOMMU, and I think that we can defer setting it up
> until whenever is convenient.

Another possible way is not to split VT-d DMA remapping and interrupt
remapping. The possible case of "intr remapping enabled but DMA
remapping not" that I can imagine is that the guest VM doesn't want DMA
translation because of poor efficiency. If so, the overhead impacted by
DMA translation can be eliminated through "iommu=pt" or kernel build
configuration. Of course, there may also be some special needs that I
did not think of.

Best regards,
baolu

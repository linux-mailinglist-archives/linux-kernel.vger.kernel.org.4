Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04B6F0371
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbjD0JfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbjD0JfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:35:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5598B35B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:35:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC2D82F4;
        Thu, 27 Apr 2023 02:36:01 -0700 (PDT)
Received: from [10.57.23.190] (unknown [10.57.23.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C48A3F64C;
        Thu, 27 Apr 2023 02:35:16 -0700 (PDT)
Message-ID: <d89938b0-191f-8037-70c1-4f054b527c42@arm.com>
Date:   Thu, 27 Apr 2023 10:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
 <ZCGJn3QWhQl4F1dI@nvidia.com>
 <ad57d47e-3f54-0e63-5cef-d786dab5535c@linux.intel.com>
 <ZEnFPYvNzF8WFgqO@Asurada-Nvidia>
 <09e4ce6e-0341-8590-b933-795ee28326a3@linux.intel.com>
 <ZEnt+qyN5EJIzCRf@Asurada-Nvidia>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZEnt+qyN5EJIzCRf@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-27 04:37, Nicolin Chen wrote:
> On Thu, Apr 27, 2023 at 11:20:40AM +0800, Baolu Lu wrote:
> 
>>> Attaching WARNINGs:
>>> [   19.680725] ------------[ cut here ]------------
>>> [   19.681083] WARNING: CPU: 0 PID: 561 at include/linux/mmap_lock.h:161 track_pfn_remap+0xf5/0x100
> 
>>> [   19.684817] Call Trace:
>>> [   19.684893]  <TASK>
>>> [   19.684967]  remap_pfn_range+0x3e/0xa0
>>> [   19.685084]  vfio_pci_mmap_fault+0x8a/0x160 [vfio_pci_core]
>   
>> I took a quick look. It seems that above warnings are irrelevant to this
>> commit. Can you please simply revert this commit and check whether there
>> are any changes?
> 
> I tried on top of the v6.3-rc5 tag. The warnings were triggered
> constantly. And reverting the commit fixes it:
> nicolinc@Asurada-Nvidia:~/work/mkt/images/nicolinc/src/kernel$ git log --oneline -2
> cb3dc9b2417e (HEAD -> v6.3-rc5) Revert "iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()"
> 7e364e56293b (tag: v6.3-rc5, jgg/linus) Linux 6.3-rc5
> 
> I don't think the commit is the causation yet there seems to be
> a strong correlation here...

The correlation is probably that you're now getting to see a genuine 
warning from lockdep_assert_held(), since intel-iommu is no longer 
causing debug_locks to be turned off earlier.

Robin.

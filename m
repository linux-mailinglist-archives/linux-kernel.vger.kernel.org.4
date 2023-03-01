Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60FD6A66F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCAEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAEXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:23:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787741CAF5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677644596; x=1709180596;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GJFnn/TsgIJy1ElS1Z4jJ9heoTDtcnibfA3sOxSj6nA=;
  b=Ps+9vfsx1Tx38TpBh6h5NDUiopSl1w6A1EWUdFCq2+3iFYO4cZRwusuk
   3mesi442feZJOVj+35upqxA8aq7SHokrQ5VahJT8xj9QdU5GmT+MLfQ6i
   8raDzcDFlwq7bj/OstjpJWepp4c3NdsN7PKqxJqb85r7tL6WuBDmGWI/6
   h2kpNwuJ5tjUfCtwl/TqYsBFFLpEkPbpBVoxAidmUezVfsJHgBbMJ99MX
   zNOuZVx4grPQVHyqy4XnCAii7qObCMCFAAG/yQhPjYIcrEbEPD5W/SosV
   5CKbTm2PWh1JuggXVEvZelxQ8VwFN4gwTtBI+6bHZrDAHnyqDO4+0X6QB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="313988018"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="313988018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 20:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704685838"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704685838"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2023 20:23:13 -0800
Message-ID: <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
Date:   Wed, 1 Mar 2023 12:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/3yNaQD5Pkvf61k@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 8:23 PM, Jason Gunthorpe wrote:
> On Tue, Feb 28, 2023 at 10:33:41AM +0800, Lu Baolu wrote:
>> In normal processing of PCIe ATS requests, the IOMMU performs address
>> translation and returns the device a physical memory address which
>> will be stored in that device's IOTLB. The device may subsequently
>> issue Translated DMA request containing physical memory address. The
>> IOMMU only checks that the device was allowed to issue such requests
>> and does not attempt to validate the physical address.
>>
>> The Intel IOMMU implementation only allows PCIe ATS on several SOC-
>> integrated devices which are opt-in’ed through the ACPI tables to
>> prevent any compromised device from accessing arbitrary physical
>> memory.
>>
>> Add a kernel option intel_iommu=relax_ats to allow users to have an
>> opt-in to allow turning on ATS at as wish, especially for CSP-owned
>> vertical devices. In any case, risky devices are not allowed to use
>> ATS.
> Why is this an intel specific option? 

I only see similar situation on ARM SMMUv3 platforms. The device ATS is
only allowed when the ATS bit is set in RC node of the ACPI/IORT table.

> all it does is effectively
> disable untrusted?

It's irrelevant to untrusted devices.

Untrusted devices, with pci_dev->untrusted set, means device connects to
the system through some kind of untrusted external port, e.g.
thunderbolt ports. For those devices, ATS shouldn't be enabled for those
devices.

Here we are talking about soc-integrated devices vs. discrete PCI
devices (connected to the system through internal PCI slot). The problem
is that the DMAR ACPI table only defines ATS attribute for Soc-
integrated devices, which causes ATS (and its ancillary features) on the
discrete PCI devices not to work.

> Why not a global option? All iommu with ATS will
> need this?
> 
> Also, why doesn't a "CSP" set their ACPI to make the devices they want
> to use ATS with trusted instead of this?

For example, users might purchase general servers and use their own or
third-party PCIe adapters on them. They have no means to customize the
BIOS.

Best regards,
baolu

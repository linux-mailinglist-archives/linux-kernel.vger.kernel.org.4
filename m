Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6C5B54EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiILHBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiILHBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:01:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3E24965
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662966111; x=1694502111;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GNBHq8PNXi22DyUwvYix9geYyFDMruJSs97qqEumAZs=;
  b=Vf/o+n6sfiz/3ZdKMfCS7hXzVkXtm4puwJzZUi6vEl05oA6eLZ0jyTUV
   Epl/Hqo2V6RGA9RP2Xo/oawXJLCjaQOTtboUXzebjqVJjLptQgYMdNk38
   QLQtuHPkEHOcs0V7Q3aIsvtUud9wmI8mVFknanrHx8ZTL/EVDZWG0R5Fz
   6lFbNFw0FbW0D4KfUxOVmKy7g4Q1cdmy/QWR4uD8E29yahUccr4GDNA8S
   nzBenfiHHhDQABtaKlka5s5Tg0uQ8pnzWlYt9KkYn255k+5KunzbiVFA2
   EF6qF4cyx85KEVnKdQN1bv5O+MRZrEiLDDkkYto60MHiE22qkpbbmaO/1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="359524239"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="359524239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 00:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646338248"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.195]) ([10.254.208.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 00:01:48 -0700
Message-ID: <5a11d688-9245-9041-5183-3eb87914eb1f@linux.intel.com>
Date:   Mon, 12 Sep 2022 15:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Make SVA and IOPF irrelevant
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220908023557.4582-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276307EAF55B4EE8AB71E278C439@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276307EAF55B4EE8AB71E278C439@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/9 16:33, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, September 8, 2022 10:36 AM
>>
>> The existing IOPF handling code relies on the per-PASID SVA data
>> structures. It does not apply to scenarios other than SVA. This
>> decouples the I/O page fault reporting and responding code from
>> SVA related data structures so that the PRQ handling code could
>> become generic.
> 
> I think the point is that it's unnecessary to access those SVA data
> in the fault path. otherwise 'decouple' reads like an alternative
> implementation is added instead of just removing the code.

Makes sense. I will rephrase the commit message like this:

iommu/vt-d: Remove unnecessary SVA data accesses in page fault path

The existing I/O page fault handling code accesses the per-PASID SVA data
structures. This is unnecessary and makes the fault handling code only
suitable for SVA scenarios. This removes the SVA data accesses from the
I/O page fault reporting and responding code, so that the fault handling
code could be generic.

> 
> Overall this is a nice cleanup, but a few nits here:
> 
>> -		/*
>> -		 * If prq is to be handled outside iommu driver via receiver of
>> -		 * the fault notifiers, we skip the page response here.
>> -		 */
> 
> I didn't understand what this comment is trying to say. But just want
> to confirm removing it is the desired thing given the original code below
> it is still kept below...

I carelessly removed this comment. Yes. It still makes sense. I will add
it back.

> 
>> -		if (intel_svm_prq_report(iommu, sdev->dev, req))
>> +		pdev = pci_get_domain_bus_and_slot(iommu->segment,
>> +						   PCI_BUS_NUM(req->rid),
>> +						   req->rid & 0xff);
>> +		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
>>   			handle_bad_prq_event(iommu, req,
>> QI_RESP_INVALID);
>>
>> -		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
>> +		trace_prq_report(iommu, &pdev->dev, req->qw_0, req-
>>> qw_1,
>>   				 req->priv_data[0], req->priv_data[1],
>> -				 sdev->prq_seq_number);
>> +				 prq_seq_number++);
> 
> Previously this is counted per device but now becomes global. Could it
> be stored elsewhere in a per-device structure?

I think the per-IOMMU structure might be the right place to store it.
Those faults share a page fault queue.

Best regards,
baolu

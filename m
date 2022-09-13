Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3D5B6794
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIMGBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIMGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:01:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB22126C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663048875; x=1694584875;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=LJSJTX5Z4IGDOgD+1HXWmQwXqq1YXqUh+I8TJnnlQmM=;
  b=MxvRYhsYNYfQKlD6cqBD9kHe9irTd8Nz22Ul6s0+yEa5B9M+aXAsnd+9
   I49SlKYeI5mCWqYM1MaaARM2SS+hYt1+vfGQpD42UQ8Z9Wl74CJqVIRyT
   AdHwhB6KIBCV6khKue1vpGSmx1hUvnTjj373fJLnTZRpKNDKtZNKHwpqJ
   7jIakaDlStH6z5ln4oTki/2tgzGY84/SdetglcWiVDps9fslF3yYGM8b2
   48WueI7tztLBB0E5U5Nv2vYvauKUanvN9IF9uSs8ix3Hd4Q6znRrV1TF/
   Xf1bC1166PTAm9h62NAnYPjfeUCl548uZSajDHXqqxiq5QESuiRYZWnk3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277779229"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="277779229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:01:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646783886"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:01:10 -0700
Message-ID: <af6a3ae8-d4b2-517d-8b14-15dd20392a00@linux.intel.com>
Date:   Tue, 13 Sep 2022 14:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276B65B2EAF97D53719D2FE8C479@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <BN9PR11MB5276B65B2EAF97D53719D2FE8C479@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/9/13 11:13, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, September 12, 2022 10:48 AM
>>
>> Previously PASID supports on both IOMMU and PCI devices are enabled in
>> the
>> iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's
>> functionally
>> correct as the SVA is the only feature that requires PASID setup. However,
>> looking ahead, we will add more features that need to enable pasid (for
>> example, kernel DMA with PASID, SIOV, VM guest SVA, etc.). It makes more
>> sense to enable PASID during iommu probing device.
>>
>> This enables PASID during iommu probing device and deprecates the
>> intel_iommu_enable_pasid() helper. This is safe because the IOMMU
>> hardware
>> will block any PCI TLP with a PASID prefix if there is no IOMMU domain
>> attached to the PASID of the device.
>>
> 
> IMHO it's better to enable something only when it's actually required,
> e.g. does it make more sense to have a IOMMU_DEV_FEAT_PASID
> instead?

PASID is a capability (not a feature) of a device. Hence from my point
of view, the IOMMU driver could enable it by default as long as the
IOMMU can handle transactions with PASID. Currently other PCIe
capabilities like ATS and PRI are also handled in this way.

> 
> What this patch does has one problem. It's an intel-iommu driver
> internal policy. How can a device driver reliably tell that the pasid
> capability has been enabled by the iommu driver?

If *necessary*, I do not object to letting the device drivers enable or
disable PCI/PASID through an IOMMU interface. In that case, we may need
a reference counter, and explicitly tell the device driver that
disabling PASID will only take effect when the reference counter
becomes 0.

Best regards,
baolu

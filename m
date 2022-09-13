Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37D25B6ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIMJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiIMJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:30:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FDC4E616
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663061445; x=1694597445;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=E7t2UOdY9wHDMf0CP0CgwG8FAmDq7eQIjFUMP5nR1Hw=;
  b=OENKrrEe4o/VnjZe4FlmUAzZr4kvpvRj6g6e4s3mIjcw0d77VN5ATZg8
   ZfEx0TCEZ8FLvsoGP0Ovn7RABOTksRxfG8QLbUiajdw0EDn70iP+Jkeau
   7W+LXA9QtGyoegCF1OV276rYTy/y7TAedPWdXHSG7kdjyc/VqZg+ognQF
   CYYQq/LTBtqlaRQ+4pOeCPF7a6DvX8i32efy3hmSqgx/IVgiNjxYFpDSB
   UQnWgBJ5Ue4BztrPPQXC+aGdsATixZ04PZoRelshEfQ8rVr/tVMC/l1fu
   RiOMEL8NCHfprUROMqtmIIkebyvXRAhVmEoty9833dxfFFkjlIXmAQoDf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384388675"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="384388675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:30:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="646855920"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:30:42 -0700
Message-ID: <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
Date:   Tue, 13 Sep 2022 17:30:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ethan,

On 2022/9/13 15:46, Ethan Zhao wrote:
> Baolu,
> 
> 在 2022/9/12 10:48, Lu Baolu 写道:
>> Previously PASID supports on both IOMMU and PCI devices are enabled in 
>> the
>> iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's functionally
>> correct as the SVA is the only feature that requires PASID setup. 
>> However,
>> looking ahead, we will add more features that need to enable pasid (for
>> example, kernel DMA with PASID, SIOV, VM guest SVA, etc.). It makes more
>> sense to enable PASID during iommu probing device.
>>
>> This enables PASID during iommu probing device and deprecates the
>> intel_iommu_enable_pasid() helper. This is safe because the IOMMU 
>> hardware
>> will block any PCI TLP with a PASID prefix if there is no IOMMU domain
>> attached to the PASID of the device.
> 
> What the error path would be if this code runs on some old platforms don't
> 
> support PASID, would you print out "this platform doesn't suppor PASID" and
> 
> give users an interface function to query if the PASID cap of iommu is 
> enabled
> 
> and if not why ?

It's not an error case if the IOMMU doesn't support PASID. But it's an
error case if any device drivers call PASID related IOMMU interfaces
(for example, iommu_domain_attach/detach_dev_pasid()). The corresponding
error code will be returned to the drivers.

Best regards,
baolu

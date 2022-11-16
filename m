Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7A62B274
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiKPEnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKPEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:43:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B12BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 20:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668573803; x=1700109803;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mfuAnJyXBw78Ly0C9nViAz8p0E4CuLlwDxyfTAU6G+g=;
  b=PoG/GxXLDxD/82PuoTjOlVyiff9G46fSM8vL4Ncu+jUm/DPuAC0uYj5v
   KUTL+cTliYX54Oujh0CiznbSkRJgfaDXTdTcFZwuduG4++8fvVudzG/lc
   0pyIIfz1McO9V8tCHN2j7/Kc5QZVbUAgjlfR2ujw6O5TDg83NwCelCREl
   5THsG+Swd0XIj/IVnwsQ6AylG2nq98R+qik62BHTYHphUXD9QlWKdx91S
   +EYeCrjYBI8Y4pFXFipHKVfS/55S7u3SALhW2fqOgJKsb/7XnWU0gO+LK
   CGIjwCnjhwy5llaE+USgSMM7Vn4iCmfEzc9sTH1dW1JzLgERKa/+nAuC2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374581987"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374581987"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 20:43:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641483889"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641483889"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2022 20:43:20 -0800
Message-ID: <e7c686d7-bad9-b58b-3be4-50898e142230@linux.intel.com>
Date:   Wed, 16 Nov 2022 12:36:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-5-baolu.lu@linux.intel.com>
 <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 11:53 AM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Monday, November 14, 2022 9:41 AM
>> @@ -4562,7 +4538,10 @@ static void intel_iommu_release_device(struct
>> device *dev)
>>   {
>>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>
>> -	dmar_remove_one_dev_info(dev);
>> +	iommu_disable_pci_caps(info);
>> +	domain_context_clear(info);
>> +	device_block_translation(dev);
> clear context after blocking translation.

Unfortunately domain_context_clear() needs reference to info->domain
(for domain id when flushing cache), which is cleared in
device_block_translation().

Best regards,
baolu

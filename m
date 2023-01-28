Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4342E67F5BB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjA1Hmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1Hms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:42:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22140359B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674891767; x=1706427767;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N5qn4ZkLAD19ELEluaPpOQ6lUsuRzvH9y0vFGRlSUi4=;
  b=G2eBhT8rOk/V5C/ILNNW/JWwhLe36RC8pXaoA0/lNxgKaU82qZLtpcBo
   mje5nkF7LDTygQ5LED8yO9aqKaMBy9KEGTkbM8dgQQfOe1kezV52m+Zt3
   cgXk4Fifp9FonbOU6EIKFgANhOx2K5zpXVmVWXnPZpmEUCi+2Qr+Ns9C0
   uvlBQllmxK7Mq7XTNRrjoovs2UFMPSyxEfE/uSeWKoxdofEScGO8C749l
   2KsqeqBPNhU1sjQDBHKQcDl+383a3IcBVBSXUnK+8aICs5ykxar4AjiEA
   anxGpJMsycuZWNOAptfvZD0hbzwr2S2sLNNClyjY+436TvmhfJKZfaWOi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327289115"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="327289115"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:42:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726945105"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="726945105"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:42:44 -0800
Message-ID: <ecef3c86-2f35-9f51-23c1-8e317c1afde6@linux.intel.com>
Date:   Sat, 28 Jan 2023 15:42:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Set No Execute Enable bit in PASID table
 entry
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230126095438.354205-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D8D7CF2AD32D605EFD628CCD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D8D7CF2AD32D605EFD628CCD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/28 15:19, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, January 26, 2023 5:55 PM
>>
>> Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
>> entry. It is required when XD bit of the first level page table
>> entry is about to be set.
> "is about to set" sounds like the NXE bit is set conditionally when
> certain event happens. But the actual definition of NXE bit is to
> allow the use of XD bit of the first level page table.
> 
> With the comment fixed:
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>

Updated. Thank you, Kevin.

Best regards,
baolu


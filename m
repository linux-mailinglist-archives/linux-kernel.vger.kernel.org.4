Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF36A946F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCCJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCCJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:51:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA71A962
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677837065; x=1709373065;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZymY3H9NdnOJcpTx0m9d4tusfMSeC+69qgEpN1llX8g=;
  b=RTMWvbksIBMgAeTsv9EBf9TwcMbXvNB+fAUYWd7xOA9RU5l0/tDQJsl7
   bXWhSwmuSt7H3A1MSeApt+gusX3UaDjYrV1sxR4ej3Xo+iEck4MbVpH/P
   el9BNHyfXeD7Elrn4+P0YAAxhku4TxpkKmUzfU6GgLHOMMY0DTYkM0kBC
   emxKkI2nO+OZ49MhBgDs4sgqspAojzYV629fy/3zdDO/Bu7DFC4iQRioq
   Hxh4TwB8zt23cTpgUW2I3TORxTwqXDQGud5rUPj8B0SwAlQozogKUC4IB
   ygW1bs3/VbVePC3my3nviYm+uR/31Y3gqeI7eT2jCCG1uENkO2hgD3h2u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="332488770"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="332488770"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 01:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668602245"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="668602245"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.51]) ([10.254.208.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 01:51:02 -0800
Message-ID: <6e60e491-e3db-6342-28be-8cdce2843543@linux.intel.com>
Date:   Fri, 3 Mar 2023 17:51:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com> <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
 <Y/+OobufnmGhg/R7@nvidia.com>
 <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/3 16:19, Tian, Kevin wrote:
> But Baolu, seems there is a small bug on handling satcu->atc_required.
> This indicates that ATS must be enabled as a functional requirement.
> Then we should handle the failure of pci_enable_ats() on such device.

Yes. We have people working on this. For example, when pci=noats is opt-
in, pci_enable_ats() definitely will return failure.

Best regards,
baolu

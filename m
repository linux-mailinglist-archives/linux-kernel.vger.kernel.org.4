Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09B66A9B7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjANGoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjANGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:44:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA23A93
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673678650; x=1705214650;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZWBI4yEDtYe5SgIEcmnWVxcrxOfnPV3XsNS6rea3BZo=;
  b=DHklcf5DK+TufSW1J0wWWndgsQ9PD0ltY0qQshPX1ZTy3NXgV83d55dk
   gnPvGiJlH2Fcss/s2ZlOzx8TELrDahQU27JYYELozsj7jIV7QiBwfaPNU
   ItaSGDeysBxi/WaijKlLM1F+qH+d2C+TVol2sKomy5xRIioRkqtkBWl75
   a7baFMzYqb4CcuL+SvrJmMwCqBbYk+UUxLt7VOHdUc8sGEQPrM9kSxPCl
   mO6P9tDZExgOI3nXuChZjdy2utiDvzDTY1rmSle98ZXBWQgRh9eBuXHzX
   xkLTPnyQ9SQp4dHxv9WgSW+S1JL4oquLgorJttFgiMScUMkdYwXXzoRGr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325427791"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="325427791"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:44:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987245324"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="987245324"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.184.153]) ([10.252.184.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:44:07 -0800
Message-ID: <76e7b9fe-5ee5-83f6-0e91-4d07e8e821f8@linux.intel.com>
Date:   Sat, 14 Jan 2023 14:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca> <Y8GwHQLKnXyqa3Ty@8bytes.org>
 <Y8G06onFowE3ZIy8@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y8G06onFowE3ZIy8@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/14 3:45, Jason Gunthorpe wrote:
> On Fri, Jan 13, 2023 at 08:25:17PM +0100, Joerg Roedel wrote:
>> On Fri, Jan 13, 2023 at 03:12:21PM -0400, Jason Gunthorpe wrote:
>>> I'm surprised the 0-day bot didn't notice?
>>
>> Well, I think 0-day does not spend that much time on iommu patch-sets,
>> especially doing randconfigs or allyes/modconfigs.
> 
> Intel folks, can you check on this with the 0-day team? Perhaps since
> the list was moved it is not properly subscribed.

I've forwarded this thread to the Intel 0-day team.

> 
>> In general it is a good idea to at least compile-test every file that is
>> changed in a patch-set before sending it out and not rely on 0-day bot
>> for that.
> 
> Against every arch combination? This is why we have automation bots :(
> 
> Jason
> 

--
Best regards,
baolu

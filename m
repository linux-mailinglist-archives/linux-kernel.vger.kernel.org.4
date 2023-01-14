Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8366A9BA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjANGtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjANGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:48:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06046AB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673678920; x=1705214920;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XsM/vRhs05DLA99A717nlC82ZdpLOZNvxrsRWsZdQNY=;
  b=PgCkeAjRkvB0DYZAGpyjPtVMm3f/m3oR0b7yogJFe8QfIYSZln1DJ/8h
   e/8OHi63I98mAqVXijHTKgN4agclgrUhjyvlqjtzMSsUPSP7Y4YPbNa+i
   4FPsApThgpKzh5wQGBg7KLB5rP5oEo7l6hElWABJvptWIqsEfV2wcWA4O
   5Ul6tg4RT2eKeiTLtT4ZfXtYIBdFsNGiK/Y5j0virrK08+SiwJWn7DYrY
   P0Jyy9/8i5XRu4IacFySfogGKu39H2R984YVD9BkUUpbr/pVGQ5CqSgEC
   oKACImzkPrz9W7qi6gMf1mOSGpkdPsSnqYnQLuaqUZFsW3r9eZrPg2gBX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="326226135"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="326226135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:48:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="721762716"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="721762716"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.184.153]) ([10.252.184.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:48:37 -0800
Message-ID: <2d49a943-09f5-5479-2f71-cc2051155f70@linux.intel.com>
Date:   Sat, 14 Jan 2023 14:48:35 +0800
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
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca> <Y8GwHQLKnXyqa3Ty@8bytes.org>
 <Y8G06onFowE3ZIy8@ziepe.ca> <Y8HNJfz9R1IidJPq@8bytes.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y8HNJfz9R1IidJPq@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/14 5:29, Joerg Roedel wrote:
> On Fri, Jan 13, 2023 at 03:45:46PM -0400, Jason Gunthorpe wrote:
>> On Fri, Jan 13, 2023 at 08:25:17PM +0100, Joerg Roedel wrote:
>>> In general it is a good idea to at least compile-test every file that is
>>> changed in a patch-set before sending it out and not rely on 0-day bot
>>> for that.
>> Against every arch combination? This is why we have automation bots 🙁
> No, not every combination. But if possible please compile-test each
> changed file with a .config that pulls that source file in.  Lots of
> drivers can be enabled just with COMPILE_TEST on x86 or be catched with
> a generic ARM/ARM64 config which enables all IOMMU drivers.  PAMU is a
> bit more difficult as it requires a PPC-32 bit config, but that is the
> exception.
> 
> A full kernel build is usually also not necessary, often a 'make
> drivers/iommu/' with a given config is enough.
> 
> That is also how I compile-test the IOMMU tree before I push changes
> out. There are per-arch configurations which select all IOMMU drivers on
> that arch. Only for X86 I do the full allnoconfig, defconfig,
> allmodconfig and allyesconfig cycle (each for 32 and 64 bit).
> 
> That certainly does not catch everything, but a lot of compile issues can be
> found that way. And for patch-sets only touching, for example, VT-d it
> is still enough to only compile-test on x86. A patch-set touching that
> much drivers is rather the exception.

This one as well. Thank you for your feedback on 0-day.

--
Best regards,
baolu

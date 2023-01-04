Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3465CAF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjADAfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbjADAfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:35:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964D2167C5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672792543; x=1704328543;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=AQQCUoBmBnV6RpnznP0zSFHaXETOQbD7b9hAWbdNjfc=;
  b=Z1tb1w4SFRT6DM6ykjQrV66HayPH5rCmSRmSTPg392Qp1ADRbI1q8bBn
   9d4DWHf7ygjN+KuL5glZ1BJcE9ezs5D2q7XRb2j4tR8S4FNtYxsXHgOI9
   eGnhdHZg4wjVNzjgF/xOKRgvhd8Wgp2n2jBWU/DZy4FHj692WDrjeOB8L
   iKn/oTroKKTvwe861guiYoZyOvGkL+FVgFQlhqOuvJ9WAM63p2epJykIe
   8uap7AklG3A2SbAOa4YEeJeuo9QzRqrupFFGcGI4o+CX+MmF7mCd7B9Vy
   OLibJQco3/c3fZxMOOUM7CbWp4dM89nDDNVm2dEFUZJWZ2dDqkdxP1xXv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302168916"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302168916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 16:35:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743668051"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="743668051"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 16:35:40 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 5/8] migrate_pages: batch _unmap and _move
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-6-ying.huang@intel.com>
        <05A09BF6-A30C-45A5-952D-0CCFC43FE2D7@nvidia.com>
Date:   Wed, 04 Jan 2023 08:34:46 +0800
In-Reply-To: <05A09BF6-A30C-45A5-952D-0CCFC43FE2D7@nvidia.com> (Zi Yan's
        message of "Tue, 03 Jan 2023 14:01:37 -0500")
Message-ID: <87lemjnnmh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 26 Dec 2022, at 19:28, Huang Ying wrote:
>
>> In this patch the _unmap and _move stage of the folio migration is
>> batched.  That for, previously, it is,
>>
>>   for each folio
>>     _unmap()
>>     _move()
>>
>> Now, it is,
>>
>>   for each folio
>>     _unmap()
>>   for each folio
>>     _move()
>
> Also worth adding some notes here, we need extra code to undo the _unmap()
> if _move() fails. Andrew has asked for comments on *_undo_src/dst(),
> but I think it would be better to provide a high level new workflow,
> in the form of pseudo code, in git log and the comment for migrate_pages().
> The extra cleanup code for a failed _move() with a previously successful
> _unmap() might not be obvious to everyone.

Here, I removed the detailed error processing to make it easier to
understand the basic flow changing.  So, I would rather to keep the
pseudo code here as simple as possible and keep the detailed flow in the
diff below.

Best Regards,
Huang, Ying

>>
>> Based on this, we can batch the TLB flushing and use some hardware
>> accelerator to copy folios between batched _unmap and batched _move
>> stages.
>>

[snip]

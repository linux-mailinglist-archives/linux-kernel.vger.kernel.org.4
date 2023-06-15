Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37106730D79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjFODYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjFODYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:24:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABFA1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686799481; x=1718335481;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=aUwRqqzMRAXohh/UHJbsf4F6QRKqrcZRD7HQbgVBrsM=;
  b=Pb91Go69yJK9tZfhwspd/Gm8Xqr1DsBbdW2uwEUHYPhsQqeuilfABcqE
   L5LsXOWvNwpabboqlHghv4cVuGPbiZAQloBPVW/xsD4a0tpnsJLXumyXv
   1o+sQB6HvzLlFweFBiy4le/nKK1YsvA7qz5EMBVW6ndDPxx/B1m4cO6x8
   3hgphUCI6GCvKWWN6/pIRqvvw+/vBhSJJImB7eH+IbBtxXixosYul23a6
   av8qZqpsICAeFJLTlMfSAudAZTPT7P1Nm0P+A23rSvYdyoq8nGcBqlq+h
   pR5066RWDHXNh54TM5BK1bMOYn3xOE2pt1WaCJK+yvw9LIW38ZemuW252
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="387217423"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="387217423"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 20:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="959008686"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="959008686"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 20:24:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>, <david@redhat.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
        <20230614095501.m4porztaibchrgwx@techsingularity.net>
Date:   Thu, 15 Jun 2023 11:22:58 +0800
In-Reply-To: <20230614095501.m4porztaibchrgwx@techsingularity.net> (Mel
        Gorman's message of "Wed, 14 Jun 2023 10:55:01 +0100")
Message-ID: <87ilbpo1d9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Mel Gorman <mgorman@techsingularity.net> writes:

> On Tue, Jun 13, 2023 at 04:55:04PM +0800, Baolin Wang wrote:
>> On some machines, the normal zone can have a large memory hole like
>> below memory layout, and we can see the range from 0x100000000 to
>> 0x1800000000 is a hole. So when isolating some migratable pages, the
>> scanner can meet the hole and it will take more time to skip the large
>> hole. From my measurement, I can see the isolation scanner will take
>> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>> 
>> So adding a new helper to fast search next online memory section
>> to skip the large hole can help to find next suitable pageblock
>> efficiently. With this patch, I can see the large hole scanning only
>> takes < 1us.
>> 
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> This may only be necessary for non-contiguous zones so a check for
> zone_contiguous could be made but I suspect the saving, if any, would be
> marginal.
>
> However, it's subtle that block_end_pfn can end up in an arbirary location
> past the end of the zone or past cc->free_pfn. As the "continue" will update
> cc->migrate_pfn, that might lead to errors in the future. It would be a
> lot safer to pass in cc->free_pfn and do two things with the value. First,
> there is no point scanning for a valid online section past cc->free_pfn so
> terminating after cc->free_pfn may save some cycles. Second, cc->migrate_pfn
> does not end up with an arbitrary value which is a more defensive approach
> to any future programming errors.

I have thought about this before.  Originally, I had thought that we
were safe because cc->free_pfn should be in a online section and
block_end_pfn should reach cc->free_pfn before the end of zone.  But
after checking more code and thinking about it again, I found that the
underlying sections may go offline under us during compaction.  So that,
cc->free_pfn may be in a offline section or after the end of zone.  So,
you are right, we need to consider the range of block_end_pfn.

But, if we thought in this way (memory online/offline at any time), it
appears that we need to check whether the underlying section was
offlined.  For example, is it safe to use "pfn_to_page()" in
"isolate_migratepages_block()"?  Is it possible for the underlying
section to be offlined under us?

Hi, David, can you teach me on this too?

Best Regards,
Huang, Ying


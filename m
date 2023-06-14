Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265DF72F9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjFNJzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbjFNJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:55:15 -0400
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846CA1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:55:11 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 0F8DABAB68
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:55:10 +0100 (IST)
Received: (qmail 24175 invoked from network); 14 Jun 2023 09:55:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jun 2023 09:55:09 -0000
Date:   Wed, 14 Jun 2023 10:55:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
Message-ID: <20230614095501.m4porztaibchrgwx@techsingularity.net>
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:55:04PM +0800, Baolin Wang wrote:
> On some machines, the normal zone can have a large memory hole like
> below memory layout, and we can see the range from 0x100000000 to
> 0x1800000000 is a hole. So when isolating some migratable pages, the
> scanner can meet the hole and it will take more time to skip the large
> hole. From my measurement, I can see the isolation scanner will take
> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
> 
> So adding a new helper to fast search next online memory section
> to skip the large hole can help to find next suitable pageblock
> efficiently. With this patch, I can see the large hole scanning only
> takes < 1us.
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

This may only be necessary for non-contiguous zones so a check for
zone_contiguous could be made but I suspect the saving, if any, would be
marginal.

However, it's subtle that block_end_pfn can end up in an arbirary location
past the end of the zone or past cc->free_pfn. As the "continue" will update
cc->migrate_pfn, that might lead to errors in the future. It would be a
lot safer to pass in cc->free_pfn and do two things with the value. First,
there is no point scanning for a valid online section past cc->free_pfn so
terminating after cc->free_pfn may save some cycles. Second, cc->migrate_pfn
does not end up with an arbitrary value which is a more defensive approach
to any future programming errors.

-- 
Mel Gorman
SUSE Labs

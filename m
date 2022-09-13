Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE85B64B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIMAzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIMAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:55:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267EC2CE02
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663030549; x=1694566549;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=dCM6TZmUcoYUCnUYQadHcfqnI3uM9Wcqb/0Hp7avu/c=;
  b=Vsf1GXni2+NLToDmgkVeD058K2nOmaLpKm40jbPIeFmJBFcM235vzUKz
   bsQPlcrO6umAhXZqi6iYI0V7s5d6lLZvXPp2kRT+2l718LxQng3G+GNbb
   YYjijAPiZQIRmtMgNNHwb9Voi3vENNKQYTrHTIWsKcC9DDVfabSllj7A3
   Fp+qNMS9dkv1tFQihoz/9ZwSkcGQzC55pTMvhStzaN13GjZBwl0GoV2lS
   U54vQO1VYYuQN6V3B8dLjNoCmw9jg0mMxXE+srvTlgcxomX9tjj2jWkT/
   LV91cv88Rc5y0Lg2P/FVh1NyFzHp5LoBW/JLXwOgSMaRwL1lsvqwrZ/Xk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298008243"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="298008243"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="944848473"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:55:46 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 5/7] mm: Remember young/dirty bit for page migrations
References: <20220811161331.37055-1-peterx@redhat.com>
        <20220811161331.37055-6-peterx@redhat.com>
        <20220911164828.faaa229189826ef2c219fc2d@linux-foundation.org>
Date:   Tue, 13 Sep 2022 08:55:35 +0800
In-Reply-To: <20220911164828.faaa229189826ef2c219fc2d@linux-foundation.org>
        (Andrew Morton's message of "Sun, 11 Sep 2022 16:48:28 -0700")
Message-ID: <874jxcrt2w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 11 Aug 2022 12:13:29 -0400 Peter Xu <peterx@redhat.com> wrote:
>
>> When page migration happens, we always ignore the young/dirty bit settings
>> in the old pgtable, and marking the page as old in the new page table using
>> either pte_mkold() or pmd_mkold(), and keeping the pte clean.
>> 
>> That's fine from functional-wise, but that's not friendly to page reclaim
>> because the moving page can be actively accessed within the procedure.  Not
>> to mention hardware setting the young bit can bring quite some overhead on
>> some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
>> The same slowdown problem to dirty bits when the memory is first written
>> after page migration happened.
>> 
>> Actually we can easily remember the A/D bit configuration and recover the
>> information after the page is migrated.  To achieve it, define a new set of
>> bits in the migration swap offset field to cache the A/D bits for old pte.
>> Then when removing/recovering the migration entry, we can recover the A/D
>> bits even if the page changed.
>> 
>> One thing to mention is that here we used max_swapfile_size() to detect how
>> many swp offset bits we have, and we'll only enable this feature if we know
>> the swp offset is big enough to store both the PFN value and the A/D bits.
>> Otherwise the A/D bits are dropped like before.
>> 
>
> There was some discussion over v3 of this patch, but none over v4.
>
> Can people please review this patch series so we can get moving with it?

Most discussions over v3 are for migrate_device.c code.  There are some
bugs and they have been fixed by Alistair via [1].

This patch itself is good.  Sorry for bothering.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

[1] https://lore.kernel.org/linux-mm/9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com/

Best Regards,
Huang, Ying

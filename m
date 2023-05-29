Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035871419B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjE2BOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjE2BOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:14:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD665BE
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685322882; x=1716858882;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=dly2fVuw24pBpSMpGKK40cjF5fCNBKrwQ87QkKjsS2E=;
  b=lRiRBa0n24CuExLswBsukjmN5ewQT6gHYWAHjqhl6nwqKl8iIVvzQ2d8
   fh8QDQ9zZ4rlYPjVyoJ//EFUK2+pISUJH1st+j7AlpX5zi2UNNIUIDJHX
   7kvsdUHg9zfv/ymGlQIZldeLa4FY1blnVFqAu1Qvu/JK7m1D2moYIrBi8
   hG2dqZ5UsScmUoXqJg+QzIBFBPub9YVbN+gPSO6vKL8KsYqD0Awi2uyqn
   UsjV6iOrHVM5iFlzvlx0q90bf/4r0HCw1bXJdt/CnyDwkUK4hgcVNFa7j
   y+azy+nWEz7A8CB0xiuMno7EdOal+ninMdWGp1PKdQvCPpd7rbp2ZaLuR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="418066056"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="418066056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 18:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="770951539"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="770951539"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 18:14:39 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
References: <20230511065607.37407-1-ying.huang@intel.com>
        <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
        <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZGIUEqhSydAdvRFN@dhcp22.suse.cz>
        <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com>
        <ZG4Db1QSE1LZXEEP@dhcp22.suse.cz>
Date:   Mon, 29 May 2023 09:13:37 +0800
In-Reply-To: <ZG4Db1QSE1LZXEEP@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 24 May 2023 14:30:39 +0200")
Message-ID: <87y1l8vt1a.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> [Sorry for late reply, conferencing last 2 weeks and now catching up]

Never mind.  And my reply is late too for sickness.

> On Tue 16-05-23 12:30:21, David Hildenbrand wrote:
> [...]
>> > And auto-tuning doesn't sound easy.  Do you have some idea of how to do
>> > that?
>> 
>> If we could avoid instantiating more zones and rather improve existing
>> mechanisms (PCP), that would be much more preferred IMHO. I'm sure it's not
>> easy, but that shouldn't stop us from trying ;)
>
> Absolutely agreed. Increasing the zone number sounds like a hack to me
> TBH. It seems like an easier way but it allows more subtle problems
> later on. E.g. hard to predict per-zone memory consumption and memory
> reclaim disbalances.

At least, we all think that improving PCP is something deserved to be
done.  I will do some experiment on that and return to you (after some
time).

Best Regards,
Huang, Ying

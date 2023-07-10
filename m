Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CFB74CA11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGJCvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGJCvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:51:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C97FB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688957459; x=1720493459;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ckGeBpOXLv9b/a08Rkn8RixoVZzOcdiRFSfoXrXdKwc=;
  b=ZpMzpcasI/LVZXq3MsKkuLIqurEzDjfFOHmwWwtxYgDj2R/hd7m8kr43
   B47DjtZ6bDSQk81vxenOltONz++eitvilNyEKGArbiwWhv1wn+IT4oweD
   Uz0VAOGelhbJeL0dqMSJUu75sq3paNcHJpT4Z/baV+p7+0Yn1OL/li8Vk
   PzojDJYlCcmpnFO9d65BIIbAIaXgS1Z4wz6tpRybWh24/CTBc6svi2cWQ
   hYH693Len8zfD71mzLQLIIe5JO7+p1ESqufvdVBaJY4HabF1nS3grUp3q
   KUFo1ODyiF09E7Ff76kijt9F1iuUREDyN64lpJbxoLEAXZZPqWljv2AwZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="354102463"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="354102463"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 19:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="697854029"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="697854029"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 19:50:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
        <20230703135330.1865927-5-ryan.roberts@arm.com>
        <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
        <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
        <ZKgZrNuxuq4ACvIb@casper.infradead.org>
Date:   Mon, 10 Jul 2023 10:49:11 +0800
In-Reply-To: <ZKgZrNuxuq4ACvIb@casper.infradead.org> (Matthew Wilcox's message
        of "Fri, 7 Jul 2023 14:57:00 +0100")
Message-ID: <87351wh460.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>> On 07.07.23 11:52, Ryan Roberts wrote:
>> > On 07/07/2023 09:01, Huang, Ying wrote:
>> > > Although we can use smaller page order for FLEXIBLE_THP, it's hard to
>> > > avoid internal fragmentation completely.  So, I think that finally we
>> > > will need to provide a mechanism for the users to opt out, e.g.,
>> > > something like "always madvise never" via
>> > > /sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
>> > > a good idea to reuse the existing interface of THP.
>> > 
>> > I wouldn't want to tie this to the existing interface, simply because that
>> > implies that we would want to follow the "always" and "madvise" advice too; That
>> > means that on a thp=madvise system (which is certainly the case for android and
>> > other client systems) we would have to disable large anon folios for VMAs that
>> > haven't explicitly opted in. That breaks the intention that this should be an
>> > invisible performance boost. I think it's important to set the policy for use of
>> 
>> It will never ever be a completely invisible performance boost, just like
>> ordinary THP.
>> 
>> Using the exact same existing toggle is the right thing to do. If someone
>> specify "never" or "madvise", then do exactly that.
>> 
>> It might make sense to have more modes or additional toggles, but
>> "madvise=never" means no memory waste.
>
> I hate the existing mechanisms.  They are an abdication of our
> responsibility, and an attempt to blame the user (be it the sysadmin
> or the programmer) of our code for using it wrongly.  We should not
> replicate this mistake.
>
> Our code should be auto-tuning.  I posted a long, detailed outline here:
> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/

Yes.  Auto-tuning should be more preferable than any configuration
mechanisms.

Something like THP shrinker could be another way of auto-tuning.

https://lore.kernel.org/linux-mm/cover.1667454613.git.alexlzhu@fb.com/

That is, allocating the large folios on page fault, then try to detect
internal fragmentation.

>> I remember I raised it already in the past, but you *absolutely* have to
>> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
>> example, userfaultfd) that doesn't want the kernel to populate any
>> additional page tables. So if you have to respect that already, then also
>> respect MADV_HUGEPAGE, simple.
>
> Possibly having uffd enabled on a VMA should disable using large folios,
> I can get behind that.  But the notion that userspace knows what it's
> doing ... hahaha.  Just ignore the madvise flags.  Userspace doesn't
> know what it's doing.

Best Regards,
Huang, Ying

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083866BBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAPK3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjAPK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:29:30 -0500
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85DB1A94F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:29:27 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id 19EC0C0C31
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:29:26 +0000 (GMT)
Received: (qmail 31739 invoked from network); 16 Jan 2023 10:29:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jan 2023 10:29:25 -0000
Date:   Mon, 16 Jan 2023 10:29:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Message-ID: <20230116102923.krilmcwrclshbm5e@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-7-mgorman@techsingularity.net>
 <Y77cikPSHepZ/GQj@dhcp22.suse.cz>
 <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
 <167373421396.4602.14376527067766958302@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <167373421396.4602.14376527067766958302@noble.neil.brown.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 09:10:13AM +1100, NeilBrown wrote:
> On Thu, 12 Jan 2023, Mel Gorman wrote:
> > On Wed, Jan 11, 2023 at 04:58:02PM +0100, Michal Hocko wrote:
> > > On Mon 09-01-23 15:16:30, Mel Gorman wrote:
> > > > Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> > > > vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> > > > other non-blocking allocation requests equal access to reserve.  Rename
> > > > ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> > > > means.
> > > 
> > > GFP_NOWAIT can be also used for opportunistic allocations which can and
> > > should fail quickly if the memory is tight and more elaborate path
> > > should be taken (e.g. try higher order allocation first but fall back to
> > > smaller request if the memory is fragmented). Do we really want to give
> > > those access to memory reserves as well?
> > 
> > Good question. Without __GFP_ATOMIC, GFP_NOWAIT only differs from GFP_ATOMIC
> > by __GFP_HIGH but that is not enough to distinguish between a caller that
> > cannot sleep versus one that is speculatively attempting an allocation but
> > has other options.
> 
> Isn't that a distinction without a difference?

Ideally yes but it's not always clear what the consequences of failure are.

> A caller than cannot sleep MUST have other options, because failure is
> always possible.
> The "other option" might be failure (error to user space, dropped packets
> etc), but sometimes failure IS an option.
> 

True, but it varies how gracefully it's handled and there is some cut&paste
involved and other cases where the GFP_ATOMIC usage predated the existance
or awareness of NOWAIT.

> So the difference between ATOMIC and NOWAIT boils down to the perceived
> cost of the "other options".  If that cost is high, then include
> __GFP_HIGH to get GFP_ATOMIC.  If that cost is low, then don't include
> __GFP_HIGH and get GFP_NOWAIT.
> 

Again, ideally yes but not necessary true. It depends on how careful
the caller was. The core appears to get it right in the cases I checked,
I'm less sure about drivers.

> I don't think there is any useful third option that is worth supporting.
> 

That's what we'll find out over time once the series hits a released
kernel.

-- 
Mel Gorman
SUSE Labs

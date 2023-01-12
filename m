Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDE666E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbjALJsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjALJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:47:18 -0500
Received: from outbound-smtp21.blacknight.com (outbound-smtp21.blacknight.com [81.17.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722913F21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:43:45 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 2874ECCCFB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:44 +0000 (GMT)
Received: (qmail 4654 invoked from network); 12 Jan 2023 09:43:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2023 09:43:43 -0000
Date:   Thu, 12 Jan 2023 09:43:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] mm/page_alloc.c: Allow __GFP_NOFAIL requests deeper
 access to reserves
Message-ID: <20230112094341.hom3ccscbko6v626@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-6-mgorman@techsingularity.net>
 <Y77ZxWRYe+4RPGRj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y77ZxWRYe+4RPGRj@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:46:13PM +0100, Michal Hocko wrote:
> On Mon 09-01-23 15:16:29, Mel Gorman wrote:
> > Currently __GFP_NOFAIL allocations without any other flags can access 25%
> > of the reserves but these requests imply that the system cannot make forward
> > progress until the allocation succeeds. Allow __GFP_NOFAIL access to 75%
> > of the min reserve.
> 
> I am not sure this is really needed. IIRC the original motivation for
> allowing NOFAIL request to access access to memory reserves was
> GFP_NOFS|__GFP_NOFAIL requests which do not invoke the OOM killer.
> The amount of memory reserves granted was not really important. The
> point was to allow to move forward. Giving more of the reserves is a
> double edge sword. It can help in some cases but it can also prevent
> other high priority users from fwd progress.
> 
> I would much rahter see such a change with an example where it really
> made a difference.
> 

Fair point but based on your review for "mm/page_alloc: Give GFP_ATOMIC
and non-blocking allocations access to reserves" and only allowing
non-blocking allocations to access reserves if __GFP_HIGH is also
specified, this patch becomes a no-op and can be dropped.

If GFP_NOFAIL requests really require deeper access to reserves, it'll
have to be explicitly handled in __zone_watermark_ok and __GFP_NOFAIL
would be added to the ALLOC_RESERVES collection of flags.

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B082C67C696
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjAZJEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjAZJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:04:19 -0500
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E451420D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:04:17 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 00313FA7FC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:04:15 +0000 (GMT)
Received: (qmail 29039 invoked from network); 26 Jan 2023 09:04:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2023 09:04:15 -0000
Date:   Thu, 26 Jan 2023 09:04:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Fix excessive CPU usage during compaction
Message-ID: <20230126090413.h6cugx2dh6g55a3z@techsingularity.net>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
 <20230125171159.355a770a2e34f78d7664e1f0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230125171159.355a770a2e34f78d7664e1f0@linux-foundation.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 05:11:59PM -0800, Andrew Morton wrote:
> On Wed, 25 Jan 2023 13:44:30 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > Commit 7efc3b726103 ("mm/compaction: fix set skip in fast_find_migrateblock")
> > fixed a problem where pageblocks found by fast_find_migrateblock() were
> > ignored. Unfortunately there were numerous bug reports complaining about high
> > CPU usage and massive stalls once 6.1 was released. Due to the severity,
> > the patch was reverted by Vlastimil as a short-term fix[1] to -stable and
> > is currently sitting in the Andrew's git branch mm/mm-hotfixes-unstable.
> > 
> > The underlying problem for each of the bugs is suspected to be the
> > repeated scanning of the same pageblocks. This series should guarantee
> > forward progress even with commit 7efc3b726103. More information is in
> > the changelog for patch 4.
> > 
> > If this series is accepted and merged after the revert of 7efc3b726103
> > then a "revert of the revert" will be needed.
> 
> If we drop Vlastimil's reversion and apply this, the whole series
> should be cc:stable and it isn't really designed for that.
> 
> So I think either
> 
> a) drop Vlastimil's reversion and persuade Mel to send us a minimal
>    version of patch #4 for -stable consumption.  Patches 1-3 of this
>    series come later.
> 
> b) go ahead with Vlastimil's revert for -stable, queue up this
>    series for 6.3-rc1 and redo the original "fix set skip in
>    fast_find_migrateblock" some time in the future.
> 
> If we go with b) then the Fixes: tag in "[PATCH 4/4] mm, compaction:
> Finish pageblocks on complete migration failure" is inappropriate -
> fixing a reverted commit which Vlastimil's revert already fixed.
> 
> I'll plan on b) for now.

I think plan b) is more appropriate because Vlastimil's revert contains
useful information on this class of bug that may be useful again in the
future. There is no harm preserving that in both the mainline and -stable
git history.

The series worked for me but that was a limited test case and high CPU
usage bugs could crop up again in 6.2. If such bugs show up then reverting
("mm/compaction: fix set skip in fast_find_migrateblock") becomes a
short-term option again while it is analysed.

I disagee that the Fixes tag is inappropriate. Commit 7efc3b726103 is simply
a messenger that fast_find_migrateblock() was broken and while it fixed one
problem, it triggered many more because the fix was incomplete. Vlastimil's
fix was a short-term "fix" to mitigate the fallout until a proper fix was
available. This series is a more comprehensive fix but both are "Fixes"
to commit 7efc3b726103 in terms of what kernel has very obvious problems
that needs to be fixed. Any kernel including 7efc3b726103 should include
either Vlastimil's fix, mine or both if git history is being preserved by the
backports. While there is an older commit that broke fast_find_migrateblock,
most people simply didn't notice where as commit 7efc3b726103 was noticeable
by a number of people very quickly.

However, if you disagree then the appropriate fixes would be

Fixes: 70b44595eafe9 ("mm, compaction: use free lists to quickly locate a migration source")

That would at least indicate to anyone doing the backport that they need
to ensure the backport does not have any hidden dependencies.

-- 
Mel Gorman
SUSE Labs

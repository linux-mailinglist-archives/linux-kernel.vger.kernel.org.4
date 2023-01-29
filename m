Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CA680164
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjA2VAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjA2VAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:00:19 -0500
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE661C5A3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:00:17 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id EC9FD1CA0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:00:14 +0000 (GMT)
Received: (qmail 9970 invoked from network); 29 Jan 2023 21:00:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jan 2023 21:00:14 -0000
Date:   Sun, 29 Jan 2023 21:00:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Fix excessive CPU usage during compaction
Message-ID: <20230129210012.ghvweg5kqlqeu3xu@techsingularity.net>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
 <20230125171159.355a770a2e34f78d7664e1f0@linux-foundation.org>
 <7ad2cbdc-8589-3aa2-b16a-41336f849f65@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7ad2cbdc-8589-3aa2-b16a-41336f849f65@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 07:03:54PM +0100, Vlastimil Babka wrote:
> On 1/26/23 02:11, Andrew Morton wrote:
> > On Wed, 25 Jan 2023 13:44:30 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > If we drop Vlastimil's reversion and apply this, the whole series
> > should be cc:stable and it isn't really designed for that.
> > 
> > So I think either
> > 
> > a) drop Vlastimil's reversion and persuade Mel to send us a minimal
> >    version of patch #4 for -stable consumption.  Patches 1-3 of this
> >    series come later.
> > 
> > b) go ahead with Vlastimil's revert for -stable, queue up this
> >    series for 6.3-rc1 and redo the original "fix set skip in
> >    fast_find_migrateblock" some time in the future.
> > 
> > If we go with b) then the Fixes: tag in "[PATCH 4/4] mm, compaction:
> > Finish pageblocks on complete migration failure" is inappropriate -
> > fixing a reverted commit which Vlastimil's revert already fixed.
> > 
> > I'll plan on b) for now.
> 
> Agreed with the plan b). I couldn't review this yet due to being sick,
> but I doubt I would have enough confidence to fast-track the series to
> 6.2 and 6.1-stable. It's subtle enough area and extra time in -next and
> full -rc cycle will help.

I hope you feel better soon but for what it's worth, I think it also
deserves a full -rc cycle. I've been running it on my own machine for the
last few days using an openSUSE stable kernel with this series applied and
I haven't had problems with kcompactd or khugepaged getting out of control
(monitored via top -b -i). However, I have noticed at least one audio glitch
and I'm not sure if that is related to the series or not. Compaction is
more active than I would have expected from intuition but I've also never
had reason to monitor compaction on my desktop so that's not very useful
in itself. My desktop is a very basic environment (awesome WM, no fancy
animations) and the times when my machine starts thrashing, I also expect
it to because it's the weekly "run git gc on every git tree Friday evening
if X is idle more than an hour".

-- 
Mel Gorman
SUSE Labs

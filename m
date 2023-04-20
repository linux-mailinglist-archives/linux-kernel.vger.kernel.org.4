Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA816E9016
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjDTKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjDTKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:24:18 -0400
Received: from outbound-smtp05.blacknight.com (outbound-smtp05.blacknight.com [81.17.249.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91FE1996
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:23:23 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 3F8BECCC00
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:23:22 +0100 (IST)
Received: (qmail 4555 invoked from network); 20 Apr 2023 10:23:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Apr 2023 10:23:21 -0000
Date:   Thu, 20 Apr 2023 11:23:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Doug Anderson <dianders@chromium.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
Message-ID: <20230420102304.7wdquge2b7r3xerj@techsingularity.net>
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
 <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
 <e5237b55-50eb-2a93-78cf-79421164f1fd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e5237b55-50eb-2a93-78cf-79421164f1fd@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:17:23AM +0200, Vlastimil Babka wrote:
> > Actually, the more I think about it the more I think the right answer
> > is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
> > MIGRATE_SYNC_LIGHT not block on the folio lock. kcompactd can accept
> > some blocking but we don't want long / unbounded blocking. Reading the
> > comments for MIGRATE_SYNC_LIGHT, this also seems like it fits pretty
> > well. MIGRATE_SYNC_LIGHT says that the stall time of writepage() is
> > too much. It's entirely plausible that someone else holding the lock
> > is doing something as slow as writepage() and thus waiting on the lock
> > can be just as bad for latency.
> 
> +Cc Mel for potential insights. Sounds like a good compromise at first
> glance, but it's a tricky area.
> Also there are other callers of migration than compaction, and we should
> make sure we are not breaking them unexpectedly.
> 

It's tricky because part of the point of SYNC_LIGHT was to block on
some operations but not for too long. writepage was considered to be an
exception because it can be very slow for a variety of reasons. I think
At the time that writeback from reclaim context was possible and it was
very inefficient, more more inefficient than reads.  Storage can also be
very slow (e.g. USB stick plugged in) and there can be large differences
between read/write performance (SMR, some ssd etc). Pages read were generally
clean and could be migrated, pages for write may be redirtied etc. It was
assumed that while both read/write could lock the page for a long time,
write had worse hold times and most other users of lock page were transient.

A compromise for SYNC_LIGHT or even SYNC on lock page would be to try
locking with a timeout. I don't think there is a specific helper but it
should be possible to trylock, wait on the folio_waitqueue and attempt
once to get the lock again. I didn't look very closely but it would
doing something similar to folio_wait_bit_common() with
io_schedule_timeout instead of io_schedule. This will have false
positives because the folio waitqueue may be woken for unrelated pages
and obviously it can race with other wait queues.

kcompactd is an out-of-line wait and can afford to wait for a long time
without user-visible impact but 120 seconds or any potentially unbounded
length of time is ridiculous and unhelpful. I would still be wary about
adding new sync modes or making major modifications to kcompactd because
detecting application stalls due to a kcompactd modification is difficult.

There is another approach -- kcompactd or proactive under heavy memory
pressure is probably a waste of CPU time and resources and should
avoid or minimise effort when under pressure. While direct compaction
can capture a page for immediate use, kcompactd and proactive reclaim
are just shuffling memory around for *potential* users and may be making
the overall memory pressure even worse. If memory pressure detection was
better and proactive/kcompactd reclaim bailed then the unbounded time to
lock a page is mitigated or completely avoided.

The two options are ortogonal. trylock_page_timeout() would mitigate
worst case behaviour while memory pressure detection and bailing on SYNC*
compaction side-steps the issue in extreme cases. Both have value as
pressure detection would be best-effort and trylock_page_timeout() would
limit worst-case behaviour.

> > I'll try to send out a v2 with this approach today and we can see what
> > people think.
> 
> Please Cc Mel and myself for further versions.
> 

Yes please.

-- 
Mel Gorman
SUSE Labs

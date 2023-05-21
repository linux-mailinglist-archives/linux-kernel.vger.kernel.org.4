Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E070AFC9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEUTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEUTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:20:58 -0400
Received: from outbound-smtp16.blacknight.com (outbound-smtp16.blacknight.com [46.22.139.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA9D7
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 12:20:54 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 483691C47D4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 20:20:53 +0100 (IST)
Received: (qmail 13105 invoked from network); 21 May 2023 19:20:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[93.89.247.161])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 May 2023 19:20:52 -0000
Date:   Sun, 21 May 2023 20:20:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Follow-up "Fix excessive CPU usage during compaction"
Message-ID: <20230521192046.pduhkcv2u3j5dfbl@techsingularity.net>
References: <6d62686f-964d-342c-e085-0eae2555cc54@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6d62686f-964d-342c-e085-0eae2555cc54@amd.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 12:13:11PM +0530, Raghavendra K T wrote:
> On 5/15/2023 5:03 PM, Mel Gorman wrote:
> > The series "Fix excessive CPU usage during compaction" [1] attempted to
> > fix a bug [2] but Vlastimil noted that the fix was incomplete [3]. While
> > the series was merged, fast_find_migrateblock was still disabled. This
> > series should fix the corner cases and allow 95e7a450b819 ("Revert
> > "mm/compaction: fix set skip in fast_find_migrateblock"") to be safely
> > reverted. Details on how many pageblocks are rescanned are in the
> > changelog of the last patch.
> > 
> > [1] https://lore.kernel.org/r/20230125134434.18017-1-mgorman@techsingularity.net
> > [2] https://bugzilla.suse.com/show_bug.cgi?id=1206848
> > [3] https://lore.kernel.org/r/a55cf026-a2f9-ef01-9a4c-398693e048ea@suse.cz
> > 
> >   mm/compaction.c | 24 ++++++++++--------------
> >   1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> 
> Hello Mel,
> 
> Not sure how much this info would help, (also I saw it is in Andrew's
> tree already) But was curious to evaluate the  patchset from perf
> perspective, and I have run mmtest usemem so here is the result (Only
> for  compact cases).
> 
> <SNIP>
>

Thanks Raghavendra!

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E676EF7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbjDZPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbjDZPdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:33:44 -0400
Received: from outbound-smtp05.blacknight.com (outbound-smtp05.blacknight.com [81.17.249.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CC6EBB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:33:34 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 739FBCCC7C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 16:33:33 +0100 (IST)
Received: (qmail 17964 invoked from network); 26 Apr 2023 15:33:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2023 15:33:33 -0000
Date:   Wed, 26 Apr 2023 16:33:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "mm/compaction: fix set skip in
 fast_find_migrateblock""
Message-ID: <20230426153331.dfqagb47i4xo3ouv@techsingularity.net>
References: <3576e3520c044beb2a81860aecb2d4f597089300.1682521303.git.baolin.wang@linux.alibaba.com>
 <c48c4da5-9de5-f060-b6ad-5373ced87d0a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <c48c4da5-9de5-f060-b6ad-5373ced87d0a@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:10:14PM +0200, Vlastimil Babka wrote:
> On 4/26/23 17:03, Baolin Wang wrote:
> > This reverts commit 95e7a450b8190673675836bfef236262ceff084a.
> > 
> > When I tested thpscale with v6.3 kernel, I found the compaction efficiency
> > had a great regression compared to v6.2-rc1 kernel. See below numbers:
> >                                     v6.2-rc             v6.3
> > Percentage huge-3        81.35 (   0.00%)       32.97 ( -59.47%)
> > Percentage huge-5        89.92 (   0.00%)       41.70 ( -53.63%)
> > Percentage huge-7        92.41 (   0.00%)       34.08 ( -63.12%)
> > Percentage huge-12       90.29 (   0.00%)       41.10 ( -54.49%)
> > Percentage huge-18       82.38 (   0.00%)       41.24 ( -49.95%)
> > Percentage huge-24       80.34 (   0.00%)       35.99 ( -55.20%)
> > Percentage huge-30       88.90 (   0.00%)       44.20 ( -50.28%)
> > Percentage huge-32       90.69 (   0.00%)       79.57 ( -12.25%)
> > 
> > Ops Compaction stalls                 113790.00      207099.00
> > Ops Compaction success                 33983.00      19488.00
> > Ops Compaction failures                79807.00      187611.00
> > Ops Compaction efficiency                 29.86          9.41
> > 
> > After some investigation, I found the commit 95e7a450b819
> > ("Revert mm/compaction: fix set skip in fast_find_migrateblock") caused
> > the regression. This commit revert the commit 7efc3b726103 ("mm/compaction:
> > fix set skip in fast_find_migrateblock") to fix a CPU stalling issue, which
> > is caused by compaction stucked in repeating fast_find_migrateblock().
> > 
> > And now the compaction stalling issue is addressed by commit cfccd2e63e7e
> > ("mm, compaction: finish pageblocks on complete migration failure"). So
> 
> IIRC at that time I was pointing out some scenarios that could make the
> problem appear even after that commit, and we wanted to revisit that
> when Mel is back.
> 

Yes, I've prototyped the fix against 6.3-rc7 and the revert is at the
end but the revert on its own has the potential for causing problems. The
series needs to be rebased, retested and posted. What I last tested
should show up shortly at

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-follupfastmigrate-v1r1

-- 
Mel Gorman
SUSE Labs

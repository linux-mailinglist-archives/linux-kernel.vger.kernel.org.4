Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E25BE09A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiITIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:46:07 -0400
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDD1F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:46:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id DC056CAC48
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:46:03 +0100 (IST)
Received: (qmail 21985 invoked from network); 20 Sep 2022 08:46:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Sep 2022 08:46:03 -0000
Date:   Tue, 20 Sep 2022 09:45:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Subject: Re: [RFC PATCH] mm: check global free_list if there is ongoing
 reclaiming when pcp fail
Message-ID: <20220920084555.rzphzayirdbtht2w@techsingularity.net>
References: <1663325892-9825-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20220919101629.xlafi2y2dk357wk3@techsingularity.net>
 <CAGWkznFEBDwDVeR1AH6gk30PHU3pvSHBusOSQgEB2L7mZD4Mxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAGWkznFEBDwDVeR1AH6gk30PHU3pvSHBusOSQgEB2L7mZD4Mxg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:45:35AM +0800, Zhaoyang Huang wrote:
> On Mon, Sep 19, 2022 at 6:22 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Sep 16, 2022 at 06:58:12PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Check the global free list again even if rmqueue_bulk failed for pcp pages when
> > > there is ongoing reclaiming, which could eliminate potential direct reclaim by
> > > chance.
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Patch does not apply and may be based on a custom kernel that introduced
> > a problem. There is no description of what problem this is trying to
> > fix. Checking the status of reclaim for a specific zone in this path would
> > be a little unexpected.  If allocation pressure is exceeding the ability
> > of reclaim to make progress then the caller likely needs to take action
> > like direct reclaim. If the allocation failure is due to a high-order
> > failure then it may need to enter direct compaction etc.
>
> Agree with the above comment. This is a proposal aiming at avoiding
> direct reclaiming things with minimum cost, that is to say, about 5
> CPU instructions in return with the overhead of function calls which
> has both of several loops inside and potential throttle sleep by IO
> congestion etc.

If the refill fails and kswapd is failing to keep up then actions like
direct reclaim or compaction are inevitable. At best, this patch would
race to allocate pages in one context that are being freed in parallel by
another context.

Nak.

-- 
Mel Gorman
SUSE Labs

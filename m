Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92385FAE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJKIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:25:37 -0400
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F697101CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:25:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id D6034CAB71
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:25:33 +0100 (IST)
Received: (qmail 28258 invoked from network); 11 Oct 2022 08:25:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2022 08:25:33 -0000
Date:   Tue, 11 Oct 2022 09:25:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-ID: <20221011082530.p2fk44dhglxulsou@techsingularity.net>
References: <20220824141802.23395-1-mgorman@techsingularity.net>
 <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
 <20221010142208.ctsasloh7hbudupc@techsingularity.net>
 <a7092c47-63ef-200a-8968-7e3402e19a38@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a7092c47-63ef-200a-8968-7e3402e19a38@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:45:43PM +0200, Vlastimil Babka wrote:
> On 10/10/22 16:22, Mel Gorman wrote:
> > On Wed, Aug 24, 2022 at 10:58:26PM -0600, Yu Zhao wrote:
> > > On Wed, Aug 24, 2022 at 8:18 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > > > 
> > > > The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> > > > allocating from the PCP must not re-enter the allocator from IRQ context.
> > > > In each instance where IRQ-reentrancy is possible, the lock is acquired using
> > > > pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> > > > is impossible.
> > > > 
> > > > Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> > > > case at the cost of some IRQ allocations taking a slower path. If the PCP
> > > > lists need to be refilled, the zone lock still needs to disable IRQs but
> > > > that will only happen on PCP refill and drain. If an IRQ is raised when
> > > > a PCP allocation is in progress, the trylock will fail and fallback to
> > > > using the buddy lists directly. Note that this may not be a universal win
> > > > if an interrupt-intensive workload also allocates heavily from interrupt
> > > > context and contends heavily on the zone->lock as a result.
> > > 
> > > Hi,
> > > 
> > > This patch caused the following warning. Please take a look.
> > > 
> > > Thanks.
> > > 
> > >    WARNING: inconsistent lock state
> > >    6.0.0-dbg-DEV #1 Tainted: G S      W  O
> > >    --------------------------------
> > 
> > I finally found time to take a closer look at this and I cannot reproduce
> > it against 6.0. What workload triggered the warning, on what platform and
> > can you post the kernel config used please? It would also help if you
> > can remember what git commit the patch was tested upon.
> > 
> > Thanks and sorry for the long delay.
> 
> I didn't (try to) reproduce this, but FWIW the report looked legit to me, as
> after the patch, pcp_spin_trylock() has to be used for both allocation and
> freeing to be IRQ safe. free_unref_page() uses it, so it's fine. But as the
> stack trace in the report shows, free_unref_page_list() does pcp_spin_lock()
> and not _trylock, and that's IMHO the problem.
> 

I completely agree, it was a surprise to me that IO completion would
happen in soft IRQ context even though blk_done_softirq indicates that
it is normal and I didn't manage to trigger that case myself. I wondered
if there was an easy way to force that which would have made testing of
this easier. I can live without the reproduction case and cc Yu Zhao after
6.1-rc1 comes out and I've fixed this.

-- 
Mel Gorman
SUSE Labs

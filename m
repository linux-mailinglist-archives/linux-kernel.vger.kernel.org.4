Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAA60CD46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiJYNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiJYNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:20:06 -0400
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF7844D4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:20:03 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id A15EC23D5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:20:01 +0100 (IST)
Received: (qmail 976 invoked from network); 25 Oct 2022 13:20:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Oct 2022 13:20:01 -0000
Date:   Tue, 25 Oct 2022 14:19:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: fix pcp count beyond pcp high in pcplist allocation
Message-ID: <20221025131959.sd47fipimhehf76i@techsingularity.net>
References: <20221024134146.3442393-1-chenwandun@huawei.com>
 <20221024145555.oaoisy6m723h4axc@techsingularity.net>
 <f189c530-1576-21fa-4c12-caa62739bbd0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f189c530-1576-21fa-4c12-caa62739bbd0@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:49:59PM +0800, Chen Wandun wrote:
> 
> 
> On 2022/10/24 22:55, Mel Gorman wrote:
> > On Mon, Oct 24, 2022 at 09:41:46PM +0800, Chen Wandun wrote:
> > > Nowadays there are several orders in pcplist, Function __rmqueue_pcplist
> > > would alloc pcp batch pages to refill pcplist, when list of target order
> > > if empty meanwhile other lists is not all empty, that result in pcp count
> > > beyond pcp high after allocation. This behaviour can be easily observed by
> > > adding debugging information in __rmqueue_pcplist.
> > > 
> > > Fix this by recalculate the batch pages to be allocated.
> > Are any problems observed other than the PCP lists temporarily exceed
> > pcp->high?
>
> It will result frequently refill pcp page from buddy and release pcp page to
> buddy.

Under what circumstances does this causes a problem? I 100% accept that it
could happen but one downside of the patch is that it simply changes the
shape of the problem. If the batch refill is clamped then potentially the
PCP list is depleted quicker and needs to be refilled sooner and so zone
lock acquisitions are still required potentially higher frequency due to
clamped refill sizes. All that changes is the timing.

> >   As is, the patch could result in a batch request of 0 and
>
>  I foget this, the patch need some improve, thanks.
>
> > fall through to allocating from the zone list anyway defeating the
> > purpose of the PCP allocator and probably regressing performance in some
> > csaes.
>
> Same as I understand???how about set high/batch for each order in pcplist???

Using anything would than (X >> order) consumes storage. Even if storage
was to be used, selecting a value per-order would be impossible because
the correct value would depend on frequency of requests for each order.
That can only be determined at runtime and the cost of determining the
value would likely exceed the benefit.

At most, you could state that the batch refill should at least be 1 but
otherwise not exceed high. The downside is that zone->lock contention will
increase for a stream of THP pages which is a common allocation size.
The intent behind batch-2 was to reduce contention by 50% when multiple
processes are faulting large anonymous regions at the same time. THP
allocations are ones most likely to exceed pcp->high by a noticeable amount.

> or just share pcp batch value only set high for each order? It looks like
> strange for pcp count beyond pcp high in common case.
> 
> If each order has it's own pcp high value, that behaviour is same as pcplist
> which
> only contains order 0.
> 

Specify in the changelog how a workload is improved. That may be in terms
of memory usage, performance, zone lock contention or cases where pcp->high
being exceeded causes a functional problem on a particular class of
system.

-- 
Mel Gorman
SUSE Labs

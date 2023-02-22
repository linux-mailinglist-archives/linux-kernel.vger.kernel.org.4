Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AEA69ED47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjBVDIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjBVDIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:08:36 -0500
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [IPv6:2001:41d0:203:375::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49842799C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:08:06 -0800 (PST)
Date:   Tue, 21 Feb 2023 22:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677035284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fh+ZWupQZLC960FUtMOl+KhoqTzp8W4OBFpCPFVSY8g=;
        b=pJ7n8xcP3A9T8tZjf80xmcq102eUtVS/EpajkfOeF5d6nJYCbEGJPE//No+GSJLwD7eZaV
        Sgs97WX3MuZL+6uxHL2ubR0U0WPVBeutZZYqC1BfULQOQpZSq7EiLP+/x1UWtv0NvjBGpl
        gTEbcN+Y8sVp7TUBe6Uo7Ph2xjeSkJk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: What size anonymous folios should we allocate?
Message-ID: <Y/WHEWnr6MyNd6jP@moria.home.lan>
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
 <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
> On Tue, Feb 21, 2023 at 1:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > In a sense this question is premature, because we don't have any code
> > in place to handle folios which are any size but PMD_SIZE or PAGE_SIZE,
> > but let's pretend that code already exists and is just waiting for us
> > to answer this policy question.
> >
> > I'd like to reject three ideas up front: 1. a CONFIG option, 2. a boot
> > option and 3. a sysfs tunable.  It is foolish to expect the distro
> > packager or the sysadmin to be able to make such a decision.  The
> > correct decision will depend upon the instantaneous workload of the
> > entire machine and we'll want different answers for different VMAs.
> 
> Yeah, I agree those 3 options should be avoided. For some
> architectures, there are a or multiple sweet size(s) benefiting from
> hardware. For example, ARM64 contiguous PTE supports up to 16
> consecutive 4K pages to form a 64K entry in TLB instead of 16 4K
> entries. Some implementations may support intermediate sizes (for
> example, 8K, 16K and 32K, but this may make the hardware design
> harder), but some may not. AMD's coalesce PTE supports a different
> size (128K if I remember correctly). So the multiple of the size
> supported by hardware (64K or 128K) seems like the common ground from
> maximizing hardware benefit point of view. Of course, nothing prevents
> the kernel from allocating other orders.
> 
> ARM even supports contiguous PMD, but that would be too big to
> allocate by buddy allocator.

Every time this discussion comes up it seems like MM people have a major
blind spot, where they're only thinking about PTE looking and TLB
overhead and forgetting every other codepath in the kernel that deals
with cached data - historically one physical page at a time.

By framing the discussion in terms of what's best for the hardware,
you're screwing over all the pure software codepaths. This stupity has
gone on for long enough with the ridicurous normalpage/hugepage split,
let's not continue it.

Talk to any filesystem person, you don't want to fragment data
unnecessarily. That's effectively what you're advocating for, by
continuing to talk about hardware page sizes.

You need to get away from designing things around hardware limitations
and think in more general terms. The correct answer is "anonymous pages
should be any power of two size".

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8174BBA5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGHECW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHECS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913CD123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AfjkjixMYu2h2WslbSIJH5jv4hNa2iolRJaPXMMoIzc=; b=BtL71q5f+y7sP0xlZmxkwb84J1
        yC2k81UmUmr1gqo36QiOVxQfPM//GIzSDMe1f9oNSUlgAi1B85kQ5HfH41uLSJlHciBBCqp5wwu0x
        7ud0qMqJnImr5J9LE9BFmZAxGHXxExxRgykBf4hst3e/HpDxKdbw8wzT6HjE0JablLpRkDorwL6uY
        qTOg88Vrg7MjZ1Dg1GxVjUb1OvaIbHMlV6YKLXM8R0yb88c8ObODoBvDLiRR0vUOUx5QzXE2kVIS0
        ScPoX9yA3YnPI1axeWWIpYveNNNCcjqt0EhbVonV2kTPWYgNKYj+gZV+H8hdXywKT9Ip/gJS7nf1l
        MTC2eBHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHz97-00CcTy-Ki; Sat, 08 Jul 2023 04:02:09 +0000
Date:   Sat, 8 Jul 2023 05:02:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Message-ID: <ZKjfwYWh/n/LbTZv@casper.infradead.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436cd29f-44a6-7636-5015-377051942137@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 11:52:23AM +0800, Yin, Fengwei wrote:
> > Oh, I agree, there are always going to be circumstances where we realise
> > we've made a bad decision and can't (easily) undo it.  Unless we have a
> > per-page pincount, and I Would Rather Not Do That.  But we should _try_
> > to do that because it's the right model -- that's what I meant by "Tell
> > me why I'm wrong"; what scenarios do we have where a user temporarilly
> > mlocks (or mprotects or ...) a range of memory, but wants that memory
> > to be aged in the LRU exactly the same way as the adjacent memory that
> > wasn't mprotected?
> for manpage of mlock():
>        mlock(),  mlock2(), and mlockall() lock part or all of the calling process's virtual address space into RAM, preventing that memory
>        from being paged to the swap area.
> 
> So my understanding is it's OK to let the memory mlocked to be aged with
> the adjacent memory which is not mlocked. Just make sure they are not
> paged out to swap.

Right, it doesn't break anything; it's just a similar problem to
internal fragmentation.  The pages of the folio which aren't mlocked
will also be locked in RAM and never paged out.

> One question for implementation detail:
>   If the large folio cross VMA boundary can not be split, how do we
>   deal with this case? Retry in syscall till it's split successfully?
>   Or return error (and what ERRORS should we choose) to user space?

I would be tempted to allocate memory & copy to the new mlocked VMA.
The old folio will go on the deferred_list and be split later, or its
valid parts will be written to swap and then it can be freed.

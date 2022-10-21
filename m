Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5714C6073D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJUJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiJUJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:19:18 -0400
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE5211284
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:19:14 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 6E46CBAD1D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:19:13 +0100 (IST)
Received: (qmail 8314 invoked from network); 21 Oct 2022 09:19:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Oct 2022 09:19:13 -0000
Date:   Fri, 21 Oct 2022 10:19:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Message-ID: <20221021091911.ak3a7a3wr3qcbe3b@techsingularity.net>
References: <20221005180341.1738796-1-shy828301@gmail.com>
 <20221005180341.1738796-3-shy828301@gmail.com>
 <20221013123830.opbulq4qad56kuev@techsingularity.net>
 <CAHbLzkpc+CAfsYe6gXjh=-3MxMH_aWhPMYhic7ddFZgWttOhng@mail.gmail.com>
 <20221017094132.vnanndrwa2yn7qcw@techsingularity.net>
 <CAHbLzkpmbmtOdOsud-VG+wyk18wFAFnan8T55XxxwkHrnhLCmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkpmbmtOdOsud-VG+wyk18wFAFnan8T55XxxwkHrnhLCmw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:01:31AM -0700, Yang Shi wrote:
> > > Yeah, I didn't think of a better way to pass the pages to dm-crypt.
> > >
> > > >
> > > > How about this
> > > >
> > > > 1. Add a callback to __alloc_pages_bulk() that takes a page as a
> > > >    parameter like bulk_add_page() or whatever.
> > > >
> > > > 2. For page_list == NULL && page_array == NULL, the callback is used
> > > >
> > > > 3. Add alloc_pages_bulk_cb() that passes in the name of a callback
> > > >    function
> > > >
> > > > 4. In the dm-crypt case, use the callback to pass the page to bio_add_page
> > > >    for the new page allocated.
> > >
> > > Thank you so much for the suggestion. But I have a hard time
> > > understanding how these work together. Do you mean call bio_add_page()
> > > in the callback? But bio_add_page() needs other parameters. Or I
> > > misunderstood you?
> > >
> >
> > I expected dm-crypt to define the callback. Using bio_add_page
> > directly would not work as the bulk allocator has no idea what to pass
> > bio_add_page. dm-crypt would likely need to create both a callback and an
> > opaque data structure passed as (void *) to track "clone" and "len"
> 
> I see. Yeah, we have to pass the "clone" and "len" to the callback via
> pool_data. It should not be hard since dm-crypt already uses
> crypt_config to maintain a counter for allocated pages, we should just
> need to pass the struct to the callback as a parameter.
> 
> But I'm wondering whether this is worth it or not? Will it make the
> code harder to follow?
> 

A little because a callback is involved but it's not the only place in the
kernel where a callback is used like this and a comment should suffice. It
should be faster than list manipulation if nothing else. Mostly, I'm wary
of adding the first user of the list interface for the bulk allocator that
does not even want a list. If there isn't a user of the list interface
that *requires* it, the support will simply be deleted as dead code.

-- 
Mel Gorman
SUSE Labs

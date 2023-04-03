Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E76D4E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjDCQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:36:28 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFF1721
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:36:27 -0700 (PDT)
Date:   Mon, 3 Apr 2023 12:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680539783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLq/fee/rAnKhGEHWUNMA+5CkZ4Fztgv7aGPljQgyZM=;
        b=t5CDZlBcBkXQiFf0dli4Jwe1z9f5aVC/6Okq/ur8yEOhvk10GavgoOLEaxOmXo+iLeQj8S
        4TLHxF7QgVlQEtq6f5IPQ8MrmZK0qQUri9jG17kwKkoaFUk4eUxfIpqmm33SgCAf1IQkIh
        p86LNNAi4Pn7tIJ2oZ7++R7eDVd1wcY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCsAhDpsiNWpiAxS@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCrsbv+zKGf4jvUm@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:10:38AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 04:28:08PM -0400, Kent Overstreet wrote:
> > > Can you post a code size comparism for the before and after cases?
> > 
> > 6.2:
> > kent@moria:~/linux$ size ktest-out/kernel_build.x86_64/vmlinux
> >    text    data     bss     dec     hex filename
> > 13234215        5355074  872448 19461737        128f669 ktest-out/kernel_build.x86_64/vmlinux
> > 
> > With patches:
> > kent@moria:~/linux$ size ktest-out/kernel_build.x86_64/vmlinux
> >    text    data     bss     dec     hex filename
> > 13234215        5355578  872448 19462241        128f861 ktest-out/kernel_build.x86_64/vmlinux
> 
> So we have a slightly larger binary size, and a slighly larger source
> code size.  What is the overall benefit of this conversion?

Data went up a bit because I added some asserts, yes. And it's also not
uncommon for source code to grow a bit when you start focusing on
readability instead of just playing code golf.

And that was one of the main motivations - Matthew was complaining about
the bio iter code being a pain in the ass when he did the bio folio iter
code; additionally, I realized I could do a much cleaner and smaller
version of bio_for_each_folio() with some refactoring of the existing
code.

But this was all right there in the original commit message. And to be
honest Christoph, these kinds of drive by "let's focus on the easiest
thing to measure" comments are what I expect from you at this point, but
I don't find them to be super helpful. Reads like a typical MBA manager
who just wants to focus on making their silly charts going up, instead
of digging in and understanding what's going on. Was it your time in
FinTech that you got that from...?

If we want object size to go back down, we could
 - convert WARN_ONS() to BUG_ON()s (Linus won't like that)
 - drop the new assertions (_I_ wouldn't like that)
 - switch from inlines to out-of-line functions - this'll make text size
   go down vs. baseline, but if there's a performance impact Jens will
   care about that.

Anyways, I've got a patch converting to out-of-line functions but I
don't have as sensitive a performance testing setup as Jens does. If the
patch is interesting to people - if Jens wants to perf test it or just
take it - I'm happy to post it too.

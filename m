Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE61F693603
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 05:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBLESZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 23:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLESW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 23:18:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB12014EB0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 20:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C1+aOkGVEB4KQ1YTLeYD4sqqteaA3LlF8O5Ivt5MSa8=; b=fgmHgD72h0yJu+JFs2V7YqI5ne
        jt83z98YvTg4kQ3PNwDJLNGiXoyttkH8C/yHP20WN4sAtrDncAxr2qzI7MUQtgxmmOq5IPrMQO+s0
        vUPIFdFX/vA0BqhQ2m9viHJlfvaWn0sEmhVzYBg1UJy63dDNnPwWIY07eHr6MN3NeiKaLEiKltLge
        rDsCIyQ8cG/GQ5DMXk63YfG7+fyx2fAvLDFSf9CZvErPLYqPDPNUUntXcwa8nskDfoDlw7wg61J2H
        Eu3s2OKKDzfuK/F0l9dKiRZtpJ2GQS6lWTsgaoKrSR1q6ehtK4qWRLFFWUS1meS58GxcykPa32Ntv
        Z0jV7vsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pR3od-004bok-7o; Sun, 12 Feb 2023 04:18:15 +0000
Date:   Sun, 12 Feb 2023 04:18:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Vlastimil Babka <vbabka@suse.cz>,
        David Chen <david.chen@nutanix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report for mainline [2023-02-11]
Message-ID: <Y+hohwykIsBD2082@casper.infradead.org>
References: <167613641114.2124708.9785978428796571420@leemhuis.info>
 <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 01:39:08PM -0800, Linus Torvalds wrote:
> Maybe we should just bite the bullet and say "page cache pages are
> rcu-freed after removing them from the mapping", so that we don't need
> the whole folio_try_get_rcu() at all.

For GUP, you'd also have to do it for any page which has ever been mapped
to userspace, including from drivers.  I think that gets a bit tricky.

But there's a good motivation for RCU-freeing page cache pages.
Ben Lahaise once worked on a system which did very small reads which
invariably hit in the page cache.  On the order of dozens to hundreds
of bytes.  For that workload, cache contention on the page refcount was
the limiting factor on performance.  He had an optimisation where he'd
look up the page, memcpy() to a small buffer on the stack, look up the
page again, and if it was the same, copy_to_user().  I was thinking that
we could do that less painfully by RCU-freeing pages.

That's at the back of my mind; I'm kind of busy with other things
right now.

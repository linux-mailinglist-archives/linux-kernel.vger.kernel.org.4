Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4569177A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjBJEGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjBJEGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:06:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3246F23D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:06:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so4328944pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 20:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQukG6VNZYZUXm//Al1g4+POizmfJHeVziiad8wAEoU=;
        b=kzUuan30m3yKkEUOHtbIuptRZVN8st7qEB21fNA/9L0cHJRQFMMsCVePQpuzRl5W2I
         Gd7IqT9cKalmdEM/0E7AECi0cZlPmXL0R3hjb6p7EZ9vqlnjob3Ee7zKmANG4khQjVDv
         Tz3jvGmYHOwzVEgjrWxAW24dNnRNHVrDxkj/X0J3fjLs/CnvgHhYbf+LRQt0ar37DsNo
         ARfsDn60bvBXWoW3Sq790q9D7u/ZVGTythsckiMnmp/tUMSwyqrb0exc7jK5ZKSdI8jI
         UZGEkOWTxqRbCgi6AWkxRDB+TTQzSRSL2DKHPSuWIZKD8oyBnS/DI/aS6OlN/SeWDcyB
         ym2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQukG6VNZYZUXm//Al1g4+POizmfJHeVziiad8wAEoU=;
        b=w8MtAxkzDsAf9opRVzNaNTVJJ75GkIFONv93R8EcJvO60WBsiBIBMXaB4vTgHFeSBw
         B2sjGTLQw1ogVShHUSA9CyKEYxFfN0fBz4J+ZWzQAXiMVtUCoap6eUP63VsVT2Xxv5Y1
         G9zRhES2/dSppXiEDS3pq5aBg26JXYxDa0AzVsRUP2vTh6+vzu+GWvAbnwUXd/O6JpaB
         KeNsZhOUL1lm9gnmzh5uuyeMJR1+B1c6tr2x2qGWV68NXmCE+CafJEqYP8lW0HaMrGcP
         7MDUkllfgU73omAQJuL0HULlTeyOZUWrToTa9c5WvXBV1a64LHU3K9HL+oZ4lHkB4B0j
         uA9w==
X-Gm-Message-State: AO0yUKVI/YetYiavMMpAwjv9aBLyplDdE7p/gE5G177My2Xn57KguMna
        AdhxDFYqjzvK+D1jEsF2u0CAlw==
X-Google-Smtp-Source: AK7set+aERyy//+fPM2gibPlaQeM1kDv6ohqX2U7atZnXrN4SLysgPAmxz7P29Uo4XVx9U7MI9Pc9Q==
X-Received: by 2002:a17:903:32c4:b0:196:d05:bac7 with SMTP id i4-20020a17090332c400b001960d05bac7mr15939857plr.58.1676001989352;
        Thu, 09 Feb 2023 20:06:29 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b001928c204428sm2285919plb.142.2023.02.09.20.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:06:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pQKg6-00DUZL-Cg; Fri, 10 Feb 2023 15:06:26 +1100
Date:   Fri, 10 Feb 2023 15:06:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Subject: Re: copy on write for splice() from file to pipe?
Message-ID: <20230210040626.GB2825702@dread.disaster.area>
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210021603.GA2825702@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 01:16:03PM +1100, Dave Chinner wrote:
> On Thu, Feb 09, 2023 at 08:41:02AM -0800, Linus Torvalds wrote:
> > Now, I do see a couple of possible alternatives to "just create a stable copy".
> > 
> > For example, we very much have the notion of "confirm buffer data
> > before copying". It's used for things like "I started the IO on the
> > page, but the IO failed with an error, so even though I gave you a
> > splice buffer, it turns out you can't use it".
> > 
> > And I do wonder if we could introduce a notion of "optimistic splice",
> > where the splice works exactly the way it does now (you get a page
> > reference), but the "confirm" phase could check whether something has
> > changed in that mapping (using the file versioning or whatever - I'm
> > hand-waving) and simply fail the confirm.
> > 
> > That would mean that the "splice to socket" part would fail in your
> > chain, and you'd have to re-try it. But then the onus would be on
> > *you* as a splicer, not on the rest of the system to fix up your
> > special case.
> > 
> > That idea sounds fairly far out there, and complicated and maybe not
> > usable. So I'm just throwing it out as a "let's try to think of
> > alternative solutions".
> 
> Oh, that's sounds like an exact analogy to the new IOMAP_F_STALE
> flag and the validity cookie we have in the iomap write path code.
> The iomap contains cached, unserialised information, and the
> filesystem side mapping it is derived from can change asynchronously
> (e.g. by IO completion doing unwritten extent conversion). Hence the
> cached iomap can become stale, and that's a data corruption vector.
> 
> The validity cookie is created when the iomap is built, and it is
> passed to a filesystem callback when a folio is locked for copy-in.
> This allows the IO path to detect that the filesystem side extent
> map has changed during the write() operations before we modify the
> contents of the folio. It is done under the locked folio so that the
> validation is atomic w.r.t. the modification to the folio contents
> we are about to perform.
> 
> On detection of a cookie mismatch, the write operation then sets the
> IOMAP_F_STALE flag, backs out of the write to that page and ends the
> write to the iomap. The iomap infrastructure then remaps the file
> range from the offset of the folio at which the iomap change was
> detected.  The write the proceeds with the new, up to date iomap....
> 
> We have had a similar "is the cached iomap still valid?" mechanism
> on the writeback side of the page cache for years. The details are
> slightly different, though I plan to move that code to use the same
> IOMAP_F_STALE infrastructure in the near future because it
> simplifies the writeback context wrapper shenanigans an awful lot.
> And it helps make it explicit that iomaps are cached/shadowed
> state, not the canonical source of reality.
> 
> Applying the same principle it to multiply referenced cached page
> contents will be more complex. I suspect we might be able to
> leverage inode->i_version or ctime as the "data changed" cookie as
> they are both supposed to change on every explicit user data
> modification made to an inode. However, I think most of the
> complexity would be in requiring spliced pages to travel in some
> kind of container that holds the necessary verification
> information....

So while I was pondering the complexity of this and watching a great
big shiny rocket create lots of heat, light and noise, it occurred
to me that we already have a mechanism for preventing page cache
data from being changed while the folios are under IO:
SB_I_STABLE_WRITES and folio_wait_stable().

That is, md/dm RAID5/6 devices require the folio contents to be
stable during writeback to calculate parity during IO submission,
and folio_wait_stable() is the mechanism that guarantees pages don't
get changed while they are under IO.

So instead of the complex dance described above to detect data
changes at the splice destination, we simply have splice add
temporary folio state that folio_wait_stable() blocks on to prevents
new user data modification on that folio from occurring until the
splice reference and stable state flag goes away.

Whilst this would work for folios that are currently clean, I
suspect it won't work properly with folios that are already mapped
and dirty because there won't be another page fault to trap the data
being changed.  i.e. no folio_clear_dirty_for_io() call has been
made on the page to trigger new write faults. Perhaps a variant that
just propagates the pte dirty bit into the folio and clears it (i.e.
first part of folio_clear_dirty_for_io()) would be sufficient in
this case.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

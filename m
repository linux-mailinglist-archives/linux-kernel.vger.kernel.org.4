Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00867173B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjEaCaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEaCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:30:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DE113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:30:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f6b2af4558so26487751cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685500220; x=1688092220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwgqufLL+BZf+iFjUCvuUpn5v95zPOIiAfCvQNA1OTY=;
        b=W+CvHuZuGxk1g1OV26ZeNlIdaJCON/0DbBboKDdO8uREAiJ58P6JokBX8FMBbCBXlO
         lu7QSX406XjqlPluKy0+0lB5BH7lpIe/nT341347lEBE0dwnEYXftfNTinQMFoLYdZf+
         pI1djVBRX5Fxf/PhkVULt/IrU8ShNx2hQU3HCv7JctlcEV9GfEStkxQe8ZB0iWZwB4EN
         jPa8OsujecSAcgyLXwBys3SVnwE5e7E2I2BaBqwvk5YqvtGMq96Jn8MhYl5IhOQlcnE+
         HMfvYt2glTogyHPldgDfq3k92r0mngVKEQhSDrBDZ51l5NyRPAK1ATDwd8zES4hwSuKk
         7x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685500220; x=1688092220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwgqufLL+BZf+iFjUCvuUpn5v95zPOIiAfCvQNA1OTY=;
        b=FTYnCfZF6E4FfzyoZe7MdGvLJnxqbMv9800yNsTDTJJLWUWIiiW6BZlpNbmywWP2sD
         /hzE6laSDNBNHsES4KP5kJraZReqXBygPzRwrQVW8yfcdIPPTKQynGM5TRdU+je1lMGr
         3k2I0AMlLeUBPhpKbCl/G9vbVH5BVgc+GDlq13tCtsBC9oaE+Q22fyYcKXbVOL/Y38Ce
         dJT3AzUHf2GHSMpTlIfOxwVrWibMFylQituDwcRU2jYgrfa6W4qaQiXNZoWRxGuxUEQy
         onut7vc0b9TRPXVvOA0F7UCnIYDnD2VJS8qFG+zarjadsc9vCneiMrhwvLw+k2hUPCYI
         3Exw==
X-Gm-Message-State: AC+VfDwhveUlWXlOVw8GzsfIArIq8ShSiNssUfJ0/mBt6fhiTBsQdqRY
        i7CfwYmc+OmgfiIc80K8YRrcEg==
X-Google-Smtp-Source: ACHHUZ5dnAdpJQEsgVQGfGbrrL9fOzvHwkNp3TtGdEGJEbU/6FyWqYAEns/B6P92wSR9d57Gs6o/1A==
X-Received: by 2002:a05:6214:e43:b0:616:4b40:5ea9 with SMTP id o3-20020a0562140e4300b006164b405ea9mr4908421qvc.40.1685500220181;
        Tue, 30 May 2023 19:30:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id k8-20020ad44208000000b006261a1cd7f7sm3147860qvp.10.2023.05.30.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 19:30:19 -0700 (PDT)
Date:   Tue, 30 May 2023 22:30:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <20230531023018.GC102494@cmpxchg.org>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
 <20230530041341.GB84971@cmpxchg.org>
 <ZHYNaxgcKs7PSp9I@google.com>
 <20230530155519.GB97194@cmpxchg.org>
 <ZHY+C0ICTah8/+V3@google.com>
 <20230530185451.GA101722@cmpxchg.org>
 <ZHadno3POk05o82x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHadno3POk05o82x@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 06:06:38PM -0700, Chris Li wrote:
> On Tue, May 30, 2023 at 02:54:51PM -0400, Johannes Weiner wrote:
> > > Maybe ENOMEM is a bad example. How about if the swap device
> > > just went bad and can't complete new IO writes?
> > 
> > This is actually outside the scope of zswap, and handled by the
> > swapcache (end_swap_bio_write).
> > 
> > Once the IO is submitted, zswap will ax its copy and leave the rest to
> > the swapcache. It behaves the same way as if zswap had never been
> > involved to begin with when the swap out fails on IO errors.
> > 
> > From a zswap perspective, there are no persistent errors in moving a
> > zswap entry back into the swapcache. Not just currently, but generally.
> Again, you are right that this zswap writeback is async.
> So the writeback error is NOT going to propagate to the
> shrink function.
> 
> With the current three pool backends that I looked at{zbud,
> z3fold,zsmalloc} they all have internal retry 8 times.
> Adding more retry did not fundamentally change the existing
> behavior.

Ah, but they're looping over different things.

The internal loop in the zs_reclaim_page() function is about walking
the LRU list until at least one backing page is freed.

Then there is zs_zpool_shrink() which calls zs_reclaim_page() until
the requested number of pages are freed.

Finally, there is shrink_worker(), which calls zs_zpool_shrink(). It
currently calls it for a single page when woken up during a store that
hits the zswap pool limit. This is the problematic one, because zswap
is very unlikely to go back to accepting stores after one page freed.

Domenico's patch isn't adding more retries for error conditions. It
ensures the pool is shrunk back down to where it accepts stores again.

The reason that it now looks at errors as well isn't to retry over
them (that's zs_reclaim_page()'s job). It's to avoid an infinite loop
in case there is an unexpectedly high rate of errors across a whole
series of pages (suggesting there is a bug of some kind).

> I look at all the possible error codes generated inside
> the reclaim code, the only noticeable errors are ENOMEM
> and concurrent swap invalidation or a racing swapin fault.

Right.

> BTW, zswap reclaim consumes memory. Keep on looping ENOMEM
> might cause more OOM. But that can exist in current code
> as well.

Right.

And this is temporary. Zswap will allocate a page to decompress in,
add it to the swapcache and kick off the IO. Once the page is written
out, it'll be reclaimed again. So while the consumption increases
temporarily, the end result is a net reduction by the amount of
compressed data that was written back from zswap.

This is typical for other types of reclaim as well, e.g. allocating
entries in the swapcache tree, allocating bios and IO requests...

> > > > Aside from -ENOMEM, writeback_entry will fail on concurrent swap
> > > > invalidation or a racing swapin fault. In both cases we should
> > > > absolutely keep trying other entries until the goal is met.
> > > 
> > > How about a narrower fix recognizing those error cases and making
> > > the inner loop continue in those errors?
> > 
> > Right, I just I don't really see the value proposition of this
> > complication, and I see some downsides (see below). No single entry
> > error should ever cause us to stop the wider reclaim loop.
> 
> That is until the current LRU list has been through once.
> I expect repeating the same list yields less reclaimed pages.

If we see failure due to invalidation races, the entries will free and
shrink the pool, thus getting us closer to the can_accept() condition.
We'll stop looping in the shrinker once enough entries have been freed
- whether we reclaimed them ourselves, or somebody else invalidated them.

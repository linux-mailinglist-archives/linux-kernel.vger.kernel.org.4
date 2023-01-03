Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA265C79C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjACTfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjACTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:35:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F113DE8;
        Tue,  3 Jan 2023 11:35:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554FB614FE;
        Tue,  3 Jan 2023 19:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7FC433D2;
        Tue,  3 Jan 2023 19:35:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W+5NW3Rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672774533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVElIohNFNtKW3ZE1msjI450T/TRBnRTo0iv1QIRm4k=;
        b=W+5NW3Rq7Sg7ZuTMgTdUwj03IpK7ihNUOc1Q9h+gBQpWC+QUV6EXFUsODA2AmCv42FNd0e
        OMb29Km/uY+FlG/OGvBF2xg7gnUad65wYssd7fdkTOERShnrkrQOaaAmje6Ueu8SzufDZk
        Q3UvdX/gQYNwNIA9tLioErEXt5eNqYg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ec6e94ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 19:35:32 +0000 (UTC)
Date:   Tue, 3 Jan 2023 20:35:30 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7SDgtXayQCy6xT6@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Jan 03, 2023 at 11:19:36AM -0800, Linus Torvalds wrote:
> performed as well as they could, but on the whole this is still a
> really tiny thing, and Jason is trying to micro-optimize something
> that THE KERNEL SHOULD NOT CARE ABOUT.

I don't think this is about micro-optimization. Rather, userspace RNGs
aren't really possible in a safe way at the moment. This patchset aims
to make that possible, by providing things that libc will use. The cover
letter of this series makes that case.

> This should all be in libc. Not in the kernel with special magic vdso
> support and special buffer allocations. The kernel should give good
> enough support that libc can do a good job, but the kernel should
> simply *not* take the approach of "libc will get this wrong, so let's
> just do all the work for it".

That's not what this patchset does. libc still needs to handle
per-thread semantics itself and slice up buffers and so forth. The vDSO
doesn't allocate any memory. I suspect this was Ingo's presumption too,
and you extrapolated from that. But that's not what's happening.

> Now, if the magic buffers were something cool that were a generic
> concept that a lot of *other* cases would also kill for, that's one

Actually, I was thinking VM_DROPPABLE might be a somewhat interesting
thing to introduce for database caches and so forth, where dropping
things under memory pressure is actually useful. Obviously that's the
result of a thought process involving a solution looking for a problem,
but I considered this a month or so ago when I first sent this in, and
decided that if I was to expose this via a MAP_* flag in mmap(), that
should come later, so I didn't here. Anyway, that is all to say it's not
like this is the only use for it. But either way, I don't actually have
my sights set on it as a general solution -- after all, I am not in the
process of authoring a database cache or something -- and if I can make
Andy's vm_ops suggestion work, that sounds perfectly fine to me.

> thing. But this is such a small special case that absolutely *nobody*
> has asked for, and that nothing else wants.

Okay so that's where I think you're really quite mistaken. If you recall
the original discussion on this, I was initially a bit hesitant to do it
and didn't really want to do it that much. And then I looked into it,
and talked to a bunch of library and program authors, and saw that
there's actually quite a bit of demand for this, and generally an
unhealthy ecosystem of bad solutions that have cropped up in lieu of a
good one.

(I talked about this a bit with tglx at Plumbers, and I had hoped to
discuss with you as well, but you weren't available.)

Jason

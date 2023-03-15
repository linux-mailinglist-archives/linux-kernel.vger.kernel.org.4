Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9239D6BBA89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCORJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCORJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:09:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90716889
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:09:36 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id cf14so16927798qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678900176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2u/hv+4L5KWt+yxxObl0PU58hsBZGPZ5ydDwTbcNAY4=;
        b=OJcM421Yu9irppO33iKhVaS56EdzqHIGXpiEqQSktHFFf1BGsZ/qi0RSVsSEDRj74E
         mLppOO0rrrdTl+h42R4Ff8/zKMpLpT9KCxtBuTt2PXvjslrQrFxpL9IqZgL+EGIPON5E
         pdJ4r1QrT5DZ2pOJ0VkgLQfsItkqYQ0owQ1pGcdMh1cVkLxclzx7YBUCMrhvefGdnOC9
         ihnpk4ErKubkw3g9BhOl12O5cc36aaroxliMNjRrBhGnDg2XYpri17GTnJrrMmWfhMLj
         cpzY3cyciYzwFlO8SXVpXS5RbPR4WljRc/fWvqxMpVgGHY6zWZojMiY4dFDoby8YnZIB
         Lpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u/hv+4L5KWt+yxxObl0PU58hsBZGPZ5ydDwTbcNAY4=;
        b=1ivkWDxrxgGwwVSwAKbbwEmpVIO2XiuMNb7WVeiDvO8rZYa3aEK+rzQoJQBXICSMNM
         kemfk2OnMWUAb2F9W/aLAAPxVp7gbYOsHwhzHmklihKZKz1iYKqMc0nhH8MTzFAj2TWz
         9xWykJ1i4eqhXowCsmY5+Pb2imbW7ndOrCqJj0AhlcYUZWc2fM8SFbWmV5Gte5H6oK/o
         wsONGv6PTAx5/qBKfaCIO8ERQNlXEq5GksFImGiebOV0AQD7/kwtfiXWUN4QZI+3hAAO
         tjK97CDd2UBItx8Xm5ZRYyk2/tKcjk8aqBP4ZvTYMhYZcR63fDW9C2w2pIEr3+IllEXS
         v2Xw==
X-Gm-Message-State: AO0yUKUYyolz3rLTa3q+CWKtM8y1t4BHiaYqEjAyV8wMiS0dQiACgIJZ
        RZgo6LBofPV6/M1vPWB9kyGH9Q==
X-Google-Smtp-Source: AK7set+lRsaObCn+ZgF11fgL9DZNL3NUt7U2STF/fjpMDMlXzzDQryX15MIPJUmFhMoE/z2CSL4taA==
X-Received: by 2002:a05:622a:1a88:b0:3b8:588c:40e9 with SMTP id s8-20020a05622a1a8800b003b8588c40e9mr1090682qtc.19.1678900175736;
        Wed, 15 Mar 2023 10:09:35 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id 185-20020a3706c2000000b0071f0d0aaef7sm4157265qkg.80.2023.03.15.10.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:09:35 -0700 (PDT)
Date:   Wed, 15 Mar 2023 13:09:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        andres@anarazel.de, kernel-team@meta.com
Subject: Re: [PATCH v11 0/3] cachestat: a new syscall for page cache state of
 files
Message-ID: <20230315170934.GA97793@cmpxchg.org>
References: <20230308032748.609510-1-nphamcs@gmail.com>
 <20230314160041.960ede03d5f5ff3dbb3e3fd0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314160041.960ede03d5f5ff3dbb3e3fd0@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Mar 14, 2023 at 04:00:41PM -0700, Andrew Morton wrote:
> On Tue,  7 Mar 2023 19:27:45 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
> 
> > There is currently no good way to query the page cache state of large
> > file sets and directory trees. There is mincore(), but it scales poorly:
> > the kernel writes out a lot of bitmap data that userspace has to
> > aggregate, when the user really doesn not care about per-page information
> > in that case. The user also needs to mmap and unmap each file as it goes
> > along, which can be quite slow as well.
> 
> A while ago I asked about the security implications - could cachestat()
> be used to figure out what parts of a file another user is reading. 
> This also applies to mincore(), but cachestat() newly permits user A to
> work out which parts of a file user B has *written* to.

The caller of cachestat() must have the file open for reading. If they
can read the contents that B has written, is the fact that they can
see dirty state really a concern?

Nhat and I were discussing this offlist at the time, but weren't
creative enough to come up with an abuse scenario.

> I don't recall seeing a response to this, and there is no discussion in
> the changelogs.

It might have drowned in the noise, but he did reply:

https://lore.kernel.org/lkml/CAKEwX=Ppf=WbOuV2Rh3+V8ohOYXo=CnfSu9qqSh-DpVvfy2nhA@mail.gmail.com/

> Secondly, I'm not seeing description of any use cases.  OK, it's faster
> and better than mincore(), but who cares?  In other words, what
> end-user value compels us to add this feature to Linux?

Years ago there was a thread about adding dirty bits to mincore(), I
don't know if you remember this:

https://lkml.org/lkml/2013/2/10/162

In that thread, Rusty described a usecase of maintaining a journaling
file alongside a main file. The idea for testing the dirty state isn't
to call sync but to see whether the journal needs to be updated.

The efficiency of mincore() was touched on too. Andres Freund (CC'd,
hopefully I got the email address right) mentioned that Postgres has a
usecase for deciding whether to do an index scan or query tables
directly, based on whether the index is cached. Postgres works with
files rather than memory regions, and Andres mentioned that the index
could be quite large. The consensus was that having to go through
mmap(), and getting a bytemap representing each page when all you need
is a summary for the queried range, was too painful in practice.

Most recently, the database team at Meta reached out to us and asked
about the ability to query dirty state again. The motivation for this
was twofold. One was simply visibility into the writeback algorithm,
i.e. trying to figure out what it's doing when investigating
performance problems.

The second usecase they brought up was to advise writeback from
userspace to manage the tradeoff between integrity and IO utilization:
if IO capacity is available, sync more frequently; if not, let the
work batch up. Blindly syncing through the file in chunks doesn't work
because you don't know in advance how much IO they'll end up doing (or
how much they've done, afterwards.) So it's difficult to build an
algorithm that will reasonably pace through sparsely dirtied regions
without the risk of overwhelming the IO device on dense ones. And it's
not straight-forward to do this from the kernel, since it doesn't know
the IO headroom the application needs for reading (which is dynamic).

The page cache is often the biggest memory consumer, and so the kernel
heuristics that manage it have a big impact on performance. We have a
rich interface to augment those heuristics with fadvise and the sync
family, but it's not a stretch to say that it's difficult to use them
if you cannot get good insights into what the other hand is doing.

Another query we get almost monthly is service owners trying to
understand where their memory is going and what's causing unexpected
pressure on a host. They see the cache in vmstat, but between a
complex application, shared libraries or a runtime (jvm, hhvm etc.)
and a myriad of host management agents, there is so much going on on
the machine that it's hard to find out who is touching which
files. When it comes to disk usage, the kernel provides the ability to
quickly stat entire filesystem subtrees and drill down with tools like
du. It sure would be useful to have the same for memory usage.

Our current cache interface is seriously lacking in that regard.

It would be great to have a stable, canonical and versatile interface
to inspect what the cache is doing. One that blends in with the
broader VFS and buffered IO interface: an easy to discover, easy to
use syscall (not an obscure tracepoint or fcntl or a drgn script); an
fd instead of a vma; a VFS-based permission model; efficient handling
of the wide range of file sizes that exist in the real world.

cachestat() fits that bill.

> >    struct cachestat {
> >	        __u64 nr_cache;
> >	        __u64 nr_dirty;
> >	        __u64 nr_writeback;
> >	        __u64 nr_evicted;
> >	        __u64 nr_recently_evicted;
> >    };
> 
> And these fields are really getting into the weedy details of internal
> kernel implementation.  Bear in mind that we must support this API for
> ever.
> 
> Particularly the "evicted" things.  The workingset code was implemented
> eight years ago, which is actually relatively recent.  It could be that
> eight years from now it will have been removed and possibly replaced
> workingset with something else.  Then what do we do?

;) I'm definitely biased here, but I don't think it's realistic that
we'd ever go back to a cache that doesn't maintain *some* form of
non-residency information.

We now have two reclaim implementations that rely on it at its
core. And psi is designed around the concept of initial faults vs
refaults; that's an ABI we have to maintain indefinitely anyway, and
is widely used for OOM killing and load shedding in datacenters, on
Android, by all systemd-based installations etc.

It seems unlikely that this is a fluke. But even if I'm completely
wrong about that, I think we have options that wouldn't spell the end
of the world. We could report 0 for those fields and be perfectly
backward compatible. There is a flags field that allows versioning of
struct cachestat, too.

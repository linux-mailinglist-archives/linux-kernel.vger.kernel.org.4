Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC96F62EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEDC0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDC0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:26:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631511B1;
        Wed,  3 May 2023 19:26:09 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7515631b965so458344785a.0;
        Wed, 03 May 2023 19:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683167168; x=1685759168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLDTYk0tPVXVsplJLhLm6jmpkxTtu8RLOaQ4cLfMe5g=;
        b=P/HogoDovJW1+0CFh3o4honx3WNft5BSdMnqQj3thmzIaWqEDHhtlWtsnL+9NbxTPd
         6D8wSZjPHjXapbNNG9aUYoBfCb7XS+90s4uLTzLSdJJP6Xyri+qXTpATQuxrqmoH369P
         ufj8u2HIi7vKqFJIXQJrHomnk4YJ+BGlAUAA9dObaOalofmkGakKT0SW7ue7o65W0xKr
         POYi/6DQJbfSi/kwaTfaHjlNi+f4UanZULAgxBslCqgOMqOb+/5uZQpp9chkLc+6VvoU
         WxFOUXDQHQA/FVI6/appITim0QKFuCVc7fRKq1Kldujy7Bh2prvMpxmgQU/668o2hyk0
         WXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683167168; x=1685759168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLDTYk0tPVXVsplJLhLm6jmpkxTtu8RLOaQ4cLfMe5g=;
        b=OBYYr028gxaMcruDLrstR9CNsv26IlH81jXW3GtbX6JBjjQ1eoO9bCqMh89SDhRiX/
         NcIuECc7pzrwdLw7EwZa42bs+s3hI58RX9e84FFBR1mG0qB+PbQaFdeANIixyseVpHWx
         O7QCbIg5gLn0Yb+BDCLdoYePI/WWtYOM+JwXDKcCt006aHNoQzK84lmZ9tqvSfd9AbsH
         PsnbjpksxipWM30+XWXIFw1ixKVoVjKfo456YM/C2m13XjgYudERc1DBDimGawlezABj
         r2rDtDNCRHnIMi/e4LA0BP/ZjOeHFIYMpgHROGekGxV0I6lqsD6sQVsZijGSR9zfStU5
         lthA==
X-Gm-Message-State: AC+VfDwsaVxXxRAiywBpoO7Tw6CNYBj/Vn2Z3ClRQ/EMUyhesWZjDfYL
        hqkPxVvicj9mtIvjkGBUMpXYXfL8fUtCukjMHRhd1oJmUHFDkg==
X-Google-Smtp-Source: ACHHUZ47HhYCWR/yoFvokIBjkNXhGc1mPF6wLj1BeAqMU75woOkThHbHQRw2BNWoHTvF+WSjv6mmCR8ZIes8wjt/NYA=
X-Received: by 2002:ad4:5b8b:0:b0:5ad:45f2:4307 with SMTP id
 11-20020ad45b8b000000b005ad45f24307mr5025757qvp.11.1683167168408; Wed, 03 May
 2023 19:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230503013608.2431726-1-nphamcs@gmail.com> <20230503013608.2431726-3-nphamcs@gmail.com>
 <20230503150425.GC193380@cmpxchg.org>
In-Reply-To: <20230503150425.GC193380@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 3 May 2023 19:25:57 -0700
Message-ID: <CAKEwX=MmC-5wY2u25YY9WupGLfZrY2V=VGYAZHJqSSdzT9yO3w@mail.gmail.com>
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 8:04=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Tue, May 02, 2023 at 06:36:07PM -0700, Nhat Pham wrote:
> > There is currently no good way to query the page cache state of large
> > file sets and directory trees. There is mincore(), but it scales poorly=
:
> > the kernel writes out a lot of bitmap data that userspace has to
> > aggregate, when the user really doesn not care about per-page
> > information in that case. The user also needs to mmap and unmap each
> > file as it goes along, which can be quite slow as well.
> >
> > Some use cases where this information could come in handy:
> >   * Allowing database to decide whether to perform an index scan or
> >     direct table queries based on the in-memory cache state of the
> >     index.
> >   * Visibility into the writeback algorithm, for performance issues
> >     diagnostic.
> >   * Workload-aware writeback pacing: estimating IO fulfilled by page
> >     cache (and IO to be done) within a range of a file, allowing for
> >     more frequent syncing when and where there is IO capacity, and
> >     batching when there is not.
> >   * Computing memory usage of large files/directory trees, analogous to
> >     the du tool for disk usage.
> >
> > More information about these use cases could be found in the following
> > thread:
> >
> > https://lore.kernel.org/lkml/20230315170934.GA97793@cmpxchg.org/
> >
> > This patch implements a new syscall that queries cache state of a file
> > and summarizes the number of cached pages, number of dirty pages, numbe=
r
> > of pages marked for writeback, number of (recently) evicted pages, etc.
> > in a given range. Currently, the syscall is only wired in for x86
> > architecture.
> >
> > NAME
> >     cachestat - query the page cache statistics of a file.
> >
> > SYNOPSIS
> >     #include <sys/mman.h>
> >
> >     struct cachestat_range {
> >         __u64 off;
> >         __u64 len;
> >     };
> >
> >     struct cachestat {
> >         __u64 nr_cache;
> >         __u64 nr_dirty;
> >         __u64 nr_writeback;
> >         __u64 nr_evicted;
> >         __u64 nr_recently_evicted;
> >     };
> >
> >     int cachestat(unsigned int fd, struct cachestat_range *cstat_range,
> >         struct cachestat *cstat, unsigned int flags);
> >
> > DESCRIPTION
> >     cachestat() queries the number of cached pages, number of dirty
> >     pages, number of pages marked for writeback, number of evicted
> >     pages, number of recently evicted pages, in the bytes range given b=
y
> >     `off` and `len`.
> >
> >     An evicted page is a page that is previously in the page cache but
> >     has been evicted since. A page is recently evicted if its last
> >     eviction was recent enough that its reentry to the cache would
> >     indicate that it is actively being used by the system, and that
> >     there is memory pressure on the system.
> >
> >     These values are returned in a cachestat struct, whose address is
> >     given by the `cstat` argument.
> >
> >     The `off` and `len` arguments must be non-negative integers. If
> >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` =
=3D=3D
> >     0, we will query in the range from `off` to the end of the file.
> >
> >     The `flags` argument is unused for now, but is included for future
> >     extensibility. User should pass 0 (i.e no flag specified).
> >
> >     Currently, hugetlbfs is not supported.
> >
> >     Because the status of a page can change after cachestat() checks it
> >     but before it returns to the application, the returned values may
> >     contain stale information.
> >
> > RETURN VALUE
> >     On success, cachestat returns 0. On error, -1 is returned, and errn=
o
> >     is set to indicate the error.
> >
> > ERRORS
> >     EFAULT cstat or cstat_args points to an invalid address.
> >
> >     EINVAL invalid flags.
> >
> >     EBADF  invalid file descriptor.
> >
> >     EOPNOTSUPP file descriptor is of a hugetlbfs file
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Thanks for persisting through the pain. This looks great to me now.
>
> Like I've said before, I think this is sorely needed. The cache is
> frequently the biggest memory consumer in the system. We have a rich
> API for influencing it, but there is a glaring gap when it comes to
> introspection. It's difficult to design control loops without
> feedback. This proposes an intuitive, versatile and scalable interface
> to bridge that gap, and it integrates nicely with the existing VFS API
> for managing the cache. I would love to see this go in.
>
> I'd also love for the `mu' tool you wrote to make it into coreutils
> eventually. It would make debugging memory consumption and writeback
> issues on live systems, especially with complex and/or multiple
> workloads, so much easier.
I'd love to share this too! Let me clean it up and submit it separately.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

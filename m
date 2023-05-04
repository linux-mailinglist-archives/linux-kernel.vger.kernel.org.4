Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5116F70D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEDR02 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 May 2023 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:26:26 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD1449C;
        Thu,  4 May 2023 10:26:25 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a44a2637bso10475227b3.2;
        Thu, 04 May 2023 10:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221184; x=1685813184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rnIRd9cvXtgtMC0ZOKTG1aj8pR1h+8CjVNfvekskoI=;
        b=hhF/QmnrdYxeA532+SQ4SaTc8OPLBt+bHBiUo6zQkHpUEWjgfIg6IMIgE9RyBk1FvN
         M6n2FvdPL5bMMhELOctbp1kwpBDEFiUEMeiSpPKT3D/+lswcxfbpu5U2VSZFl5vEb5tS
         BiG8SzwywSpOm6aOn40ERN7S0gMLPY2raahVMBm0wNdIU/DBaXdqLQM/TlkFH29l73kV
         i8mjIGJgygTJaSJHXmwnBGkqIplFteJ6/Slj+ErF6x3hk1n9fOKvi7CS2lT40gXHvjnZ
         mAGrHv3ngCn8V5mTgEGTS+j38fCiAfYg51uZ1tpzdSfKIG/vUd0vRDSNPevC6xwCFvCK
         2Fyw==
X-Gm-Message-State: AC+VfDxldtCWJUhPhiVKWDUT+vnbM+bCsLMrhy5awNdAnSn4qHkGQ7FW
        GA+xk0/o88ByqCM1nVzp3B3kXIdAc3uYOg==
X-Google-Smtp-Source: ACHHUZ4vYY7SkCmBy6UlJO4C++XMn+OLhxvsmkJ6vShevVhBtUib6RTtkjKdp1tf3nf00T72WC+QOQ==
X-Received: by 2002:a0d:d40f:0:b0:55a:5dce:aa19 with SMTP id w15-20020a0dd40f000000b0055a5dceaa19mr3323271ywd.51.1683221184444;
        Thu, 04 May 2023 10:26:24 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z11-20020a81c20b000000b0055d6c72731esm703255ywc.144.2023.05.04.10.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:26:23 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so1045906276.0;
        Thu, 04 May 2023 10:26:23 -0700 (PDT)
X-Received: by 2002:a25:dd07:0:b0:b8f:227a:b080 with SMTP id
 u7-20020a25dd07000000b00b8f227ab080mr724998ybg.18.1683221183312; Thu, 04 May
 2023 10:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230503013608.2431726-1-nphamcs@gmail.com> <20230503013608.2431726-3-nphamcs@gmail.com>
In-Reply-To: <20230503013608.2431726-3-nphamcs@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 May 2023 19:26:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
Message-ID: <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

On Wed, May 3, 2023 at 3:38 AM Nhat Pham <nphamcs@gmail.com> wrote:
> There is currently no good way to query the page cache state of large
> file sets and directory trees. There is mincore(), but it scales poorly:
> the kernel writes out a lot of bitmap data that userspace has to
> aggregate, when the user really doesn not care about per-page
> information in that case. The user also needs to mmap and unmap each
> file as it goes along, which can be quite slow as well.
>
> Some use cases where this information could come in handy:
>   * Allowing database to decide whether to perform an index scan or
>     direct table queries based on the in-memory cache state of the
>     index.
>   * Visibility into the writeback algorithm, for performance issues
>     diagnostic.
>   * Workload-aware writeback pacing: estimating IO fulfilled by page
>     cache (and IO to be done) within a range of a file, allowing for
>     more frequent syncing when and where there is IO capacity, and
>     batching when there is not.
>   * Computing memory usage of large files/directory trees, analogous to
>     the du tool for disk usage.
>
> More information about these use cases could be found in the following
> thread:
>
> https://lore.kernel.org/lkml/20230315170934.GA97793@cmpxchg.org/
>
> This patch implements a new syscall that queries cache state of a file
> and summarizes the number of cached pages, number of dirty pages, number
> of pages marked for writeback, number of (recently) evicted pages, etc.
> in a given range. Currently, the syscall is only wired in for x86
> architecture.
>
> NAME
>     cachestat - query the page cache statistics of a file.
>
> SYNOPSIS
>     #include <sys/mman.h>
>
>     struct cachestat_range {
>         __u64 off;
>         __u64 len;
>     };
>
>     struct cachestat {
>         __u64 nr_cache;
>         __u64 nr_dirty;
>         __u64 nr_writeback;
>         __u64 nr_evicted;
>         __u64 nr_recently_evicted;
>     };
>
>     int cachestat(unsigned int fd, struct cachestat_range *cstat_range,
>         struct cachestat *cstat, unsigned int flags);
>
> DESCRIPTION
>     cachestat() queries the number of cached pages, number of dirty
>     pages, number of pages marked for writeback, number of evicted
>     pages, number of recently evicted pages, in the bytes range given by
>     `off` and `len`.
>
>     An evicted page is a page that is previously in the page cache but
>     has been evicted since. A page is recently evicted if its last
>     eviction was recent enough that its reentry to the cache would
>     indicate that it is actively being used by the system, and that
>     there is memory pressure on the system.
>
>     These values are returned in a cachestat struct, whose address is
>     given by the `cstat` argument.
>
>     The `off` and `len` arguments must be non-negative integers. If
>     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
>     0, we will query in the range from `off` to the end of the file.
>
>     The `flags` argument is unused for now, but is included for future
>     extensibility. User should pass 0 (i.e no flag specified).
>
>     Currently, hugetlbfs is not supported.
>
>     Because the status of a page can change after cachestat() checks it
>     but before it returns to the application, the returned values may
>     contain stale information.
>
> RETURN VALUE
>     On success, cachestat returns 0. On error, -1 is returned, and errno
>     is set to indicate the error.
>
> ERRORS
>     EFAULT cstat or cstat_args points to an invalid address.
>
>     EINVAL invalid flags.
>
>     EBADF  invalid file descriptor.
>
>     EOPNOTSUPP file descriptor is of a hugetlbfs file
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +

This should be wired up on each and every architecture.
Currently we're getting

    <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]

in linux-next for all the missing architectures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

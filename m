Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602AD66933A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjAMJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbjAMJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:47:16 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699F4FD63
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:36:11 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id g9so3998347qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfYWOGUw6JcZk6BCbCEfYG54SLYJu12x8TR2uJqxvmU=;
        b=lba8i3MlJTJwJPCZlDXGAbD/pMwI0YVnbcvwe7FxYMKYbG0WZmNcPlFvwZn9INgVPH
         R5dP1UbUFUkNzXHrtaluXitfQ5cfpmzd8tOFcY1qD12OYmxE1ZPCHXFCA5iisGmo/Otg
         XQCuhIL/fcFVtLlxR0fAUT+IVZUX3GPR7sEXVC97qn2FYBrJsWgsGtsmxADP/HqBV/ME
         3vOYBS/Y+XM73FkH0HhraEB+pO52cdTjtocPs0cJD5tfWRDEEaZKGkJswBBpA9zclaW1
         45V9QJ6Axu/O4kpCcu7FUsSIz3vQFpCKg0AlQ0u6qzC47vr7YVTy5JLY3v3fzIDl+UtN
         wcxQ==
X-Gm-Message-State: AFqh2kqhBoQu3n88IUK17owZyoEesXKokkOVc9U9Wf0dbE5R9k4Adml4
        Aal25FR7xMFPMEFtnflJBjzoToeUpcuUiA==
X-Google-Smtp-Source: AMrXdXs/TVzGk0fBJGObs8+isZe7HI+Fledm2tkfIpg5lharTdsA5Abx7m945KzVgTYNF+4AmRPkUw==
X-Received: by 2002:a05:622a:4a15:b0:3af:b6bd:aba7 with SMTP id fv21-20020a05622a4a1500b003afb6bdaba7mr18333943qtb.43.1673602569925;
        Fri, 13 Jan 2023 01:36:09 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b0070383f1b6f1sm12495037qkp.31.2023.01.13.01.36.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:36:09 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-4c24993965eso270265387b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:36:09 -0800 (PST)
X-Received: by 2002:a0d:d98c:0:b0:4dd:7a8e:1cf3 with SMTP id
 b134-20020a0dd98c000000b004dd7a8e1cf3mr249079ywe.384.1673602568857; Fri, 13
 Jan 2023 01:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20230104231127.2634648-1-nphamcs@gmail.com> <20230104231127.2634648-3-nphamcs@gmail.com>
In-Reply-To: <20230104231127.2634648-3-nphamcs@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jan 2023 10:35:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXObtC0_US+fpc9Wq0SEHGcmLfVb19F55SF6x=yMKD4UQ@mail.gmail.com>
Message-ID: <CAMuHMdXObtC0_US+fpc9Wq0SEHGcmLfVb19F55SF6x=yMKD4UQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] cachestat: implement cachestat syscall
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 12:13 AM Nhat Pham <nphamcs@gmail.com> wrote:
> Implement a new syscall that queries cache state of a file and
> summarizes the number of cached pages, number of dirty pages, number of
> pages marked for writeback, number of (recently) evicted pages, etc. in
> a given range.
>
> NAME
>     cachestat - query the page cache statistics of a file.
>
> SYNOPSIS
>     #include <sys/mman.h>
>
>     struct cachestat {
>         __u64 nr_cache;
>         __u64 nr_dirty;
>         __u64 nr_writeback;
>         __u64 nr_evicted;
>         __u64 nr_recently_evicted;
>     };
>
>     int cachestat(unsigned int fd, off_t off, size_t len,
>           size_t cstat_size, struct cachestat *cstat,
>           unsigned int flags);
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
>     `cstat_size` allows users to obtain partial results. The syscall
>     will copy the first `csstat_size` bytes to the specified userspace
>     memory. `cstat_size` must be a non-negative value that is no larger
>     than the current size of the cachestat struct.
>
>     The `flags` argument is unused for now, but is included for future
>     extensibility. User should pass 0 (i.e no flag specified).
>
> RETURN VALUE
>     On success, cachestat returns 0. On error, -1 is returned, and errno
>     is set to indicate the error.
>
> ERRORS
>     EFAULT cstat points to an invalid address.
>
>     EINVAL invalid `cstat_size` or `flags`
>
>     EBADF  invalid file descriptor.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

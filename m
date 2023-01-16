Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4B66BB48
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjAPKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAPKJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:09:47 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD51C315
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:09:07 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id j9so1461441qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kDLEtq+nWxDSi+y0oUmLdJdW5VKXAcidnDmusHhhfQ=;
        b=Hok9ncU+nMu6MjUJ4LsjoP5FuuvFnAsf5kMoyEtcouN1sqm/NdbdOiiranEPuTFm9j
         sV6V5+V+aErAaqw8qCnx0KwQn6imvL1QsxM9JGS5xvbiaLbDyA/aqnh7Cd9qxfGdVzDS
         nA+IKoECh+ANBSG5bXtMu2MsVhEmWzXP3UlELNWiR0NDtIMoBO0S/eIVjs1Ayk7h8PUU
         /yz+nC0lvddJ0YaYPRMhhFLk7Ii5Q1vKDMJ06dFLEOSX+S52OkhgJizS27juq0Y0bPhc
         Za2tAUFfCeiVFX4dB1A/qMJ4iGWSqRxm4AjqBFXeqALL3CukPTGUtctxlCM9URFY2MPA
         kieA==
X-Gm-Message-State: AFqh2kqZHGmnPA2S+UtzvhhEtanr755GLRiF3S0rVMWdyqNcPbCYZWDm
        cpCFSL04M6gBdtnWkbpaiJa62WiPzTo5wg==
X-Google-Smtp-Source: AMrXdXsrB+U/4SZMTO4y/UX5ugnPXnlMHnTQ4Hg2tAIgbsJbE5g1CXA4mDdDkEkrdYKcfHON+dZ+XQ==
X-Received: by 2002:ac8:4657:0:b0:3a9:2478:2d70 with SMTP id f23-20020ac84657000000b003a924782d70mr140152749qto.24.1673863745897;
        Mon, 16 Jan 2023 02:09:05 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id d6-20020a37b406000000b007049f19c736sm17610125qkf.7.2023.01.16.02.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:09:05 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id a9so13005426ybb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:09:05 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:7b4:6a33:d89f with SMTP id
 p75-20020a25d84e000000b007b46a33d89fmr2918676ybg.543.1673863745031; Mon, 16
 Jan 2023 02:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20221208202808.908690-1-nphamcs@gmail.com> <20221208202808.908690-4-nphamcs@gmail.com>
In-Reply-To: <20221208202808.908690-4-nphamcs@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 11:08:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgi_V9JwMgMdPQu5+E76PjFrsGXRRxJNvGnfbnQxEq8A@mail.gmail.com>
Message-ID: <CAMuHMdUgi_V9JwMgMdPQu5+E76PjFrsGXRRxJNvGnfbnQxEq8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cachestat: implement cachestat syscall
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 9:42 PM Nhat Pham <nphamcs@gmail.com> wrote:
> Implement a new syscall that queries cache state of a file and
> summarizes the number of cached pages, number of dirty pages, number of
> pages marked for writeback, number of (recently) evicted pages, etc. in
> a given range.
>
> NAME
>     cachestat - query the page cache status of a file.
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
>     pages, number of pages marked for writeback, number of (recently)
>     evicted pages, in the bytes range given by `off` and `len`.
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

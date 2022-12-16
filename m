Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50FA64F378
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLPVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLPVsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:48:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60BD2CE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0953B81E3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 21:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF64C433EF;
        Fri, 16 Dec 2022 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671227295;
        bh=4si32cFtPatYVk2GoZlXa5/Q/bdn4eAB7DegYBPJzu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oOPiGGCq+TN077B/wlGYAoiaPw9ZU55dRNLHSilQ7XKti0vvwP0OmKix+V72nxOif
         cMe0GLbSDHG2tied26vv/ez4F/QxkrBAveOGrlDXfUXLyoyu0JCJ3jzFJkRFjw200O
         oE/nBDaHJAS66i0W6kZSEbcOIHabT9AwAMPoPIsY=
Date:   Fri, 16 Dec 2022 13:48:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/4] cachestat: implement cachestat syscall
Message-Id: <20221216134814.61c8d5119ceb4179c68e1cd7@linux-foundation.org>
In-Reply-To: <20221216192149.3902877-4-nphamcs@gmail.com>
References: <20221216192149.3902877-1-nphamcs@gmail.com>
        <20221216192149.3902877-4-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 11:21:48 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

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

I suggest this be spelled out better: "number of evicted and number or
recently evicted pages".

I suggest this clearly tell readers what an "evicted" page is - they
aren't kernel programmers!

What is the benefit of the "recently evicted" pages?  "recently" seems
very vague - what use is this to anyone?

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

Why is `flags' here?  We could add an unused flags arg to any syscall,
but we don't.  What's the plan?


Are there security implications?  If I know that some process has a
file open, I can use cachestat() to infer which parts of that file
they're looking at (like mincore(), I guess).  And I can infer which
parts they're writing to, unlike mincore().


I suggest the [patch 1/4] fixup be separated from this series.



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224E36F5A96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjECPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjECPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:04:30 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD6C5580
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:04:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f0b299d739so24951751cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683126267; x=1685718267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4aOFB0vWadOlRxqaa5gQV4EPY0CVi95TspUPmGHw4o=;
        b=Tvwca5J/S0KrTfmL1A8cX6mdaxiM4nWALAlT/vfwl/KuaMb4GC21Nvz5/usoglkn60
         srpn6dJS1RafPdvbGasRf/DjHExh22qlNFZ4rU7WLxo2lIxHdoI6WLTsV3akExDXj98m
         o+6Elwrsqr8JNZ3lMrvWB3iZQsdyCk+gNsVCh+A7mkwKsslAOAhEcP2gH2xL6x8sKhWm
         +mruhJlc3b2X1u52AGi3XSf2/M2gJ2uWaJBxUbUSx+oE2miVd13iQOuHvXlUkNGbCywy
         mMtFwvzIGuir68YaNnGyXW7kvAzOYlGLEwArmwO8uYxPQ+IYqvmGFoxrLvLLoBrpdhy/
         gyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126267; x=1685718267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4aOFB0vWadOlRxqaa5gQV4EPY0CVi95TspUPmGHw4o=;
        b=Riptk19LvMmD6zYk/H5kfpNa/4JURDvWSyv9GOkxTDvDbDCfcnIs8OQKhLF66/Ni36
         8fs1O9/1V5bG6FjWoYe9mv3RrB7YONCWNTcaV3oJBkomWzqkAlKPtBK8PxlZoW0vc+xt
         lFyDj4feS9jYhfzm5pOETPZyvsXpU9Zd7HQijbzMhlQBvU/qx4JHHJ7NUSNezf/AfwC5
         oFcJMg6i0dLXVmHYtDcfR81jJS89R9ZMR2veNAYFsVp2T9Ib94AqhVJZgN8lpBkF0mVR
         nFAQUWjXvZcjP7/MO5XhGoB9Vp5/lKesCBgppDi2+82YNU5uH+6nGQWAM7+j2UDb8uP5
         89uw==
X-Gm-Message-State: AC+VfDw8k6YFd/iEVTGcHZP8z72FhXUg0jj8BVuWfJTcqgRUwxlXBCJ6
        Ijnf3k8EuLfyEMeAO0WBd1h5wg==
X-Google-Smtp-Source: ACHHUZ51unN/hWjZ8WcB3kNfIzft/QaAVdfmBiihtP/FlEZVeXnOmHp7eTaNnRogS2+X/UZoI1iyAg==
X-Received: by 2002:ac8:4e8b:0:b0:3ef:57c1:ad7 with SMTP id 11-20020ac84e8b000000b003ef57c10ad7mr721807qtp.30.1683126267047;
        Wed, 03 May 2023 08:04:27 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id ge8-20020a05622a5c8800b003e3914c6839sm8742441qtb.43.2023.05.03.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:04:26 -0700 (PDT)
Date:   Wed, 3 May 2023 11:04:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
Message-ID: <20230503150425.GC193380@cmpxchg.org>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
 <20230503013608.2431726-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503013608.2431726-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 06:36:07PM -0700, Nhat Pham wrote:
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

Thanks for persisting through the pain. This looks great to me now.

Like I've said before, I think this is sorely needed. The cache is
frequently the biggest memory consumer in the system. We have a rich
API for influencing it, but there is a glaring gap when it comes to
introspection. It's difficult to design control loops without
feedback. This proposes an intuitive, versatile and scalable interface
to bridge that gap, and it integrates nicely with the existing VFS API
for managing the cache. I would love to see this go in.

I'd also love for the `mu' tool you wrote to make it into coreutils
eventually. It would make debugging memory consumption and writeback
issues on live systems, especially with complex and/or multiple
workloads, so much easier.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

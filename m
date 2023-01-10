Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AD66432A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjAJOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbjAJOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229255E67C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673360491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I09tRp6zdZi/ub/P22Gc5q2mZ7cWTO2lX7+uoGwzZqg=;
        b=Wlcv0GNk1KWP7uXainyCpBc9sD8wDy4SN6xeyLfdLpcmWirvyptEHoQjnJ4lP2EUXx/acs
        wmshTq5Df8ZBYaSrnMJX8fqjlfcXcAsOLKl70uCPeJSSeirTt7Oy8j93xqBDwuiiiZ3R+X
        2f7hxIHEFGpEjXEaSIWJDhwST4PHARc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-MeSPptylN4KAzvEhm7OCdQ-1; Tue, 10 Jan 2023 09:21:30 -0500
X-MC-Unique: MeSPptylN4KAzvEhm7OCdQ-1
Received: by mail-yb1-f197.google.com with SMTP id 81-20020a250b54000000b007c002e178dfso3853638ybl.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I09tRp6zdZi/ub/P22Gc5q2mZ7cWTO2lX7+uoGwzZqg=;
        b=4l1KRqN9BZ8ATwa6sTxcQKusRFLXdZjA6Vwqqd5ZKV21bN40HJlsS1ybYfQcyK0b21
         bCs0+N6z3LGIXcFE2YH24yI/06BNn8qDjCL7ykVboTijSQHH+j/COu5RbOPgy02N1mKB
         DVuhcKfdsgLmoQTaEQR3msBqrFPWegjWL9oflWI8E+dXVMQ/780bcbiZ0YSj9m50VSjl
         MrxgbzJUZQRWfDdr+SB2VZ1uxTYy1oIMkN/+oi0zJJFcZymF6pA0onRkd4mgcQEeQDeI
         oGtyHU7E3kvSj5PUSE4qaVMVsSBRLkdmtQ7S04EATOqk8u+omrEvHfZGVDzmS+e9wDP7
         CHXg==
X-Gm-Message-State: AFqh2kp0bQ5Ow6eP7y4LFDszywq2dnANoMmvPNCdatb2GQ4ss43xGHbB
        ABo/HcEg0R6IC4oWsxuWH5DQH8s3AiYWSi2/O7egmTbAlaSstGcKdl7Cz+NahkWrJMsjqqcmmdW
        hNq04U+TZZ5JKOkqE7q+aeSMz
X-Received: by 2002:a05:7500:5c92:b0:f0:401b:6d0e with SMTP id fh18-20020a0575005c9200b000f0401b6d0emr595490gab.22.1673360488503;
        Tue, 10 Jan 2023 06:21:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu0suqD6JUejg/bP+LLxlqm+8/NhlapFl+BQRsKWPzq2pn6o1g8ft2fkGiYEy6xXkAbSWzAKA==
X-Received: by 2002:a05:7500:5c92:b0:f0:401b:6d0e with SMTP id fh18-20020a0575005c9200b000f0401b6d0emr595479gab.22.1673360488073;
        Tue, 10 Jan 2023 06:21:28 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id y22-20020a37f616000000b006fef61300fesm7143852qkj.16.2023.01.10.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:21:27 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:22:28 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
Subject: Re: [PATCH v5 2/3] cachestat: implement cachestat syscall
Message-ID: <Y710pFYI8rBX9Eqe@bfoster>
References: <20230104231127.2634648-1-nphamcs@gmail.com>
 <20230104231127.2634648-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104231127.2634648-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 03:11:26PM -0800, Nhat Pham wrote:
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
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
>  include/linux/fs.h                          |   3 +
>  include/linux/syscalls.h                    |   3 +
>  include/uapi/asm-generic/unistd.h           |   5 +-
>  include/uapi/linux/mman.h                   |   9 ++
>  init/Kconfig                                |  10 ++
>  kernel/sys_ni.c                             |   1 +
>  mm/filemap.c                                | 143 ++++++++++++++++++++
>  20 files changed, 186 insertions(+), 1 deletion(-)
> 
...
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 08341616ae7a..d70d47b20700 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
...
> @@ -3949,3 +3953,142 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
>  	return try_to_free_buffers(folio);
>  }
>  EXPORT_SYMBOL(filemap_release_folio);
...
> +#ifdef CONFIG_CACHESTAT_SYSCALL
> +/*
> + * The cachestat(5) system call.
> + *
> + * cachestat() returns the page cache statistics of a file in the
> + * bytes range specified by `off` and `len`: number of cached pages,
> + * number of dirty pages, number of pages marked for writeback,
> + * number of evicted pages, and number of recently evicted pages.
> + *
> + * An evicted page is a page that is previously in the page cache
> + * but has been evicted since. A page is recently evicted if its last
> + * eviction was recent enough that its reentry to the cache would
> + * indicate that it is actively being used by the system, and that
> + * there is memory pressure on the system.
> + *
> + * `off` and `len` must be non-negative integers. If `len` > 0,
> + * the queried range is [`off`, `off` + `len`]. If `len` == 0,
> + * we will query in the range from `off` to the end of the file.
> + *
> + * `cstat_size` allows users to obtain partial results. The syscall
> + * will copy the first `csstat_size` bytes to the specified userspace
> + * memory. It also makes the cachestat struct extensible - new fields
> + * can be added in the future without breaking existing usage.
> + * `cstat_size` must be a non-negative value that is no larger than
> + * the current size of the cachestat struct.
> + *
> + * The `flags` argument is unused for now, but is included for future
> + * extensibility. User should pass 0 (i.e no flag specified).
> + *
> + * Because the status of a page can change after cachestat() checks it
> + * but before it returns to the application, the returned values may
> + * contain stale information.
> + *
> + * return values:
> + *  zero    - success
> + *  -EFAULT - cstat points to an illegal address
> + *  -EINVAL - invalid arguments
> + *  -EBADF	- invalid file descriptor
> + */
> +SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
> +		size_t, cstat_size, struct cachestat __user *, cstat,
> +		unsigned int, flags)
> +{
> +	struct fd f = fdget(fd);
> +	struct address_space *mapping;
> +	struct cachestat cs;
> +	pgoff_t first_index = off >> PAGE_SHIFT;
> +	pgoff_t last_index =
> +		len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> +
> +	if (off < 0 || cstat_size > sizeof(struct cachestat) || flags != 0)
> +		return -EINVAL;
> +
> +	if (!f.file)
> +		return -EBADF;
> +

It looks like we miss an fdput() before returning via the above error
checks.

The only other thing that stands out as a bit odd to me is the
cstat_size check and associated ability to return a partial cachestat
struct. Do other syscalls do anything like that? I'd think we'd want to
ensure we always at least return a fully populated cachestat struct,
even if it happened to be an old/compat version if the size does ever
increase. Hm?

Brian

> +	memset(&cs, 0, sizeof(struct cachestat));
> +	mapping = f.file->f_mapping;
> +	filemap_cachestat(mapping, first_index, last_index, &cs);
> +	fdput(f);
> +
> +	if (copy_to_user(cstat, &cs, cstat_size))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_CACHESTAT_SYSCALL */
> -- 
> 2.30.2
> 


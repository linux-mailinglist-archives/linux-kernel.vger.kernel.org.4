Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32F06522DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiLTOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiLTOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD858BAC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671547074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/FjbEpoRdR1NHbN3/m88Q4muAb1AJ3S0g9UVwS9euM=;
        b=HF/+jc7B4H0lzNcXTPi/mwunA/KsFPnA4xV1xYYt7Dia1hVsrZl7Hel3tpbO3idzBsWfm+
        AzUmg4L3/VWD614t4zej4y10iCMrs0mZv6KALDD4irc+dQR7O+Wio6EOpcdHfBnWwdFVgY
        fpHoLKZFMHNMFAGHQvlzMQPo15H/9yE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-c_QKJYQcMV-TfrATtCwJQA-1; Tue, 20 Dec 2022 09:37:53 -0500
X-MC-Unique: c_QKJYQcMV-TfrATtCwJQA-1
Received: by mail-qv1-f71.google.com with SMTP id s9-20020a0cf789000000b004d544bd8258so7178134qvn.16
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/FjbEpoRdR1NHbN3/m88Q4muAb1AJ3S0g9UVwS9euM=;
        b=pjFmCNJe1CmXQ+9j3CGGhOkFoepoe0PKjlRQ+OQhw9UPrnGoa3fyN5zy0h6jrgLbHG
         wkN0lPe00WQqae6uO8kMXMmiLqlNzFhJA5hIQlvvWy0kCkKlI4Qbi9xojKYZMvaEKdsp
         lwODHBJ9VM25rFiWcoz6z1xtpTD96wX0R9o6NL94bE9dc6vpewdONVLOcSRtJ0jxi0Sp
         4C/RZbfY4Ds7kzVV+II0bpHU4g2vZb66mM5emLdpxufwbRm10aA9tdaFSuQ3/OWUfP8n
         qY7TgGcqJz2s9LgtA2WKH41eA64jibB05jzafMs97Pln+1RIy4FvdJF6pok/NNbVJqx8
         xSnw==
X-Gm-Message-State: ANoB5pnaltmf+UKdjATp2CSwsizturmQKoMUoYKmjmF6BnXLq886sVKb
        tnDdqJ2qmz/mmXpPxCrIDB+neHlJl+NnYtyfvNRdOJq6Z1vo4thlCIos/LIN9vOaBxQN7WYbCXV
        tWBQAC+FKzdrrqVFKteyol+oS
X-Received: by 2002:ac8:6786:0:b0:3a8:1a6d:3db3 with SMTP id b6-20020ac86786000000b003a81a6d3db3mr40391449qtp.62.1671547072770;
        Tue, 20 Dec 2022 06:37:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+a7lOWncpxetwm3ZN/RkP79KblTgc/MGgVtmr6Ks5QqdoyhMfQdfI5E19yqSSxH7CJPq0cw==
X-Received: by 2002:ac8:6786:0:b0:3a8:1a6d:3db3 with SMTP id b6-20020ac86786000000b003a81a6d3db3mr40391423qtp.62.1671547072443;
        Tue, 20 Dec 2022 06:37:52 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b006fc2f74ad12sm9095307qkn.92.2022.12.20.06.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:37:51 -0800 (PST)
Date:   Tue, 20 Dec 2022 09:37:58 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 3/4] cachestat: implement cachestat syscall
Message-ID: <Y6HIxvH/YTHNnYM9@bfoster>
References: <20221216192149.3902877-1-nphamcs@gmail.com>
 <20221216192149.3902877-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216192149.3902877-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:21:48AM -0800, Nhat Pham wrote:
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
> ---

Hi Nhat,

Thanks for the tweaks. FWIW, this by and large looks reasonable to me.
Just a couple more random nitty things, if you happen to care about
them..

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
>  mm/filemap.c                                | 137 ++++++++++++++++++++
>  20 files changed, 180 insertions(+), 1 deletion(-)
> 
...
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 08341616ae7a..29ffb906caa4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
...
> @@ -3949,3 +3953,136 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
>  	return try_to_free_buffers(folio);
>  }
>  EXPORT_SYMBOL(filemap_release_folio);
> +
> +#ifdef CONFIG_CACHESTAT
> +/**
> + * filemap_cachestat() - compute the page cache statistics of a mapping
> + * @mapping:	The mapping to compute the statistics for.
> + * @first_index:	The starting page cache index.
> + * @last_index:	The final page index (inclusive).
> + * @cs:	the cachestat struct to write the result to.
> + *
> + * This will query the page cache statistics of a mapping in the
> + * page range of [first_index, last_index] (inclusive). THe statistics
> + * queried include: number of dirty pages, number of pages marked for
> + * writeback, and the number of (recently) evicted pages.
> + */
> +void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
> +		pgoff_t last_index, struct cachestat *cs)
> +{

Not sure why the internal helper needs to be wrapped in a config option?
Perhaps it makes more sense to define CONFIG_CACHESTAT_SYSCALL and just
wrap the syscall bits with that..?

I would also think it might make things simpler to split out all the
syscall bits into a separate patch from filemap_cachestat().

> +	XA_STATE(xas, &mapping->i_pages, first_index);
> +	struct folio *folio;
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, folio, last_index) {
> +		unsigned long nr_pages;
> +		pgoff_t folio_first_index, folio_last_index;
> +
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		nr_pages = folio_nr_pages(folio);
> +		folio_first_index = folio_pgoff(folio);
> +		folio_last_index = folio_first_index + nr_pages - 1;
> +
> +		/* Folios might straddle the range boundaries, only count covered subpages */
> +		if (folio_first_index < first_index)
> +			nr_pages -= first_index - folio_first_index;
> +
> +		if (folio_last_index > last_index)
> +			nr_pages -= folio_last_index - last_index;
> +
> +		if (xa_is_value(folio)) {
> +			/* page is evicted */
> +			void *shadow = (void *)folio;
> +			bool workingset; /* not used */
> +
> +			cs->nr_evicted += nr_pages;
> +
> +#ifdef CONFIG_SWAP /* implies CONFIG_MMU */
> +			if (shmem_mapping(mapping)) {
> +				/* shmem file - in swap cache */
> +				swp_entry_t swp = radix_to_swp_entry(folio);
> +
> +				shadow = get_shadow_from_swap_cache(swp);
> +			}
> +#endif
> +			if (workingset_test_recent(shadow, true, &workingset))
> +				cs->nr_recently_evicted += nr_pages;
> +
> +			continue;
> +		}
> +
> +		/* page is in cache */
> +		cs->nr_cache += nr_pages;
> +
> +		if (folio_test_dirty(folio))
> +			cs->nr_dirty += nr_pages;
> +
> +		if (folio_test_writeback(folio))
> +			cs->nr_writeback += nr_pages;

I'm not sure this is an issue right now (or if it will ever be for your
use cases), but from a filesystem perspective it is possible to have
large or variable sized folios in cache. At the moment I think the fs
(or XFS+iomap at least) manages dirty/writeback state at folio
granularity, but that may change in the near future if/when iomap
sub-page dirty tracking comes along. I suspect that means it may become
possible to have a large folio of some N number of pages where only a
subset of those pages are actually in dirty/writeback state, and thus
introduces some inaccuracy here because this assumes that folio state
applies to folio_nr_pages() worth of pages. Just something to be aware
of..

Brian
 
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(filemap_cachestat);
> +
> +/*
> + * The cachestat(5) system call.
> + *
> + * cachestat() returns the page cache statistics of a file in the
> + * bytes specified by `off` and `len`: number of cached pages,
> + * number of dirty pages, number of pages marked for writeback,
> + * number of (recently) evicted pages.
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
> +#endif /* CONFIG_CACHESTAT */
> -- 
> 2.30.2
> 


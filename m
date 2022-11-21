Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF4632727
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKUO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:56:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD0D089E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669041945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grM+KS8TII8/rEOFyAQQEbedoSGBGFwtgLZp4306LrY=;
        b=BtCLunUq67dLMqr9cHItTqaziZZecm9l65fVKfOUQWpsgoaZvHeKzNnFfo+O1GlmLQkWnp
        QC3pt87rz16DAwj4FEFwn8piRLcyTwsxKTvTTZTlX2uoRp9bBl3r5MrYw7I3xxKlM7hU+C
        QryRrRuDjAUpDHsJcUvI1m2S6dr6Dqc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-XhG-1XpBOoCnvamDZ4kCqg-1; Mon, 21 Nov 2022 09:45:44 -0500
X-MC-Unique: XhG-1XpBOoCnvamDZ4kCqg-1
Received: by mail-qt1-f199.google.com with SMTP id ay12-20020a05622a228c00b003a52bd33749so11961798qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grM+KS8TII8/rEOFyAQQEbedoSGBGFwtgLZp4306LrY=;
        b=Nt5XZnVHp4pKHBP0nVOfBpwOdN2E1rKxcF4OyPD3Gkr5aAky3pZ93tf92niXQw0LGq
         +joAde+oDsZPnlNVn0kaQ+ITJl0s8i/lyfEHnDuXoGa3eyKs1d8uOQ2QDjGanMZtgfPM
         s2SpzY+6viOv8++4vD0IaQcZkfDLwbMowqGjlMcvGqTxYvxJ19gQl3zmZMEBl4sY55sR
         xdbsj2akDoMVg8xmcJUILROFZZ6Rqq+TPwI/DyNIReMeCP2BslWHuMXRLLtpCyZ1WOak
         EvynG9b0vIJgj2JSbOGx98IODRziQ2TVKwMc3d7nTscLVS2KQp48/XuTCG/h6tdeQddJ
         966A==
X-Gm-Message-State: ANoB5pm06v3c6GUbzjp7xpp9VPYLyMYlojCMY6CCAEE6M5kX3joanGhR
        eJxQtNt8wZIZ/CmDsOfS7Cu05/7d8CJpjLHf5MVGZ5qw4SFq/3CndZ94slwLOtkkWsyiLCZHRNp
        lxl5ExFj7HCI/LtjWxr1reXhq
X-Received: by 2002:ae9:ed58:0:b0:6ec:1753:e4e8 with SMTP id c85-20020ae9ed58000000b006ec1753e4e8mr3339318qkg.746.1669041943673;
        Mon, 21 Nov 2022 06:45:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4TR0H7Sh4y4BHAfcYvwEgHNQtqx70jm2P/DL0nqLeWXzsoVZHmml5ag3NYrHnoS2QuxnjFrg==
X-Received: by 2002:ae9:ed58:0:b0:6ec:1753:e4e8 with SMTP id c85-20020ae9ed58000000b006ec1753e4e8mr3339283qkg.746.1669041943289;
        Mon, 21 Nov 2022 06:45:43 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id z4-20020ac86b84000000b003996aa171b9sm6613168qts.97.2022.11.21.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:45:43 -0800 (PST)
Date:   Mon, 21 Nov 2022 09:45:49 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] cachestat: implement cachestat syscall
Message-ID: <Y3uPHYX6HxYuE4LX@bfoster>
References: <20221115182901.2755368-1-nphamcs@gmail.com>
 <20221115182901.2755368-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115182901.2755368-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:29:00AM -0800, Nhat Pham wrote:
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
>         unsigned long nr_cache;
>         unsigned long nr_dirty;
>         unsigned long nr_writeback;
>         unsigned long nr_evicted;
>         unsigned long nr_recently_evicted;
>     };
> 
>     int cachestat(unsigned int fd, off_t off, size_t len,
>         struct cachestat *cstat);
> 

Do you have a strong use case for a user specified range vs. just
checking the entire file? If not, have you considered whether it might
be worth expanding statx() to include this data? That call is already
designed to include "extended" file status and avoids the need for a new
syscall. For example, the fields could be added individually with
multiple flags, or the entire struct tied to a new STATX_CACHE flag or
some such.

That said, I'm not sure how sensitive folks might be to increasing the
size of struct statx or populating it with cache data. Just a thought
that it might be worth bringing up on linux-fsdevel if you haven't
considered it already. A few random nits below..

> DESCRIPTION
>     cachestat() queries the number of cached pages, number of dirty
>     pages, number of pages marked for writeback, number of (recently)
>     evicted pages, in the bytes range given by `off` and `len`.
> 
>     These values are returned in a cachestat struct, whose address is
>     given by the `cstat` argument.
> 
>     The `off` argument must be a non-negative integers, If `off` + `len`
>     >= `off`, the queried range is [`off`, `off` + `len`]. Otherwise, we
>     will query in the range from `off` to the end of the file.
> 

(off + len < off) is an error condition on some (most?) other syscalls.
At least some calls (i.e. fadvise(), sync_file_range()) use len == 0 to
explicitly specify "to EOF."

> RETURN VALUE
>     On success, cachestat returns 0. On error, -1 is returned, and errno
>     is set to indicate the error.
> 
> ERRORS
>     EFAULT cstat points to an invalid address.
> 
>     EINVAL `off` is negative.
> 
>     EBADF  invalid file descriptor.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  MAINTAINERS                            |   7 ++
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/syscalls.h               |   2 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/mman.h              |   8 ++
>  kernel/sys_ni.c                        |   1 +
>  mm/Makefile                            |   2 +-
>  mm/cachestat.c                         | 109 +++++++++++++++++++++++++
>  9 files changed, 134 insertions(+), 2 deletions(-)
>  create mode 100644 mm/cachestat.c
> 
...
> diff --git a/mm/cachestat.c b/mm/cachestat.c
> new file mode 100644
> index 000000000000..193151cb0767
> --- /dev/null
> +++ b/mm/cachestat.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * The cachestat() system call.
> + */
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/syscalls.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
> +#include <uapi/linux/mman.h>
> +
> +#include "swap.h"
> +
> +/*
> + * The cachestat(3) system call.
> + *
> + * cachestat() returns the page cache status of a file in the
> + * bytes specified by `off` and `len`: number of cached pages,
> + * number of dirty pages, number of pages marked for writeback,
> + * number of (recently) evicted pages.
> + *
> + * If `off` + `len` >= `off`, the queried range is [`off`, `off` + `len`].
> + * Otherwise, we will query in the range from `off` to the end of the file.
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
> +SYSCALL_DEFINE4(cachestat, unsigned int, fd, off_t, off, size_t, len,
> +	struct cachestat __user *, cstat)
> +{
> +	struct fd f;
> +	struct cachestat cs;
> +
> +	memset(&cs, 0, sizeof(struct cachestat));

Maybe move this after the next couple error checks to avoid unnecessary
work?

> +
> +	if (off < 0)
> +		return -EINVAL;
> +
> +	if (!access_ok(cstat, sizeof(struct cachestat)))
> +		return -EFAULT;
> +
> +	f = fdget(fd);

Doing this:

	if (!f.file)
		return -EBADF;

... removes a level of indentation for the rest of the function, making
it a bit easier to read (and removing the locals defined in the if
branch, which I'm not sure is widely accepted style for the kernel).

Brian

> +	if (f.file) {
> +		struct address_space *mapping = f.file->f_mapping;
> +		pgoff_t first_index = off >> PAGE_SHIFT;
> +		XA_STATE(xas, &mapping->i_pages, first_index);
> +		struct folio *folio;
> +		pgoff_t last_index = (off + len - 1) >> PAGE_SHIFT;
> +
> +		if (last_index < first_index)
> +			last_index = ULONG_MAX;
> +
> +		rcu_read_lock();
> +		xas_for_each(&xas, folio, last_index) {
> +			if (xas_retry(&xas, folio) || !folio)
> +				continue;
> +
> +			if (xa_is_value(folio)) {
> +				/* page is evicted */
> +				void *shadow;
> +				bool workingset; /* not used */
> +
> +				cs.nr_evicted += 1;
> +
> +				if (shmem_mapping(mapping)) {
> +					/* shmem file - in swap cache */
> +					swp_entry_t swp = radix_to_swp_entry(folio);
> +
> +					shadow = get_shadow_from_swap_cache(swp);
> +				} else {
> +					/* in page cache */
> +					shadow = (void *) folio;
> +				}
> +
> +				if (workingset_test_recent(shadow, true, &workingset))
> +					cs.nr_recently_evicted += 1;
> +
> +				continue;
> +			}
> +
> +			/* page is in cache */
> +			cs.nr_cache += 1;
> +
> +			if (folio_test_dirty(folio))
> +				cs.nr_dirty += 1;
> +
> +			if (folio_test_writeback(folio))
> +				cs.nr_writeback += 1;
> +		}
> +		rcu_read_unlock();
> +		fdput(f);
> +
> +		if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +
> +	return -EBADF;
> +}
> -- 
> 2.30.2
> 
> 


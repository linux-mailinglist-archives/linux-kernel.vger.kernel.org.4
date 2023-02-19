Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1469C02A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBSMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:21:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB43E399;
        Sun, 19 Feb 2023 04:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJseHQTnv1iITs62Fnj7SadMOAE+fjrqhaVwjdlj74M=; b=CpsPmT7XFm6onB5jMft1I36dAA
        ior0H9BAS84l6dnGQGcqxWqtyCS8r5oJxjwgkM0oHAySiuIpiZVL4oi0f3EWMx7Il3aBaQ/N7eKb1
        BoKVXYCwXAv14xAqoi0GNdDKodhbVtsVc/Pj3CvAPU3gtlGAJYR+XA8GK0SrIKeibgJsx7u2lfZMw
        A6me6OIOUj3JdffSzxqRCI23lsoPeYZ7F8ZAHJ8qYZTds4A+IVGaUIiwqkbbDPD9XuN3L/ImUR+mH
        lrqcg8JjqFUp4L66ThpfT4S561/oRr96JjsI+VRTQwjxDan3RKQEk1mYDEGaV4rKEECG9q7PQQiLw
        6/apbMwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTihC-00Aug2-7r; Sun, 19 Feb 2023 12:21:34 +0000
Date:   Sun, 19 Feb 2023 12:21:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
Message-ID: <Y/IUTiL03C9OOSFx@casper.infradead.org>
References: <20230219073318.366189-1-nphamcs@gmail.com>
 <20230219073318.366189-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219073318.366189-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 11:33:17PM -0800, Nhat Pham wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..83300f1491e7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -75,6 +75,7 @@ struct fs_context;
>  struct fs_parameter_spec;
>  struct fileattr;
>  struct iomap_ops;
> +struct cachestat;
> 
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -830,6 +831,8 @@ void filemap_invalidate_lock_two(struct address_space *mapping1,
>  				 struct address_space *mapping2);
>  void filemap_invalidate_unlock_two(struct address_space *mapping1,
>  				   struct address_space *mapping2);
> +void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
> +		pgoff_t last_index, struct cachestat *cs);

1. Why is this in fs.h instead of pagemap.h?

2. Why is it not static, since it's only used by the syscall,
which is also in filemap.c?

> @@ -55,6 +56,9 @@
>  #include <linux/buffer_head.h> /* for try_to_free_buffers */
> 
>  #include <asm/mman.h>
> +#include <uapi/linux/mman.h>

I think this hunk should be:

-#include <asm/mman.h>
+#include <linux/mman.h>

(linux/mman.h includes uapi/linux/mman.h, which includes asm/mman.h)

> +/**
> + * filemap_cachestat() - compute the page cache statistics of a mapping
> + * @mapping:	The mapping to compute the statistics for.
> + * @first_index:	The starting page cache index.
> + * @last_index:	The final page index (inclusive).
> + * @cs:	the cachestat struct to write the result to.
> + *
> + * This will query the page cache statistics of a mapping in the
> + * page range of [first_index, last_index] (inclusive). The statistics
> + * queried include: number of dirty pages, number of pages marked for
> + * writeback, and the number of (recently) evicted pages.
> + */

Do we care that this isn't going to work for hugetlbfs?

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

s/subpages/pages/


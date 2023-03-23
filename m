Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04396C6D45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCWQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCWQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:19:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABAC22020
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:19:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id o12so10210042iow.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679588393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gxbyXM9VniJfchNlzpEP3glR9+pWHD0pj8j3ifk4Mw=;
        b=EhKBazWRGtSgCzqOkEYEwT/+lIuWMsw/vxHPOhdqhXI0Sm31/YtSRJLeqz3JDZUG2q
         jNhqcqzlnVnd1gzpSxjwVIW8Bre6XYJrgUH4H74QB0I4j4c+6KOiIXBlDc3MLEQZgqti
         /IzvP550GXWo8HDO1L2/XfIOqWvpSi5kkZaf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gxbyXM9VniJfchNlzpEP3glR9+pWHD0pj8j3ifk4Mw=;
        b=DBOW1qq5AEKeBvvS34n+Qm4oCh99yTpOpL+HAsR7gkCjcyyalpScWX+P8HEc83nj9p
         T8LE9wAQ/0ToacSsljPIpZqGoAXAn4n+5bPyd1LbhEsTC+WoOj9UJqkfkUK5f6xO6qEz
         huqoVN18Upb0uKxtbOFb8nAud95gYIYFdT4/MNUJpP4PCMBNK1PD7700xgnqSFgKwHcF
         kPTj84jQDkIx5K9kzfapgZUKkdViBXQcY9NzssukelVQrVCA2u5CXH0XQRM0eueGa5o/
         2WOExXpDaAq8nUfkfD9wfvCVi+Fw5Lgkk9uLK0HqbeSPJAehzSIozOWTJMkCuMnhbu8H
         z/Dg==
X-Gm-Message-State: AO0yUKX2n4Xisuax+VNca/CFNQ2S5Ya9C0h+3Sz11qiPphvw5cz9Re5K
        dQi5nQlFPnLy6CJpuiIAmJtjAA==
X-Google-Smtp-Source: AK7set9Zw8S1cGqdQPEi8gutIWlt3/JjVPmlkY4mwEcFHXd0gu8L6BT6CxV2gtl5o2UY1KiRNrrbEw==
X-Received: by 2002:a6b:6604:0:b0:716:99e0:807f with SMTP id a4-20020a6b6604000000b0071699e0807fmr7683212ioc.11.1679588393255;
        Thu, 23 Mar 2023 09:19:53 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id l6-20020a026646000000b003c488204c6fsm5944854jaf.76.2023.03.23.09.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:19:52 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:19:52 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM: hibernate: don't store zero pages in the image
 file.
Message-ID: <ZBx8KEuVtIbqkeq1@google.com>
References: <20230113193006.1320379-1-bgeffon@google.com>
 <20230302171348.3601107-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302171348.3601107-1-bgeffon@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:13:48PM -0500, Brian Geffon wrote:
> On ChromeOS we've observed a considerable number of in-use pages filled with
> zeros. Today with hibernate it's entirely possible that saveable pages are just
> zero filled. Since we're already copying pages word-by-word in do_copy_page it
> becomes almost free to determine if a page was completely filled with zeros.
> 
> This change introduces a new bitmap which will track these zero pages. If a page
> is zero it will not be included in the saved image, instead to track these zero
> pages in the image file we will introduce a new flag which we will set on the
> packed PFN list. When reading back in the image file we will detect these zero
> page PFNs and rebuild the zero page bitmap.
> 
> When the image is being loaded through calls to write_next_page if we encounter
> a zero page we will silently memset it to 0 and then continue on to the next
> page. Given the implementation in snapshot_read_next/snapshot_write_next this
> change  will be transparent to non-compressed/compressed and swsusp modes of
> operation.
> 
> To provide some concrete numbers from simple ad-hoc testing, on a device which
> was lightly in use we saw that:
> 
>   PM: hibernation: Image created (964408 pages copied, 548304 zero pages)
> 
> Of the approximately 6.2GB of saveable pages 2.2GB (36%) were just zero filled
> and could be tracked entirely within the packed PFN list. The savings would
> obviously be much lower for lzo compressed images, but even in the case of
> compression not copying pages across to the compression threads will still
> speed things up. It's also possible that we would see better overall compression
> ratios as larger regions of "real data" would improve the compressibility.
> 
> Finally, such an approach could dramatically improve swsusp performance
> as each one of those zero pages requires a write syscall to reload, by
> handling it as part of the packed PFN list we're able to fully avoid
> that.
> 
>  Patch v2 -> v3:
>    - Use nr_zero_pages rather than walking each pfn to count.
>    - Make sure zero_bm is allocated in safe pages on resume.
>      When reading in the pfn list and building the zero page bm
>      we don't know which pages are unsafe yet so we will need to
>      copy this bm to safe pages after the metadata has been read.
> 
>  Patch v1 -> v2:
>    - minor code mistake from rebasing corrected.
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  kernel/power/snapshot.c | 169 +++++++++++++++++++++++++++++++---------
>  1 file changed, 133 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index cd8b7b35f1e8b..a2c4fe17f9067 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c

...

> @@ -1371,14 +1381,18 @@ static unsigned int count_data_pages(void)
>  
>  /*
>   * This is needed, because copy_page and memcpy are not usable for copying
> - * task structs.
> + * task structs. Returns 1 if a page was filled with only zeros, otherwise 0.

nit: s/a page/the page/

>   */
> -static inline void do_copy_page(long *dst, long *src)
> +static inline int do_copy_page(long *dst, long *src)
>  {
>  	int n;
> +	long z = 0;
>  
> -	for (n = PAGE_SIZE / sizeof(long); n; n--)
> +	for (n = PAGE_SIZE / sizeof(long); n; n--) {
> +		z |= *src;
>  		*dst++ = *src++;
> +	}
> +	return !z;
>  }

...

> -static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
> +static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>  {
> -	safe_copy_page(page_address(pfn_to_page(dst_pfn)),
> +	return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
>  				pfn_to_page(src_pfn));
>  }
>  #endif /* CONFIG_HIGHMEM */
>  
>  static void copy_data_pages(struct memory_bitmap *copy_bm,
> -			    struct memory_bitmap *orig_bm)
> +			    struct memory_bitmap *orig_bm,
> +			    struct memory_bitmap *zero_bm,
> +			    unsigned int *zero_count)
>  {
>  	struct zone *zone;
> -	unsigned long pfn;
> +	unsigned long pfn, copy_pfn;
>  
>  	for_each_populated_zone(zone) {
>  		unsigned long max_zone_pfn;
> @@ -1462,11 +1482,20 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
>  	}
>  	memory_bm_position_reset(orig_bm);
>  	memory_bm_position_reset(copy_bm);
> +	copy_pfn = memory_bm_next_pfn(copy_bm);
>  	for(;;) {
>  		pfn = memory_bm_next_pfn(orig_bm);
>  		if (unlikely(pfn == BM_END_OF_MAP))
>  			break;
> -		copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
> +		if (copy_data_page(copy_pfn, pfn)) {
> +			memory_bm_set_bit(zero_bm, pfn);
> +			if (zero_count)

This check is not needed. The function is called only once, with a pointer. The kernel
trusts itself if the pointer is supposed to be always != NULL.

Or better: use a local counter and have copy_data_pages() return the number of pages
that were actually copied, which is what the caller is interested in.

> +				(*zero_count)++;
> +
> +			/* We will reuse this copy_pfn for a real 'nonzero' page. */
> +			continue;
> +		}
> +		copy_pfn = memory_bm_next_pfn(copy_bm);
>  	}
>  }

...

> @@ -2247,24 +2299,34 @@ static int load_header(struct swsusp_info *info)
>   * unpack_orig_pfns - Set bits corresponding to given PFNs in a memory bitmap.
>   * @bm: Memory bitmap.
>   * @buf: Area of memory containing the PFNs.
> + * @zero_bm: Memory bitmap which will be populated with the PFNs of zero pages.
>   *
>   * For each element of the array pointed to by @buf (1 page at a time), set the
> - * corresponding bit in @bm.
> + * corresponding bit in @bm. If the the page was originally populated with only
> + * zeros then a corresponding bit will also be set in @zero_bm.

s/the the/the/

...

> @@ -2486,6 +2548,7 @@ static inline void free_highmem_data(void) {}
>   * prepare_image - Make room for loading hibernation image.
>   * @new_bm: Uninitialized memory bitmap structure.
>   * @bm: Memory bitmap with unsafe pages marked.
> + * @zero_bm: Memory bitmap containing the zero pages.

That sounds as if the memory bitmap actually contained zero pages. I suggest to
change it to something like the comment for 'bm' above, i.e. "... with zero
pages marked"

>   *
>   * Use @bm to mark the pages that will be overwritten in the process of
>   * restoring the system memory state from the suspend image ("unsafe" pages)
> @@ -2496,8 +2559,12 @@ static inline void free_highmem_data(void) {}
>   * pages will be used for just yet.  Instead, we mark them all as allocated and
>   * create a lists of "safe" pages to be used later.  On systems with high
>   * memory a list of "safe" highmem pages is created too.
> + *
> + * Because we didn't know which pages were unsafe when we created the zero bm we
> + * will make a copy of it and recreate it within safe pages.

nit: s/we will make/we make/

>   */
> -static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
> +static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
> +		struct memory_bitmap *zero_bm)
>  {
>  	unsigned int nr_pages, nr_highmem;
>  	struct linked_page *lp;
> @@ -2516,6 +2583,20 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
>  
>  	duplicate_memory_bitmap(new_bm, bm);
>  	memory_bm_free(bm, PG_UNSAFE_KEEP);
> +	error = memory_bm_create(bm, GFP_ATOMIC, PG_ANY);
> +	if (error)
> +		goto Free;
> +
> +	/* use bm as storage while we rebuild zero_bm using safe pages */

Re-using the 'bm' parameter is confusing, it should be avoided IMO unless there
is a real benefit. struct memory_bitmap isn't that big, why not create a local
variable 'zero_mb_tmp' or similar as a temporary store for the zero page bitmap?

> +	duplicate_memory_bitmap(bm, zero_bm);
> +	memory_bm_free(zero_bm, PG_UNSAFE_KEEP);
> +	error = memory_bm_create(zero_bm, GFP_ATOMIC, PG_SAFE);
> +	if (error)
> +		goto Free;
> +	duplicate_memory_bitmap(zero_bm, bm);
> +	memory_bm_free(bm, PG_UNSAFE_KEEP);
> +	/* at this point zero_bm is in safe pages and we can use it while restoring */
> +
>  	if (nr_highmem > 0) {
>  		error = prepare_highmem_image(bm, &nr_highmem);
>  		if (error)

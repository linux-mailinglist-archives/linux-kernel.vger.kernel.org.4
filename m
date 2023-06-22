Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B573A5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFVQWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 12:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:22:22 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692381BD8;
        Thu, 22 Jun 2023 09:22:19 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-97ea801b0d0so176970066b.1;
        Thu, 22 Jun 2023 09:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450938; x=1690042938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgv16YmnQep3zizlGt6RURSljOqXvB2ydQV/fWDluCc=;
        b=iPjU1npHOoT5H4nemHpZ8t+rGpRMWLINky1amvOegGbb0pn0RKMW7fSyIJ4BAzLfLw
         lB3Oqr93fo3Uda2XMaC/ukgy8m1O/VWhf3lZjaqqK/qafTGLPcy2604innQXh4VOFhow
         15nUCWoxKsnChcdxT1nTOCWrm2vwMsp/4g6Fx85MsnwPfOt91PjFuYwQvf6CbcX6QxSo
         O2ZMYl7b2hlynz9rzqyPGgRAqeLuiyHci+Nlj+WHT+1bw1J6qMo0ahlcjfGDmcRDok1w
         gu4cqox9KSJxZc5O0Vn4iAPZz1h3nmNPuDcLd24h0cr3IQV0pXO2P3cKUFsS7RNkeG2B
         rt/w==
X-Gm-Message-State: AC+VfDxfUOzN0IvbfxzZ30GynzDGTf021k4l3TRQ5B+QM4SYbMmkRoeW
        1ZydRQNH5L5xTQB6rrguFJItNaF8Rw8OtSPoxoJyFBJz
X-Google-Smtp-Source: ACHHUZ5p2XNZMl8wKkU4phh0bdYyZpxkjKUiqDC7C0X5f8a9lspxE5Sq23vphSZ6zLFgWwbYQI+9xqrHmhf1/VD1ic4=
X-Received: by 2002:a17:906:729e:b0:988:c8bb:e3ac with SMTP id
 b30-20020a170906729e00b00988c8bbe3acmr8215986ejl.7.1687450937514; Thu, 22 Jun
 2023 09:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230113193006.1320379-1-bgeffon@google.com> <20230406182005.1001883-1-bgeffon@google.com>
In-Reply-To: <20230406182005.1001883-1-bgeffon@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Jun 2023 18:22:06 +0200
Message-ID: <CAJZ5v0ictTXMePuaiyG16wX_3pv-9Hi_0jqMqtL5Ntx6+Z2VtA@mail.gmail.com>
Subject: Re: [PATCH v4] PM: hibernate: don't store zero pages in the image file.
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 8:20 PM Brian Geffon <bgeffon@google.com> wrote:
>
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
> PM: hibernation: Image created (964408 pages copied, 548304 zero pages)
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
> Patch v3 -> v4:
> - Suggestions from Matthias Kaehlcke:
>  - Return number of copy pages from copy_data_pages
>  - Use an explicit temporary bitmap while moving the zerm_bm
>    to safe pages.
>
> Patch v2 -> v3:
> - Use nr_zero_pages rather than walking each pfn to count.
> - Make sure zero_bm is allocated in safe pages on resume.
>  When reading in the pfn list and building the zero page bm
>  we don't know which pages are unsafe yet so we will need to
>  copy this bm to safe pages after the metadata has been read.
>
> Patch v1 -> v2:
> - minor code mistake from rebasing corrected.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  kernel/power/snapshot.c | 180 +++++++++++++++++++++++++++++++---------
>  1 file changed, 142 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index cd8b7b35f1e8..43d0c45fa05c 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -404,6 +404,7 @@ struct bm_position {
>         struct mem_zone_bm_rtree *zone;
>         struct rtree_node *node;
>         unsigned long node_pfn;
> +       unsigned long cur_pfn;
>         int node_bit;
>  };
>
> @@ -589,6 +590,7 @@ static void memory_bm_position_reset(struct memory_bitmap *bm)
>         bm->cur.node = list_entry(bm->cur.zone->leaves.next,
>                                   struct rtree_node, list);
>         bm->cur.node_pfn = 0;
> +       bm->cur.cur_pfn = BM_END_OF_MAP;
>         bm->cur.node_bit = 0;
>  }
>
> @@ -799,6 +801,7 @@ static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
>         bm->cur.zone = zone;
>         bm->cur.node = node;
>         bm->cur.node_pfn = (pfn - zone->start_pfn) & ~BM_BLOCK_MASK;
> +       bm->cur.cur_pfn = pfn;
>
>         /* Set return values */
>         *addr = node->data;
> @@ -850,6 +853,11 @@ static void memory_bm_clear_current(struct memory_bitmap *bm)
>         clear_bit(bit, bm->cur.node->data);
>  }
>
> +static unsigned long memory_bm_get_current(struct memory_bitmap *bm)
> +{
> +       return bm->cur.cur_pfn;
> +}
> +
>  static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
>  {
>         void *addr;
> @@ -929,10 +937,12 @@ static unsigned long memory_bm_next_pfn(struct memory_bitmap *bm)
>                 if (bit < bits) {
>                         pfn = bm->cur.zone->start_pfn + bm->cur.node_pfn + bit;
>                         bm->cur.node_bit = bit + 1;
> +                       bm->cur.cur_pfn = pfn;
>                         return pfn;
>                 }
>         } while (rtree_next_node(bm));
>
> +       bm->cur.cur_pfn = BM_END_OF_MAP;
>         return BM_END_OF_MAP;
>  }
>
> @@ -1371,14 +1381,18 @@ static unsigned int count_data_pages(void)
>
>  /*
>   * This is needed, because copy_page and memcpy are not usable for copying
> - * task structs.
> + * task structs. Returns 1 if the page was filled with only zeros, otherwise 0.
>   */
> -static inline void do_copy_page(long *dst, long *src)
> +static inline int do_copy_page(long *dst, long *src)

Make it bool, please.

>  {
>         int n;
> +       long z = 0;

Please put this above the other declaration.

>
> -       for (n = PAGE_SIZE / sizeof(long); n; n--)
> +       for (n = PAGE_SIZE / sizeof(long); n; n--) {
> +               z |= *src;
>                 *dst++ = *src++;
> +       }
> +       return !z;
>  }
>
>  /**
> @@ -1389,15 +1403,17 @@ static inline void do_copy_page(long *dst, long *src)
>   * CONFIG_ARCH_HAS_SET_DIRECT_MAP is not set. In that case kernel_page_present()
>   * always returns 'true'.
>   */
> -static void safe_copy_page(void *dst, struct page *s_page)
> +static int safe_copy_page(void *dst, struct page *s_page)

This can be bool too.

>  {
> +       int ret;

I'd call this "zeros_only" or similar and it can be bool.

>         if (kernel_page_present(s_page)) {
> -               do_copy_page(dst, page_address(s_page));
> +               ret = do_copy_page(dst, page_address(s_page));
>         } else {
>                 hibernate_map_page(s_page);
> -               do_copy_page(dst, page_address(s_page));
> +               ret = do_copy_page(dst, page_address(s_page));
>                 hibernate_unmap_page(s_page);
>         }
> +       return ret;
>  }
>
>  #ifdef CONFIG_HIGHMEM
> @@ -1407,17 +1423,18 @@ static inline struct page *page_is_saveable(struct zone *zone, unsigned long pfn
>                 saveable_highmem_page(zone, pfn) : saveable_page(zone, pfn);
>  }
>
> -static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
> +static int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)

This can be bool.

>  {
>         struct page *s_page, *d_page;
>         void *src, *dst;
> +       int ret;

And this can be bool and please rename it to something more meaningful
like above.

>
>         s_page = pfn_to_page(src_pfn);
>         d_page = pfn_to_page(dst_pfn);
>         if (PageHighMem(s_page)) {
>                 src = kmap_atomic(s_page);
>                 dst = kmap_atomic(d_page);
> -               do_copy_page(dst, src);
> +               ret = do_copy_page(dst, src);
>                 kunmap_atomic(dst);
>                 kunmap_atomic(src);
>         } else {
> @@ -1426,30 +1443,38 @@ static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>                          * The page pointed to by src may contain some kernel
>                          * data modified by kmap_atomic()
>                          */
> -                       safe_copy_page(buffer, s_page);
> +                       ret = safe_copy_page(buffer, s_page);
>                         dst = kmap_atomic(d_page);
>                         copy_page(dst, buffer);
>                         kunmap_atomic(dst);
>                 } else {
> -                       safe_copy_page(page_address(d_page), s_page);
> +                       ret = safe_copy_page(page_address(d_page), s_page);
>                 }
>         }
> +       return ret;
>  }
>  #else
>  #define page_is_saveable(zone, pfn)    saveable_page(zone, pfn)
>
> -static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
> +static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)

This can be bool.

>  {
> -       safe_copy_page(page_address(pfn_to_page(dst_pfn)),
> +       return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
>                                 pfn_to_page(src_pfn));
>  }
>  #endif /* CONFIG_HIGHMEM */
>
> -static void copy_data_pages(struct memory_bitmap *copy_bm,
> -                           struct memory_bitmap *orig_bm)
> +/*
> + * Copy data pages will copy all pages into pages pulled from the copy_bm.
> + * If a page was entirely filled with zeros it will be marked in the zero_bm.
> + *
> + * Returns the number of pages copied.
> + */
> +static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
> +                           struct memory_bitmap *orig_bm,
> +                           struct memory_bitmap *zero_bm)
>  {
>         struct zone *zone;
> -       unsigned long pfn;
> +       unsigned long pfn, copy_pfn, copied_pages = 0;

Please put this above the other declaration.

>
>         for_each_populated_zone(zone) {
>                 unsigned long max_zone_pfn;
> @@ -1462,18 +1487,30 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
>         }
>         memory_bm_position_reset(orig_bm);
>         memory_bm_position_reset(copy_bm);
> +       copy_pfn = memory_bm_next_pfn(copy_bm);
>         for(;;) {
>                 pfn = memory_bm_next_pfn(orig_bm);
>                 if (unlikely(pfn == BM_END_OF_MAP))
>                         break;
> -               copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
> +               if (copy_data_page(copy_pfn, pfn)) {
> +                       memory_bm_set_bit(zero_bm, pfn);
> +
> +                       /* We will reuse this copy_pfn for a real 'nonzero' page. */

I'd prefer something like "This copy_pfn will be reused for a page
that is not full of zeros."

> +                       continue;
> +               }
> +               copied_pages++;
> +               copy_pfn = memory_bm_next_pfn(copy_bm);
>         }
> +       return copied_pages;
>  }
>
>  /* Total number of image pages */
>  static unsigned int nr_copy_pages;
>  /* Number of pages needed for saving the original pfns of the image pages */
>  static unsigned int nr_meta_pages;
> +/* Number of zero pages */
> +static unsigned int nr_zero_pages;
> +
>  /*
>   * Numbers of normal and highmem page frames allocated for hibernation image
>   * before suspending devices.
> @@ -1494,6 +1531,9 @@ static struct memory_bitmap orig_bm;
>   */
>  static struct memory_bitmap copy_bm;
>
> +/* Memory bitmap which tracks which saveable pages were zero filled. */
> +static struct memory_bitmap zero_bm;
> +
>  /**
>   * swsusp_free - Free pages allocated for hibernation image.
>   *
> @@ -1538,6 +1578,7 @@ void swsusp_free(void)
>  out:
>         nr_copy_pages = 0;
>         nr_meta_pages = 0;
> +       nr_zero_pages = 0;
>         restore_pblist = NULL;
>         buffer = NULL;
>         alloc_normal = 0;
> @@ -1756,8 +1797,15 @@ int hibernate_preallocate_memory(void)
>                 goto err_out;
>         }
>
> +       error = memory_bm_create(&zero_bm, GFP_IMAGE, PG_ANY);
> +       if (error) {
> +               pr_err("Cannot allocate zero bitmap\n");
> +               goto err_out;
> +       }
> +
>         alloc_normal = 0;
>         alloc_highmem = 0;
> +       nr_zero_pages = 0;
>
>         /* Count the number of saveable data pages. */
>         save_highmem = count_highmem_pages();
> @@ -2014,7 +2062,6 @@ static int swsusp_alloc(struct memory_bitmap *copy_bm,
>  asmlinkage __visible int swsusp_save(void)
>  {
>         unsigned int nr_pages, nr_highmem;
> -

Unrelated change and not needed AFAICS.

>         pr_info("Creating image:\n");
>
>         drain_local_pages(NULL);
> @@ -2037,19 +2084,19 @@ asmlinkage __visible int swsusp_save(void)
>          * Kill them.
>          */
>         drain_local_pages(NULL);
> -       copy_data_pages(&copy_bm, &orig_bm);
> +       nr_copy_pages = copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
>
>         /*
>          * End of critical section. From now on, we can write to memory,
>          * but we should not touch disk. This specially means we must _not_
>          * touch swap space! Except we must write out our image of course.
>          */
> -
>         nr_pages += nr_highmem;
> -       nr_copy_pages = nr_pages;
> +       /* We don't actually copy the zero pages */
> +       nr_zero_pages = nr_pages - nr_copy_pages;
>         nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
>
> -       pr_info("Image created (%d pages copied)\n", nr_pages);
> +       pr_info("Image created (%d pages copied, %d zero pages)\n", nr_copy_pages, nr_zero_pages);
>
>         return 0;
>  }
> @@ -2094,15 +2141,22 @@ static int init_header(struct swsusp_info *info)
>         return init_header_complete(info);
>  }
>
> +#define ENCODED_PFN_ZERO_FLAG ((unsigned long)1 << (BITS_PER_LONG - 1))
> +#define ENCODED_PFN_MASK (~ENCODED_PFN_ZERO_FLAG)
> +
>  /**
>   * pack_pfns - Prepare PFNs for saving.
>   * @bm: Memory bitmap.
>   * @buf: Memory buffer to store the PFNs in.
> + * @zero_bm: Memory bitmap containing PFNs of zero pages.
>   *
>   * PFNs corresponding to set bits in @bm are stored in the area of memory
> - * pointed to by @buf (1 page at a time).
> + * pointed to by @buf (1 page at a time). Pages which were filled with only
> + * zeros will have the highest bit set in the packed format to distinguish
> + * them from PFNs which will be contained in the image file.
>   */
> -static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
> +static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm,
> +               struct memory_bitmap *zero_bm)
>  {
>         int j;
>
> @@ -2110,6 +2164,8 @@ static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
>                 buf[j] = memory_bm_next_pfn(bm);
>                 if (unlikely(buf[j] == BM_END_OF_MAP))
>                         break;
> +               if (memory_bm_test_bit(zero_bm, buf[j]))
> +                       buf[j] |= ENCODED_PFN_ZERO_FLAG;
>         }
>  }
>
> @@ -2151,7 +2207,7 @@ int snapshot_read_next(struct snapshot_handle *handle)
>                 memory_bm_position_reset(&copy_bm);
>         } else if (handle->cur <= nr_meta_pages) {
>                 clear_page(buffer);
> -               pack_pfns(buffer, &orig_bm);
> +               pack_pfns(buffer, &orig_bm, &zero_bm);
>         } else {
>                 struct page *page;
>
> @@ -2247,24 +2303,34 @@ static int load_header(struct swsusp_info *info)
>   * unpack_orig_pfns - Set bits corresponding to given PFNs in a memory bitmap.
>   * @bm: Memory bitmap.
>   * @buf: Area of memory containing the PFNs.
> + * @zero_bm: Memory bitmap with the zero PFNs marked.
>   *
>   * For each element of the array pointed to by @buf (1 page at a time), set the
> - * corresponding bit in @bm.
> + * corresponding bit in @bm. If the page was originally populated with only
> + * zeros then a corresponding bit will also be set in @zero_bm.
>   */
> -static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
> +static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm,
> +               struct memory_bitmap *zero_bm)
>  {
> -       int j;
> +       int j, zero;

"zero" is a bool variable.

> +       unsigned long decoded_pfn;

Please put this above the other declaration.

>
>         for (j = 0; j < PAGE_SIZE / sizeof(long); j++) {
>                 if (unlikely(buf[j] == BM_END_OF_MAP))
>                         break;
>
> -               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
> -                       memory_bm_set_bit(bm, buf[j]);
> +               zero = !!(buf[j] & ENCODED_PFN_ZERO_FLAG);
> +               decoded_pfn = buf[j] & ENCODED_PFN_MASK;
> +               if (pfn_valid(decoded_pfn) && memory_bm_pfn_present(bm, decoded_pfn)) {
> +                       memory_bm_set_bit(bm, decoded_pfn);
> +                       if (zero) {
> +                               memory_bm_set_bit(zero_bm, decoded_pfn);
> +                               nr_zero_pages++;
> +                       }
>                 } else {
> -                       if (!pfn_valid(buf[j]))
> +                       if (!pfn_valid(decoded_pfn))
>                                 pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
> -                                      (unsigned long long)PFN_PHYS(buf[j]));
> +                                      (unsigned long long)PFN_PHYS(decoded_pfn));
>                         return -EFAULT;
>                 }
>         }
> @@ -2486,6 +2552,7 @@ static inline void free_highmem_data(void) {}
>   * prepare_image - Make room for loading hibernation image.
>   * @new_bm: Uninitialized memory bitmap structure.
>   * @bm: Memory bitmap with unsafe pages marked.
> + * @zero_bm: Memory bitmap containing the zero pages.
>   *
>   * Use @bm to mark the pages that will be overwritten in the process of
>   * restoring the system memory state from the suspend image ("unsafe" pages)
> @@ -2496,11 +2563,16 @@ static inline void free_highmem_data(void) {}
>   * pages will be used for just yet.  Instead, we mark them all as allocated and
>   * create a lists of "safe" pages to be used later.  On systems with high
>   * memory a list of "safe" highmem pages is created too.
> + *
> + * Because we didn't know which pages were unsafe when we created the zero bm we
> + * make a copy of it and recreate it within safe pages.

I would prefer something like "Because it was not known which pages
were unsafe when @zero_bm was created, make a copy of it and recreate
it within safe pages."

>   */
> -static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
> +static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
> +               struct memory_bitmap *zero_bm)
>  {
>         unsigned int nr_pages, nr_highmem;
>         struct linked_page *lp;
> +       struct memory_bitmap tmp;

Please put this above the previous declaration.

>         int error;
>
>         /* If there is no highmem, the buffer will not be necessary */
> @@ -2516,6 +2588,22 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
>
>         duplicate_memory_bitmap(new_bm, bm);
>         memory_bm_free(bm, PG_UNSAFE_KEEP);
> +
> +       /* Make a copy of the zero bm so it can be created in safe pages */

s/the zero bm/zero_bm/

> +       error = memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
> +       if (error)
> +               goto Free;

Please add empty lines after an if () without a block in all places.

> +       duplicate_memory_bitmap(&tmp, zero_bm);
> +       memory_bm_free(zero_bm, PG_UNSAFE_KEEP);
> +
> +       /* Recreate zero_bm in safe pages */
> +       error = memory_bm_create(zero_bm, GFP_ATOMIC, PG_SAFE);
> +       if (error)
> +               goto Free;
> +       duplicate_memory_bitmap(zero_bm, &tmp);
> +       memory_bm_free(&tmp, PG_UNSAFE_KEEP);
> +       /* at this point zero_bm is in safe pages and we can use it while restoring */

"At this point zero_bm is in safe pages and it can be used for restoring."

> +
>         if (nr_highmem > 0) {
>                 error = prepare_highmem_image(bm, &nr_highmem);
>                 if (error)
> @@ -2530,7 +2618,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
>          *
>          * nr_copy_pages cannot be less than allocated_unsafe_pages too.
>          */
> -       nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
> +       nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
>         nr_pages = DIV_ROUND_UP(nr_pages, PBES_PER_LINKED_PAGE);
>         while (nr_pages > 0) {
>                 lp = get_image_page(GFP_ATOMIC, PG_SAFE);
> @@ -2543,7 +2631,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
>                 nr_pages--;
>         }
>         /* Preallocate memory for the image */
> -       nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
> +       nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
>         while (nr_pages > 0) {
>                 lp = (struct linked_page *)get_zeroed_page(GFP_ATOMIC);
>                 if (!lp) {
> @@ -2631,8 +2719,9 @@ int snapshot_write_next(struct snapshot_handle *handle)
>         static struct chain_allocator ca;
>         int error = 0;
>
> +next:
>         /* Check if we have already loaded the entire image */
> -       if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
> +       if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages + nr_zero_pages)
>                 return 0;
>
>         handle->sync_read = 1;
> @@ -2657,19 +2746,26 @@ int snapshot_write_next(struct snapshot_handle *handle)
>                 if (error)
>                         return error;
>
> +               error = memory_bm_create(&zero_bm, GFP_ATOMIC, PG_ANY);
> +               if (error)
> +                       return error;
> +
> +               nr_zero_pages = 0;
> +
>                 hibernate_restore_protection_begin();
>         } else if (handle->cur <= nr_meta_pages + 1) {
> -               error = unpack_orig_pfns(buffer, &copy_bm);
> +               error = unpack_orig_pfns(buffer, &copy_bm, &zero_bm);
>                 if (error)
>                         return error;
>
>                 if (handle->cur == nr_meta_pages + 1) {
> -                       error = prepare_image(&orig_bm, &copy_bm);
> +                       error = prepare_image(&orig_bm, &copy_bm, &zero_bm);
>                         if (error)
>                                 return error;
>
>                         chain_init(&ca, GFP_ATOMIC, PG_SAFE);
>                         memory_bm_position_reset(&orig_bm);
> +                       memory_bm_position_reset(&zero_bm);
>                         restore_pblist = NULL;
>                         handle->buffer = get_buffer(&orig_bm, &ca);
>                         handle->sync_read = 0;
> @@ -2686,6 +2782,14 @@ int snapshot_write_next(struct snapshot_handle *handle)
>                         handle->sync_read = 0;
>         }
>         handle->cur++;
> +
> +       /* Zero pages were not included in the image, memset it and move on. */
> +       if ((handle->cur > (nr_meta_pages + 1)) &&
> +                       memory_bm_test_bit(&zero_bm, memory_bm_get_current(&orig_bm))) {
> +               memset(handle->buffer, 0, PAGE_SIZE);
> +               goto next;
> +       }
> +
>         return PAGE_SIZE;
>  }
>
> @@ -2702,7 +2806,7 @@ void snapshot_write_finalize(struct snapshot_handle *handle)
>         copy_last_highmem_page();
>         hibernate_restore_protect_page(handle->buffer);
>         /* Do that only if we have loaded the image entirely */
> -       if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages) {
> +       if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages + nr_zero_pages) {
>                 memory_bm_recycle(&orig_bm);
>                 free_highmem_data();
>         }
> --

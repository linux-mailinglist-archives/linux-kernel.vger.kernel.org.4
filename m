Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAC7343D1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjFQUul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFQUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:50:39 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209AA10C4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:50:38 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-55ab0f777acso1367536eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687035037; x=1689627037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OHn8Xgw17gU+Kda8waCzRgm915Hr1NA+ZRnxZtShvHE=;
        b=MLjsgZHpk5JPwl2Z1qaWZwMJqDwWH9KbD2l16ewt9v4z/z1S/UDgMKrwL9WcYsEfWn
         07/Vt13TS6LY8+dMnPEYdEHPXOx/DS5QbaUp6k36zbqhvkEo9T+tSwSESDSkedX4msLh
         WRynyRtoN73bbDX1f1fihr4F6COD1Xy0BEKymq3cE+IVWUGnTPK3dH9s8TNrxUbAwcKb
         0owSUvyo+ALahJsF+3+CBgLmCQSMMqjsvZ376ebOr75mfa8lZh2R/gqsl/HS4jziQhWN
         lydr5y3/CwmzmNFASgK5YSTK25GyCfYlG8ntfr0bPbYjRdhnYpAEIdskdzJcCu5xSQam
         qs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687035037; x=1689627037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHn8Xgw17gU+Kda8waCzRgm915Hr1NA+ZRnxZtShvHE=;
        b=CrNtbUgzHbZTtkeOwJh+4K/NDs6sEe/2QOgFVmNupxXFpb7Nby+dB2cWKALGvGq5a9
         39SUD8F9UdIv/WP0o5jZSbRJn5kT7vBQdutnsdX2zFyH+P0mAUR0usMATbqjzf+3tf8K
         klHHA09123FJmgdyCMtamrzjHGKulIDtxRKVDxJqa72JmKqvk3vbiL3ddOmUtEgRVf7U
         VN92JMGocyk2tHBIsWDpX1kvTogFAuvIS67R5Sd5ShsgE58/ScCaNyH4LtSyI9TO/HLa
         DCT4QX21rji8VpwFPKhkzZBIh032BWaIMvaTQKh1GozOVgoOiMlTmBESwBu2F4SgFdsy
         rJYA==
X-Gm-Message-State: AC+VfDybfFyjhsJ3ovLQzic0D/TbCf4Ig/CuEHiToTrw2VoyZya5Rscg
        B7ew7k+3nkw4nRzukWrTRPCNHOuyatagLxMJQEw=
X-Google-Smtp-Source: ACHHUZ46E67WzZdOyX1RmVt5IpbndGhdZLGoa6H4uBgeSFEqHJpls5uDVvl4VPmlCxrpr4TAxVFh8muqTGoOZ9woXLU=
X-Received: by 2002:a05:6358:c6a5:b0:12b:dce7:f428 with SMTP id
 fe37-20020a056358c6a500b0012bdce7f428mr2159357rwb.1.1687035037211; Sat, 17
 Jun 2023 13:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230614021312.34085-1-vishal.moola@gmail.com> <20230614021312.34085-6-vishal.moola@gmail.com>
In-Reply-To: <20230614021312.34085-6-vishal.moola@gmail.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Sat, 17 Jun 2023 21:50:26 +0100
Message-ID: <CAA5enKbCuFqURVcPeYvboQYR8XMXzg9DzW-TghuF1HNbWHgwFQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: Remove is_longterm_pinnable_page() and
 Reimplement folio_is_longterm_pinnable()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 at 03:14, Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> folio_is_longterm_pinnable() already exists as a wrapper function. Now
> that the whole implementation of is_longterm_pinnable_page() can be
> implemented using folios, folio_is_longterm_pinnable() can be made its
> own standalone function - and we can remove is_longterm_pinnable_page().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..e2d35e272e07 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1910,39 +1910,35 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>         return page_maybe_dma_pinned(page);
>  }
>
> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
> +/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>  #ifdef CONFIG_MIGRATION
> -static inline bool is_longterm_pinnable_page(struct page *page)
> +static inline bool folio_is_longterm_pinnable(struct folio *folio)
>  {
>  #ifdef CONFIG_CMA
> -       int mt = get_pageblock_migratetype(page);
> +       int mt = folio_migratetype(folio);
>
>         if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>                 return false;
>  #endif
>         /* The zero page may always be pinned */
> -       if (is_zero_pfn(page_to_pfn(page)))
> +       if (is_zero_pfn(folio_pfn(folio)))
>                 return true;
>
>         /* Coherent device memory must always allow eviction. */
> -       if (is_device_coherent_page(page))
> +       if (folio_is_device_coherent(folio))
>                 return false;
>
> -       /* Otherwise, non-movable zone pages can be pinned. */
> -       return !is_zone_movable_page(page);
> +       /* Otherwise, non-movable zone folios can be pinned. */
> +       return !folio_is_zone_movable(folio);
> +

Nit, but you're adding a newline here.

>  }
>  #else
> -static inline bool is_longterm_pinnable_page(struct page *page)
> +static inline bool folio_is_longterm_pinnable(struct folio *folio)
>  {
>         return true;
>  }
>  #endif
>
> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
> -{
> -       return is_longterm_pinnable_page(&folio->page);
> -}
> -
>  static inline void set_page_zone(struct page *page, enum zone_type zone)
>  {
>         page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
> --
> 2.40.1
>
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

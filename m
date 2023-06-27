Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F873F0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjF0Cr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjF0Crz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:47:55 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867A19A8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:47:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40079620a83so134511cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687834073; x=1690426073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOHMGk1IHW9nIXyoyhy6ScxjHGO05nJh9iYXmQJ8lRg=;
        b=4Hxtqyz9AC5uq4MuNdUiUTytvXCSHBztZ8M76g0ceKIjnz0PJbRxq4j9xf48iqBl8z
         uOAa0SjGLlNiOmuesNGIjV6ZEtAaql+t7LaLclTsqLdjWGgtUyTYHYxqyoUKW5PZ8+oA
         CPN8+kFMBzGza8w1PEdpNYj3T/H/D2g1+h2yVb1dOKdEkXl3MW7xWHGuBNIsJuI2dpbL
         u9j8wwh7+YY8qKVkw+4OZp6+QPdQwuDjHdLCq2f4ovoXXEUt0D33oYlhzfMu86LnMiFd
         H0aY0bwtPf9reOaOak+4TqM+JB8fShj+0qc6i2vJ8aAkdg1fOGJQnnkCnCjBag5lncQf
         /4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834073; x=1690426073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOHMGk1IHW9nIXyoyhy6ScxjHGO05nJh9iYXmQJ8lRg=;
        b=aPRKv5njxJ80fRhw2Chm2/ja55w5Vs9PiELsHYO6wR8d3/ucQKrvX7bEbzFvNlFu2I
         7Y5fOROKrh89uCdl01MTUo8LX0/TOqrA/dmkuhx4lfGhOUDCpI0DcG/HZabyRAp3etS/
         U5ScdHjcqEMHwB96EjpDUEJGWy7Wr5+5+URAlpEJTENs2PgEa10RCzg2te1Gq1ACQAsJ
         Cmy9h7x0jMUzGbxfXmpM+Gh8Q8Yq9vTjSCZJQwvC1Ke4uQzYHDBfrdyF30iZMDF75V58
         +Ra8jF2q9jEXvExwAt9RSWa2zt0LSJj8ZP1pyxNV10Y0qso41aJhBGbtqn1X8OCx/oDU
         B1Rg==
X-Gm-Message-State: AC+VfDxthl9IjGrRAXooKlkSTGoiUZOZ/e/g1WzkWAW2GZ5Pg0JSnpzE
        ea63TopGWrbIvlcDhqFms1mIP5xplTs8dsKf3NO5Ag==
X-Google-Smtp-Source: ACHHUZ6c1tU80i2NFgJWtDiNUQ4dKD46I90OznjvJZlr0ZavKr0VLoNsmAzWutpLRTPpKjM4PW0xSA6rqZaKASxRktE=
X-Received: by 2002:a05:622a:5c8:b0:3ef:3361:75d5 with SMTP id
 d8-20020a05622a05c800b003ef336175d5mr537286qtb.11.1687834073238; Mon, 26 Jun
 2023 19:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-9-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-9-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 20:47:17 -0600
Message-ID: <CAOUHufZ5pAR=ySs7YyoUpum2_6tJ9jM-H608ZeQucguNGAfKTw@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] mm: Kconfig hooks to determine max anon folio
 allocation order
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> For variable-order anonymous folios, we need to determine the order that
> we will allocate. From a SW perspective, the higher the order we
> allocate, the less overhead we will have; fewer faults, fewer folios in
> lists, etc. But of course there will also be more memory wastage as the
> order increases.
>
> From a HW perspective, there are memory block sizes that can be
> beneficial to reducing TLB pressure. arm64, for example, has the ability
> to map "contpte" sized chunks (64K for a 4K base page, 2M for 16K and
> 64K base pages) such that one of these chunks only uses a single TLB
> entry.
>
> So we let the architecture specify the order of the maximally beneficial
> mapping unit when PTE-mapped. Furthermore, because in some cases, this
> order may be quite big (and therefore potentially wasteful of memory),
> allow the arch to specify 2 values; One is the max order for a mapping
> that _would not_ use THP if all size and alignment constraints were met,
> and the other is the max order for a mapping that _would_ use THP if all
> those constraints were met.
>
> Implement this with Kconfig by introducing some new options to allow the
> architecture to declare that it supports large anonymous folios along
> with these 2 preferred max order values. Then introduce a user-facing
> option, LARGE_ANON_FOLIO, which defaults to disabled and can only be
> enabled if the architecture has declared its support. When disabled, it
> forces the max order values, LARGE_ANON_FOLIO_NOTHP_ORDER_MAX and
> LARGE_ANON_FOLIO_THP_ORDER_MAX to 0, meaning only a single page is ever
> allocated.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/Kconfig  | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/memory.c |  8 ++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7672a22647b4..f4ba48c37b75 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1208,4 +1208,43 @@ config PER_VMA_LOCK
>
>  source "mm/damon/Kconfig"
>
> +config ARCH_SUPPORTS_LARGE_ANON_FOLIO
> +       def_bool n
> +       help
> +         An arch should select this symbol if wants to allow LARGE_ANON_=
FOLIO
> +         to be enabled. It must also set the following integer values:
> +         - ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +         - ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
> +
> +config ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +       int
> +       help
> +         The maximum size of folio to allocate for an anonymous VMA PTE-=
mapping
> +         that does not have the MADV_HUGEPAGE hint set.
> +
> +config ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
> +       int
> +       help
> +         The maximum size of folio to allocate for an anonymous VMA PTE-=
mapping
> +         that has the MADV_HUGEPAGE hint set.
> +
> +config LARGE_ANON_FOLIO
> +       bool "Allocate large folios for anonymous memory"
> +       depends on ARCH_SUPPORTS_LARGE_ANON_FOLIO
> +       default n
> +       help
> +         Use large (bigger than order-0) folios to back anonymous memory=
 where
> +         possible. This reduces the number of page faults, as well as ot=
her
> +         per-page overheads to improve performance for many workloads.
> +
> +config LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +       int
> +       default 0 if !LARGE_ANON_FOLIO
> +       default ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +
> +config LARGE_ANON_FOLIO_THP_ORDER_MAX
> +       int
> +       default 0 if !LARGE_ANON_FOLIO
> +       default ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
> +
>  endmenu

I don't think an MVP should add this many Kconfigs. One Kconfig sounds
reasonable to me for now.

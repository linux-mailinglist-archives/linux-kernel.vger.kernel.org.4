Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E173F0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjF0B42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0B4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:56:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145871715
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:56:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40079620a83so126291cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687830979; x=1690422979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tQeS+NgvL9gdsqnn0SpOEkHfViOYxTZPaCYpoCkL24=;
        b=60hic23BjNzvDtmwzOgn1MGUJS385E8qjRXwGDdx5oFNFXl07UFmQ8SM0jme+3UZak
         8TPvxMoBVd0/boJww6XEce0KK+tadb5kh/xWzpmyMgdh351azpInHaKRbmo4Gar6yfp1
         LpKcvaGnWt9AwvtTeNfLxJVQ42I9WXAYeV661LQvCSX90DjXZWn22h1TqBjHU1vXR7rm
         S2VerQn/OQAGb13OsVr68o0IbNssvEcNUN+Sw92W0QMmV67yGkSnOkUgWRUmZEHRdU/m
         O/fz3eCb4kPhxLrxwc2qGdcN3/Wp1+NoSkn2ZQNKQi+jsatj4YqTaMawlQlow2Gq0a0P
         NRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687830979; x=1690422979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tQeS+NgvL9gdsqnn0SpOEkHfViOYxTZPaCYpoCkL24=;
        b=D7jmPy3oG7tP3iRWWb4FJuPcHxV77aJ64gJmpiIBGLDhG2bJYBROvyG3qwGE9dVry/
         4+Yznl8b441nMuD1AXtKIyJ2OD2vKZSSxFAFlvKm6oAtVvvGV2M6nZQjZzfhYHcaLGk+
         bQcoFPQxJbL6hQGTBv3FaO6AGkNvUqrkgZ6a3yeJdfdw+IqnCHL+8nK1kL2tVmRbA+GL
         zzA0GxN4HHPSraXLUDXCNZJ3K77PzBDqDITfSJ7uS8owHss09dm4Sf50pxfv+aFrcZcQ
         kS0LvTz9TaNzVsRCk6w7AoQX5pIT+Q6KT4KUTaZEvme8mQIdo/xJhr35+8x69htx3LQi
         JLBg==
X-Gm-Message-State: AC+VfDygm0VQZnbz3WqfB++GgEnWfSdqxhVah+Yk8lGnATKCXvQvrWI6
        xRBXSnAHQNL3pMp6sij0O+H/StLI5twBszaIWCIodg==
X-Google-Smtp-Source: ACHHUZ7NGbNaYPgdhd+csLZUAO7vv9iHp/Px2n5rb+BQ+fyLrwu3yOI/1OC27EhOO3O86tRfvjvrFyJ4P7FTZVx/ap0=
X-Received: by 2002:a05:622a:24a:b0:3f6:97b4:1a4d with SMTP id
 c10-20020a05622a024a00b003f697b41a4dmr380570qtx.23.1687830978959; Mon, 26 Jun
 2023 18:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-2-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-2-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 19:55:42 -0600
Message-ID: <CAOUHufacvArJh7NjL_3LT-e3s1X+bazkvbgvEU+KPKGKEoW+dw@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] mm: Expose clear_huge_page() unconditionally
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

On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> In preparation for extending vma_alloc_zeroed_movable_folio() to
> allocate a arbitrary order folio, expose clear_huge_page()
> unconditionally, so that it can be used to zero the allocated folio in
> the generic implementation of vma_alloc_zeroed_movable_folio().
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/mm.h | 3 ++-
>  mm/memory.c        | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7f1741bd870a..7e3bf45e6491 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3684,10 +3684,11 @@ enum mf_action_page_type {
>   */
>  extern const struct attribute_group memory_failure_attr_group;
>
> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
>  extern void clear_huge_page(struct page *page,
>                             unsigned long addr_hint,
>                             unsigned int pages_per_huge_page);
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)

We might not want to depend on THP eventually. Right now, we still
have to, unless splitting is optional, which seems to contradict
06/10. (deferred_split_folio()  is a nop without THP.)

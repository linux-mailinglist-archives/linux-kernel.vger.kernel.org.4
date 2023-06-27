Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6374773F11E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjF0DCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjF0DCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:02:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2638ED
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:01:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso137751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687834919; x=1690426919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dubf60A5K0NzNIP7xjDZqZozn3KVMPgogoe8ASnGAZg=;
        b=PDCiQ+OMm+ZYhItlBm9CJOAjt3arCBaIPefCRV+cRGlKtmTkgJuKH7kAOKyAbCQJzL
         BCdmcPnotA0n4v9avoXLaITUGQgCoZm0BKEirmoOrgdrv8GGmlOoIokTT8s6lPxZIxSr
         eePAgRbrFZroffClytmh37SqL9NSTT2FHr7ZtV7QGlDkmk6KAHHYcWPVhpXKOVGr8Tr7
         Xvj/gX5em4lLmUFwa2ra0Yw/kozeJB+nK/9f/BgOWwSt6jpUIMH8XIdAtL1yeNznNHSz
         i5guqpOz9eCzUhqIk6gXiuPNKiSeUkePu5MwafnJai+nUz1Z0jF1fVOyqLoOaTDwUabC
         0MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834919; x=1690426919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dubf60A5K0NzNIP7xjDZqZozn3KVMPgogoe8ASnGAZg=;
        b=iyefE0rR5FXX6IDEXgtHAduoHr2fmo8ZGOrCKS04xtdYwCoL8WyCpJtgRPQqV7La2D
         QmyEZt79ukA3G9JmArRQd3amdl7tyF+2BEmHqvOEhd7C6/Ld+QqhP5rNSN75euPZF6WJ
         d2Qw69I035TXKc1ntnoFYpAZH9uAfaIwuwl7IIxIddKTit7pEBJvPNcF9kSAk4xkB2U1
         g0EW5ZbeaQreEreWOHLRJAzTVpSZCNaGsVl2sd5YoodrxN5h4B1N9qU8gK2OLw3KZ6hx
         oJOjXf4302meZQWOW9qmKIYxCs4rfHEqVqKJ9o1gmLTHFljCIIzNxxNrgIx4z3eWLck+
         EExA==
X-Gm-Message-State: AC+VfDyRXk5puFqLNwIP15lp+RKAu3QDfX7rqtSZisF6IWnOXL6he7oB
        K3HuBJTadEwv669PI5KdLiO/8F53Wcz2YhUcP85fJA==
X-Google-Smtp-Source: ACHHUZ5kSZ0VxsoAPI4/7ibeP7x8z7uQzBQxZXwrk6r4ft671XydiY3Jw1m0BE4SFdIns2MuaVANBIMzMf5b0M5GeEY=
X-Received: by 2002:a05:622a:1a0e:b0:3f9:a73b:57bb with SMTP id
 f14-20020a05622a1a0e00b003f9a73b57bbmr69998qtb.4.1687834918926; Mon, 26 Jun
 2023 20:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-11-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-11-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 21:01:22 -0600
Message-ID: <CAOUHufarua_JmnTu5NM-W3K4Togw+24F=Pf0HU0ZOjuwbRMC0A@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] mm: Allocate large folios for anonymous memory
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> With all of the enabler patches in place, modify the anonymous memory
> write allocation path so that it opportunistically attempts to allocate
> a large folio up to `max_anon_folio_order()` size (This value is
> ultimately configured by the architecture). This reduces the number of
> page faults, reduces the size of (e.g. LRU) lists, and generally
> improves performance by batching what were per-page operations into
> per-(large)-folio operations.
>
> If CONFIG_LARGE_ANON_FOLIO is not enabled (the default) then
> `max_anon_folio_order()` always returns 0, meaning we get the existing
> allocation behaviour.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 144 insertions(+), 15 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index a8f7e2b28d7a..d23c44cc5092 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3161,6 +3161,90 @@ static inline int max_anon_folio_order(struct vm_a=
rea_struct *vma)
>                 return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
>  }
>
> +/*
> + * Returns index of first pte that is not none, or nr if all are none.
> + */
> +static inline int check_ptes_none(pte_t *pte, int nr)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr; i++) {
> +               if (!pte_none(ptep_get(pte++)))
> +                       return i;
> +       }
> +
> +       return nr;
> +}
> +
> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int order)

As suggested previously in 03/10, we can leave this for later.

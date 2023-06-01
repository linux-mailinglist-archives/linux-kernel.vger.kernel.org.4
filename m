Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09307194F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjFAID2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFAID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:03:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21093E6A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:03:10 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75b17aa343dso46229985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685606589; x=1688198589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIxWoQMPbMs3SyYnNFpd12uvUzGg1vQdtEK/LhLStOc=;
        b=L+cEiy60nrnsyZr30rVoBm80T3+W3sdW+AT5zAPegICSqtvz7TWzCY2+Dk0r6D8PtV
         N0VO9ijzSqk2gJBxZ0pIAfZ9n0k9l6lAPn3Vcz3LwpaPHUO4SZhrbMQESkdsMvJaG/JW
         DlaHPnrT+DLQYK922xcUOZjzChtgQEkH8Op7u1d8czKB0CgxnDLRbBn9k6Wb1Vp0I2VO
         6g2PIlxWp/ZJm0GF8GUO+DtF2x2r+Yc2DI92e2x1cWWDypBwDyYSnmmzrb9YYuiSzlTS
         3PM+7wWomGxY/1jaC+N/OMtn0QSLLe+HugIMWQhcylKS4/UDdxCZimMmn2TWiExaUhyV
         D/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685606589; x=1688198589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIxWoQMPbMs3SyYnNFpd12uvUzGg1vQdtEK/LhLStOc=;
        b=RiX3sJg4LWaT6RJCiukmINM4SN0d+kVv63B9B9LdutHTWdMnwJDSgQeCdgn3Pukt90
         70NirsM8O2xktU1F+jwWYZ3PnJqfWhJFq67y091Tor/dzoprp8Rz92HvuWoJP4hyFcLu
         Xqqewfi+h0r4B44SDeCUNn6V3B7K+Yh7QC/bmZ4erZmvKhis1wMv9h2nvQO9lLBmuC9+
         VczAw1QPrfZ6g1cEbkYvWVMmg/yzV9icZwlAap67EPDCVQplpUx9/Qmr3cZHMgFiVZ8X
         JBMvSB4ahkKU2d6pFmcBvi/Adv5hUelT7C5OfBFAsrV4DYAqbNBwXSQZdx+RF2KXCy+X
         UdzQ==
X-Gm-Message-State: AC+VfDxfbk3AeaFiRli8o/QbA+MZgSEMSt2PQueQB1SqjqjLh9gBN1F7
        PdPMEwt/q6X85GbqbiMBLJotq9Qws4ZXo+vCeSpFAA==
X-Google-Smtp-Source: ACHHUZ7lA3uZW1Vp6G1Pyowwp2MLXBsBc7ROCQLXc9vzJ3EoQ+1jC8tVutyGhc5nYrDdvncql1nRlKBQBJ2OKxmdYj4=
X-Received: by 2002:a05:620a:e92:b0:75b:23a1:8308 with SMTP id
 w18-20020a05620a0e9200b0075b23a18308mr8724732qkm.3.1685606588982; Thu, 01 Jun
 2023 01:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com> <20230522112058.2965866-4-talumbau@google.com>
In-Reply-To: <20230522112058.2965866-4-talumbau@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Thu, 1 Jun 2023 16:02:58 +0800
Message-ID: <CAJj2-QHSBPNhuM2EY3Hki=-Xq_H-k2zutm7xJGCP+fCqfCqt1g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 4/4] mm: multi-gen LRU: cleanup lru_gen_test_recent()
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
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

On Mon, May 22, 2023 at 7:21=E2=80=AFPM T.J. Alumbaugh <talumbau@google.com=
> wrote:
>
> Avoid passing memcg* and pglist_data* to lru_gen_test_recent()
> since we only use the lruvec anyway.
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>  mm/workingset.c | 46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 90ae785d4c9c..5796e927e6d7 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -257,59 +257,46 @@ static void *lru_gen_eviction(struct folio *folio)
>
>  /*
>   * Tests if the shadow entry is for a folio that was recently evicted.
> - * Fills in @memcgid, @pglist_data, @token, @workingset with the values
> - * unpacked from shadow.
> + * Fills in @lruvec, @token, @workingset with the values unpacked from s=
hadow.
>   */
> -static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> -               struct pglist_data **pgdat, unsigned long *token, bool *w=
orkingset)
> +static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec *=
*lruvec,
> +                               unsigned long *token, bool *workingset)
>  {
> -       struct mem_cgroup *eviction_memcg;
> -       struct lruvec *lruvec;
> -       struct lru_gen_folio *lrugen;
> +       int memcg_id;
>         unsigned long min_seq;
> +       struct mem_cgroup *memcg;
> +       struct pglist_data *pgdat;
>
> -       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> -       eviction_memcg =3D mem_cgroup_from_id(*memcgid);
> +       unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
>
> -       lruvec =3D mem_cgroup_lruvec(eviction_memcg, *pgdat);
> -       lrugen =3D &lruvec->lrugen;
> +       memcg =3D mem_cgroup_from_id(memcg_id);
> +       *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>
> -       min_seq =3D READ_ONCE(lrugen->min_seq[file]);
> +       min_seq =3D READ_ONCE((*lruvec)->lrugen.min_seq[file]);
>         return (*token >> LRU_REFS_WIDTH) =3D=3D (min_seq & (EVICTION_MAS=
K >> LRU_REFS_WIDTH));
>  }
>
>  static void lru_gen_refault(struct folio *folio, void *shadow)
>  {
>         int hist, tier, refs;
> -       int memcg_id;
>         bool workingset;
>         unsigned long token;
> -       unsigned long min_seq;
>         struct lruvec *lruvec;
>         struct lru_gen_folio *lrugen;
> -       struct mem_cgroup *memcg;
> -       struct pglist_data *pgdat;
>         int type =3D folio_is_file_lru(folio);
>         int delta =3D folio_nr_pages(folio);
>
>         rcu_read_lock();
>
> -       if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
> -                       &workingset))
> +       if (!lru_gen_test_recent(shadow, type, &lruvec, &token, &workings=
et))
>                 goto unlock;
>
> -       memcg =3D folio_memcg_rcu(folio);
> -       if (memcg_id !=3D mem_cgroup_id(memcg))
> +       if (lruvec !=3D folio_lruvec(folio))
>                 goto unlock;
>
> -       if (pgdat !=3D folio_pgdat(folio))
> -               goto unlock;
> -
> -       lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>         lrugen =3D &lruvec->lrugen;
> -       min_seq =3D READ_ONCE(lrugen->min_seq[type]);
>
> -       hist =3D lru_hist_from_seq(min_seq);
> +       hist =3D lru_hist_from_seq(READ_ONCE(lrugen->min_seq[type]));
>         /* see the comment in folio_lru_refs() */
>         refs =3D (token & (BIT(LRU_REFS_WIDTH) - 1)) + workingset;
>         tier =3D lru_tier_from_refs(refs);
> @@ -339,8 +326,8 @@ static void *lru_gen_eviction(struct folio *folio)
>         return NULL;
>  }
>
> -static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> -               struct pglist_data **pgdat, unsigned long *token, bool *w=
orkingset)
> +static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec *=
*lruvec,
> +                               unsigned long *token, bool *workingset)
>  {
>         return false;
>  }
> @@ -435,8 +422,7 @@ bool workingset_test_recent(void *shadow, bool file, =
bool *workingset)
>         unsigned long eviction;
>
>         if (lru_gen_enabled())
> -               return lru_gen_test_recent(shadow, file, &memcgid, &pgdat=
, &eviction,
> -                       workingset);
> +               return lru_gen_test_recent(shadow, file, &eviction_lruvec=
, &eviction, workingset);
>
>         unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
>         eviction <<=3D bucket_order;
> --
> 2.40.1.698.g37aff9b760-goog
>
Reviewed-by: Yuanchu Xie <yuanchu@google.com>

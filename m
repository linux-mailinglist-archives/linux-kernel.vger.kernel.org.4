Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999474F667
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGKRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjGKRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:05:37 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41460B7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:05:36 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57d24970042so6317877b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689095135; x=1691687135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egt2ow1fWfYS8Gw95Yl0UW2LZk+PQZpFZ+iHkx63nEU=;
        b=ecuxrJucUhDGppYS/qb0NC3IHv/38+Hvtpuhc9jQb3nZB3pq0gP7fi6JvuTEalDYTt
         rSIk5nkzXuyFzlPXFlekWycYD0Z+BzSgopxWgQo9E/6lG7VkxAIz6xUr8Kk2zc7wIkrp
         N1zxq9PI6ERSfBZFkSFm70vq50/bDRsuV6rmTHg0Nqdm4divdscl+t+FACP5CuAk/DOq
         irtWCuMXtFjCUX+TLeOVjiNawUzNd1RF41x0S7QtJmM+bUagol2k7o5bUrJDohv2INmp
         5rHbDonugyo6XIyYRNeZx86NAJ7YurTV9jgFQ/YmGJB7RgPFimMNfSQFJ6ODczlwBiTJ
         xPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689095135; x=1691687135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egt2ow1fWfYS8Gw95Yl0UW2LZk+PQZpFZ+iHkx63nEU=;
        b=OBJnCnYWcPHU449mVhO4V42HiOZCODugthkUlB8XhHPNNgznohWdXeEDK6Sm60XZ5n
         LDduETjcKt3KfoB3yywfF4VFpGbh9YcSS1IfIxNRJvSD7N8d+WVtAXx+kGPphwZuEMAg
         lwJZYLLbHy66WkdqINQ2oGE9h90QR1q8ekNU/hKInMQoeWy6RBZ+gdVZIAn0nX8AwiEg
         YsK3MQcdq9stgNfBNces7DYMzYXaxsfLBxSt5bOeteePaUvRWPvdyLxn84Jt/6gzJOO/
         N9H13DnSX8vGTNp64+Rlnym5cKeo2I9fdnp+p1oKDbMtCJKVDz6E0azsXfbLQJwaLQzK
         yKaA==
X-Gm-Message-State: ABy/qLYip1o+Q4ncGnNyeFYFcI/XCzv0c8C/Givz+WNeUecH4pV+J2XT
        AxKfNe+Psh7gwJ9YVIZex9gQlYpYGTe6fVmnz+uv8w==
X-Google-Smtp-Source: APBJJlGwX8m5ob2cXU4K9uII5megnsCGiF69LmucGrIx/ZEsclmQh1ho0vxb69t4Dee/wTcKhM3uTHiF2TUVEIRDfoc=
X-Received: by 2002:a81:730b:0:b0:56c:fd16:330f with SMTP id
 o11-20020a81730b000000b0056cfd16330fmr14511958ywc.12.1689095135312; Tue, 11
 Jul 2023 10:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com> <20230707201904.953262-3-jiaqiyan@google.com>
 <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com> <CACw3F50k9WJr7WgHS-dRxJRfuXPbq2adUBLeFcKRjmm2D6qf-g@mail.gmail.com>
In-Reply-To: <CACw3F50k9WJr7WgHS-dRxJRfuXPbq2adUBLeFcKRjmm2D6qf-g@mail.gmail.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Tue, 11 Jul 2023 10:05:21 -0700
Message-ID: <CACw3F52Pj+SeB+dD2Cjkr-bX-OZkmCpL1s6SO1aHDvaD37YZBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 8:16=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> On Fri, Jul 7, 2023 at 7:57=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> =
wrote:
> >
> > On 2023/7/8 4:19, Jiaqi Yan wrote:
> > > Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> > > hugetlb folio is a raw HWPOISON page. This functionality relies on
> > > RawHwpUnreliable to be not set; otherwise hugepage's raw HWPOISON lis=
t
> > > becomes meaningless.
> > >
> > > is_raw_hwp_subpage needs to hold hugetlb_lock in order to synchronize
> > > with __get_huge_page_for_hwpoison, who iterates and inserts an entry =
to
> > > raw_hwp_list. llist itself doesn't ensure insertion is synchornized w=
ith
> > > the iterating used by __is_raw_hwp_list. Caller can minimize the
> > > overhead of lock cycles by first checking if folio / head page's
> > > HWPOISON flag is set.
> > >
> > > Exports this functionality to be immediately used in the read operati=
on
> > > for hugetlbfs.
> > >
> > > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > ---
> > >  include/linux/hugetlb.h | 19 +++++++++++++++++++
> > >  include/linux/mm.h      |  7 +++++++
> > >  mm/hugetlb.c            | 10 ++++++++++
> > >  mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
> > >  4 files changed, 60 insertions(+), 10 deletions(-)
> > > ...
> > > -static inline struct llist_head *raw_hwp_list_head(struct folio *fol=
io)
> > > +bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> > >  {
> > > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > +     struct llist_head *raw_hwp_head;
> > > +     struct raw_hwp_page *p, *tmp;
> > > +     bool ret =3D false;
> > > +
> > > +     if (!folio_test_hwpoison(folio))
> > > +             return false;
> > > +
> > > +     /*
> > > +      * When RawHwpUnreliable is set, kernel lost track of which sub=
pages
> > > +      * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> > > +      */
> > > +     if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> > > +             return true;
> > > +
> > > +     raw_hwp_head =3D raw_hwp_list_head(folio);
> > > +     llist_for_each_entry_safe(p, tmp, raw_hwp_head->first, node) {
> >
> > Since we don't free the raw_hwp_list, does llist_for_each_entry works s=
ame as llist_for_each_entry_safe?

Sorry I missed this comment. Yes they are the same but
llist_for_each_entry doesn't need "tmp". I will switch to
llist_for_each_entry in v4.

>
> >
> > > +             if (subpage =3D=3D p->page) {
> > > +                     ret =3D true;
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     return ret;
> > >  }
> >
> > It seems there's a race between __is_raw_hwp_subpage and unpoison_memor=
y:
> >   unpoison_memory               __is_raw_hwp_subpage
> >                                   if (!folio_test_hwpoison(folio)) -- h=
wpoison is set
> >     folio_free_raw_hwp            llist_for_each_entry_safe raw_hwp_lis=
t
> >       llist_del_all                 ..
> >     folio_test_clear_hwpoison
> >
>
> Thanks Miaohe for raising this concern.
>
> > But __is_raw_hwp_subpage is used in hugetlbfs, unpoison_memory couldn't=
 reach here because there's a
> > folio_mapping =3D=3D NULL check before folio_free_raw_hwp.
>
> I agree. But in near future I do want to make __is_raw_hwp_subpage
> work for shared-mapping hugetlb, so it would be nice to work with
> unpoison_memory. It doesn't seem to me that holding mf_mutex in
> __is_raw_hwp_subpage is nice or even absolutely correct. Let me think
> if I can come up with something in v4.

At my 2nd thought, if __is_raw_hwp_subpage simply takes mf_mutex
before llist_for_each_entry, it will introduce a deadlock:

unpoison_memory                       __is_raw_hwp_subpage
  held mf_mutex                         held hugetlb_lock
  get_hwpoison_hugetlb_folio            attempts mf_mutex
    attempts hugetlb lock

Not for this patch series, but for future, is it a good idea to make
mf_mutex available to hugetlb code? Then enforce the order of locking
to be mf_mutex first, hugetlb_lock second? I believe this is the
current locking pattern / order for try_memory_failure_hugetlb.


>
> >
> > Anyway, this patch looks good to me.
> >
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > Thanks.
> >

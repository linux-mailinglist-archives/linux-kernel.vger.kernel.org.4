Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2174D9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGJPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGJPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:17:08 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3BA0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:17:07 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57012b2973eso59829157b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689002227; x=1691594227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev9w8qY5qeXK6l96dBjt1M0c/nck2SlIA1nfO//2Cvg=;
        b=UXvy2lXuacyPSAIEDq5qk/QFhDP0pWrsvmHQao1FdXfgkWCCTkvztAJoL4KblYUUIn
         Id6XFTfQ7pGHNwDVV0tIbF3GxZp5av38rOxIT6RcYIEhgy4qlSnbmn/zrnLUvwzPWO0Y
         WYU6B8NWzON02+L61fxZmg49WwdNMkUrzaCU3ws366Y1MNmH4VJ3/IozxXvyFjnCM5Rv
         8tJzfW4PTjiifwQ0kUJ6+yrqLA7N9CGXNOpufniE4821v5bcmEe2cP6YitHieT7uRIBW
         7UWH+6fhv8DJJL9XxsmXLAEqeQaVt/0wfaTD+1WUG3ujlv6L5G6kjyH9qwzAVkrFBAdV
         AIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002227; x=1691594227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev9w8qY5qeXK6l96dBjt1M0c/nck2SlIA1nfO//2Cvg=;
        b=Vh1GgHnGiL6AB+T+ZdRJjgIccolbLgfjkABXyLwKRkugO1/uemP3CqzyNFLOgLcbeq
         0YLF4aIhkLnX84vGrag6DQJv7J7pCnloJ5K+mfFLnMfbRYlktz9PmlypWI/Qu+5uoD2H
         Bh7SUDTy2Q2nJdWD87C1IqlwOynmsy064+3j+5gRvkR9m83xMiceOvEoCSCdL1O0UClJ
         Hh9CJUXlvC3gJcbK8QYbNFOUts1a+0XOyWfioEc9JGckCsev0KVQJQFHogUPhMdm0LUH
         Ej32uB7VDbqY8UkFPxuwSNAJJVNxGP4ph4BlOROaiVi4U06yT5nIdOroT71BHuNugjF1
         4qBw==
X-Gm-Message-State: ABy/qLa/K0/WHbOTnBwoqMK1MtY8sJPAMUHKNcwkKUrrXEUlAokzX2qT
        4dDkrq3WNiLGXM1Go4BAG6a+x+DrVoSTdLqCWtmyUA==
X-Google-Smtp-Source: APBJJlH/mdYwBePFgE2xPEQJ8BWpSbYER3+V0l6Dh7xD0Ej6k2tSZSaudJZCmfy3XG72u8/rjHDCdvJ288fZPdgHje4=
X-Received: by 2002:a0d:ca0e:0:b0:56d:28b:8042 with SMTP id
 m14-20020a0dca0e000000b0056d028b8042mr11153655ywd.40.1689002226674; Mon, 10
 Jul 2023 08:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com> <20230707201904.953262-3-jiaqiyan@google.com>
 <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com>
In-Reply-To: <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Mon, 10 Jul 2023 08:16:53 -0700
Message-ID: <CACw3F50k9WJr7WgHS-dRxJRfuXPbq2adUBLeFcKRjmm2D6qf-g@mail.gmail.com>
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

On Fri, Jul 7, 2023 at 7:57=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> wr=
ote:
>
> On 2023/7/8 4:19, Jiaqi Yan wrote:
> > Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> > hugetlb folio is a raw HWPOISON page. This functionality relies on
> > RawHwpUnreliable to be not set; otherwise hugepage's raw HWPOISON list
> > becomes meaningless.
> >
> > is_raw_hwp_subpage needs to hold hugetlb_lock in order to synchronize
> > with __get_huge_page_for_hwpoison, who iterates and inserts an entry to
> > raw_hwp_list. llist itself doesn't ensure insertion is synchornized wit=
h
> > the iterating used by __is_raw_hwp_list. Caller can minimize the
> > overhead of lock cycles by first checking if folio / head page's
> > HWPOISON flag is set.
> >
> > Exports this functionality to be immediately used in the read operation
> > for hugetlbfs.
> >
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  include/linux/hugetlb.h | 19 +++++++++++++++++++
> >  include/linux/mm.h      |  7 +++++++
> >  mm/hugetlb.c            | 10 ++++++++++
> >  mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
> >  4 files changed, 60 insertions(+), 10 deletions(-)
> > ...
> > -static inline struct llist_head *raw_hwp_list_head(struct folio *folio=
)
> > +bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> >  {
> > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > +     struct llist_head *raw_hwp_head;
> > +     struct raw_hwp_page *p, *tmp;
> > +     bool ret =3D false;
> > +
> > +     if (!folio_test_hwpoison(folio))
> > +             return false;
> > +
> > +     /*
> > +      * When RawHwpUnreliable is set, kernel lost track of which subpa=
ges
> > +      * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> > +      */
> > +     if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> > +             return true;
> > +
> > +     raw_hwp_head =3D raw_hwp_list_head(folio);
> > +     llist_for_each_entry_safe(p, tmp, raw_hwp_head->first, node) {
>
> Since we don't free the raw_hwp_list, does llist_for_each_entry works sam=
e as llist_for_each_entry_safe?
>
> > +             if (subpage =3D=3D p->page) {
> > +                     ret =3D true;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return ret;
> >  }
>
> It seems there's a race between __is_raw_hwp_subpage and unpoison_memory:
>   unpoison_memory               __is_raw_hwp_subpage
>                                   if (!folio_test_hwpoison(folio)) -- hwp=
oison is set
>     folio_free_raw_hwp            llist_for_each_entry_safe raw_hwp_list
>       llist_del_all                 ..
>     folio_test_clear_hwpoison
>

Thanks Miaohe for raising this concern.

> But __is_raw_hwp_subpage is used in hugetlbfs, unpoison_memory couldn't r=
each here because there's a
> folio_mapping =3D=3D NULL check before folio_free_raw_hwp.

I agree. But in near future I do want to make __is_raw_hwp_subpage
work for shared-mapping hugetlb, so it would be nice to work with
unpoison_memory. It doesn't seem to me that holding mf_mutex in
__is_raw_hwp_subpage is nice or even absolutely correct. Let me think
if I can come up with something in v4.

>
> Anyway, this patch looks good to me.
>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Thanks.
>

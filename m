Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1095E70A10C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjESUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjESUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:32 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E6132
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561c46e07d7so51324107b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684529670; x=1687121670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B95I2ErHfSKpIP3GGiqUWw60UUrTwERJDKlWWGCQqAQ=;
        b=D18JUVsLkLZpjvIl5h5Dwd1u8deHaloBFH+VD56K9Pdzc3bUoQb6zAaly1nHAbG4tg
         hSUhiBTQAzZMvTnFds5VA/Luy9aSR7sOTjKihgkwllwh6hj1+yqzRRBL/Qa5sVJ+5AGV
         FOtgOdXbjAdTsFhW7DwRRvDoaAAiSlghKBrbyrwW66or+00+Yiiy3mau838YOBmQyFv3
         4KWfcXdDmWw4JDDXlThdopr/dMvXQgfNx2JviUt4N3LQXdsQ2q5sFkACnAL4eNS122+G
         VX8qB8CxUjETI+qFntxQ1VOItlyzKQvXkXphMqDNGBAK9CEW9l98Qeo+/DgbgAgDe0Rq
         cR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529670; x=1687121670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B95I2ErHfSKpIP3GGiqUWw60UUrTwERJDKlWWGCQqAQ=;
        b=cz4MUU1pawJZTdK1GmJVDqhWXAxbpfgX7XKdlll23R8+WfzeRdEY6dwJL/2MezuvDQ
         i+g0p17oBvv+75z2ER3/35tRoYUuTLmJ/SEHoQHW4tOQZpwQyMzj9mDS7XYw6mlJtlgA
         MUPWRBW1/Ik1y2i/0BA3OhP+fVuyFq52WwlfO3K8EaTd6FSF0PA0g8YEjcDxWa3egLZ7
         KP3qz2yc395FZXLnAGoL97ijL5RcUPaQHAFKYiEZBu9I2bM3fI5scHc3+Xo46VyHyyU5
         Lcmf2qYWRCqZQtPUqocfNiDFwmFy0IcrXH6ypMctq2vnNx7cQL595Qxs2+f0daDOS+cD
         cqtw==
X-Gm-Message-State: AC+VfDyY2Zn7Hl55srUNz/DzRB39uFetvMR85t6BexM06OYkSh/0hpqr
        dFJtprGtbHexVg5d9pcVQfI6Kh3q+IYa3NoxF8JdqA==
X-Google-Smtp-Source: ACHHUZ7PilSNBvSKDgQ0Ty7EsCa7E2fB2HBgS0jvDO3j1+0fsunx8Hx6LGEPhE48lpQ8s/MJQFmCDRbkT8ISYeuVkFs=
X-Received: by 2002:a81:a554:0:b0:562:1060:f2c9 with SMTP id
 v20-20020a81a554000000b005621060f2c9mr3296846ywg.13.1684529669598; Fri, 19
 May 2023 13:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com> <20230517160948.811355-2-jiaqiyan@google.com>
 <20230517235314.GB10757@monkey>
In-Reply-To: <20230517235314.GB10757@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 19 May 2023 13:54:18 -0700
Message-ID: <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
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

On Wed, May 17, 2023 at 4:53=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 05/17/23 16:09, Jiaqi Yan wrote:
> > Adds the functionality to search a subpage's corresponding raw_hwp_page
> > in hugetlb page's HWPOISON list. This functionality can also tell if a
> > subpage is a raw HWPOISON page.
> >
> > Exports this functionality to be immediately used in the read operation
> > for hugetlbfs.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> >  mm/memory-failure.c | 26 ++++++++++++++++----------
> >  2 files changed, 39 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 27ce77080c79..f191a4119719 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
>
> Any reason why you decided to add the following to linux/mm.h instead of
> linux/hugetlb.h?  Since it is hugetlb specific I would have thought
> hugetlb.h was more appropriate.
>
> > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> >   */
> >  extern const struct attribute_group memory_failure_attr_group;
> >
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +/*
> > + * Struct raw_hwp_page represents information about "raw error page",
> > + * constructing singly linked list from ->_hugetlb_hwpoison field of f=
olio.
> > + */
> > +struct raw_hwp_page {
> > +     struct llist_node node;
> > +     struct page *page;
> > +};
> > +
> > +static inline struct llist_head *raw_hwp_list_head(struct folio *folio=
)
> > +{
> > +     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > +}
> > +
> > +/*
> > + * Given @subpage, a raw page in a hugepage, find its location in @fol=
io's
> > + * _hugetlb_hwpoison list. Return NULL if @subpage is not in the list.
> > + */
> > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > +                                    struct page *subpage);
> > +#endif
> > +
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> >  extern void clear_huge_page(struct page *page,
> >                           unsigned long addr_hint,
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 5b663eca1f29..c49e6c2d1f07 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> >  #endif /* CONFIG_FS_DAX */
> >
> >  #ifdef CONFIG_HUGETLB_PAGE
> > -/*
> > - * Struct raw_hwp_page represents information about "raw error page",
> > - * constructing singly linked list from ->_hugetlb_hwpoison field of f=
olio.
> > - */
> > -struct raw_hwp_page {
> > -     struct llist_node node;
> > -     struct page *page;
> > -};
> >
> > -static inline struct llist_head *raw_hwp_list_head(struct folio *folio=
)
> > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > +                                    struct page *subpage)
> >  {
> > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > +     struct llist_node *t, *tnode;
> > +     struct llist_head *raw_hwp_head =3D raw_hwp_list_head(folio);
> > +     struct raw_hwp_page *hwp_page =3D NULL;
> > +     struct raw_hwp_page *p;
> > +
> > +     llist_for_each_safe(tnode, t, raw_hwp_head->first) {
>
> IIUC, in rare error cases a hugetlb page can be poisoned WITHOUT a
> raw_hwp_list.  This is indicated by the hugetlb page specific flag
> RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().
>
> Looks like this routine does not consider that case.  Seems like it shoul=
d
> always return the passed subpage if folio_test_hugetlb_raw_hwp_unreliable=
()
> is true?

Thanks for catching this. I wonder should this routine consider
RawHwpUnreliable or should the caller do.

find_raw_hwp_page now returns raw_hwp_page* in the llist entry to
caller (valid one at the moment), but once RawHwpUnreliable is set,
all the raw_hwp_page in the llist will be kfree(), and the returned
value becomes dangling pointer to caller (if the caller holds that
caller long enough). Maybe returning a bool would be safer to the
caller? If the routine returns bool, then checking RawHwpUnreliable
can definitely be within the routine.

Another option is, this routine simply doesn one thing: find a
raw_hwp_page in raw_hwp_list for a subpage. But the caller needs to 1)
test RawHwpUnreliable before calls into the routine, and 2) test
RawHwpUnreliable before access returned raw_hwp_page*. I think 2nd
option will be error-prone and the 1st option is a better one.

Maybe I am over-thinking. What do you think?

> --
> Mike Kravetz
>
> > +             p =3D container_of(tnode, struct raw_hwp_page, node);
> > +             if (subpage =3D=3D p->page) {
> > +                     hwp_page =3D p;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return hwp_page;
> >  }
> >
> >  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool mo=
ve_flag)
> > --
> > 2.40.1.606.ga4b1b128d6-goog
> >

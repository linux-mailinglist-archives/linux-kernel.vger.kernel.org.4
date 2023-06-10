Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3972A93E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFJFtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJFtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:49:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23E3AA7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 22:48:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bc476bf5239so240589276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686376139; x=1688968139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNKbpa9Pu7wgeLeX9XS4+eS+VovsVvMpWBnZ1K6EmSQ=;
        b=E+W/H2ihv6nz8SrQsk7DZqfzgtf9G2USASXlraBQmTefoFEMfctooJbmyDW4et4XlG
         PEC/YuDMj3hGY7dqNqefEM9VHwKeEkFA9SYKhpKwl7M95KQg4N2eFXI7xpGje525YzsT
         Bo+U/OKv3BegK6z0UsRPzpvOP5U4C8aazN2DOyTfuLAeU5XxYBKE2T+KKF/wxuofGBGx
         x4ok2Us19SVAbXdNGyDvaJxBFPY1XeFdzcoeWkiisOOaV1DP/yZt7NDOEb003i26hw/Z
         6QudsLZs9g6rUEgXuFjT4NF1kflhv84zkny6G/fkh+/tqWGek5v4n9gM51I6K9RxGOc2
         2ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686376139; x=1688968139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNKbpa9Pu7wgeLeX9XS4+eS+VovsVvMpWBnZ1K6EmSQ=;
        b=fDdLZxYeAkoYN5VaTlx36a4h5tIpVe6aGon4aqnrNn5YUCr/Cf+SiA2xe82uP5rZoW
         260E2x9qHxbWUHHw27MU9Zfy+w2ijcKk0r6TEuWGA7+bGOK8gO02+/JuVkbJRpgDIJdi
         h/yDVAawGyxR//JplfqDkM/F8+WQ4F/aQUBqLzyx5O/bmZ6Oh8oeh5nItpvbLbXAnRj0
         e+jYWekn05r+V41u01vFv5Ic2wHLEG5De2Jv3w0JtOTzeQMaIsk2UZL/WLtJfSP9DpCu
         MrckbTpMhtBX9O241wYcjzs0iPNROkJHG5t0D0wWVNfNtpHZw5V5qquCfP+uxhPqXRVY
         eumw==
X-Gm-Message-State: AC+VfDxTfJtwywLF/ngQ90fKLptrptWFV1ooaV8ACkLE5AXJWHKqAqGg
        DaGH1yu7IHBRJNMl5I4lcGezMN6MxoEBHZ68idaSqQ==
X-Google-Smtp-Source: ACHHUZ76KAH8I31gAJF+2K0bUt4R3l0POI3dGOONWkYHMDH5hLc1vqPlJbkULsWtPuWo5a4vEOu8FSL+BfSXppyqo9I=
X-Received: by 2002:a0d:db4a:0:b0:56a:3b3e:bc6 with SMTP id
 d71-20020a0ddb4a000000b0056a3b3e0bc6mr3489976ywe.14.1686376138762; Fri, 09
 Jun 2023 22:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com> <20230517160948.811355-2-jiaqiyan@google.com>
 <20230517235314.GB10757@monkey> <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey> <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp> <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
In-Reply-To: <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 9 Jun 2023 22:48:47 -0700
Message-ID: <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
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

On Thu, May 25, 2023 at 5:28=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> On Mon, May 22, 2023 at 7:43=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=
=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> <naoya.horiguchi@nec.com> wrote:
> >
> > On Mon, May 22, 2023 at 11:22:49AM -0700, Jiaqi Yan wrote:
> > > On Sun, May 21, 2023 at 9:50=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=E5=
=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > <naoya.horiguchi@nec.com> wrote:
> > > >
> > > > On Fri, May 19, 2023 at 03:42:14PM -0700, Mike Kravetz wrote:
> > > > > On 05/19/23 13:54, Jiaqi Yan wrote:
> > > > > > On Wed, May 17, 2023 at 4:53=E2=80=AFPM Mike Kravetz <mike.krav=
etz@oracle.com> wrote:
> > > > > > >
> > > > > > > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > > > > > > Adds the functionality to search a subpage's corresponding =
raw_hwp_page
> > > > > > > > in hugetlb page's HWPOISON list. This functionality can als=
o tell if a
> > > > > > > > subpage is a raw HWPOISON page.
> > > > > > > >
> > > > > > > > Exports this functionality to be immediately used in the re=
ad operation
> > > > > > > > for hugetlbfs.
> > > > > > > >
> > > > > > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > > > > > ---
> > > > > > > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > > > > > > >  mm/memory-failure.c | 26 ++++++++++++++++----------
> > > > > > > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > index 27ce77080c79..f191a4119719 100644
> > > > > > > > --- a/include/linux/mm.h
> > > > > > > > +++ b/include/linux/mm.h
> > > > > > >
> > > > > > > Any reason why you decided to add the following to linux/mm.h=
 instead of
> > > > > > > linux/hugetlb.h?  Since it is hugetlb specific I would have t=
hought
> > > > > > > hugetlb.h was more appropriate.
> > > > > > >
> > > > > > > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > > > > > > >   */
> > > > > > > >  extern const struct attribute_group memory_failure_attr_gr=
oup;
> > > > > > > >
> > > > > > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > +/*
> > > > > > > > + * Struct raw_hwp_page represents information about "raw e=
rror page",
> > > > > > > > + * constructing singly linked list from ->_hugetlb_hwpoiso=
n field of folio.
> > > > > > > > + */
> > > > > > > > +struct raw_hwp_page {
> > > > > > > > +     struct llist_node node;
> > > > > > > > +     struct page *page;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static inline struct llist_head *raw_hwp_list_head(struct =
folio *folio)
> > > > > > > > +{
> > > > > > > > +     return (struct llist_head *)&folio->_hugetlb_hwpoison=
;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * Given @subpage, a raw page in a hugepage, find its loca=
tion in @folio's
> > > > > > > > + * _hugetlb_hwpoison list. Return NULL if @subpage is not =
in the list.
> > > > > > > > + */
> > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio=
,
> > > > > > > > +                                    struct page *subpage);
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG=
_HUGETLBFS)
> > > > > > > >  extern void clear_huge_page(struct page *page,
> > > > > > > >                           unsigned long addr_hint,
> > > > > > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > > > > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > > > > > > --- a/mm/memory-failure.c
> > > > > > > > +++ b/mm/memory-failure.c
> > > > > > > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs=
);
> > > > > > > >  #endif /* CONFIG_FS_DAX */
> > > > > > > >
> > > > > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > -/*
> > > > > > > > - * Struct raw_hwp_page represents information about "raw e=
rror page",
> > > > > > > > - * constructing singly linked list from ->_hugetlb_hwpoiso=
n field of folio.
> > > > > > > > - */
> > > > > > > > -struct raw_hwp_page {
> > > > > > > > -     struct llist_node node;
> > > > > > > > -     struct page *page;
> > > > > > > > -};
> > > > > > > >
> > > > > > > > -static inline struct llist_head *raw_hwp_list_head(struct =
folio *folio)
> > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio=
,
> > > > > > > > +                                    struct page *subpage)
> > > > > > > >  {
> > > > > > > > -     return (struct llist_head *)&folio->_hugetlb_hwpoison=
;
> > > > > > > > +     struct llist_node *t, *tnode;
> > > > > > > > +     struct llist_head *raw_hwp_head =3D raw_hwp_list_head=
(folio);
> > > > > > > > +     struct raw_hwp_page *hwp_page =3D NULL;
> > > > > > > > +     struct raw_hwp_page *p;
> > > > > > > > +
> > > > > > > > +     llist_for_each_safe(tnode, t, raw_hwp_head->first) {
> > > > > > >
> > > > > > > IIUC, in rare error cases a hugetlb page can be poisoned WITH=
OUT a
> > > > > > > raw_hwp_list.  This is indicated by the hugetlb page specific=
 flag
> > > > > > > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().
> > > > > > >
> > > > > > > Looks like this routine does not consider that case.  Seems l=
ike it should
> > > > > > > always return the passed subpage if folio_test_hugetlb_raw_hw=
p_unreliable()
> > > > > > > is true?
> > > > > >
> > > > > > Thanks for catching this. I wonder should this routine consider
> > > > > > RawHwpUnreliable or should the caller do.
> > > > > >
> > > > > > find_raw_hwp_page now returns raw_hwp_page* in the llist entry =
to
> > > > > > caller (valid one at the moment), but once RawHwpUnreliable is =
set,
> > > > > > all the raw_hwp_page in the llist will be kfree(), and the retu=
rned
> > > > > > value becomes dangling pointer to caller (if the caller holds t=
hat
> > > > > > caller long enough). Maybe returning a bool would be safer to t=
he
> > > > > > caller? If the routine returns bool, then checking RawHwpUnreli=
able
> > > > > > can definitely be within the routine.
> > > > >
> > > > > I think the check for RawHwpUnreliable should be within this rout=
ine.
> > > > > Looking closer at the code, I do not see any way to synchronize t=
his.
> > > > > It looks like manipulation in the memory-failure code would be
> > > > > synchronized via the mf_mutex.  However, I do not see how travers=
al and
> > > > > freeing of the raw_hwp_list  called from __update_and_free_hugetl=
b_folio
> > > > > is synchronized against memory-failure code modifying the list.
> > > > >
> > > > > Naoya, can you provide some thoughts?
> > > >
> > > > Thanks for elaborating the issue.  I think that making find_raw_hwp=
_page() and
> > > > folio_clear_hugetlb_hwpoison() do their works within mf_mutex can b=
e one solution.
> > > > try_memory_failure_hugetlb(), one of the callers of folio_clear_hug=
etlb_hwpoison(),
> > > > already calls it within mf_mutex, so some wrapper might be needed t=
o implement
> > > > calling path from __update_and_free_hugetlb_folio() to take mf_mute=
x.
> > > >
> > > > It might be a concern that mf_mutex is a big lock to cover overall =
hwpoison
> > > > subsystem, but I think that the impact is not so big if the changed=
 code paths
> > > > take mf_mutex only after checking hwpoisoned hugepage.  Maybe using=
 folio_lock
> > > > to synchronize accesses to the raw_hwp_list could be possible, but =
currently
> > > > __get_huge_page_for_hwpoison() calls folio_set_hugetlb_hwpoison() w=
ithout
> > > > folio_lock, so this approach needs update on locking rule and it so=
unds more
> > > > error-prone to me.
> > >
> > > Thanks Naoya, since memory_failure is the main user of raw_hwp_list, =
I
> > > agree mf_mutex could help to sync its two del_all operations (one fro=
m
> > > try_memory_failure_hugetlb and one from
> > > __update_and_free_hugetlb_folio).
> > >
> > > I still want to ask a perhaps stupid question, somewhat related to ho=
w
> > > to implement find_raw_hwp_page() correctly. It seems
> > > llist_for_each_safe should only be used to traverse after list entrie=
s
> > > already *deleted* via llist_del_all. But the llist_for_each_safe call=
s
> > > in memory_failure today is used *directly* on the raw_hwp_list. This
> > > is quite different from other users of llist_for_each_safe (for
> > > example, kernel/bpf/memalloc.c).
> >
> > Oh, I don't noticed that when writing the original code. (I just chose
> > llist_for_each_safe because I just wanted struct llist_node as a singly
> > linked list.)
>
> And maybe because you can avoid doing INIT_LIST_HEAD (which seems
> doable in folio_set_hugetlb_hwpoison if hugepage is hwpoison-ed for
> the first time)?
>
> >
> > >  Why is it correct? I guess mostly
> > > because they are sync-ed under mf_mutex (except the missing coverage
> > > on __update_and_free_hugetlb_folio)?
> >
> > Yes, and there seems no good reason to use the macro llist_for_each_saf=
e
> > here.  I think it's OK to switch to simpler one like list_for_each whic=
h
> > should be supposed to be called directly.  To do this, struct raw_hwp_p=
age
> > need to have @node (typed struct list_head instead of struct llist_node=
).

Hi Naoya, a maybe-stupid question on list vs llist: _hugetlb_hwpoison
in folio is a void*. struct list_head is composed of two pointers to
list_node (prev and next) so folio just can't hold a list_head in the
_hugetlb_hwpoison field, right? llist_head on the other hand only
contains one pointer to llist_node first. I wonder if this is one of
the reason you picked llist instead of list in the first place.

The reason I ask is while I was testing my refactor draft, I
constantly see the refcount of the 3rd subpage in the folio got
corrupted. I am not sure about the exact reason but it feels to me
related to the above reason.

>
> I will start to work on a separate patch to switch to list_head, and
> make sure operations from __update_and_free_hugetlb_folio and
> memory_failure are serialized (hopefully without intro new locks and
> just use mf_mutex).
>
> >
> > Thanks,
> > Naoya Horiguchi

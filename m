Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E2733B75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjFPVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjFPVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:19:18 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3F359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:19:16 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57059626276so14178787b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686950355; x=1689542355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8jo71L/wnw9C65fC3wBYtWb/3Td8mS5trrbwy3tbXE=;
        b=GYluVuaGinGspU2FwWJC0g5IziWPPxovWsn11amKV4ZczetN3f3tAYIJsRmg/8XrHD
         /OC6IYQ+NBOGSuuvrnpTavIJhrRbA9C2a8bcN6ccquT0HNTssMiWbqLqXRWrzTfUOZYc
         AVU18m5xeWEP9I2gK5E5tIFzGuShDlTUDGrSbKejyoSX+51i8UhUz2yVXUinLYMJPPhE
         ImMTfhxe+7j+AIIccrAd534coZ0c7IsY1seNS5BeFvruxybisB/YvxT9YNtgdS4DPjSv
         u1JQIN3aP7zPE9hf7BoMYKcSv+Y/Jl/5wD/3OinbxIVWQxSgKqqHJDNp/R5gYcJ16Vc/
         BIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686950355; x=1689542355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8jo71L/wnw9C65fC3wBYtWb/3Td8mS5trrbwy3tbXE=;
        b=hgsTjYXc7pOApkHUzzXLhn41ZUnDfq6YPDVWLHVgfnNfx/AC4luThqmgGX6Otp6Nuv
         W49IAK1KbbFrKW7O2Y/h/GsElDO9Z0IDFHaLTEui77c74bO9KeKAdG0jmnxpvZQlVKVD
         6hI71wYCy8qEJH/wr/ozhmMBwh+LJYKABMI/8CGFqZBFFHp1CuJT4PbGCMHhj6dzIAQz
         1fV8JYuSvBYkGOl6t3mrV81cX9PpJXjyX0sJWOrN7qFjNw5awQhaxOs1fqhD4t0MB0dv
         hu5vmvpLSfUTyEWm5osn78ZqtCzn+cPPAxxBpGUjVqPQkbnYd+4MXM/BkHkF32PCs60V
         v4CQ==
X-Gm-Message-State: AC+VfDzzGQ9zsDnqucHiJMO1w7intcPvBcBCKlUK+nF922Y80HRC1gFO
        feXYFw5QatoiOihOUvPfmZm7PKKy9EZKPKx4mkUaow==
X-Google-Smtp-Source: ACHHUZ60k8+tKuIRDhDO1Ssd92XbKRizuBCcQesr8d60QCeCm4LgTzC2PxMQUJHtak95xy3N+2L895DB7eknjeIxzyE=
X-Received: by 2002:a81:8007:0:b0:56d:40da:1fc2 with SMTP id
 q7-20020a818007000000b0056d40da1fc2mr3278277ywf.50.1686950355285; Fri, 16 Jun
 2023 14:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com> <20230517160948.811355-2-jiaqiyan@google.com>
 <20230517235314.GB10757@monkey> <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey> <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp> <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com> <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
In-Reply-To: <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 16 Jun 2023 14:19:03 -0700
Message-ID: <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
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

On Sun, Jun 11, 2023 at 9:19=E2=80=AFPM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Fri, Jun 09, 2023 at 10:48:47PM -0700, Jiaqi Yan wrote:
> > On Thu, May 25, 2023 at 5:28=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com>=
 wrote:
> > >
> > > On Mon, May 22, 2023 at 7:43=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=E5=
=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > <naoya.horiguchi@nec.com> wrote:
> > > >
> > > > On Mon, May 22, 2023 at 11:22:49AM -0700, Jiaqi Yan wrote:
> > > > > On Sun, May 21, 2023 at 9:50=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=
=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > >
> > > > > > On Fri, May 19, 2023 at 03:42:14PM -0700, Mike Kravetz wrote:
> > > > > > > On 05/19/23 13:54, Jiaqi Yan wrote:
> > > > > > > > On Wed, May 17, 2023 at 4:53=E2=80=AFPM Mike Kravetz <mike.=
kravetz@oracle.com> wrote:
> > > > > > > > >
> > > > > > > > > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > > > > > > > > Adds the functionality to search a subpage's correspond=
ing raw_hwp_page
> > > > > > > > > > in hugetlb page's HWPOISON list. This functionality can=
 also tell if a
> > > > > > > > > > subpage is a raw HWPOISON page.
> > > > > > > > > >
> > > > > > > > > > Exports this functionality to be immediately used in th=
e read operation
> > > > > > > > > > for hugetlbfs.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > > > > > > > ---
> > > > > > > > > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > > > > > > > > >  mm/memory-failure.c | 26 ++++++++++++++++----------
> > > > > > > > > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > > > index 27ce77080c79..f191a4119719 100644
> > > > > > > > > > --- a/include/linux/mm.h
> > > > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > >
> > > > > > > > > Any reason why you decided to add the following to linux/=
mm.h instead of
> > > > > > > > > linux/hugetlb.h?  Since it is hugetlb specific I would ha=
ve thought
> > > > > > > > > hugetlb.h was more appropriate.
> > > > > > > > >
> > > > > > > > > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > > > > > > > > >   */
> > > > > > > > > >  extern const struct attribute_group memory_failure_att=
r_group;
> > > > > > > > > >
> > > > > > > > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > > +/*
> > > > > > > > > > + * Struct raw_hwp_page represents information about "r=
aw error page",
> > > > > > > > > > + * constructing singly linked list from ->_hugetlb_hwp=
oison field of folio.
> > > > > > > > > > + */
> > > > > > > > > > +struct raw_hwp_page {
> > > > > > > > > > +     struct llist_node node;
> > > > > > > > > > +     struct page *page;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +static inline struct llist_head *raw_hwp_list_head(str=
uct folio *folio)
> > > > > > > > > > +{
> > > > > > > > > > +     return (struct llist_head *)&folio->_hugetlb_hwpo=
ison;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +/*
> > > > > > > > > > + * Given @subpage, a raw page in a hugepage, find its =
location in @folio's
> > > > > > > > > > + * _hugetlb_hwpoison list. Return NULL if @subpage is =
not in the list.
> > > > > > > > > > + */
> > > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *f=
olio,
> > > > > > > > > > +                                    struct page *subpa=
ge);
> > > > > > > > > > +#endif
> > > > > > > > > > +
> > > > > > > > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CO=
NFIG_HUGETLBFS)
> > > > > > > > > >  extern void clear_huge_page(struct page *page,
> > > > > > > > > >                           unsigned long addr_hint,
> > > > > > > > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > > > > > > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > > > > > > > > --- a/mm/memory-failure.c
> > > > > > > > > > +++ b/mm/memory-failure.c
> > > > > > > > > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_p=
rocs);
> > > > > > > > > >  #endif /* CONFIG_FS_DAX */
> > > > > > > > > >
> > > > > > > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > > -/*
> > > > > > > > > > - * Struct raw_hwp_page represents information about "r=
aw error page",
> > > > > > > > > > - * constructing singly linked list from ->_hugetlb_hwp=
oison field of folio.
> > > > > > > > > > - */
> > > > > > > > > > -struct raw_hwp_page {
> > > > > > > > > > -     struct llist_node node;
> > > > > > > > > > -     struct page *page;
> > > > > > > > > > -};
> > > > > > > > > >
> > > > > > > > > > -static inline struct llist_head *raw_hwp_list_head(str=
uct folio *folio)
> > > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *f=
olio,
> > > > > > > > > > +                                    struct page *subpa=
ge)
> > > > > > > > > >  {
> > > > > > > > > > -     return (struct llist_head *)&folio->_hugetlb_hwpo=
ison;
> > > > > > > > > > +     struct llist_node *t, *tnode;
> > > > > > > > > > +     struct llist_head *raw_hwp_head =3D raw_hwp_list_=
head(folio);
> > > > > > > > > > +     struct raw_hwp_page *hwp_page =3D NULL;
> > > > > > > > > > +     struct raw_hwp_page *p;
> > > > > > > > > > +
> > > > > > > > > > +     llist_for_each_safe(tnode, t, raw_hwp_head->first=
) {
> > > > > > > > >
> > > > > > > > > IIUC, in rare error cases a hugetlb page can be poisoned =
WITHOUT a
> > > > > > > > > raw_hwp_list.  This is indicated by the hugetlb page spec=
ific flag
> > > > > > > > > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable=
().
> > > > > > > > >
> > > > > > > > > Looks like this routine does not consider that case.  See=
ms like it should
> > > > > > > > > always return the passed subpage if folio_test_hugetlb_ra=
w_hwp_unreliable()
> > > > > > > > > is true?
> > > > > > > >
> > > > > > > > Thanks for catching this. I wonder should this routine cons=
ider
> > > > > > > > RawHwpUnreliable or should the caller do.
> > > > > > > >
> > > > > > > > find_raw_hwp_page now returns raw_hwp_page* in the llist en=
try to
> > > > > > > > caller (valid one at the moment), but once RawHwpUnreliable=
 is set,
> > > > > > > > all the raw_hwp_page in the llist will be kfree(), and the =
returned
> > > > > > > > value becomes dangling pointer to caller (if the caller hol=
ds that
> > > > > > > > caller long enough). Maybe returning a bool would be safer =
to the
> > > > > > > > caller? If the routine returns bool, then checking RawHwpUn=
reliable
> > > > > > > > can definitely be within the routine.
> > > > > > >
> > > > > > > I think the check for RawHwpUnreliable should be within this =
routine.
> > > > > > > Looking closer at the code, I do not see any way to synchroni=
ze this.
> > > > > > > It looks like manipulation in the memory-failure code would b=
e
> > > > > > > synchronized via the mf_mutex.  However, I do not see how tra=
versal and
> > > > > > > freeing of the raw_hwp_list  called from __update_and_free_hu=
getlb_folio
> > > > > > > is synchronized against memory-failure code modifying the lis=
t.
> > > > > > >
> > > > > > > Naoya, can you provide some thoughts?

Hi Mike,

Now looking again this, I think concurrent adding and deleting are
fine with each other and with themselves, because raw_hwp_list is
lock-less llist.

As for synchronizing traversal with adding and deleting, I wonder is
it a good idea to make __update_and_free_hugetlb_folio hold
hugetlb_lock before it folio_clear_hugetlb_hwpoison(which traverse +
delete raw_hwp_list)? In hugetlb, get_huge_page_for_hwpoison already
takes hugetlb_lock; it seems to me __update_and_free_hugetlb_folio is
missing the lock.

> > > > > >
> > > > > > Thanks for elaborating the issue.  I think that making find_raw=
_hwp_page() and
> > > > > > folio_clear_hugetlb_hwpoison() do their works within mf_mutex c=
an be one solution.
> > > > > > try_memory_failure_hugetlb(), one of the callers of folio_clear=
_hugetlb_hwpoison(),
> > > > > > already calls it within mf_mutex, so some wrapper might be need=
ed to implement
> > > > > > calling path from __update_and_free_hugetlb_folio() to take mf_=
mutex.
> > > > > >
> > > > > > It might be a concern that mf_mutex is a big lock to cover over=
all hwpoison
> > > > > > subsystem, but I think that the impact is not so big if the cha=
nged code paths
> > > > > > take mf_mutex only after checking hwpoisoned hugepage.  Maybe u=
sing folio_lock
> > > > > > to synchronize accesses to the raw_hwp_list could be possible, =
but currently
> > > > > > __get_huge_page_for_hwpoison() calls folio_set_hugetlb_hwpoison=
() without
> > > > > > folio_lock, so this approach needs update on locking rule and i=
t sounds more
> > > > > > error-prone to me.
> > > > >
> > > > > Thanks Naoya, since memory_failure is the main user of raw_hwp_li=
st, I
> > > > > agree mf_mutex could help to sync its two del_all operations (one=
 from
> > > > > try_memory_failure_hugetlb and one from
> > > > > __update_and_free_hugetlb_folio).
> > > > >
> > > > > I still want to ask a perhaps stupid question, somewhat related t=
o how
> > > > > to implement find_raw_hwp_page() correctly. It seems
> > > > > llist_for_each_safe should only be used to traverse after list en=
tries
> > > > > already *deleted* via llist_del_all. But the llist_for_each_safe =
calls
> > > > > in memory_failure today is used *directly* on the raw_hwp_list. T=
his
> > > > > is quite different from other users of llist_for_each_safe (for
> > > > > example, kernel/bpf/memalloc.c).
> > > >
> > > > Oh, I don't noticed that when writing the original code. (I just ch=
ose
> > > > llist_for_each_safe because I just wanted struct llist_node as a si=
ngly
> > > > linked list.)
> > >
> > > And maybe because you can avoid doing INIT_LIST_HEAD (which seems
> > > doable in folio_set_hugetlb_hwpoison if hugepage is hwpoison-ed for
> > > the first time)?
> > >
> > > >
> > > > >  Why is it correct? I guess mostly
> > > > > because they are sync-ed under mf_mutex (except the missing cover=
age
> > > > > on __update_and_free_hugetlb_folio)?
> > > >
> > > > Yes, and there seems no good reason to use the macro llist_for_each=
_safe
> > > > here.  I think it's OK to switch to simpler one like list_for_each =
which
> > > > should be supposed to be called directly.  To do this, struct raw_h=
wp_page
> > > > need to have @node (typed struct list_head instead of struct llist_=
node).
> >
> > Hi Naoya, a maybe-stupid question on list vs llist: _hugetlb_hwpoison
> > in folio is a void*. struct list_head is composed of two pointers to
> > list_node (prev and next) so folio just can't hold a list_head in the
> > _hugetlb_hwpoison field, right? llist_head on the other hand only
> > contains one pointer to llist_node first. I wonder if this is one of
> > the reason you picked llist instead of list in the first place.
>
> Yes, that's one reason to use llist_head, and another (minor) reason is t=
hat
> we don't need doubly-linked list here.

Hi Naoya,

Even with hugetlb_lock, I think we should still fix
__folio_free_raw_hwp: call llist_del_all first, then traverse the list
and free raw_hwp_page entries. Then folio_clear_hugetlb_hwpoison from
both memory_failure and hugetlb will be safe given llist_del_all on
llist is safe with itself.

In my v2, I tried both (1.taking hugetlb in
__update_and_free_hugetlb_folio, 2. call llist_del_all first in
__folio_free_raw_hwp). I also changed find_raw_hwp_page to
is_raw_hwp_subpage (only returns bool, and takes hugetlb_lock for
traversing raw_hwp_list). So far I didn't run into any problems with
my selftest.

>
> Thanks,
> Naoya Horiguchi
>
> >
> > The reason I ask is while I was testing my refactor draft, I
> > constantly see the refcount of the 3rd subpage in the folio got
> > corrupted. I am not sure about the exact reason but it feels to me
> > related to the above reason.
> >
> > >
> > > I will start to work on a separate patch to switch to list_head, and
> > > make sure operations from __update_and_free_hugetlb_folio and
> > > memory_failure are serialized (hopefully without intro new locks and
> > > just use mf_mutex).
> > >
> > > >
> > > > Thanks,
> > > > Naoya Horiguchi
> >
> >

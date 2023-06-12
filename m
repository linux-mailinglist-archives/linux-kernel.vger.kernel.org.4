Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB9272B65B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 06:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjFLEZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:25:55 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 21:25:52 PDT
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEEC1A5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:25:52 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:19:01 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686543551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opOgHt17eiUp65TQ0zjKIaKhcl3B5yuyEyfLy/NBFtA=;
        b=YdaAc3dfbatHJJI5IwryMrdE2UPwdwZE7B6YPavsgbc+6rkRa2ZYdVKBzhhm48DaKtEqSM
        nGG42bwphNTp7JjRNqlcU/gHV8A92I3nxPBzK3XqxXYg1MgC0MYB0qTh5pZUDhbx9kvBcF
        pJ9A6UPMF2bBYppmax7nix34WLOBVF8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517160948.811355-2-jiaqiyan@google.com>
 <20230517235314.GB10757@monkey>
 <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey>
 <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:48:47PM -0700, Jiaqi Yan wrote:
> On Thu, May 25, 2023 at 5:28 PM Jiaqi Yan <jiaqiyan@google.com> wrote:
> >
> > On Mon, May 22, 2023 at 7:43 PM HORIGUCHI NAOYA(堀口　直也)
> > <naoya.horiguchi@nec.com> wrote:
> > >
> > > On Mon, May 22, 2023 at 11:22:49AM -0700, Jiaqi Yan wrote:
> > > > On Sun, May 21, 2023 at 9:50 PM HORIGUCHI NAOYA(堀口　直也)
> > > > <naoya.horiguchi@nec.com> wrote:
> > > > >
> > > > > On Fri, May 19, 2023 at 03:42:14PM -0700, Mike Kravetz wrote:
> > > > > > On 05/19/23 13:54, Jiaqi Yan wrote:
> > > > > > > On Wed, May 17, 2023 at 4:53 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > > > > >
> > > > > > > > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > > > > > > > Adds the functionality to search a subpage's corresponding raw_hwp_page
> > > > > > > > > in hugetlb page's HWPOISON list. This functionality can also tell if a
> > > > > > > > > subpage is a raw HWPOISON page.
> > > > > > > > >
> > > > > > > > > Exports this functionality to be immediately used in the read operation
> > > > > > > > > for hugetlbfs.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > > > > > > ---
> > > > > > > > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > > > > > > > >  mm/memory-failure.c | 26 ++++++++++++++++----------
> > > > > > > > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > > index 27ce77080c79..f191a4119719 100644
> > > > > > > > > --- a/include/linux/mm.h
> > > > > > > > > +++ b/include/linux/mm.h
> > > > > > > >
> > > > > > > > Any reason why you decided to add the following to linux/mm.h instead of
> > > > > > > > linux/hugetlb.h?  Since it is hugetlb specific I would have thought
> > > > > > > > hugetlb.h was more appropriate.
> > > > > > > >
> > > > > > > > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > > > > > > > >   */
> > > > > > > > >  extern const struct attribute_group memory_failure_attr_group;
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > +/*
> > > > > > > > > + * Struct raw_hwp_page represents information about "raw error page",
> > > > > > > > > + * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> > > > > > > > > + */
> > > > > > > > > +struct raw_hwp_page {
> > > > > > > > > +     struct llist_node node;
> > > > > > > > > +     struct page *page;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > > > > > > > > +{
> > > > > > > > > +     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * Given @subpage, a raw page in a hugepage, find its location in @folio's
> > > > > > > > > + * _hugetlb_hwpoison list. Return NULL if @subpage is not in the list.
> > > > > > > > > + */
> > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > > > > > > > +                                    struct page *subpage);
> > > > > > > > > +#endif
> > > > > > > > > +
> > > > > > > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> > > > > > > > >  extern void clear_huge_page(struct page *page,
> > > > > > > > >                           unsigned long addr_hint,
> > > > > > > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > > > > > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > > > > > > > --- a/mm/memory-failure.c
> > > > > > > > > +++ b/mm/memory-failure.c
> > > > > > > > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> > > > > > > > >  #endif /* CONFIG_FS_DAX */
> > > > > > > > >
> > > > > > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > -/*
> > > > > > > > > - * Struct raw_hwp_page represents information about "raw error page",
> > > > > > > > > - * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> > > > > > > > > - */
> > > > > > > > > -struct raw_hwp_page {
> > > > > > > > > -     struct llist_node node;
> > > > > > > > > -     struct page *page;
> > > > > > > > > -};
> > > > > > > > >
> > > > > > > > > -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > > > > > > > +                                    struct page *subpage)
> > > > > > > > >  {
> > > > > > > > > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > > > > > > > +     struct llist_node *t, *tnode;
> > > > > > > > > +     struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
> > > > > > > > > +     struct raw_hwp_page *hwp_page = NULL;
> > > > > > > > > +     struct raw_hwp_page *p;
> > > > > > > > > +
> > > > > > > > > +     llist_for_each_safe(tnode, t, raw_hwp_head->first) {
> > > > > > > >
> > > > > > > > IIUC, in rare error cases a hugetlb page can be poisoned WITHOUT a
> > > > > > > > raw_hwp_list.  This is indicated by the hugetlb page specific flag
> > > > > > > > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().
> > > > > > > >
> > > > > > > > Looks like this routine does not consider that case.  Seems like it should
> > > > > > > > always return the passed subpage if folio_test_hugetlb_raw_hwp_unreliable()
> > > > > > > > is true?
> > > > > > >
> > > > > > > Thanks for catching this. I wonder should this routine consider
> > > > > > > RawHwpUnreliable or should the caller do.
> > > > > > >
> > > > > > > find_raw_hwp_page now returns raw_hwp_page* in the llist entry to
> > > > > > > caller (valid one at the moment), but once RawHwpUnreliable is set,
> > > > > > > all the raw_hwp_page in the llist will be kfree(), and the returned
> > > > > > > value becomes dangling pointer to caller (if the caller holds that
> > > > > > > caller long enough). Maybe returning a bool would be safer to the
> > > > > > > caller? If the routine returns bool, then checking RawHwpUnreliable
> > > > > > > can definitely be within the routine.
> > > > > >
> > > > > > I think the check for RawHwpUnreliable should be within this routine.
> > > > > > Looking closer at the code, I do not see any way to synchronize this.
> > > > > > It looks like manipulation in the memory-failure code would be
> > > > > > synchronized via the mf_mutex.  However, I do not see how traversal and
> > > > > > freeing of the raw_hwp_list  called from __update_and_free_hugetlb_folio
> > > > > > is synchronized against memory-failure code modifying the list.
> > > > > >
> > > > > > Naoya, can you provide some thoughts?
> > > > >
> > > > > Thanks for elaborating the issue.  I think that making find_raw_hwp_page() and
> > > > > folio_clear_hugetlb_hwpoison() do their works within mf_mutex can be one solution.
> > > > > try_memory_failure_hugetlb(), one of the callers of folio_clear_hugetlb_hwpoison(),
> > > > > already calls it within mf_mutex, so some wrapper might be needed to implement
> > > > > calling path from __update_and_free_hugetlb_folio() to take mf_mutex.
> > > > >
> > > > > It might be a concern that mf_mutex is a big lock to cover overall hwpoison
> > > > > subsystem, but I think that the impact is not so big if the changed code paths
> > > > > take mf_mutex only after checking hwpoisoned hugepage.  Maybe using folio_lock
> > > > > to synchronize accesses to the raw_hwp_list could be possible, but currently
> > > > > __get_huge_page_for_hwpoison() calls folio_set_hugetlb_hwpoison() without
> > > > > folio_lock, so this approach needs update on locking rule and it sounds more
> > > > > error-prone to me.
> > > >
> > > > Thanks Naoya, since memory_failure is the main user of raw_hwp_list, I
> > > > agree mf_mutex could help to sync its two del_all operations (one from
> > > > try_memory_failure_hugetlb and one from
> > > > __update_and_free_hugetlb_folio).
> > > >
> > > > I still want to ask a perhaps stupid question, somewhat related to how
> > > > to implement find_raw_hwp_page() correctly. It seems
> > > > llist_for_each_safe should only be used to traverse after list entries
> > > > already *deleted* via llist_del_all. But the llist_for_each_safe calls
> > > > in memory_failure today is used *directly* on the raw_hwp_list. This
> > > > is quite different from other users of llist_for_each_safe (for
> > > > example, kernel/bpf/memalloc.c).
> > >
> > > Oh, I don't noticed that when writing the original code. (I just chose
> > > llist_for_each_safe because I just wanted struct llist_node as a singly
> > > linked list.)
> >
> > And maybe because you can avoid doing INIT_LIST_HEAD (which seems
> > doable in folio_set_hugetlb_hwpoison if hugepage is hwpoison-ed for
> > the first time)?
> >
> > >
> > > >  Why is it correct? I guess mostly
> > > > because they are sync-ed under mf_mutex (except the missing coverage
> > > > on __update_and_free_hugetlb_folio)?
> > >
> > > Yes, and there seems no good reason to use the macro llist_for_each_safe
> > > here.  I think it's OK to switch to simpler one like list_for_each which
> > > should be supposed to be called directly.  To do this, struct raw_hwp_page
> > > need to have @node (typed struct list_head instead of struct llist_node).
> 
> Hi Naoya, a maybe-stupid question on list vs llist: _hugetlb_hwpoison
> in folio is a void*. struct list_head is composed of two pointers to
> list_node (prev and next) so folio just can't hold a list_head in the
> _hugetlb_hwpoison field, right? llist_head on the other hand only
> contains one pointer to llist_node first. I wonder if this is one of
> the reason you picked llist instead of list in the first place.

Yes, that's one reason to use llist_head, and another (minor) reason is that
we don't need doubly-linked list here.

Thanks,
Naoya Horiguchi

> 
> The reason I ask is while I was testing my refactor draft, I
> constantly see the refcount of the 3rd subpage in the folio got
> corrupted. I am not sure about the exact reason but it feels to me
> related to the above reason.
> 
> >
> > I will start to work on a separate patch to switch to list_head, and
> > make sure operations from __update_and_free_hugetlb_folio and
> > memory_failure are serialized (hopefully without intro new locks and
> > just use mf_mutex).
> >
> > >
> > > Thanks,
> > > Naoya Horiguchi
> 
> 

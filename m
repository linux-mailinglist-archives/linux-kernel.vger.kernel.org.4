Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B3D745316
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 01:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjGBXuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 19:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGBXus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 19:50:48 -0400
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [IPv6:2001:41d0:1004:224b::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041331B5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 16:50:45 -0700 (PDT)
Date:   Mon, 3 Jul 2023 08:50:34 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688341843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhWA0YLBWsVFxrFnH3VgBgG6UALQpN/vPaWrnHpD31Q=;
        b=OYSUxmAqM30vAxweav6qFvAT6mTMaKY67p8PccP42j9OKdkrOF2V8VwmTvVtcfA3IFTDcW
        R1Jx38yrz1VnB8QlArvAa35jurRBn9N46FkED/KD7+zeSgJOmGiMgyoOLUZR28hONrjj2d
        XkyWU3zbXB8wbKD6myJ6k51mJjS1264=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 1/4] mm/hwpoison: delete all entries before traversal
 in __folio_free_raw_hwp
Message-ID: <20230702235034.GA2906304@ik1-406-35019.vs.sakura.ne.jp>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-2-jiaqiyan@google.com>
 <20230630145217.GA2213127@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F52R8oUNP50dfy35m1KED82NKgKcHKk3ev4O+4nqhFVdzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F52R8oUNP50dfy35m1KED82NKgKcHKk3ev4O+4nqhFVdzg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 01:59:23PM -0700, Jiaqi Yan wrote:
> On Fri, Jun 30, 2023 at 7:52 AM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
> >
> > On Fri, Jun 23, 2023 at 04:40:12PM +0000, Jiaqi Yan wrote:
> > > Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
> > > are deleted from the llist.
> > >
> > > llist_del_all are lock free with itself. folio_clear_hugetlb_hwpoison()s
> > > from __update_and_free_hugetlb_folio and memory_failure won't need
> > > explicit locking when freeing the raw_hwp_list.
> > >
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> >
> > (Sorry if stupid question...) folio_set_hugetlb_hwpoison() also calls
> > llist_for_each_safe() but it still traverses the list without calling
> > llist_del_all().  This convention applies only when removing item(s)?
> 
> I think in our previous discussion, Mike and I agree as of today's
> code in hugetlb.c and memory-failure.c, concurrent adding, deleting,
> traversing are fine with each other and with themselves [1], but new
> code need to be careful wrt ops on raw_hwp_list.
> 
> This patch is a low-hanging fruit to ensure any caller of
> __folio_free_raw_hwp won't introduce any problem by correcting one
> thing in __folio_free_raw_hwp: since it wants to delete raw_hwp_page
> entries in the list, it should do it by first llist_del_all, and then
> kfree with a llist_for_each_safe.

Thanks for the explanation, this is worth adding to the patch description
for future developers to understand the background.

> 
> As for folio_set_hugetlb_hwpoison, I am not very comfortable fixing
> it. I imagine a way to fix it is llist_del_all() =>
> llist_for_each_safe{...} => llist_add_batch(), or llist_add() within
> llist_for_each_safe{...}. I haven't really thought through if this is
> a correct fix.

I see. Changing folio_set_hugetlb_hwpoison() like this is a little too complex
considering that this fix is for precaution.
So no change on this for now is fine to me.

Anyway this patch looks fine to me.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> 
> [1] https://lore.kernel.org/lkml/CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com/#t
> 
> 
> >
> > Thanks,
> > Naoya Horiguchi
> >
> > > ---
> > >  mm/memory-failure.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index 004a02f44271..c415c3c462a3 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1825,12 +1825,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > >
> > >  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> > >  {
> > > -     struct llist_head *head;
> > > -     struct llist_node *t, *tnode;
> > > +     struct llist_node *t, *tnode, *head;
> > >       unsigned long count = 0;
> > >
> > > -     head = raw_hwp_list_head(folio);
> > > -     llist_for_each_safe(tnode, t, head->first) {
> > > +     head = llist_del_all(raw_hwp_list_head(folio));
> > > +     llist_for_each_safe(tnode, t, head) {
> > >               struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> > >
> > >               if (move_flag)
> > > @@ -1840,7 +1839,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> > >               kfree(p);
> > >               count++;
> > >       }
> > > -     llist_del_all(head);
> > >       return count;
> > >  }
> > >
> > > --
> > > 2.41.0.162.gfafddb0af9-goog
> > >
> > >
> > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2173AFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFWFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWFR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843F1FF5;
        Thu, 22 Jun 2023 22:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8C461976;
        Fri, 23 Jun 2023 05:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A662DC433C8;
        Fri, 23 Jun 2023 05:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687497444;
        bh=XX6cUuDdk9ATCSiX4MTnMkPw220czxXOLev5W1cROd4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iecVcTPZymyB3ev5EB1lOFSfIzhKgfN4XcJcbxovmXtBvjexkClGWES/47ZYMUI4Z
         QnJC5xN81fP38xrRhSey58INv/a8ncUH3xF0h2Tn34lOohPy32waEjQ2jlTsBurNSX
         MGQMkhvju/4JG9bTQcPBmpnuER5qs9bIr6WxlCAe/3csszQ5eTFD34rBtyub3MB6Vx
         MFeVKKfOuCdgthC0VtZ2GtrChM4l+bmRnz+M/uAmdvDxZ0EVOVd/a84HHR4p7Tg5rE
         afy1plXymmvOSTlb/OgeRdTlCGd6FqhgP3uMICTuMTTs3WqRbsjTvkbf3oxvD0QSY7
         wMvsctURVom+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 40B6BCE2569; Thu, 22 Jun 2023 22:17:24 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:17:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Add necessary WRITE_ONCE()
Message-ID: <2fd1169a-a695-4bff-9611-a84dd02025b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230620171346.207076-1-mmpgouride@gmail.com>
 <50c4aa37-388b-449c-8184-00a9d69471fc@paulmck-laptop>
 <B9A94CB4-DB9B-43D2-9D34-ADB4F7EA737D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B9A94CB4-DB9B-43D2-9D34-ADB4F7EA737D@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:08:28AM +0800, Alan Huang wrote:
> 
> > 2023年6月21日 06:26，Paul E. McKenney <paulmck@kernel.org> 写道：
> > 
> > On Tue, Jun 20, 2023 at 05:13:46PM +0000, Alan Huang wrote:
> >> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") and
> >> commit 860c8802ace1("rcu: Use WRITE_ONCE() for assignments to
> >> ->pprev for hlist_nulls") added various WRITE_ONCE() to pair with
> >> the READ_ONCE() in hlist_unhashed_lockless(), but there are still
> >> some places where WRITE_ONCE() was not added, this commit adds that.
> >> 
> >> Also add WRITE_ONCE() to pair with the READ_ONCE() in hlist_empty().
> >> 
> >> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> > 
> > On hlist_nulls_add_tail_rcu(), good catch, thank you!
> > 
> > On the others, are there really cases where a lockless read races with
> > the update?  At first glance, that sounds like a usage bug.  For example,
> > as I understand it, when you use something like hlist_del(), you are
> > supposed to ensure that there are no concurrent readers.  Which is the
> > point of the assignment of the special value LIST_POISON2, right?
> 
> Do you mean there are cases where a lockless read races with hlist_add_head/hlist_add_before
> hlist_add_behind/__hlist_del, but there is no real case where a lockless read races with the hlist_del_init/hlist_del
> hlist_move_list?
> 
> There may be no real case where a lockless read races with the hlist_del_init/hlist_del
> hlist_move_list. But for the sake of completeness, I added those WRITE_ONCE, after all, if there is WRITE_ONCE
> in __hlist_del, why not add WRITE_ONCE in its caller, like hlist_del()?

You might well have located a larger issue.  We want to be able to use
KCSAN to find unintended data races, but as you noted, there might
be different requirements for RCU-protected linked lists and for
lock-protected linked lists.  If there are, then there is probably
existing linked-list code that is using the wrong primitive, for
example, using (or failing to use) the one that Eric Dumazet provided.
For example, mismatched API usage might be causing the differences in
uses of _ONCE() primitives that you are calling out.

Would you be interested in digging into this?

You will of course need to be able to build and run kernels with KCSAN
enabled, which is not hard to do given a laptop that can build a kernel
and run a guest OS.

							Thanx, Paul

> Thanks,
> Alan
> 
> > 
> > Or is there some use case that I am missing?
> > 
> > If I am not missing something, then switching the non-RCU APIs to
> > WRITE_ONCE() would be a step backwards, because it would make it harder
> > for tools like KCSAN to find bugs.
> > 
> > Thanx, Paul
> > 
> >> ---
> >> Changelog:
> >> V1 -> V2: 
> >>  Add WRITE_ONCE in hlist_del_init to pair with READ_ONCE in
> >>  hlist_unhashed_lockless.
> >> 
> >> include/linux/list.h          | 9 +++++----
> >> include/linux/list_nulls.h    | 2 +-
> >> include/linux/rculist_nulls.h | 2 +-
> >> 3 files changed, 7 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/include/linux/list.h b/include/linux/list.h
> >> index ac366958ea..3a29b95bfe 100644
> >> --- a/include/linux/list.h
> >> +++ b/include/linux/list.h
> >> @@ -912,7 +912,7 @@ static inline void hlist_del(struct hlist_node *n)
> >> {
> >> __hlist_del(n);
> >> n->next = LIST_POISON1;
> >> - n->pprev = LIST_POISON2;
> >> + WRITE_ONCE(n->pprev, LIST_POISON2);
> >> }
> >> 
> >> /**
> >> @@ -925,7 +925,8 @@ static inline void hlist_del_init(struct hlist_node *n)
> >> {
> >> if (!hlist_unhashed(n)) {
> >> __hlist_del(n);
> >> - INIT_HLIST_NODE(n);
> >> + n->next = NULL;
> >> + WRITE_ONCE(n->pprev, NULL);
> >> }
> >> }
> >> 
> >> @@ -1026,8 +1027,8 @@ static inline void hlist_move_list(struct hlist_head *old,
> >> {
> >> new->first = old->first;
> >> if (new->first)
> >> - new->first->pprev = &new->first;
> >> - old->first = NULL;
> >> + WRITE_ONCE(new->first->pprev, &new->first);
> >> + WRITE_ONCE(old->first, NULL);
> >> }
> >> 
> >> #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
> >> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
> >> index fa6e8471bd..b63b0589fa 100644
> >> --- a/include/linux/list_nulls.h
> >> +++ b/include/linux/list_nulls.h
> >> @@ -95,7 +95,7 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
> >> 
> >> n->next = first;
> >> WRITE_ONCE(n->pprev, &h->first);
> >> - h->first = n;
> >> + WRITE_ONCE(h->first, n);
> >> if (!is_a_nulls(first))
> >> WRITE_ONCE(first->pprev, &n->next);
> >> }
> >> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> >> index ba4c00dd80..c65121655b 100644
> >> --- a/include/linux/rculist_nulls.h
> >> +++ b/include/linux/rculist_nulls.h
> >> @@ -138,7 +138,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
> >> 
> >> if (last) {
> >> n->next = last->next;
> >> - n->pprev = &last->next;
> >> + WRITE_ONCE(n->pprev, &last->next);
> >> rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
> >> } else {
> >> hlist_nulls_add_head_rcu(n, h);
> >> -- 
> >> 2.34.1
> >> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0BA72A6CD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjFIXnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFIXnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26BF30FE;
        Fri,  9 Jun 2023 16:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9126344B;
        Fri,  9 Jun 2023 23:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C2C433EF;
        Fri,  9 Jun 2023 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686354179;
        bh=DQaYRhed9iRGzYmdroHoIOdGjQzbLmn6nX4veiFuct8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P5yrpJ4UJGyWtrVLoP7Sjiq/mj1e6t0YirUa8xOGE+sYl+N/9VR0k61OtBoQdWh9I
         h8yqALxXWXq5u5SsXnwbMWE6We1c/89vNh/rgyhGx5pN+8yapriE2acVR9k4r+ykJY
         cnO3OWmKcR6kskafc3NGIcysRmEmQGf0YYANpreo8/VzYUikJ8RQoSZCT7lKFxdSDn
         s3icO6AUVWCQKep8uL4KaIHXkMS7kER0yAyDrulHt+KBNPoYj2HdfDvlHYP4T9vAoK
         7PVYLNSJBiut8Ku+3rbayFS9afv6c7WBI/egGEGoZlKB+TOrdDcIXkI2/XWV2jX3tS
         E1ccbuPrVnOvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 772FFCE14D2; Fri,  9 Jun 2023 16:42:59 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:42:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release'
 in insert function
Message-ID: <46440869-644a-4982-b790-b71b43976c66@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQFqW2QcAuHZEhc_GaUaB-=QOS0WgUOizd=FYwtFQ8vag@mail.gmail.com>
 <20230609191206.30465-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609191206.30465-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 07:12:06PM +0000, SeongJae Park wrote:
> On Fri, 19 May 2023 14:52:50 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Thu, May 18, 2023 at 6:40 PM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > The document says we can avoid extra smp_rmb() in lockless_lookup() and
> > > extra _release() in insert function when hlist_nulls is used.  However,
> > > the example code snippet for the insert function is still using the
> > > extra _release().  Drop it.
> > >
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  Documentation/RCU/rculist_nulls.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> > > index 5cd6f3f8810f..463270273d89 100644
> > > --- a/Documentation/RCU/rculist_nulls.rst
> > > +++ b/Documentation/RCU/rculist_nulls.rst
> > > @@ -191,7 +191,7 @@ scan the list again without harm.
> > >    obj = kmem_cache_alloc(cachep);
> > >    lock_chain(); // typically a spin_lock()
> > >    obj->key = key;
> > > -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> > > +  atomic_set(&obj->refcnt, 1);
> > >    /*
> > >     * insert obj in RCU way (readers might be traversing chain)
> > >     */
> > 
> > If write to ->refcnt of 1 is reordered with setting of ->key, what
> > prevents the 'lookup algorithm' from doing a key match (obj->key ==
> > key) before the refcount has been initialized?
> > 
> > Are we sure the reordering mentioned in the document is the same as
> > the reordering prevented by the atomic_set_release()?
> 
> Paul, may I ask your opinion?

The next line of code is this:

	hlist_nulls_add_head_rcu(&obj->obj_node, list);

If I understand the code correctly, obj (and thus *obj) are not
visible to readers before the hlist_nulls_add_head_rcu().  And
hlist_nulls_add_head_rcu() uses rcu_assign_pointer() to ensure that
initialization (including both ->key and ->refcnt) is ordered before
list insertion.

Except that this memory is being allocated from a slab cache that was
created with SLAB_TYPESAFE_BY_RCU.  This means that there can be readers
who gained a reference before this object was freed, and who still hold
their references.

Unfortunately, the implementation of try_get_ref() is not shown.  However,
if ->refcnt is non-zero, this can succeed, and if it succeeds, we need
the subsequent check of obj->key with key in the lookup algorithm to
be stable.  For this check to be stable, try_get_ref() needs to use an
atomic operation with at least acquire semantics (kref_get_unless_zero()
would work), and this must pair with something in the initialization.

So I don't see how it is safe to weaken that atomic_set_release() to
atomic_set(), even on x86.

Or am I missing something subtle here?

							Thanx, Paul

> Thanks,
> SJ
> 
> > 
> > For the other 3 patches, feel free to add:
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > thanks,
> > 
> >  - Joel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3B72A6FD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjFJAUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 20:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFJAUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2043A85;
        Fri,  9 Jun 2023 17:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9970A646C3;
        Sat, 10 Jun 2023 00:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E6BC4339B;
        Sat, 10 Jun 2023 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686356427;
        bh=hAWErQdgtzrtLLnuP2Z32/Gd7HN0S3pIO7CaoqvpH6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGkqFKGrPFOks6pEpqeh+5vynI5ErlrszFLAKeFWx+ru7eUxN0bhpvcTBpFtdMLku
         rsunnA6eRuqrHf/t62LCMlBvFVqEGbkVph4YGBwlIAeHQv53vveU42Ep+XeGk/EajW
         pnpNwOLzPJVTbBAzEdBlVN7zhckYeQU4xxR8M11e2dC8aD/ZOn4LGjQD0WFbhwHf7M
         xSTSagsP2xvB2KxdVqxmrg96rIgTZLcFVU/19/h4eordnith64Gl2JheAL7YsLPv8N
         WUj0JbrywL1drCSoH9+Psn24w2IeyUg2SgfGFQaAGe5KeT5YGxz8UXo824N7Qevt3b
         5cem9xa98dfHQ==
From:   SeongJae Park <sj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release' in insert function
Date:   Sat, 10 Jun 2023 00:20:24 +0000
Message-Id: <20230610002024.80653-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <46440869-644a-4982-b790-b71b43976c66@paulmck-laptop>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023 16:42:59 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Jun 09, 2023 at 07:12:06PM +0000, SeongJae Park wrote:
> > On Fri, 19 May 2023 14:52:50 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Thu, May 18, 2023 at 6:40 PM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > The document says we can avoid extra smp_rmb() in lockless_lookup() and
> > > > extra _release() in insert function when hlist_nulls is used.  However,
> > > > the example code snippet for the insert function is still using the
> > > > extra _release().  Drop it.
> > > >
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >  Documentation/RCU/rculist_nulls.rst | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> > > > index 5cd6f3f8810f..463270273d89 100644
> > > > --- a/Documentation/RCU/rculist_nulls.rst
> > > > +++ b/Documentation/RCU/rculist_nulls.rst
> > > > @@ -191,7 +191,7 @@ scan the list again without harm.
> > > >    obj = kmem_cache_alloc(cachep);
> > > >    lock_chain(); // typically a spin_lock()
> > > >    obj->key = key;
> > > > -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> > > > +  atomic_set(&obj->refcnt, 1);
> > > >    /*
> > > >     * insert obj in RCU way (readers might be traversing chain)
> > > >     */
> > > 
> > > If write to ->refcnt of 1 is reordered with setting of ->key, what
> > > prevents the 'lookup algorithm' from doing a key match (obj->key ==
> > > key) before the refcount has been initialized?
> > > 
> > > Are we sure the reordering mentioned in the document is the same as
> > > the reordering prevented by the atomic_set_release()?
> > 
> > Paul, may I ask your opinion?
> 
> The next line of code is this:
> 
> 	hlist_nulls_add_head_rcu(&obj->obj_node, list);
> 
> If I understand the code correctly, obj (and thus *obj) are not
> visible to readers before the hlist_nulls_add_head_rcu().  And
> hlist_nulls_add_head_rcu() uses rcu_assign_pointer() to ensure that
> initialization (including both ->key and ->refcnt) is ordered before
> list insertion.
> 
> Except that this memory is being allocated from a slab cache that was
> created with SLAB_TYPESAFE_BY_RCU.  This means that there can be readers
> who gained a reference before this object was freed, and who still hold
> their references.
> 
> Unfortunately, the implementation of try_get_ref() is not shown.  However,
> if ->refcnt is non-zero, this can succeed, and if it succeeds, we need
> the subsequent check of obj->key with key in the lookup algorithm to
> be stable.  For this check to be stable, try_get_ref() needs to use an
> atomic operation with at least acquire semantics (kref_get_unless_zero()
> would work), and this must pair with something in the initialization.
> 
> So I don't see how it is safe to weaken that atomic_set_release() to
> atomic_set(), even on x86.

Thank you for the nice explanation, and I agree.

> 
> Or am I missing something subtle here?

I found the text is saying extra _release() in insert function is not
needed[1], and I thought it means the atomic_set_release().  Am I misreading
it?  If not, would it be better to fix the text, for example, like below?

```
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -129,8 +129,7 @@ very very fast (before the end of RCU grace period)
 Avoiding extra smp_rmb()
 ========================

-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
-and extra _release() in insert function.
+With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().

 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
@@ -182,6 +181,9 @@ scan the list again without harm.
 2) Insert algorithm
 -------------------

+Same to the above one, but uses hlist_nulls_add_head_rcu() instead of
+hlist_add_head_rcu().
+
 ::

   /*
@@ -191,7 +193,7 @@ scan the list again without harm.
   obj = kmem_cache_alloc(cachep);
   lock_chain(); // typically a spin_lock()
   obj->key = key;
-  atomic_set_release(&obj->refcnt, 1); // key before refcnt
+  atomic_set(&obj->refcnt, 1);
   /*
    * insert obj in RCU way (readers might be traversing chain)
    */
```

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/RCU/rculist_nulls.rst#n133


Thanks,
SJ

> 
> 							Thanx, Paul
> 
> > Thanks,
> > SJ
> > 
> > > 
> > > For the other 3 patches, feel free to add:
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > thanks,
> > > 
> > >  - Joel

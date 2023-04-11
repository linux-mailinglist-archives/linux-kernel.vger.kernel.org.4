Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883636DE124
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDKQmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C610E9;
        Tue, 11 Apr 2023 09:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0949560E71;
        Tue, 11 Apr 2023 16:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65907C433EF;
        Tue, 11 Apr 2023 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681231358;
        bh=yflufE8ZksbV5SDv5btYZ8nUlqv9M275okMCEBw67wM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bY3ZIwOrtfCePa52ubRazsn/kQB1xYs3TT+xcbUgS6JEptNMDlKkE4YMox3xjNnm4
         3ENTTCms8b+n+HV0TglJYp5kDaSbxZxkE39r6e9w9NkdGXykdfmH+gXyp/XZDor7YX
         V0CuYb/lg3NAAuPhegMMsPcs5O9SwW3G93PNPlXVP3SAz2iIMP8x6gQxP/sjZkVVTD
         e3EVW7R1rBww1tAWuKvE+FhxjrGbeEnwbvcxFZl3MmE9W7rLnAsCb8GwZej0hsp00g
         rJlK+WwY+rqHstM51mRYcNmV+FIgeXYBjY3DC6YJAeRGTU3KN6e7KMlBSh9aEsj83U
         EdrKUTRNHZRiw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 050C11540478; Tue, 11 Apr 2023 09:42:38 -0700 (PDT)
Date:   Tue, 11 Apr 2023 09:42:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <2159c88e-ec99-4ad6-a166-baf4199d138f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDV1jhENgED4ctxO@pc636>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:58:22PM +0200, Uladzislau Rezki wrote:
> On Tue, Apr 11, 2023 at 02:42:27PM +0000, Zhang, Qiang1 wrote:
> > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > > cache growing and disable allocated page in fill_page_cache_func().
> > > > 
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > >
> > > >Much improved!  But still some questions below...
> > > >
> > > >							Thanx, Paul
> > > >
> > > > ---
> > > >  kernel/rcu/tree.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index cc34d13be181..9d9d3772cc45 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2908,6 +2908,8 @@ static inline bool
> > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > >  {
> > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > +		return false;
> > > >
> > > >This will mean that under low-memory conditions, we will keep zero
> > > >pages in ->bkvcache.  All attempts to put something there will fail.
> > > >
> > > >This is probably not an issue for structures containing an rcu_head
> > > >that are passed to kfree_rcu(p, field), but doesn't this mean that
> > > >kfree_rcu_mightsleep() unconditionally invokes synchronize_rcu()?
> > > >This could seriously slow up freeing under low-memory conditions,
> > > >which might exacerbate the low-memory conditions.
> > > 
> > > Thanks for mentioning this, I didn't think of this before😊.
> > > 
> > > >
> > > >Is this really what we want?  Zero cached rather than just fewer cached?
> > > >
> > > >
> > > >
> > > >  	// Check the limit.
> > > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > >  		return false;
> > > > @@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > > >  	int i;
> > > >  
> > > >  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > > > -		1 : rcu_min_cached_objs;
> > > > +		0 : rcu_min_cached_objs;
> > > >  
> > > >  	for (i = 0; i < nr_pages; i++) {
> > > >
> > > >I am still confused as to why we start "i" at zero rather than at
> > > >->nr_bkv_objs.  What am I missing here?
> > > 
> > > 
> > > No, you are right, I missed this place. 
> > > 
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2908,6 +2908,8 @@ static inline bool
> > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >         struct kvfree_rcu_bulk_data *bnode)
> > >  {
> > > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +               return false;
> > >
> > >This is broken, unfortunately. If a low memory condition we fill
> > >fill a cache with at least one page anyway because of we do not want
> > >to hit a slow path.
> > 
> > Thanks remind, please ignore my v4 patch,   how about the following?
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 41daae3239b5..e2e8412e687f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3238,6 +3238,9 @@ static void fill_page_cache_func(struct work_struct *work)
> >                         free_page((unsigned long) bnode);
> >                         break;
> >                 }
> > +
> > +               if (atomic_read(&krcp->backoff_page_cache_fill))
> > +                       break;
> >         }
> It does not fix an "issue" you are reporting. kvfree_rcu_bulk() function
> can still fill it back. IMHO, the solution here is to disable cache if
> a low memory condition and enable back later on.
> 
> The cache size is controlled by the rcu_min_cached_objs variable. We can
> set it to 1 and restore it back to original value to make the cache operating
> as before.

It would be best to use a second variable for this.  Users might get
annoyed if their changes to rcu_min_cached_objs got overwritten once
things got set back to normal operation.

							Thanx, Paul

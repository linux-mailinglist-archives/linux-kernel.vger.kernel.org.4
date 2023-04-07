Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9E6DAFB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjDGPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjDGPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D5A8A72;
        Fri,  7 Apr 2023 08:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20EF76520C;
        Fri,  7 Apr 2023 15:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DD0C433EF;
        Fri,  7 Apr 2023 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680881617;
        bh=e0Pb67hBbldtE5rzYdhSdAYTbcBz1n1z7llG83Icj8k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JrA1EfUJ3AGVCJBq7DrZMRtmBN/Ftuc9SF5RhZsd90Ck1pJDOVvyquupFyAQ9NVcr
         sp+4+eekDkVUIA+/DdfATw5JS7zCzzc5P8/eMDy+xorPXjcfANB6LlUxMSxT8uqlik
         WHxlLRmiuTJ0Kt952d6QRWgoou6vWalmZA2fzsy1EWVMA0M3b2SoAx4RbiCpTdpHY3
         9niO//qLRCrw7xE8sJYa63S6UFAwGyFbHraGBht/IYLPO4psJKpvprHx/atsN0K3PQ
         raE1V+2aPUNULR8Q/IG71TpQDWC8ehdjYjyxltUOImCKB/AOu4CV/R96zaQwU3Jhcs
         wQHCxek1AqEhQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E3560154047D; Fri,  7 Apr 2023 08:33:36 -0700 (PDT)
Date:   Fri, 7 Apr 2023 08:33:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <c0fed568-db45-4302-b204-b4f707bba140@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
 <MW5PR11MB5858999E104C21754DEB40F3DA969@MW5PR11MB5858.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5858999E104C21754DEB40F3DA969@MW5PR11MB5858.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 01:26:39AM +0000, Zhang, Qiang1 wrote:
> > >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > > cache growing.
> > > > 
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 9cc0a7766fd2..f25430ae1936 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2907,6 +2907,8 @@ static inline bool
> > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > >  {
> > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > +		return false;
> > > >  	// Check the limit.
> > > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > >  		return false;
> > > > -- 
> > > > 2.32.0
> > > >
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >
> > >Thank you both!
> > >
> > >One question, though.  Might it be better to instead modify the "for"
> > >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> > >of starting at zero?  That way, we still provide a single page under
> > >low-memory conditions, but provide rcu_min_cached_objs of them if memory
> > >is plentiful.
> > >
> > >Alternatively, if we really don't want to allow any pages at all under
> > >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
> > >to zero (instead of the current 1) when the krcp->backoff_page_cache_fill
> > >flag is set?  
> > 
> > Hi, Paul
> > 
> > If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () return false,
> > the allocated single page will also be freed in fill_page_cache_func().
> > 
> > or it would be better not to allocate under memory pressure.
> >
> >That was my thought.  ;-)
> >
> > How about like this?
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9cc0a7766fd2..94aedbc3da36 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2907,6 +2907,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >         struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > +               return false;
> >         // Check the limit.
> >         if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> >                 return false;
> > @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_struct *work)
> >         int i;
> > 
> >         nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > -               1 : rcu_min_cached_objs;
> > +               0 : rcu_min_cached_objs;
> > 
> >         for (i = 0; i < nr_pages; i++) {
> >
> >The other question is why this loop does not allow for any pages
> >that might already be allocated, thus perhaps looking like this:
> >
> >		for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
> >
> >Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
> >seeing this, but I do feel the need to ask.)
> 
> 
> The fill_page_cache_func() is triggered when we invoke get_cached_bnode() return NULL,
> this also means that krcp->nr_bkv_objs is equal to zero. 
> But if can_alloc is set,  we will unlock krcp0->lock and allocated single page,  after that
> we will reacquire krcp1 and lock,  but the krcp1 at this time may be different from the
> previous krcp0,  if !bnode is true, also trigger work to invoke fill_page_cache_func(),  but
> maybe the krcp1-> nr_bkv_objs is not equal to zero.

OK.  Given all of these good points, what would be a good patch for
this issue?  ;-)

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> >							Thanx, Paul
> >
> >                 bnode = (struct kvfree_rcu_bulk_data *)
> > 
> > Thanks
> > Zqiang
> > 
> > >This would likely mean also breaking out of that loop if
> > >krcp->backoff_page_cache_fill was set in the meantime (which happens
> > >implicitly with Zqiang's patch).
> > >
> > >Or am I missing something subtle here?
> > >
> > >							Thanx, Paul

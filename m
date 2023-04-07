Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F546DA66B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjDGAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjDGAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F04C17;
        Thu,  6 Apr 2023 17:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FD5964BED;
        Fri,  7 Apr 2023 00:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ED7C433EF;
        Fri,  7 Apr 2023 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680825843;
        bh=FWUEkRBFDu2x6pG40HBgPb+eVz+cSo+aWV9AS+aHaOA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tiKF+xsO+dsER8y8XiUE2qlTqy37WXxFezjqqoE0gPUFClUJfYmE2e4fIYtIo8GyX
         sSkYZkhQz4yS1bK8jMRJ1La599hCwrv7++Q9nPLv4ps/vEIyoRb8SWTqQMwjg45LEg
         H9L+EgzuvcAAgX5N0kZax6iwMNY2A+L4/b14ACMN3dNpKcXLKS7lPH97gjDsL3aiag
         6rGcKCC39QwBg9TytGrzpYx7CGtLxXGafhH6uApIVK4oWXF7l8Nyf1lBD4OCHXl/V0
         X4aawZ+rIgrPB2/dWi14X5OhRlH150S/yEoXIoRl6Vw5XhXhJrzFq1Wafzi4fu1eAx
         1HzStrfF5SZTA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09340154047D; Thu,  6 Apr 2023 17:04:03 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:04:03 -0700
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
Message-ID: <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:11:37PM +0000, Zhang, Qiang1 wrote:
> >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > cache growing.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  kernel/rcu/tree.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9cc0a7766fd2..f25430ae1936 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2907,6 +2907,8 @@ static inline bool
> > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >  	struct kvfree_rcu_bulk_data *bnode)
> > >  {
> > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +		return false;
> > >  	// Check the limit.
> > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > >  		return false;
> > > -- 
> > > 2.32.0
> > >
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >
> >Thank you both!
> >
> >One question, though.  Might it be better to instead modify the "for"
> >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> >of starting at zero?  That way, we still provide a single page under
> >low-memory conditions, but provide rcu_min_cached_objs of them if memory
> >is plentiful.
> >
> >Alternatively, if we really don't want to allow any pages at all under
> >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
> >to zero (instead of the current 1) when the krcp->backoff_page_cache_fill
> >flag is set?  
> 
> Hi, Paul
> 
> If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () return false,
> the allocated single page will also be freed in fill_page_cache_func().
> 
> or it would be better not to allocate under memory pressure.

That was my thought.  ;-)

> How about like this?
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9cc0a7766fd2..94aedbc3da36 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2907,6 +2907,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>         struct kvfree_rcu_bulk_data *bnode)
>  {
> +       if (atomic_read(&krcp->backoff_page_cache_fill))
> +               return false;
>         // Check the limit.
>         if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
>                 return false;
> @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_struct *work)
>         int i;
> 
>         nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> -               1 : rcu_min_cached_objs;
> +               0 : rcu_min_cached_objs;
> 
>         for (i = 0; i < nr_pages; i++) {

The other question is why this loop does not allow for any pages
that might already be allocated, thus perhaps looking like this:

		for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {

Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
seeing this, but I do feel the need to ask.)

							Thanx, Paul

>                 bnode = (struct kvfree_rcu_bulk_data *)
> 
> Thanks
> Zqiang
> 
> >This would likely mean also breaking out of that loop if
> >krcp->backoff_page_cache_fill was set in the meantime (which happens
> >implicitly with Zqiang's patch).
> >
> >Or am I missing something subtle here?
> >
> >							Thanx, Paul

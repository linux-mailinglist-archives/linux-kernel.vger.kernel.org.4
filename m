Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F064A6DE1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDKRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:10:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E79E1B0;
        Tue, 11 Apr 2023 10:10:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z26so11207759lfj.11;
        Tue, 11 Apr 2023 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681233031; x=1683825031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h81fS26c8hAx+45NfwgLd+p3DMOFE1kso+LgleFC9hE=;
        b=owOY3TKRtJT13P890w/HQhRdcO7bfwjuFDvM3TIdSQKbC2hCjr87+TRuTj7WZaX7lI
         TaQrxCkfT5LMBHqfaPvtBomkE1cHsnJEcc1nrrVPGk55asaI1SwYRya0FXGQT7mRJ5Bf
         uq7XSd8ss9vbMhfhps3KI1prLqDzojfMrwnrwWTdPhjnVnVHZWvz8KbD29JIkYxB2nC8
         P2o36eeI4nG8PjB8IUpyu7jcIrFTPJ/+7fb0e4vFuKU038nszqOYMuKgHHx8G1Y854t2
         4VawZJro2OSM7Ujso01ACP4M0HgmRqT7Fb/iCNRMNCQb1RO+aAVBpTQLPzny/vtlEeiZ
         y0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233031; x=1683825031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h81fS26c8hAx+45NfwgLd+p3DMOFE1kso+LgleFC9hE=;
        b=xrSJgGfNm1Ihd1UMYgolM3/ZtEIphdlfjzsQuKuHNFDdsOaLMKm1FpORcDf44H1MBA
         lOwP2s4eY/FfEUU96zWCw+wEOYZSVlI9ShJI+hd0ernBj+e4ARbkF47AR95inMxtmGr6
         QLZ5T7VpoSiL/hiqr6tyojG9XdFGfWLTAA4jKxG0c/JsFtuZpGtPC5/X4WU9Q1hE3OVA
         DU1ytFSwDkvUVqLZrX9drXap87QQEH38Mcdg2St2Ec08aTSJNn+4xmkZlJTxnopu18wv
         aYOeYWDJ2X5TSxXYOlUpwKk8xrYNel4wOGlzHrDbMGT+8rvGU3gVqAkowLEYkppBkQep
         RIBg==
X-Gm-Message-State: AAQBX9f2ZP9OPs+ytLgGocvzX+PMMwdCpIBVbV8Tt0Lbq6/lWmRsxA8A
        AGFu7Nx/8GCl7vfYwZWDJ30=
X-Google-Smtp-Source: AKy350Y+KSR4XYDI+3wkHvXeKTBJE1X4uD1ML3tllN9+gL03fvHx3xzqjr5Z7u1sd8IJYwRrye0jUw==
X-Received: by 2002:ac2:47f6:0:b0:4e9:609f:256d with SMTP id b22-20020ac247f6000000b004e9609f256dmr936623lfp.13.1681233030564;
        Tue, 11 Apr 2023 10:10:30 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id c20-20020ac25314000000b004ec87cf6b63sm1193858lfh.274.2023.04.11.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:10:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Apr 2023 19:10:27 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDWUgygOqJjs07pp@pc636>
References: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
 <2159c88e-ec99-4ad6-a166-baf4199d138f@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2159c88e-ec99-4ad6-a166-baf4199d138f@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 09:42:37AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 11, 2023 at 04:58:22PM +0200, Uladzislau Rezki wrote:
> > On Tue, Apr 11, 2023 at 02:42:27PM +0000, Zhang, Qiang1 wrote:
> > > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > > > cache growing and disable allocated page in fill_page_cache_func().
> > > > > 
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > >
> > > > >Much improved!  But still some questions below...
> > > > >
> > > > >							Thanx, Paul
> > > > >
> > > > > ---
> > > > >  kernel/rcu/tree.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index cc34d13be181..9d9d3772cc45 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2908,6 +2908,8 @@ static inline bool
> > > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > > >  {
> > > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > > +		return false;
> > > > >
> > > > >This will mean that under low-memory conditions, we will keep zero
> > > > >pages in ->bkvcache.  All attempts to put something there will fail.
> > > > >
> > > > >This is probably not an issue for structures containing an rcu_head
> > > > >that are passed to kfree_rcu(p, field), but doesn't this mean that
> > > > >kfree_rcu_mightsleep() unconditionally invokes synchronize_rcu()?
> > > > >This could seriously slow up freeing under low-memory conditions,
> > > > >which might exacerbate the low-memory conditions.
> > > > 
> > > > Thanks for mentioning this, I didn't think of this before😊.
> > > > 
> > > > >
> > > > >Is this really what we want?  Zero cached rather than just fewer cached?
> > > > >
> > > > >
> > > > >
> > > > >  	// Check the limit.
> > > > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > > >  		return false;
> > > > > @@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > > > >  	int i;
> > > > >  
> > > > >  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > > > > -		1 : rcu_min_cached_objs;
> > > > > +		0 : rcu_min_cached_objs;
> > > > >  
> > > > >  	for (i = 0; i < nr_pages; i++) {
> > > > >
> > > > >I am still confused as to why we start "i" at zero rather than at
> > > > >->nr_bkv_objs.  What am I missing here?
> > > > 
> > > > 
> > > > No, you are right, I missed this place. 
> > > > 
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2908,6 +2908,8 @@ static inline bool
> > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > >         struct kvfree_rcu_bulk_data *bnode)
> > > >  {
> > > > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > +               return false;
> > > >
> > > >This is broken, unfortunately. If a low memory condition we fill
> > > >fill a cache with at least one page anyway because of we do not want
> > > >to hit a slow path.
> > > 
> > > Thanks remind, please ignore my v4 patch,   how about the following?
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 41daae3239b5..e2e8412e687f 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3238,6 +3238,9 @@ static void fill_page_cache_func(struct work_struct *work)
> > >                         free_page((unsigned long) bnode);
> > >                         break;
> > >                 }
> > > +
> > > +               if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +                       break;
> > >         }
> > It does not fix an "issue" you are reporting. kvfree_rcu_bulk() function
> > can still fill it back. IMHO, the solution here is to disable cache if
> > a low memory condition and enable back later on.
> > 
> > The cache size is controlled by the rcu_min_cached_objs variable. We can
> > set it to 1 and restore it back to original value to make the cache operating
> > as before.
> 
> It would be best to use a second variable for this.  Users might get
> annoyed if their changes to rcu_min_cached_objs got overwritten once
> things got set back to normal operation.
> 
Agree. So we do not make it visible over sysfs interface for user that
we manipulate it.

--
Uladzislau Rezki

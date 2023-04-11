Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0256DDF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDKPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDKPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:16:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AA65254;
        Tue, 11 Apr 2023 08:15:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d7so21948423lfj.3;
        Tue, 11 Apr 2023 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681226069; x=1683818069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OpryC7/F2PjMoZI6KtQP1LduXXGDL/tjNVIOT59ELzY=;
        b=fg7fN9bUpaTOx3rUkPHwEGKsRSZvQRoTreMjBx/DVnEcj7O+xYbGDXMvCMnLoe1Hn+
         6hgeu5w4SJP3Kb6xTjYE1TKe+AidE4yzfQM1XJmN4EhJVGrZaXY78KhTmZSCJo/+EmD6
         mSZEHbc4r37fdGbl+fF+keMYiRZLpyZR+7nXGMNFr41P/cVppRdRTm2sT1g38OLNdzu3
         IA0RmWqSUA4947b0uiS9qSiNTSimCfYx/9sgUAaTwJdfWPjgCgmb8Ry1lRubatcibY4C
         szLI4c43Xe36Lng+VTnx9GpjorIBhW0NEcj3t7AG1cybhxudrUB1wfPDd4CjFuW3vk0g
         dmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681226069; x=1683818069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpryC7/F2PjMoZI6KtQP1LduXXGDL/tjNVIOT59ELzY=;
        b=G3pc6i53TzMIb0imWIFFEuEe5hi/SsBUPKbzv33tZ+aemnh0xrbCShNAOu+s8MTP52
         ha90BFzGVngqJ3mmwN71L/Mt/Or17At35az/EiJ7+74QxX/NNXa692YKcD88o5W+p4Wa
         E2cvzRqS4lfKvwPQ4ganTqV79tr1G3n6NNhKEdz/3KM38YGmlc8ndMfOyEgO4jgP1xs+
         IvH56SjAkLlKLQ7prD5eVgRWcAD7Cyr3+kr0z/bawE5qWFo9kzX4iSTZVINtqn/58jkS
         EBJxdOkB+W4mOK9/824OPL3Et+eg6fT6sg2z2gFufRicZ/7l8B9DCNHxRdDJlFUbvFdb
         9zHA==
X-Gm-Message-State: AAQBX9e1CTbrWoU6I40+AAbb3ga1Ea/5LG5yn5UcZ/sCno7U7j4SXgC2
        sU+bmwky4ZhXaVmWr8NCyP4=
X-Google-Smtp-Source: AKy350bPh6l2cGlM2eXwLHBShK977Du4rIBLDqED5nlAzBeLTAjy/7zHaPyyKbnbRNE4TipAMJeTMg==
X-Received: by 2002:ac2:592f:0:b0:4ea:f632:17 with SMTP id v15-20020ac2592f000000b004eaf6320017mr3171041lfi.51.1681226069340;
        Tue, 11 Apr 2023 08:14:29 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e8e82000000b002a7729eea3dsm1414880ljk.88.2023.04.11.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:14:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Apr 2023 17:14:26 +0200
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDV5UjnUqr67CeKl@pc636>
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
 <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
 <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
 <PH0PR11MB58809695F11E7B4EEBE72F95DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58809695F11E7B4EEBE72F95DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:09:13PM +0000, Zhang, Qiang1 wrote:
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
> >It does not fix an "issue" you are reporting. kvfree_rcu_bulk() function
> >can still fill it back. IMHO, the solution here is to disable cache if
> >a low memory condition and enable back later on.
> >
> >
> >The cache size is controlled by the rcu_min_cached_objs variable. We can
> >set it to 1 and restore it back to original value to make the cache operating
> >as before.
> 
> A good suggestion.  a question, when need to restore  rcu_min_cached_objs?
> after the execution of kfree_rcu_shrink_scan() ends?
> 
We do not know when a low memory condition ends :) Therefore we defer a
refill work for a certain time. In the fill_page_cache_func() we allow the
cache operate as normal again:

...
	atomic_set(&krcp->backoff_page_cache_fill, 0);
...

--
Uladzislau Rezki

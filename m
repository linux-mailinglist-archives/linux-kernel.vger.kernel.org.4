Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827EF6DDEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDKO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDKO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:58:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFF35B1;
        Tue, 11 Apr 2023 07:58:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id be27so8901672ljb.12;
        Tue, 11 Apr 2023 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681225105; x=1683817105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCfDxZPGEWehZVR1WIoWj8Z0e30/w9tLpnBsc4IqhRA=;
        b=pJzrABJ89JGct5JmE5L749eDy9kIbsZJLp12XqvnTRRhaGJhbbAcG3PtJ9iK1heRiS
         VDKiJ9zEa2/wPn07IRy3BYE8y5sfuslYjzKguAVJeVcYbb7EWmPXHOEyA8EozWq56Puv
         +W+3aJ3ETGruOLKhukn2LrcQfVEmXwA4XALTqq164aXVFYcVpgFoFTo68KTmV258zLFJ
         UIvxfJkM2DZv58WWRNwtPwbZ/J0FGg41AGu+pl/QA+MKDxBI5NU7BxbqbZ/IhQqigmYV
         CJL6fQ47PKYqdTKSF/aafa5oO+rtd/l/Dl1D4oI9YH6mayy8uWe1zRlBTwxQjozLibW9
         Vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225105; x=1683817105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCfDxZPGEWehZVR1WIoWj8Z0e30/w9tLpnBsc4IqhRA=;
        b=bRzdQofQ+2ZqweNI9TSzd6wp3pXKPIncnL2+9va4EuXar3V6OkKzQ+0OGdiMbko6Il
         aOq89besPa+/rq2nWc9LnbDTX2nxxPfzXwadsu0nZkH+576+UW6ehD3g2im8elRYnHx0
         IqL9PwK7b/TlwRFhzmg0OZMnKDWUfRBTxf4w9ELGL+acOIzjma3YN6dy9mU9RSmz336L
         pyMTKs/wf2H02e622kHppBYGZAp2bnMdFOpV65Y/iUpIk8vN3Z2BN67tNRDELLBgUd17
         bF1gFZCQYIDhZ9tu2MAobkvjXsiKHYY5Rw990+G5gAEQhZX6HsF5oqLAlQNzVG81Th5S
         Jvmw==
X-Gm-Message-State: AAQBX9ePZQ4JRwUCrJ51+RhJX73LgwSPC9CYdRcvRGFitouJxqJyeFbo
        IN6wY285Dz7CT69h+xt6jyo=
X-Google-Smtp-Source: AKy350aOPQrkzz49edIQ/RI0dLtkCn77jTKHarrOCX+RVNhY2Qz7tvbs234I3mb4dHXXnQjB3nWNpw==
X-Received: by 2002:a2e:b179:0:b0:2a7:96bd:9eb3 with SMTP id a25-20020a2eb179000000b002a796bd9eb3mr97233ljm.3.1681225105349;
        Tue, 11 Apr 2023 07:58:25 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id u25-20020a2e8559000000b002a774fb7923sm1302810ljj.45.2023.04.11.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:58:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Apr 2023 16:58:22 +0200
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
Message-ID: <ZDV1jhENgED4ctxO@pc636>
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
 <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
 <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:42:27PM +0000, Zhang, Qiang1 wrote:
> > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > cache growing and disable allocated page in fill_page_cache_func().
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >Much improved!  But still some questions below...
> > >
> > >							Thanx, Paul
> > >
> > > ---
> > >  kernel/rcu/tree.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index cc34d13be181..9d9d3772cc45 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2908,6 +2908,8 @@ static inline bool
> > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >  	struct kvfree_rcu_bulk_data *bnode)
> > >  {
> > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +		return false;
> > >
> > >This will mean that under low-memory conditions, we will keep zero
> > >pages in ->bkvcache.  All attempts to put something there will fail.
> > >
> > >This is probably not an issue for structures containing an rcu_head
> > >that are passed to kfree_rcu(p, field), but doesn't this mean that
> > >kfree_rcu_mightsleep() unconditionally invokes synchronize_rcu()?
> > >This could seriously slow up freeing under low-memory conditions,
> > >which might exacerbate the low-memory conditions.
> > 
> > Thanks for mentioning this, I didn't think of this before😊.
> > 
> > >
> > >Is this really what we want?  Zero cached rather than just fewer cached?
> > >
> > >
> > >
> > >  	// Check the limit.
> > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > >  		return false;
> > > @@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > >  	int i;
> > >  
> > >  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > > -		1 : rcu_min_cached_objs;
> > > +		0 : rcu_min_cached_objs;
> > >  
> > >  	for (i = 0; i < nr_pages; i++) {
> > >
> > >I am still confused as to why we start "i" at zero rather than at
> > >->nr_bkv_objs.  What am I missing here?
> > 
> > 
> > No, you are right, I missed this place. 
> > 
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2908,6 +2908,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >         struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > +               return false;
> >
> >This is broken, unfortunately. If a low memory condition we fill
> >fill a cache with at least one page anyway because of we do not want
> >to hit a slow path.
> 
> Thanks remind, please ignore my v4 patch,   how about the following?
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 41daae3239b5..e2e8412e687f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3238,6 +3238,9 @@ static void fill_page_cache_func(struct work_struct *work)
>                         free_page((unsigned long) bnode);
>                         break;
>                 }
> +
> +               if (atomic_read(&krcp->backoff_page_cache_fill))
> +                       break;
>         }
It does not fix an "issue" you are reporting. kvfree_rcu_bulk() function
can still fill it back. IMHO, the solution here is to disable cache if
a low memory condition and enable back later on.

The cache size is controlled by the rcu_min_cached_objs variable. We can
set it to 1 and restore it back to original value to make the cache operating
as before.

--
Uladzislau Rezki

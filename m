Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3B6DF575
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjDLMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjDLMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:37:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BA7EC8;
        Wed, 12 Apr 2023 05:36:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m4so14319263lfj.13;
        Wed, 12 Apr 2023 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302993; x=1683894993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLB83siIxXH69Mn8uH9oS0pLbxWqyF34biAfaFTutaM=;
        b=dMdQsAddccBvFy+DyAuswJTyIJgqGN1i+EuUOUizj6JkP/Jdg5XvUR7LxRc4Xzfjv9
         f4CusFVXlbHp/z1y7cfkug6+GGWdFRewCpUhtKhTMDVxC1V1MdpnV4PG1JGJDUsCRa2s
         8HOqZZorV/ANKNTUuvWmGdBCUpOLdw5MBPmXeePvWM70bftNRHpJukhQlH5lcKuDsfzB
         e14QbklqAjYZ30Dewk69o6+tP9BmJPf2jE2p0zW4/JvnS33fk6f2rmda8dCfspB8gxdQ
         Pf/22/dCv64v8Qoeq7v3DUGcRlTYci96xslpPURvDLpj3DRuC5gApKVmR3mIV+wAzOO5
         o5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302993; x=1683894993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLB83siIxXH69Mn8uH9oS0pLbxWqyF34biAfaFTutaM=;
        b=eKG3cSU6ycn3CsM8TYLiVMpGDWUcHi/JgS0pzcgbo6OkQdytRJO+H7uqRZQrC/jMcE
         qQu5eVkrkxA+MGb2ileTdy5WgLpzgAMirHH3B70Pi1m0q6GgGxEOdngQFLqG1WW0Rv0C
         pqnGeGuExhxDw+QTlNzAqv65cqUsaVu9/ud71J2rCPrkzmCwM2b2FOBKolfjVrPO14on
         5VrQH5Cyu1obCMFvaMUf+rAqHGveqa/0U5mX1+N6ITCmbs6RweNtuIcs6e27ztIO1uxT
         U7ARgg8fUBMowclSZxhg0OWkqZEhthedGqC71q+g8QEH4Vxf6Owq5B2kBLbdQh5fia2y
         JfDw==
X-Gm-Message-State: AAQBX9cenD72p7wfUyiy7MT5VzSdMwdbWepimrdfcYveH98zZBU3nYct
        L5bMs6+LvWPHBllLmskDWWs=
X-Google-Smtp-Source: AKy350ZEC5Bhc8xvVHuPxelIDOH9EsAl9fWD0GJb5xoMYgUMGlLUQD34Ma713685hkMIaWrzgt0xJA==
X-Received: by 2002:a05:6512:146:b0:4ec:82d8:ade1 with SMTP id m6-20020a056512014600b004ec82d8ade1mr1372123lfo.53.1681302993169;
        Wed, 12 Apr 2023 05:36:33 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id p12-20020a19f00c000000b004eaf8613bc3sm2984786lfc.284.2023.04.12.05.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:36:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 12 Apr 2023 14:36:30 +0200
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDalzl1CTQ9VEPDw@pc636>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
 <ZDEfFcEhirm443xE@pc636>
 <PH0PR11MB58805AC5772BECAF65AD4365DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58805AC5772BECAF65AD4365DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:18:20AM +0000, Zhang, Qiang1 wrote:
> > On Thu, Apr 06, 2023 at 11:11:37PM +0000, Zhang, Qiang1 wrote:
> > > >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > > > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > > > cache growing.
> > > > > 
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 9cc0a7766fd2..f25430ae1936 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2907,6 +2907,8 @@ static inline bool
> > > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > > >  {
> > > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > > +		return false;
> > > > >  	// Check the limit.
> > > > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > > >  		return false;
> > > > > -- 
> > > > > 2.32.0
> > > > >
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > >
> > > >Thank you both!
> > > >
> > > >One question, though.  Might it be better to instead modify the "for"
> > > >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> > > >of starting at zero?  That way, we still provide a single page under
> > > >low-memory conditions, but provide rcu_min_cached_objs of them if memory
> > > >is plentiful.
> > > >
> > > >Alternatively, if we really don't want to allow any pages at all under
> > > >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
> > > >to zero (instead of the current 1) when the krcp->backoff_page_cache_fill
> > > >flag is set?  
> > > 
> > > Hi, Paul
> > > 
> > > If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () return false,
> > > the allocated single page will also be freed in fill_page_cache_func().
> > > 
> > > or it would be better not to allocate under memory pressure.
> > 
> > That was my thought.  ;-)
> > 
> > > How about like this?
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9cc0a7766fd2..94aedbc3da36 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2907,6 +2907,8 @@ static inline bool
> > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >         struct kvfree_rcu_bulk_data *bnode)
> > >  {
> > > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +               return false;
> > >         // Check the limit.
> > >         if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > >                 return false;
> > > @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > >         int i;
> > > 
> > >         nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > > -               1 : rcu_min_cached_objs;
> > > +               0 : rcu_min_cached_objs;
> > > 
> > >         for (i = 0; i < nr_pages; i++) {
> > 
> > The other question is why this loop does not allow for any pages
> > that might already be allocated, thus perhaps looking like this:
> > 
> > 		for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
> > 
> > Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
> > seeing this, but I do feel the need to ask.)
> > 
> >Usually we start from zero, this is when a ptr. was not added into
> >a bulk array, due to no memory reason for a single argument and no
> >cache pages anymore for double argument.
> >
> >In the fill page function, the limit is checked by the put_cached_bnode() itself
> >so it stops prefetch once nr_bkv_objs contains desired value.
> >
> 
> If the krcp->nr_bkv_objs is updated in kfree_rcu_work() and happens before invoke fill_page_cache_func(),
> when invoke fill_page_cache_func(), we start from zero,  will allocate page and hold krcp->lock,
> fill krcp->bkvcache,  but if krcp->nr_bkv_objs already equal to rcu_min_cached_objs,  this page will
> be freed and exit loop,  this allocate page seems like a meaningless operation. 
> 
> I also want to ask if starting from krcp->nr_bkv_objs is necessary?
> 
At least it does not break anything. The example like you described can
occur. So starting from the krcp->nr_bkv_objs is worth to do.

So, if it happens it would be good of you could simulate it and update
the commit message accordingly.


--
Uladzislau Rezki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223C6DB96F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDHIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDHIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:00:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF5359D;
        Sat,  8 Apr 2023 01:00:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xi5so1618817ejb.13;
        Sat, 08 Apr 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940823; x=1683532823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bi7JvPElT3hg9CbjcEBIDpY1q4eP6kscnFBEUMqhqWo=;
        b=Ey95lsZW/q3t/v3cDSZpSCnqf7fGu21eyqnQYme+DfPxkX92GvxuUwEX5aC+wxQKfu
         IexoDmOogRWK//rYDxO5e9NQ3aHsz6HzM7r0Ok/Qqg/WJ00k3W5NTjuzcht4TSTnkwlB
         VxafJrEI0kg5+TgbgxLUHvjvaXHLz+t9S70AydeXAYUu+3OkclZmlfrsvfSceG8ZsckP
         xqplc0WvgNJ1VcwTNM9qx3J6jogdB6t67Zfd2MYNVRVXeQqSGkHIUD986BnY9p9YgNzt
         40g6uc8xFcm70StKiAnLl/pHD84Y/Eukf2gqg3mEHVBnU3jV7OBq7g6piMT5alAfZloE
         fI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940823; x=1683532823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi7JvPElT3hg9CbjcEBIDpY1q4eP6kscnFBEUMqhqWo=;
        b=S6gmK8KIASBuCgVdf9gLOBgVbWgBEOIfoyE/k/JHVeBEFLhNFZGpRh7m0IbrcJRnGi
         Oletrviw08fDzNG1gPCvwStP2AQ6t7l98ADN0mX3A2Ox31zdoRB9pvUDxjz021SSVDUU
         U2MSxT4C5DdlkMMHVkDCfS02gxlNr8xRgvt1zVda8RArDmK0whhqmTZgKKirHgCnnot6
         LtEs99I0vRYnmh6c4qw1/SfnOuRtUf26b9nED5sLXjNkttVuhGXbVX/LOMAeMD/Ga35b
         4+YI21DafBvbGRTZvv8+xCYJlJG5vOWfRP+bgegRW+qSAMEnE05t5+cQp+ZZRcZcbkRM
         1Fow==
X-Gm-Message-State: AAQBX9dNXmZh6Emcicf2eyPRAk+TqAAjf5Qc26z1YY2D0FR0ywXbcSvP
        quG8HM8WSevruDdP6KJSBfU=
X-Google-Smtp-Source: AKy350b7h4Z7OyhtVjpWtztw0oz7BMrwqtwwgUHF+jh6UyREppQQ/YfTztchVbAHg5xnTDbWPn3eJQ==
X-Received: by 2002:a17:906:b042:b0:930:8714:6739 with SMTP id bj2-20020a170906b04200b0093087146739mr1993555ejb.30.1680940823182;
        Sat, 08 Apr 2023 01:00:23 -0700 (PDT)
Received: from pc636 (49-224-201-31.ftth.glasoperator.nl. [31.201.224.49])
        by smtp.gmail.com with ESMTPSA id kf25-20020a17090776d900b0093b8c0952e4sm2865365ejc.219.2023.04.08.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 01:00:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 8 Apr 2023 10:00:21 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDEfFcEhirm443xE@pc636>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:04:03PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 06, 2023 at 11:11:37PM +0000, Zhang, Qiang1 wrote:
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
> 
> That was my thought.  ;-)
> 
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
> 
> The other question is why this loop does not allow for any pages
> that might already be allocated, thus perhaps looking like this:
> 
> 		for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
> 
> Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
> seeing this, but I do feel the need to ask.)
> 
Usually we start from zero, this is when a ptr. was not added into
a bulk array, due to no memory reason for a single argument and no
cache pages anymore for double argument.

In the fill page function, the limit is checked by the put_cached_bnode() itself
so it stops prefetch once nr_bkv_objs contains desired value.

--
Uladzislau Rezki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3726DDDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDKO0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjDKO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:26:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11D7559A;
        Tue, 11 Apr 2023 07:25:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t20so10624887lfd.5;
        Tue, 11 Apr 2023 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681223144; x=1683815144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q9Uteyj1DaiZUoNrfIlXlxhLeTCPZeNTZGY4/cSJ9Pg=;
        b=A1H5eFRD2xqgCsQg6sw1iWkM5v2u+AMM8rP9Ag+p97w6CmExnx26SFIILaQLZj1hS8
         Zqx/T4BlEYwFEMhYPNmV5D6WHQcCbOEJdhj8ROaCDG8oMMOt8zZT6eLStPbNTChEpTGo
         oHTVIJcaxoMwopT9ZpzT3rDfEJxwCNzh645EzDCVuUkOdfPrvYv5MHJhXy5ujD3nTjED
         wh+D4x0GuaOt4kSYpYXbHIzQhiQUv70SPS/UQ7hO9UVqAtaqGmOvfFy24/+4419mWBGu
         Au9ik4iwR70q/MSDhfJF6bXyzQCWUAXlg3WRvAbQxSdYjtQOEhg4pnz92nxB5lEPq7I0
         5IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223144; x=1683815144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9Uteyj1DaiZUoNrfIlXlxhLeTCPZeNTZGY4/cSJ9Pg=;
        b=DmoV4mHb0OE2iPHDneYVmWY0Jq/8Demo+LqU6yX8kwxECuLrFbBoPAH6WcvQt2iMh4
         g1a/ct6M5G3b66gbFMhzXX7oADFXWdA0BXHSZ57bWHU+Zyz/YN4bUcHTE3v9QCgoPRc0
         RqRUL/QLrODy1gwhG6in4A5oLu1uSjkl/CpPMj83uq7GzMYutE3U4Y8U6BIvqcb6Tc17
         iIfETDWKMjJxYDg8fCDbng6KCmgacxFD1AV5DTz57aWt+CHxYBjLjJWE0I01yuqUJ+Or
         /Xn7ZdDYxP1qvQyxh3tTZnRS+fdwC0E+gYXj+yH6E3LcEbb/QXrajN0srbxRasC9Euw1
         UDiQ==
X-Gm-Message-State: AAQBX9fj3I8GhE+rrtMIb9rkqKZHIGF4Gp7fYW7AJpVceQftJGnz04qV
        whf51TND0267zG0xXUPb+gg=
X-Google-Smtp-Source: AKy350beU351EdTavfSbsBmA/QlC58GSMuMg72ktFh0MmjCYhlIs1jBF+7ZA0eqPRmV5/Dg70Dsbug==
X-Received: by 2002:a19:f81a:0:b0:4db:28ce:e600 with SMTP id a26-20020a19f81a000000b004db28cee600mr4727370lff.1.1681223143912;
        Tue, 11 Apr 2023 07:25:43 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id z11-20020ac2418b000000b004eb2f35045bsm2586074lfh.269.2023.04.11.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:25:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Apr 2023 16:25:41 +0200
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDVt5eUAlp4VmbFy@pc636>
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
 <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
 <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:04:45AM +0000, Zhang, Qiang1 wrote:
> > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > page cache again in kfree_rcu_monitor(), this commit add a check
> > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > cache growing and disable allocated page in fill_page_cache_func().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Much improved!  But still some questions below...
> >
> >							Thanx, Paul
> >
> > ---
> >  kernel/rcu/tree.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index cc34d13be181..9d9d3772cc45 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2908,6 +2908,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >  	struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > +		return false;
> >
> >This will mean that under low-memory conditions, we will keep zero
> >pages in ->bkvcache.  All attempts to put something there will fail.
> >
> >This is probably not an issue for structures containing an rcu_head
> >that are passed to kfree_rcu(p, field), but doesn't this mean that
> >kfree_rcu_mightsleep() unconditionally invokes synchronize_rcu()?
> >This could seriously slow up freeing under low-memory conditions,
> >which might exacerbate the low-memory conditions.
> 
> Thanks for mentioning this, I didn't think of this before😊.
> 
> >
> >Is this really what we want?  Zero cached rather than just fewer cached?
> >
> >
> >
> >  	// Check the limit.
> >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> >  		return false;
> > @@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
> >  	int i;
> >  
> >  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > -		1 : rcu_min_cached_objs;
> > +		0 : rcu_min_cached_objs;
> >  
> >  	for (i = 0; i < nr_pages; i++) {
> >
> >I am still confused as to why we start "i" at zero rather than at
> >->nr_bkv_objs.  What am I missing here?
> 
> 
> No, you are right, I missed this place. 
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2908,6 +2908,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>         struct kvfree_rcu_bulk_data *bnode)
>  {
> +       if (atomic_read(&krcp->backoff_page_cache_fill))
> +               return false;
>
This is broken, unfortunately. If a low memory condition we fill
fill a cache with at least one page anyway because of we do not want
to hit a slow path.

>         // Check the limit.
>         if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
>                 return false;
> @@ -3223,7 +3225,7 @@ static void fill_page_cache_func(struct work_struct *work)
>         nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
>                 1 : rcu_min_cached_objs;
> 
> -       for (i = 0; i < nr_pages; i++) {
> +       for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
>                 bnode = (struct kvfree_rcu_bulk_data *)
>                         __get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> 
> 
IMHO, it should be send as a separate patch explaining why it
it is needed.

--
Uladzislau Rezki

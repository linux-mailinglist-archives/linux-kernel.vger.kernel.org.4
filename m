Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C566560842E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJVEOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJVEOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:14:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F125DAC5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:14:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso2760158pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFD76B1WOxbM6hvMl4TWkrGv9g+jIBPp+IWZbs4ACgA=;
        b=WZc9VMxCxukydXe+XWvhnyfUeVIYaHmZ7bBRgW3fMNkv2baBrKCVeEeThIP70aJxI4
         oPUEABJa0R93ioGXGKhPeYjsTy04DQpP91xeF7/iGSu+PM1LNTvq/KGjFDdn0i/IfN5t
         ZF+nnpnxiGooI9FqNZsIgVAyPEIaBjquTJidE6SAmKb8lOcYB5nUVm1INxr47gMtdx1G
         uP1jXvIVGHevWa9gm6i+EgPZ1ucpN1iBlsgU1DKxcxM+r+omUnNR+0ya9yosffjFp7mr
         WuCBxNyq4U8XoZ22isN3wJsx8cSeokDKyrViHuJPtg8D8fwSB/ApEyhbRBA9zpuVodXT
         Lm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFD76B1WOxbM6hvMl4TWkrGv9g+jIBPp+IWZbs4ACgA=;
        b=WH1kIP5NRqeut+dknugtJfhSy/2S/yD105KE9mkBMGcIcW+ScjakKqL5d18IMwze03
         Fogl+H8bOjP/4/4sFrZG51kw7DLXpRxLau5x0SKY+/XYRBx0ROWy9Ua2cEMLCvnSePrZ
         QmpxMTPo9gv95kjhv3OCK4EfmUBEUVlJsAyA+rCrayZYe3C7Imbcpw9BpUrzrJ2LVuJW
         SFvK4SL3KI6LimgQvaOof95txOW8zowySZxy1qZaw7LOeuELu6rApRiyUhOU86FOuGd5
         cEjmPEDxA0gvjbfMDp1Ls6wg5TJK92OaqvPmDFpnL3w+D4EJj3N2PpBqjT01t8k6kX2O
         r/2Q==
X-Gm-Message-State: ACrzQf3/cnSQ+Xi+474ByxJc7gtjgHVaYmbqg30Nfmud0Ri2YydOovJh
        Klc+R9mlcWwaZ27fpzQXx2E=
X-Google-Smtp-Source: AMsMyM6eSrtheknT3YaeF3DoWSfwMIIDLVJdWV4dFmd36QwgHbCMgHScxt4/NJrBFcuRO/JEBEut/Q==
X-Received: by 2002:a17:902:d58c:b0:17f:998a:76cd with SMTP id k12-20020a170902d58c00b0017f998a76cdmr22309000plh.155.1666412057109;
        Fri, 21 Oct 2022 21:14:17 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id lw12-20020a17090b180c00b0020d67a726easm587012pjb.10.2022.10.21.21.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 21:14:16 -0700 (PDT)
Date:   Sat, 22 Oct 2022 13:14:10 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove dead code for debug caches on
 deactivate_slab()
Message-ID: <Y1NuEhXgxmr2OHeH@hyeyoo>
References: <20221014114322.97512-1-42.hyeyoo@gmail.com>
 <82e8147e-f031-6bc2-9395-56d2052e62cb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e8147e-f031-6bc2-9395-56d2052e62cb@suse.cz>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:43:42PM +0200, Vlastimil Babka wrote:
> On 10/14/22 13:43, Hyeonggon Yoo wrote:
> > After commit c7323a5ad0786 ("mm/slub: restrict sysfs validation to debug
> > caches and make it safe"), SLUB does not take a slab from partial list for
> 
> I'm confused by "SLUB does not take a slab from partial list" here. Did you
> mean something like "SLUB never installs (even temporarily) a percpu slab
> for debug caches"?

Yes.

> So that means we never deactivate percpu slabs for debug
> caches.

Yes.

> And since debug caches are also the only ones that use the full
> list, we no longer need to care about the full list in deactivate_slab(), right?

Yes, You got it right, exactly!

Let me rephrase:

"After commit c7323a5ad0786 ("mm/slub: restrict sysfs validation to debug
caches and make it safe"), SLUB never installs percpu slab for debug caches
and thus never deactivates percpu slab for them.

Since only some of debug caches care about the full list, SLUB no longer
deactivates to full list. Remove dead code in deactivate_slab()."


Feel free to change this ;-)

> 
> > debug caches. As deactivation isn't needed anymore, remove dead code.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Otherwise it looks correct to me, just wanted to clarify I'm not missing
> something.

You are not missing anything.
Thank you for clarification.

Hyeonggon

> 
> > ---
> >  mm/slub.c | 16 ++--------------
> >  1 file changed, 2 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 96dd392d7f99..e2215240954d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2411,7 +2411,7 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
> >  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  			    void *freelist)
> >  {
> > -	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE, M_FULL_NOLIST };
> > +	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
> >  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> >  	int free_delta = 0;
> >  	enum slab_modes mode = M_NONE;
> > @@ -2487,14 +2487,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  		 * acquire_slab() will see a slab that is frozen
> >  		 */
> >  		spin_lock_irqsave(&n->list_lock, flags);
> > -	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> > -		mode = M_FULL;
> > -		/*
> > -		 * This also ensures that the scanning of full
> > -		 * slabs from diagnostic functions will not see
> > -		 * any frozen slabs.
> > -		 */
> > -		spin_lock_irqsave(&n->list_lock, flags);
> >  	} else {
> >  		mode = M_FULL_NOLIST;
> >  	}
> > @@ -2504,7 +2496,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  				old.freelist, old.counters,
> >  				new.freelist, new.counters,
> >  				"unfreezing slab")) {
> > -		if (mode == M_PARTIAL || mode == M_FULL)
> > +		if (mode == M_PARTIAL)
> >  			spin_unlock_irqrestore(&n->list_lock, flags);
> >  		goto redo;
> >  	}
> > @@ -2518,10 +2510,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  		stat(s, DEACTIVATE_EMPTY);
> >  		discard_slab(s, slab);
> >  		stat(s, FREE_SLAB);
> > -	} else if (mode == M_FULL) {
> > -		add_full(s, n, slab);
> > -		spin_unlock_irqrestore(&n->list_lock, flags);
> > -		stat(s, DEACTIVATE_FULL);
> >  	} else if (mode == M_FULL_NOLIST) {
> >  		stat(s, DEACTIVATE_FULL);
> >  	}
> 

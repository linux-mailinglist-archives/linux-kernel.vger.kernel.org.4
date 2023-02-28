Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D476A62E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB1Wx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Wx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:53:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A043401C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:53:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n5so6781165pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677624836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmJBk+SbzeGsb6WDHWELtLn5ezNrmb5a5dd/nz1DZN8=;
        b=lVY47DTv23Y0ZhtqrSvSGHFUwL9XUFn/6RhnyXQvK02Zauv+OZuVLTbZrpB6MTzbCW
         QiCDcEoizVdXP4ltBDgZm7nlSdjHhc5sr2J8LK6qWTiznx1aGcw+3J2vyMbKGy0gssce
         ZTpcSgI+oCr1w/nAZE3l7J7bV6zZbZaCpxUzr62DArrBlNGBRr0iSRJOQxKLrlP50ftz
         v+x6TYw+RIZH4fbysoFhF96H7+YVN1teZwjOE+QMTIzj6gJU2EYjTCYHx7kenUu9F6Nl
         ue3toi9HBpL4XO1/0XG3B65FkAuvwIWZTV4+hFeyGX3IvqYnpjT44Ocwmvs3K/Z9dDih
         5QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677624836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmJBk+SbzeGsb6WDHWELtLn5ezNrmb5a5dd/nz1DZN8=;
        b=Al7/Z2YSv+NQmXzusndqCtLESL2S877syW1LsQhB8nIx2FzYLrFzctZa5aosb/4pgC
         yVgj26v+TBIB5Im/+QVSTEC/GAxQlCF5E7O77KbgymOSoFYId61d+dAodCxyLMDqlvnK
         14G1UzgmBzVne4gM6ag0kD6HS3PJXlNGLC06c4tutBG9K4AEwbijiFU9RWUbVEPbFmS3
         8q7Q80ArNauNv+w3LqOxo3fzqTCyruFfaPWQo5njuz3wjHVYyXk6is6Y+zy/UsA+V0Gv
         HyLMgv4pmHQUjGXuvKLy5XxrP2NM1K78g/TeMTgD1zRALrMN1sjEOT7PG7GrfKAjVyF3
         470A==
X-Gm-Message-State: AO0yUKU37wwr3ViYHbGjSEVGGJCczzmDr2MvTKdFo4MYmQRIhOybAXJn
        2SSYqwuzkmcUdGMk+Irv5y0=
X-Google-Smtp-Source: AK7set/jEROoXr9AYq0co/9oRqaBiZryOKRUFIeuUhLG9S5SuZlHGgdaODylKVxuZJ8qHKeNUJr7cg==
X-Received: by 2002:a62:1989:0:b0:5aa:2d65:4733 with SMTP id 131-20020a621989000000b005aa2d654733mr3252721pfz.10.1677624835978;
        Tue, 28 Feb 2023 14:53:55 -0800 (PST)
Received: from google.com ([2620:15c:211:201:639:82f5:b510:3494])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78243000000b005e5861932c9sm6528850pfn.129.2023.02.28.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:53:55 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Feb 2023 14:53:53 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y/6GAYJ4c9W0bPzp@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/riPlQ2UK00WirI@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 01:38:22PM +0900, Sergey Senozhatsky wrote:
> On (23/02/23 15:27), Minchan Kim wrote:
> > > + * Pages are distinguished by the ratio of used memory (that is the ratio
> > > + * of ->inuse objects to all objects that page can store). For example,
> > > + * INUSE_RATIO_30 means that the ratio of used objects is > 20% and <= 30%.
> > > + *
> > > + * The number of fullness groups is not random. It allows us to keep
> > > + * diffeence between the least busy page in the group (minimum permitted
> > > + * number of ->inuse objects) and the most busy page (maximum permitted
> > > + * number of ->inuse objects) at a reasonable value.
> > > + */
> > > +#define ZS_INUSE_RATIO_0	0
> > 
> > How about keeping ZS_EMPTY and ZS_FULL since they are used
> > multiple places in source code? It would have less churning.
> 
> I have to admit that I sort of like the unified naming
> 	"zspage inuse ratio goes from 0 to 100"
> 
> but I can keep ZS_EMPTY / ZS_FULL as two "special" inuse values.
> 
> > > +#define ZS_INUSE_RATIO_10	1
> > > +#define ZS_INUSE_RATIO_20	2
> > > +#define ZS_INUSE_RATIO_30	3
> > > +#define ZS_INUSE_RATIO_40	4
> > > +#define ZS_INUSE_RATIO_50	5
> > > +#define ZS_INUSE_RATIO_60	6
> > > +#define ZS_INUSE_RATIO_70	7
> > > +#define ZS_INUSE_RATIO_80	8
> > > +#define ZS_INUSE_RATIO_90	9
> > > +#define ZS_INUSE_RATIO_99	10
> > 
> > Do we really need all the define macro for the range from 10 to 99?
> > Can't we do this?
> > 
> > enum class_stat_type {
> >     ZS_EMPTY,
> >     /*
> >      * There are fullness buckets between 10% - 99%.
> >      */
> >     ZS_FULL = 11
> >     NR_ZS_FULLNESS,
> >     ZS_OBJ_ALLOCATED = NR_ZS_FULLNESS,
> >     ZS_OBJ_USED,
> >     NR_ZS_STAT,
> > }
> 
> This creates undocumented secret constats, which are being heavily
> used (zspage fullness values, indeces in fullness lists arrays,
> stats array offsets, etc.) but have no trace in the code. And this
> also forces us to use magic number in the code. So should fullness
> grouping change, things like, for instance, zs_stat_get(7), will
> compile just fine yet will do something very different and we will
> have someone to spot the regression.
> 
> So yes, it's 10 lines of defines, it's not even 10 lines of code, but
>  1) it is documentation, we keep constats documented
>  2) more importantly, it protects us from regressions and bugs
> 
> From maintinability point of view, having everything excpliticly
> documented / spelled out is a win.
> 
> As of why I decided to go with defines, this is because zspage fullness
> values and class stats are two conceptually different things, they don't
> really fit in one single enum, unless enum's name is "zs_constants".
> What do you think?

Agree. We don't need to combine them, then. 
BTW, I still prefer the enum instead of 10 define.

enum fullness_group {
    ZS_EMPTY,
    ZS_INUSE_RATIO_MIN,
    ZS_INUSE_RATIO_ALMOST_FULL = 7,
    ZS_INUSE_RATIO_MAX = 10,
    ZS_FULL,
    NR_ZS_FULLNESS,
}

> 
> [..]
> > >  	 * Size of objects stored in this class. Must be multiple
> > >  	 * of ZS_ALIGN.
> > > @@ -641,8 +644,23 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
> > >  			continue;
> > >  
> > >  		spin_lock(&pool->lock);
> > > -		class_almost_full = zs_stat_get(class, ZS_ALMOST_FULL);
> > > -		class_almost_empty = zs_stat_get(class, ZS_ALMOST_EMPTY);
> > > +
> > > +		/*
> > > +		 * Replecate old behaviour for almost_full and almost_empty
> > > +		 * stats.
> > > +		 */
> > > +		class_almost_full = zs_stat_get(class, ZS_INUSE_RATIO_99);
> > > +		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_90);
> > > +		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_80);
> > > +		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_70);
> > 
> > > +
> > > +		class_almost_empty = zs_stat_get(class, ZS_INUSE_RATIO_60);
> > > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_50);
> > > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_40);
> > > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_30);
> > > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_20);
> > > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_10);
> > 
> > I guess you can use just loop here from 1 to 6
> > 
> > And then from 7 to 10 for class_almost_full.
> 
> I can change it to
> 
> 	for (r = ZS_INUSE_RATIO_10; r <= ZS_INUSE_RATIO_70; r++)
> and
> 	for (r = ZS_INUSE_RATIO_80; r <= ZS_INUSE_RATIO_99; r++)
> 
> which would be safer than using hard-coded numbers.

I didn't mean to have hard code either but just wanted to show
the intention to use the loop.

> 
> Shall we actually instead report per inuse ratio stats instead? I sort
> of don't see too many reasons to keep that below/above 3/4 thing.

Oh, yeah. Since it's debugfs, we would get excuse to break.

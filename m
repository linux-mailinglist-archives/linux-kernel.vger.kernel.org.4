Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA906A2E35
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBZEia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZEi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:38:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F458C657
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:38:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so3117549pjp.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qp/JVKTUEDkrRkz2e6HuPmWd8JQCtHI7nSlAH64P2U=;
        b=Tx1cHnfVu4O2docewlcqcozrPd8Rksf7DfjTqU+8z87kjaGnCK3/RhR2w8Ao4kzHj0
         3sMD5Rcq/WkZ5ssDbTF/WclFb4QVMJDy9FnjAFcKb0mF6Ein1qN91x7Z/ZO8ky9KUPz5
         bTFYQ8jH55sHXhSFKAQQvZVRujfQO+MeR/oFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qp/JVKTUEDkrRkz2e6HuPmWd8JQCtHI7nSlAH64P2U=;
        b=N5lJQfMAKb4TN+CCoC9OvrLNDzv6QbkaTHSP7N0e3rUJk79zVAVmosKVWgKUooiJb/
         3dvyMZWIo9v0ZIdLdGpQKgWSQU7VIQX3AzvELSHRrLCdRNYHpYpHogkSeKJTKeSAiJCN
         cLcPf8/fSfSTbP3sf0Hboc5PXSo1TLgKOS4VZvoyI7fYVAYXVNGAq3xTTFFtdl443pV7
         ww450sxNAQ2GLmn7ZCBQUMJMcI1ZWbm/YUYJOTClgAw7V0Qn027JNA3v+uxUF89CFV4P
         pcfr49yEiPqP5XlPpbjT4wPhvYaxiaK+g5g6UgRZbvSLV2jTnn8hIk77gjUfluiYEWNH
         w3gg==
X-Gm-Message-State: AO0yUKXOUiZop09XTUnjzIwtNWK+i7i7K5eucO0fPgemBN9fLzlHIUHN
        8GxiFs7fLUPP0+Z0LwEpDDitUw==
X-Google-Smtp-Source: AK7set/5ihRAeyeA3EcM7EfrNK8nILQK3d5w4fmIBzV6ILpXzEurTSdM7F4qBwcWXw/D50neO/j/qA==
X-Received: by 2002:a17:902:f690:b0:19a:80e6:2a1d with SMTP id l16-20020a170902f69000b0019a80e62a1dmr24743532plg.41.1677386306801;
        Sat, 25 Feb 2023 20:38:26 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ba8300b0019a6f32e6c1sm1988140pls.148.2023.02.25.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:38:26 -0800 (PST)
Date:   Sun, 26 Feb 2023 13:38:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y/riPlQ2UK00WirI@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/f2WvhNlwhsf2Cz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/23 15:27), Minchan Kim wrote:
> > + * Pages are distinguished by the ratio of used memory (that is the ratio
> > + * of ->inuse objects to all objects that page can store). For example,
> > + * INUSE_RATIO_30 means that the ratio of used objects is > 20% and <= 30%.
> > + *
> > + * The number of fullness groups is not random. It allows us to keep
> > + * diffeence between the least busy page in the group (minimum permitted
> > + * number of ->inuse objects) and the most busy page (maximum permitted
> > + * number of ->inuse objects) at a reasonable value.
> > + */
> > +#define ZS_INUSE_RATIO_0	0
> 
> How about keeping ZS_EMPTY and ZS_FULL since they are used
> multiple places in source code? It would have less churning.

I have to admit that I sort of like the unified naming
	"zspage inuse ratio goes from 0 to 100"

but I can keep ZS_EMPTY / ZS_FULL as two "special" inuse values.

> > +#define ZS_INUSE_RATIO_10	1
> > +#define ZS_INUSE_RATIO_20	2
> > +#define ZS_INUSE_RATIO_30	3
> > +#define ZS_INUSE_RATIO_40	4
> > +#define ZS_INUSE_RATIO_50	5
> > +#define ZS_INUSE_RATIO_60	6
> > +#define ZS_INUSE_RATIO_70	7
> > +#define ZS_INUSE_RATIO_80	8
> > +#define ZS_INUSE_RATIO_90	9
> > +#define ZS_INUSE_RATIO_99	10
> 
> Do we really need all the define macro for the range from 10 to 99?
> Can't we do this?
> 
> enum class_stat_type {
>     ZS_EMPTY,
>     /*
>      * There are fullness buckets between 10% - 99%.
>      */
>     ZS_FULL = 11
>     NR_ZS_FULLNESS,
>     ZS_OBJ_ALLOCATED = NR_ZS_FULLNESS,
>     ZS_OBJ_USED,
>     NR_ZS_STAT,
> }

This creates undocumented secret constats, which are being heavily
used (zspage fullness values, indeces in fullness lists arrays,
stats array offsets, etc.) but have no trace in the code. And this
also forces us to use magic number in the code. So should fullness
grouping change, things like, for instance, zs_stat_get(7), will
compile just fine yet will do something very different and we will
have someone to spot the regression.

So yes, it's 10 lines of defines, it's not even 10 lines of code, but
 1) it is documentation, we keep constats documented
 2) more importantly, it protects us from regressions and bugs

From maintinability point of view, having everything excpliticly
documented / spelled out is a win.

As of why I decided to go with defines, this is because zspage fullness
values and class stats are two conceptually different things, they don't
really fit in one single enum, unless enum's name is "zs_constants".
What do you think?

[..]
> >  	 * Size of objects stored in this class. Must be multiple
> >  	 * of ZS_ALIGN.
> > @@ -641,8 +644,23 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
> >  			continue;
> >  
> >  		spin_lock(&pool->lock);
> > -		class_almost_full = zs_stat_get(class, ZS_ALMOST_FULL);
> > -		class_almost_empty = zs_stat_get(class, ZS_ALMOST_EMPTY);
> > +
> > +		/*
> > +		 * Replecate old behaviour for almost_full and almost_empty
> > +		 * stats.
> > +		 */
> > +		class_almost_full = zs_stat_get(class, ZS_INUSE_RATIO_99);
> > +		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_90);
> > +		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_80);
> > +		class_almost_full += zs_stat_get(class, ZS_INUSE_RATIO_70);
> 
> > +
> > +		class_almost_empty = zs_stat_get(class, ZS_INUSE_RATIO_60);
> > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_50);
> > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_40);
> > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_30);
> > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_20);
> > +		class_almost_empty += zs_stat_get(class, ZS_INUSE_RATIO_10);
> 
> I guess you can use just loop here from 1 to 6
> 
> And then from 7 to 10 for class_almost_full.

I can change it to

	for (r = ZS_INUSE_RATIO_10; r <= ZS_INUSE_RATIO_70; r++)
and
	for (r = ZS_INUSE_RATIO_80; r <= ZS_INUSE_RATIO_99; r++)

which would be safer than using hard-coded numbers.

Shall we actually instead report per inuse ratio stats instead? I sort
of don't see too many reasons to keep that below/above 3/4 thing.

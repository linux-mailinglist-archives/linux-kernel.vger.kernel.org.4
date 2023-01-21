Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B067661E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjAULy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAULy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:54:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5D47ED2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 03:54:25 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k13so7545871plg.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 03:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yu0JPWDS2jb23DVOgU0pvAgdD67chS/bHtClPy/cVdY=;
        b=Y+ojwA3yG7jNh3yHgGAEjga11q5J9UiCKdXivgHUY6+lqZRjpJraZ/6q8MbePlEfoS
         mnjuXBpcaMHfrKWSiwte9bNte66lEiif4eMw4cHdLbdqKRI1qE1wUFYrr37L8GOOzr5u
         /jWF0At9Q0PxWOhXDGuvYHEXgHiVapxq15Ezfj0nooZ2xbODU/B2iLhbGRPZBXTrzfJU
         i94kAuf6DVkM8nEeXeVH5rtr+b3b9B10AOAt3skKUa1GqX4fYXTBBPEDI4cLTchqZBqf
         yyORNtUcWwElqfB+ZrtuO1x+8eaHvqfeOCchYdhvaNf9JqbQRrivQ8sI5OgFY1jDJcou
         7Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu0JPWDS2jb23DVOgU0pvAgdD67chS/bHtClPy/cVdY=;
        b=f14r9tGwONoTjwOmK8XyPHoVfiB6/rwElFF6FkBHtTf7a8H+Up0sBALwm6ASbYp4Ne
         ffkNrvk/bRgdUwaPYN8XMACtqR36skUk6WvOgQnWx2/LtsACz2iiD5KKZwnGrNvUUFln
         CERDlMO5BrWlPxKQzijVWtPqtIQoJLrVFVt0lylTyQ0uYWjY7SJsY0/E+Gmck6BkCnyH
         XWZji+LrVDOnC4DWf24BaGvj3T7SZ0UJQqYktToLNmIqscUefP0Z/YnJefsQ/nmweXr1
         eDx4t9MDQ9vmq73vDtko789iEvjBeu2NB5xmbRPSW2rOfDMqy+hIOuqFTWV9jmIUdAgQ
         KTwQ==
X-Gm-Message-State: AFqh2kr5YZaG1licMarVrwKZqV1GLdsGJoAG0lMyLPM/GUrVjdudxYrx
        DDX45Sx5mP+vUIzRYxCDD9A=
X-Google-Smtp-Source: AMrXdXvN26yYUni73PvR56Lw1IhZEyMtGrLsO2ZJ10XnqbeNXxQ7zNkSljk+zQXAtYd6+AnybdBtPw==
X-Received: by 2002:a17:903:2446:b0:195:e8f9:7e84 with SMTP id l6-20020a170903244600b00195e8f97e84mr6279036pls.1.1674302065245;
        Sat, 21 Jan 2023 03:54:25 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b00192fb119eb2sm17937760pln.54.2023.01.21.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:54:24 -0800 (PST)
Date:   Sat, 21 Jan 2023 20:54:15 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <Y8vSZ+gOFXWDKC8Z@hyeyoo>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:29:44PM +0100, Vlastimil Babka wrote:
> On 1/21/23 04:39, Hyeonggon Yoo wrote:
> > In workloads where this_cpu operations are frequently performed,
> > enabling DEBUG_PREEMPT may result in significant increase in
> > runtime overhead due to frequent invocation of
> > __this_cpu_preempt_check() function.
> > 
> > This can be demonstrated through benchmarks such as hackbench where this
> > configuration results in a 10% reduction in performance, primarily due to
> > the added overhead within memcg charging path.
> > 
> > Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
> > of its potential impact on performance in some workloads.
> > 
> > hackbench-process-sockets
> > 		      debug_preempt	 no_debug_preempt
> > Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
> > Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
> > Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
> > Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
> > Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
> > Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
> > Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
> > Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
> > Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Looks like it's there since the beginning of preempt and pre-git. But
> probably should be something for scheduler maintainers rather than mm/slab,
> even if the impact manifests there. You did Cc Ingo (the original author) so
> let me Cc the rest here.

Whew, I still get confused about who to Cc, thanks for adding them.
and I also didn't include the percpu memory allocator maintainers, who may
have opinion. let's add them too.

> 
> > ---
> >  lib/Kconfig.debug | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index ddbfac2adf9c..f6f845a4b9ec 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1176,13 +1176,16 @@ config DEBUG_TIMEKEEPING
> >  config DEBUG_PREEMPT
> >  	bool "Debug preemptible kernel"
> >  	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
> > -	default y
> >  	help
> >  	  If you say Y here then the kernel will use a debug variant of the
> >  	  commonly used smp_processor_id() function and will print warnings
> >  	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
> >  	  will detect preemption count underflows.
> >  
> > +	  This option has potential to introduce high runtime overhead,
> > +	  depending on workload as it triggers debugging routines for each
> > +	  this_cpu operation. It should only be used for debugging purposes.
> > +
> >  menu "Lock Debugging (spinlocks, mutexes, etc...)"
> >  
> >  config LOCK_DEBUGGING_SUPPORT
> 

-- 
Thanks,
Hyeonggon

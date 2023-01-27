Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43967E3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjA0Lq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjA0Lpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:45:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED17CC90
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:44:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so169640pjt.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcDWVx+asmpC399xeTse4sUVPqTwbNsubqnF4xxrPOE=;
        b=kuK5VpS1/ry7eWhteVsOw87/aRgYwVzhc/soWzSxKeL49GZj71EBiYtlZaWsnkA8qq
         vVaFdP/JZ5gv5fuWTsxsEaCdAZKNlh3H74/TQsVysVR0Q6mWAhv4GHt3idZPCDJgBvcw
         o7FXL2VDY3wG4UCjnZz/Z4jxPRPVBm/K7xOxkZfmWXrzZN7gcXiFyfoDpJ5GldIiIRQS
         Lpz3VKQSpS84Pir8w2joajHl5yX+ObAHKpLCUzGie0zPI/bSg4pRLcqq7HwZzAt8yuJ/
         iy+jiJbPm9SfrsQuQe/da+4Vj4mRnodbcwOoYDWJwXJjBA2rVx3R9ReNZJgHnNHKGeuf
         NX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcDWVx+asmpC399xeTse4sUVPqTwbNsubqnF4xxrPOE=;
        b=N7SLAHGyVuyoUur8FNKYBAHjPbwj1WXCmkoG7uWOygkWiT9AJbh2RRmiVm4nuYf23H
         PHrgAdTvJhdTkE9ZN5igp5q6O/ZTW4Q8XbA9cAhe74/uLc4x4rbU+60KMrajUC7AVMRx
         viFJtBjOpCEHzgfdcNBNjAf95a1uOXhiH3RcpsSkT/1+guutM5p6UNF4P6YB6AhGiDmv
         2SOFNGisdG7JeOxSOd0TvW+iwxAWzVRxRWw1K6iO/f+/DPMi/7rdH1lsoHronCORraMy
         vBiuJNCxqgjH5f30xU9Gy6+KHtfX9zG06stiTp0DsPBTGwgOqPijrFkvQZH3W4NObWc6
         pESg==
X-Gm-Message-State: AO0yUKX3tuFMKlizyznSgpDT3k7lDWI+muubWFZBaAVmis7V1ycDJosj
        WmwnDKZroqIogerhkgCHMJs=
X-Google-Smtp-Source: AK7set+Cd7aDIWxRbuiKhSfhYe5ITdcjDQU4DkJfJKvVXmVViH0xernV3uKOXVB+qTE89YoCqvdeOg==
X-Received: by 2002:a17:903:191:b0:193:2bed:3325 with SMTP id z17-20020a170903019100b001932bed3325mr5632815plg.15.1674819809510;
        Fri, 27 Jan 2023 03:43:29 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902b41000b001930b189b32sm2633640plr.189.2023.01.27.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:43:28 -0800 (PST)
Date:   Fri, 27 Jan 2023 20:43:20 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <Y9O42N9J9gAsbJ6T@hyeyoo>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
 <Y8vSZ+gOFXWDKC8Z@hyeyoo>
 <Y85MNmZDc5czMRUJ@dhcp22.suse.cz>
 <Y9FNm50H+w1B26yR@hyeyoo>
 <Y9D7iXUuLsOURfFv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9D7iXUuLsOURfFv@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:51:05AM +0100, Michal Hocko wrote:
> On Thu 26-01-23 00:41:15, Hyeonggon Yoo wrote:
> [...]
> > > Do you happen to have any perf data collected during those runs? I
> > > would be interested in the memcg side of things. Maybe we can do
> > > something better there.
> > 
> > Yes, below is performance data I've collected.
> > 
> > 6.1.8-debug-preempt-dirty
> > =========================
> >   Overhead  Command       Shared Object     Symbol
> > +    9.14%  hackbench        [kernel.vmlinux]  [k] check_preemption_disabled
> 
> Thanks! Could you just add callers that are showing in the profile for
> this call please?

-   14.56%     9.14%  hackbench        [kernel.vmlinux]  [k] check_preemption_disabled                          
   - 6.37% check_preemption_disabled                                                                            
      + 3.48% mod_objcg_state                                                                                   
      + 1.10% obj_cgroup_charge                                                                                 
        1.02% refill_obj_stock                                                                                  
     0.67% memcg_slab_post_alloc_hook                                                                           
     0.58% mod_objcg_state      

According to perf, many memcg functions call this function
and that's because __this_cpu_xxxx checks if preemption is disabled.

in include/linux/percpu-defs.h:

/*
 * Operations for contexts that are safe from preemption/interrupts.  These
 * operations verify that preemption is disabled.
 */
#define __this_cpu_read(pcp)                                            \
({                                                                      \
        __this_cpu_preempt_check("read");                               \
        raw_cpu_read(pcp);                                              \
})

#define __this_cpu_write(pcp, val)                                      \
({                                                                      \
        __this_cpu_preempt_check("write");                              \
        raw_cpu_write(pcp, val);                                        \
})

#define __this_cpu_add(pcp, val)                                        \
({                                                                      \
        __this_cpu_preempt_check("add");                                \
        raw_cpu_add(pcp, val);                                          \
})

in lib/smp_processor_id.c:

noinstr void __this_cpu_preempt_check(const char *op)
{
        check_preemption_disabled("__this_cpu_", op);
}
EXPORT_SYMBOL(__this_cpu_preempt_check);


> -- 
> Michal Hocko
> SUSE Labs

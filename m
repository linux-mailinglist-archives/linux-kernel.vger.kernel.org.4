Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D767E41F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjA0Ltg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjA0LtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:49:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742D7BBCC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:46:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v23so4700089plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnrc8gEkUSVHuwwvdrRQLi4j91HYcX9bQ8UOEavZrS4=;
        b=ANQYTRMLAXmY6HvrFxYXtV/9gV9ir4BWVlikE8Unn2l5RyfiF8h8DV/w4lOHoBc3B/
         Ia4WhlfQovB3RW0v4y8irRTKzNEQms/XVuxn64bpOkoaY+wMnh9Ng4HIkEltdazEEfIp
         vrQ7nLWWWYnq4HkrpBNQUy0KTuiQhtdwQtLyQqo1odpHyTRN3kh2ejMtRLqzuUjpNVEZ
         KzgAwqPTQC8iiEu8kIJN51M86kE8LqiZV625PMs6ByS/QFDIUuWPc2pWn6C7Kzc4IFr8
         gzXEUqpzTOBLIRJnuX4ks6bLTXRqnCJjGnVZFFsfP7bY4nuR/VRNsXA2iHune3UHilV/
         VP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnrc8gEkUSVHuwwvdrRQLi4j91HYcX9bQ8UOEavZrS4=;
        b=EPDwYpQ3yZ4z+it11GbV2zq4xqpi5ptZW69i2l3shUfN7N8DciZ1M/9aoeV2BtI9pS
         9H+TDbZBERUnnaIYTZWlBAacajoWbgsY7q1DinJZnt6p4IvjAythtnFHoFIXereRQF2o
         V1nacGHGSkzndFXpxYP4v7dOrTGaHZFg5sxV7GYBOxyyD4tvKltASIZxH90r+r8ccd5b
         o5AYpcW3cjxyo1LDlQL/1kysT7xHAuFh6L2cdq01qUleBmiO2NKec6sz5brDFUe6NuWH
         l2focJe3SfU345LdcFd+d2QAPncLqTfzf5DMYo3gu3CITgXwK967wKmJ1CY2QFO4Ze5l
         GvmA==
X-Gm-Message-State: AFqh2kq9zRCcZKK2EgT4g6980OORC/D9aaU8+6Jg5A3nfQzTC1T+d7vd
        QxMGIzfBVcHGBGoULBqiRH0=
X-Google-Smtp-Source: AMrXdXv0QRXVx18e7HvcncCVkQXcZP+GAYOT+45/eUMSBnBUJEPZQnfucAn8oSJ5FK1cKOhCTUy0sQ==
X-Received: by 2002:a17:90a:f604:b0:229:9627:80b2 with SMTP id bw4-20020a17090af60400b00229962780b2mr40398122pjb.46.1674819935801;
        Fri, 27 Jan 2023 03:45:35 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ad24700b00229b17bb1e8sm2644812pjw.34.2023.01.27.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:45:34 -0800 (PST)
Date:   Fri, 27 Jan 2023 20:45:28 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <Y9O5WAtEeVDyHwQX@hyeyoo>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <Y9HfHKXRPLrfG6g1@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9HfHKXRPLrfG6g1@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:02:04PM -0800, Roman Gushchin wrote:
> On Sat, Jan 21, 2023 at 12:39:42PM +0900, Hyeonggon Yoo wrote:
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
> Nice!
> 
> I checkout my very simple kmem performance test (1M allocations 8-bytes allocations)
> and it shows ~30% difference: 112319 us with vs 80836 us without.

Hello Roman,

Oh, it has higher impact on micro benchmark.

> 
> Probably not that big for real workloads, but still nice to have.
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you for kindly measuring impact of this patch
and giving ack!

> Thank you!
> 

--
Thanks,
Hyeonggon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7785F9744
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJJDyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJJDym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:54:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D3DE3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:54:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 70so8831849pjo.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ecXffJHGwxo/00S2RWAtsclB1H+VGDVSbXtxLQJTnkM=;
        b=grP00eNBTJ8DjTOhbCJU4nI9Hu7ZmeHHvn4Ho6Jp8pAt7SYngKXLa6RRhOktr8j8Xn
         vxGH9pGgLYGSffE+ViAii2S8YnyVqK8YAa3+HBmCWdO+nEIPI9/Rl2AwieDCVOhxBU8M
         3Tn5OSS2uTvCMZ+HJR3qhNnwVqVb4EpMt7eWfm1b75P3dVh41sFS6EM5obuAj3JRr8Ch
         N6fCFKeYq0OVN4ZyR9EPhl8S+YxFr/4ga+nIBRDcxpyP5H4SXcHIG0H6M+8qN6G6rPLJ
         wqb+W/w0S1XL6i1+4KufJeaZOdYUxNqgbxTGy0EHdnWk6scrKELpqtVwkesLnPC3FgAr
         0qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecXffJHGwxo/00S2RWAtsclB1H+VGDVSbXtxLQJTnkM=;
        b=alOLggXTiKB3rjyhcWH0j/Ncw6YJ/5e7OIexbqmSyZbkFBmwh9kFaBzDSl/2DR+xQ9
         H72JSLUfKd7/tU6ulpRPiDFaRsb/Xs8Venlt4pD0l0njLkWeeniVovFKqoQomcfAAvh/
         FgrVj3snSlWWlZ1F00QnfcRmxgtn1QZucifkQ472db2gc7Ulpz+LovwJZ6KZX1CmUCUQ
         AUFY+UpbUP3yRH/omcYUElMznPt5I7HGr2mWlWkhJkw2jMDGrpO4kBjUMzFddLM5JxGg
         8jkpxzqk7yhPIC2YEiqGC+VwQe3+LLy6337w52zCQIZmiMUXbISe2BcHxWgnVvK3QmB7
         UfFA==
X-Gm-Message-State: ACrzQf0Lf8By3YBvJ3L+5jGqQJsFQ6IeOeaoCHAcyYyD2I9nBTUt1Qtc
        26aw1dEmzWRmnpbv2YTa9dxU7w==
X-Google-Smtp-Source: AMsMyM7NXcG6OG9QTTjiIz3qDX+zykyjUO3Xcq/ZqGQbV6JogO0RWBM8/A5Uy+JD752XkzsFM6MTcg==
X-Received: by 2002:a17:90b:1e07:b0:202:bb50:1963 with SMTP id pg7-20020a17090b1e0700b00202bb501963mr29459839pjb.82.1665374078008;
        Sun, 09 Oct 2022 20:54:38 -0700 (PDT)
Received: from [2620:15c:29:203:5c2c:f18c:2a4e:44d2] ([2620:15c:29:203:5c2c:f18c:2a4e:44d2])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ee0f000000b00434760ee36asm5231395pgi.16.2022.10.09.20.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 20:54:37 -0700 (PDT)
Date:   Sun, 9 Oct 2022 20:54:36 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: slub: remove dead and buggy code from
 sysfs_slab_add()
In-Reply-To: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
Message-ID: <48a02db7-f59e-b80b-b879-3fd679623945@google.com>
References: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022, Rasmus Villemoes wrote:

> The function sysfs_slab_add() has two callers:
> 
> One is slab_sysfs_init(), which first initializes slab_kset, and only
> when that succeeds sets slab_state to FULL, and then proceeds to call
> sysfs_slab_add() for all previously created slabs.
> 
> The other is __kmem_cache_create(), but only after a
> 
> 	if (slab_state <= UP)
> 		return 0;
> 
> check.
> 
> So in other words, sysfs_slab_add() is never called without
> slab_kset (aka the return value of cache_kset()) being non-NULL.
> 
> And this is just as well, because if we ever did take this path and
> called kobject_init(&s->kobj), and then later when called again from
> slab_sysfs_init() would end up calling kobject_init_and_add(), we
> would hit
> 
> 	if (kobj->state_initialized) {
> 		/* do not error out as sometimes we can recover */
> 		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
> 		dump_stack();
> 	}
> 
> in kobject.c.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: David Rientjes <rientjes@google.com>

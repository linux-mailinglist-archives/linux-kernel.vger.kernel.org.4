Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362446E6D25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjDRTxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDRTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:53:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003C975D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:53:37 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id me15so9672677qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681847617; x=1684439617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGoi/M+H19ZEaSUrI6qk1TZawIL1Q7fYNR9L4vjQE/8=;
        b=NMIzvLIn91NVhhOzUhCambBzKYzsJw4DxxzcdXG7mVmcb7QRnWXCpKxDsMdSm2kxO7
         IPKIKd4MD28nuKXtiEhFEzjMeqa6xcknYsn0YbHqeThk0LAdpD6bjd9oPNOoTWzF7gV/
         dHjVijZiyfcebRTkftr4jWG945E+imnrz9sTlJ0jo1fczmuB1k2rPRn9tAo1c7xJ8bbU
         vLRUpnfK3/zhmadVGzHGn9Uo+4smTEP4h66mPy7K7PIHykUZSdZbVLb27MB87thnlU2W
         5JWd7q1b8lXglmVaPETuWHshhizpfmmfLDsWKB2NQ2/bhpw2OjHg+PYle73CrB8fw2Yi
         lyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847617; x=1684439617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGoi/M+H19ZEaSUrI6qk1TZawIL1Q7fYNR9L4vjQE/8=;
        b=kKYAstPsMUUp1ML1iTMwHV1xh/H/S3uwcvsnPcH9tv4XjY/Sl+g83mI5mnp3nXD0NY
         jeOId96nyTHZnW7XtRKjo13/V+NyQQJnj9qhGhRNObIiHhxAeHKf/ShmLFwy1tfO7j7C
         N5dNdHd4d/NGETXrWFQcjZLKrAIDFNqPXzbuPfS9Jd/JtQoNZed5/RmA2SvJLHEk6Nje
         zDi6tggbRv6xopgWQBh9gz2yAUlWUoodAhW3MiHZNdwEf2EsGcDmamWYVOpgWpLdfM2k
         LnTqnbNskPBDCYWpJ13qBf+Nxq7x3Y9tHf2O7LQF9I6fzl3HFC++Y7SS3lUEF8YNiIBU
         7gKQ==
X-Gm-Message-State: AAQBX9fujyO8fEf4xn/K3llGuYUyeq0phmXk4w/Ny4LZt0EE0HZ28vBW
        ZXr0wvTY2lZIsqE6MtM2WFwdbRM1B5/3ho3fJ1M=
X-Google-Smtp-Source: AKy350bIyZhpnjbglYY8ZHqsjOC1yiwx68YPPtwtxa0ItbI9Af0u2IIgv4F8nSh87GzGLv468enYBA==
X-Received: by 2002:a05:6214:c8a:b0:5ef:519:b21 with SMTP id r10-20020a0562140c8a00b005ef05190b21mr17920030qvr.26.1681847617144;
        Tue, 18 Apr 2023 12:53:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id m1-20020ad44a01000000b005ef61084fddsm2693927qvz.131.2023.04.18.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:53:36 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>, Ying <ying.huang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm, compaction: kcompactd work shouldn't count
 towards memory PSI
Message-ID: <20230418195335.GA268630@cmpxchg.org>
References: <20230418095852.RFC.1.I53bf7f0c7d48fe7af13c5dd3ad581d3bcfd9d1bd@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418095852.RFC.1.I53bf7f0c7d48fe7af13c5dd3ad581d3bcfd9d1bd@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:58:54AM -0700, Douglas Anderson wrote:
> When the main kcompactd thread is doing compaction then it's always
> proactive compaction. This is a little confusing because kcompactd has
> two phases and one of them is called the "proactive" phase.
> Specifically:
> * Phase 1 (the "non-proactive" phase): we've been told by someone else
>   that it would be a good idea to try to compact memory.
> * Phase 2 (the "proactive" phase): we analyze memory fragmentation
>   ourselves and compact if it looks fragmented.
> 
> From the context of kcompactd, the above naming makes sense. However,
> from the context of the kernel as a whole both phases are "proactive"
> because in both cases we're trying compact memory ahead of time and
> we're not actually blocking (stalling) any task who is trying to use
> memory.
> 
> Specifically, if any task is actually blocked needing memory to be
> compacted then it will be in direct reclaim. That won't block waiting
> on kcompactd task but instead call try_to_compact_pages() directly.
> The caller of that direct compaction, __alloc_pages_direct_compact(),
> already marks itself as counting towards PSI.
> 
> Sanity checking by looking at this from another perspective, we can
> look at all the people who explicitly ask kcompactd to do a reclaim by
> calling wakeup_kcompactd(). That leads us to 3 places in vmscan.c.
> Those are all requests from kswapd, which is also a "proactive"
> mechanism in the kernel (tasks aren't blocked waiting for it).

There is a reason behind annotating kswapd/kcompactd like this, it's
in the longish comment in psi.c:

 * The time in which a task can execute on a CPU is our baseline for
 * productivity. Pressure expresses the amount of time in which this
 * potential cannot be realized due to resource contention.
 *
 * This concept of productivity has two components: the workload and
 * the CPU. To measure the impact of pressure on both, we define two
 * contention states for a resource: SOME and FULL.
 *
 * In the SOME state of a given resource, one or more tasks are
 * delayed on that resource. This affects the workload's ability to
 * perform work, but the CPU may still be executing other tasks.
 *
 * In the FULL state of a given resource, all non-idle tasks are
 * delayed on that resource such that nobody is advancing and the CPU
 * goes idle. This leaves both workload and CPU unproductive.
 *
 *	SOME = nr_delayed_tasks != 0
 *	FULL = nr_delayed_tasks != 0 && nr_productive_tasks == 0
 *
 * What it means for a task to be productive is defined differently
 * for each resource. For IO, productive means a running task. For
 * memory, productive means a running task that isn't a reclaimer. For
 * CPU, productive means an oncpu task.

So when you have a CPU that's running reclaim/compaction work, that
CPU isn't available to execute the workload.

Say you only have one CPU shared between an allocating thread and
kswapd. Even if the allocating thread never has to do reclaim on its
own, if it has to wait for the CPU behind kswapd 50% of the time, that
workload is positively under memory pressure.

I don't think the distinction between proactive and reactive is all
that meaningful. It's generally assumed that all the work done by
these background threads is work that later doesn't have to be done by
an allocating thread. It might matter from a latency perspective, but
otherwise the work is fungible as it relates to memory pressure.

HTH

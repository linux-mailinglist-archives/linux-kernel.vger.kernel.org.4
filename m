Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2E60BFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiJYAmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJYAmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:42:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D927CEE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:14:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lw1-20020a17090b180100b0021316472a8fso2419974pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUr9nCpZGwPmjaMYLimECUICch35FeuRhnm3VL93618=;
        b=lGxLBaCkjGJQ5m7n6pn99E7OtikpIKcRVqc+S3npSzqN/BVCnNlv0B/ccVxzryt5rY
         Swq/kKFdgOZcInH3Gva6ymQSMwzkDmO6Js6CE+071v6qrE0s6U0xMVup7ALCOEuaGeAx
         XNDmqWyzepz0QuZ5WUA+iPBFB1uK+IklgHtLOkthABx2gvTqwPQA+wDDyiaKkkmteRhq
         lnUxoJYxt3RJEX5lL49GQejqBgo5NzsftGHnc28NWhLW9VZpWYOQ7lVjVOb0lhhk3KLk
         SR9YVlH31zbLMwxACzt1zzcmaRTcUsY7+sqUXgIgXgod2N9L0kpG1gE/BFybABUxYiGk
         TLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUr9nCpZGwPmjaMYLimECUICch35FeuRhnm3VL93618=;
        b=o7uBGPYxRZQhSmu7Ww/iRqJQE/GMk+DK0xxt2BDUBYzXPZ4h+HnuEDpiRsM1ayvUWH
         qeYHhSD2iebqC38HL2oTS+FhzujoTlAEaoer4gyZVt3aNJGgkNC5grDh6FBx29OQQDqM
         78rhOTCiSA2yqDYT5o47BgKjB69QI8cxpZzIgFNu/NcA9pvNP9NYlru7wdP90JFBvQ96
         k56HHqdUyJ/egQQaHwMRGrQGeM81FIqCX4W04XdXE/4UMrmnwBzdDNEgiryojb0NUc8S
         OeTCqcD393TeddHtbBsm5Zjkz66LWD3Msuq0gvl0xC8ITGg62A5Crx2BC4OYUTTsIQYm
         dQSQ==
X-Gm-Message-State: ACrzQf3Ibc5lT0l6JEvWjPRzv0hiqq3/uX2EuUu8EGVuJg6bnOPRR5+e
        CR6qfDC2HvIp+9dgoGOjsUQAPqqW0Gd8iA==
X-Google-Smtp-Source: AMsMyM4A+0ArO1kTkLwRNYEITVTq3K7I/kdihJ6u1j0iy9n0LOAi68ufPrrVmhXaIZTyj+hBejplMVWycOMgxg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:1406:b0:565:dc13:bb36 with SMTP
 id l6-20020a056a00140600b00565dc13bb36mr36276391pfu.46.1666653251624; Mon, 24
 Oct 2022 16:14:11 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:14:08 +0000
In-Reply-To: <20221024153022.1b81a182eac44797b40bfda1@linux-foundation.org>
Mime-Version: 1.0
References: <20221024052841.3291983-1-shakeelb@google.com> <20221024153022.1b81a182eac44797b40bfda1@linux-foundation.org>
Message-ID: <20221024231408.j3moql6q5qhct3jx@google.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:30:22PM -0700, Andrew Morton wrote:
> On Mon, 24 Oct 2022 05:28:41 +0000 Shakeel Butt <shakeelb@google.com> wrote:
> 
> > Currently mm_struct maintains rss_stats which are updated on page fault
> > and the unmapping codepaths. For page fault codepath the updates are
> > cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> > The reason for caching is performance for multithreaded applications
> > otherwise the rss_stats updates may become hotspot for such
> > applications.
> > 
> > However this optimization comes with the cost of error margin in the rss
> > stats. The rss_stats for applications with large number of threads can
> > be very skewed. At worst the error margin is (nr_threads * 64) and we
> > have a lot of applications with 100s of threads, so the error margin can
> > be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
> > 
> > Recently we started seeing the unbounded errors for rss_stats for
> > specific applications which use TCP rx0cp. It seems like
> > vm_insert_pages() codepath does not sync rss_stats at all.
> > 
> > This patch converts the rss_stats into percpu_counter to convert the
> > error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
> 
> Confused.  The max error should be O(nr_cpus)?
> 

So, percpu_counter code sets the percpu batch in the following way:

static int compute_batch_value(unsigned int cpu)
{
        int nr = num_online_cpus();

        percpu_counter_batch = max(32, nr*2);
        return 0;
}

This means each cpu can cache (nr_cpus*2) updates. Practically the
number of cpus do not change and are usually much less than the number
of threads of large applications, so error margin is lower.

> > However this conversion enable us to get the accurate stats for
> > situations where accuracy is more important than the cpu cost. Though
> > this patch does not make such tradeoffs.
> 
> Curiousity.  Can you expand on the final sentence here?
> 

Basically we can just use percpu_counter_add_local() for the updates and
percpu_counter_sum() (or percpu_counter_sync() + percpu_counter_read)
for the readers. At the moment the readers are either procfs interface,
oom_killer and memory reclaim which I think are not performance critical
and should be ok with slow read. However I think we can make that change
in a separate patch.

thanks,
Shakeel

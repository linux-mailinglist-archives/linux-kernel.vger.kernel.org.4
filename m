Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624060BF45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiJYAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJYAMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:12:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A53C2EFC2D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C1F7B810F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED06C433D6;
        Mon, 24 Oct 2022 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666650623;
        bh=aV1nMMCJPYiagkx/HzsJlx2QvJo6+skgGZVrzZnzTTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMzwrzeCPRV0ferTAxZsb1FzCakhmfIaNbvO7G8l65d+WsTuJqoNOaSfECukoVrBG
         h9C90EsD8GOcXkzh2ddKTDZCdtP0e4U5rlxfkjytJXXCX6FkXiBafdtDzmrWmIC3hr
         O9BszOnmVnc8qByLGbkTz0Sm+YJwZEOvsRSEdFJg=
Date:   Mon, 24 Oct 2022 15:30:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Message-Id: <20221024153022.1b81a182eac44797b40bfda1@linux-foundation.org>
In-Reply-To: <20221024052841.3291983-1-shakeelb@google.com>
References: <20221024052841.3291983-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 05:28:41 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> Currently mm_struct maintains rss_stats which are updated on page fault
> and the unmapping codepaths. For page fault codepath the updates are
> cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> The reason for caching is performance for multithreaded applications
> otherwise the rss_stats updates may become hotspot for such
> applications.
> 
> However this optimization comes with the cost of error margin in the rss
> stats. The rss_stats for applications with large number of threads can
> be very skewed. At worst the error margin is (nr_threads * 64) and we
> have a lot of applications with 100s of threads, so the error margin can
> be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
> 
> Recently we started seeing the unbounded errors for rss_stats for
> specific applications which use TCP rx0cp. It seems like
> vm_insert_pages() codepath does not sync rss_stats at all.
> 
> This patch converts the rss_stats into percpu_counter to convert the
> error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).

Confused.  The max error should be O(nr_cpus)?

> However this conversion enable us to get the accurate stats for
> situations where accuracy is more important than the cpu cost. Though
> this patch does not make such tradeoffs.

Curiousity.  Can you expand on the final sentence here?

>  8 files changed, 40 insertions(+), 107 deletions(-)

There's that, too.

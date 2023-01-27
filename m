Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD467E27D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjA0LAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjA0LAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:00:31 -0500
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA223C7F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:00:26 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 1735A1C38
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:00:25 +0000 (GMT)
Received: (qmail 15093 invoked from network); 27 Jan 2023 11:00:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jan 2023 11:00:24 -0000
Date:   Fri, 27 Jan 2023 11:00:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] locking/rwbase: Mitigate indefinite writer starvation
Message-ID: <20230127110022.w3ztzcho45tpo6za@techsingularity.net>
References: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 02:08:47PM +0000, Mel Gorman wrote:
> rw_semaphore and rwlock are explicitly unfair to writers in the presense
> of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
> ("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
> 
>         The implementation is writer unfair, as it is not feasible to do
>         priority inheritance on multiple readers, but experience has shown
>         that real-time workloads are not the typical workloads which are
>         sensitive to writer starvation.
> 
> While atypical, it's also trivial to block writers with PREEMPT_RT
> indefinitely without ever making forward progress. Since LTP-20220121,
> the dio_truncate test case went from having 1 reader to having 16 readers
> and the number of readers is sufficient to prevent the down_write ever
> succeeding while readers exist. Eventually the test is killed after 30
> minutes as a failure.
> 
> dio_truncate is not a realtime application but indefinite writer starvation
> is undesirable. The test case has one writer appending and truncating files
> A and B while multiple readers read file A. The readers and writer are
> contending for one file's inode lock which never succeeds as the readers
> keep reading until the writer is done which never happens.
> 
> This patch records a timestamp when the first writer is blocked. DL /
> RT tasks can continue to take the lock for read as long as readers exist
> indefinitely. Other readers can acquire the read lock unless a writer
> has been blocked for a minimum of 4ms. This is sufficient to allow the
> dio_truncate test case to complete within the 30 minutes timeout.
> 
> [bigeasy@linutronix.de: Fix overflow, close race against reader, match rwsem
> 			timeouts, better rt_task handling, simplification]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Yay/nay?

-- 
Mel Gorman
SUSE Labs

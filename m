Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB06C4689
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCVJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCVJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:35:11 -0400
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 02:35:08 PDT
Received: from outbound-smtp17.blacknight.com (outbound-smtp17.blacknight.com [46.22.139.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E8F5B5EB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:35:06 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id D65281C3A54
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:28:56 +0000 (GMT)
Received: (qmail 16978 invoked from network); 22 Mar 2023 09:28:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Mar 2023 09:28:56 -0000
Date:   Wed, 22 Mar 2023 09:28:48 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] locking/rwbase: Mitigate indefinite writer starvation.
Message-ID: <20230322092848.hjlehutudsoz2hlz@techsingularity.net>
References: <20230321161140.HMcQEhHb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230321161140.HMcQEhHb@linutronix.de>
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:11:40PM +0100, Sebastian Andrzej Siewior wrote:
> The rw_semaphore and rwlock_t locks are unfair to writers. Readers can
> indefinitely acquire the lock unless the writer fully acquired the lock.
> This can never happen if there is always a reader in the critical
> section owning the lock.
> 
> Mel Gorman reported that since LTP-20220121 the dio_truncate test case
> went from having 1 reader to having 16 reader and the number of readers
> is sufficient to prevent the down_write ever succeeding while readers
> exist. Eventually the test is killed after 30 minutes as a failure.
> 
> Mel proposed a timeout to limit how long a writer can be blocked until
> the reader is forced into the slowpath.
> Thomas argued that there is no added value by providing this timeout.
> From PREEMPT_RT point of view, there are no critical rw_semaphore or
> rwlock_t locks left where the reader must be prefer.
> 

s/prefer/preferred/

> Mitigate indefinite writer starvation by forcing the READER into the
> slowpath once the WRITER attempts to acquire the lock.
> 
> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Link: https://lore.kernel.org/877cwbq4cq.ffs@tglx
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks Sebastian and Thomas!

-- 
Mel Gorman
SUSE Labs

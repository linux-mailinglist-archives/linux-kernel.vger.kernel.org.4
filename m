Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1136C31FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCUMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCUMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EDC1C330
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E45CB8166B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976AEC433D2;
        Tue, 21 Mar 2023 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679402679;
        bh=B/vtHxAcTCxhhHRIP5YYt3LKQydEzXg1MnDjnoHNkfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJ7aLyo4hGUHYrR1vArMUTwpO1Cc6v0B9Vg5CHGvjZbjOwaglbWs4YZqlYGlOnpEh
         C226uGeJ4dgVARE5+5UpTXLMf7LRQdhh9scEsDOkufPArElmirwkGUoHgX/TlapRmx
         0riftKnWNwYXpYGiiJXhcktDk9enjNuyQcd3KbjSsUseMbmK3jLw5fpF2yAmERNEbB
         zD5KMKn0NTJZZT3C1rQ0p4EeS4YK+Y1n6v1vwGnBNeblgn83rZNijqPrIAoZvteCmG
         lx1oNtoRJmCkfYmAyr/aVq1KrXfa7wcZjDszdYNRVsdKPv2s638VlOhBsQYZmAWXD5
         yRWJ/rOlM++rw==
Date:   Tue, 21 Mar 2023 13:44:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 8/8] selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME)
 VS /proc/uptime monotonicity
Message-ID: <ZBmmtMlKXcf2+hnq@lothringen>
References: <20230222144649.624380-1-frederic@kernel.org>
 <20230222144649.624380-9-frederic@kernel.org>
 <219c5d09-0099-83e9-b21b-299fa513decd@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219c5d09-0099-83e9-b21b-299fa513decd@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:59:41PM +0100, Mirsad Todorovac wrote:
> On 2/22/23 15:46, Frederic Weisbecker wrote:
> From what I see, you round the CLOCK_BOOTIME time to 1/100ths of a second.
> 
> A simple program that queries clock_getres() on system clocks gives this
> result:
> 
> clock_res [CLOCK_REALTIME] = 0.000000001s
> clock_res [CLOCK_REALTIME_COARSE] = 0.004000000s
> clock_res [CLOCK_MONOTONIC] = 0.000000001s
> clock_res [CLOCK_MONOTONIC_COARSE] = 0.004000000s
> clock_res [CLOCK_MONOTONIC_RAW] = 0.000000001s
> clock_res [CLOCK_BOOTTIME] = 0.000000001s
> clock_res [CLOCK_PROCESS_CPUTIME_ID] = 0.000000001s
> clock_res [CLOCK_THREAD_CPUTIME_ID] = 0.000000001s
> 
> A number of programs may depend i.e. on CLOCK_REALTIME or CLOCK_BOOTIME to give
> different result each nanosecond.
> 
> I came across this when generating nonces for HMACs according to recommendations
> from RFC 4086 "Randomness Requirements for Security".
> 
> If the value of CLOCK_BOOTTIME or CLOCK_REALTIME is incremented not in what
> clock_getres() gives, but at best in 1/100th of second instead, that would seriously
> weaken our security (for as you know, in many cryptographic uses nonces need not
> be random, but MUST NOT ever repeat nor go backwards).
> 
> Could we modify the test for this assumption, or is the assumption wrong?
> 
> Here the test for CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID
> increasing monotonically with guaranteed increased value of nanoseconds
> would also seem good.
> 
> Maybe this is already covered in another test case, but it seems that all
> clocks should be guaranteed to be monotonically increasing, and increased
> at least by one nanosecond with each syscall, or many algorithms would break.
> 
> In other words, CLOCK_BOOTTIME should be tested to increase monotonically in
> the resolution given by clock_getres (CLOCK_BOOTTIME, &tv_res), not in 1/100ths
> of second (IMHO).

Maybe but verifying a clock against its own resolution is another testcase. Here the
point is to verify that CLOCK_BOOTTIME is monotonic against /proc/uptime, and
since /proc/uptime has an 1/100 second resolution, rounding clock_gettime(CLOCK_BOOTTIME)
result down to that is the best we can do.

Thanks.


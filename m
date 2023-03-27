Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C956C9F05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC0JKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjC0JKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75B10CE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QJ/+S72sneQ1arByLzds1SxtxaeNSoR/H2lA4VdoWd4=; b=W7lU0SU8Hz3A3puErWzvo/6kE/
        x27IoR58v3fDIhf3ItOASUCwZvt3xYobeAadGpnWuyknotoK7X8WgT+BmvYh9fx0jm7NyELof9HVf
        p0MoW7YFtdd126imBuDXAOUz2mRVkoGFsTtsohNEaQI4dTV1qC4RB6vaSo36wW+owFdi0wsPQb8lo
        tvF081afuhDTlE8vmtiQfwD7rZmZG7MxBrbJY22x1tiB5tyGxLFFtlHB9xGMFT1M2xC+NJ5UrDjeu
        Y8T4KnJbR6YLgPPzpg0sLbdUYWK/7rStUI4Y6p4G1ghihBc6PpxphJcMCoR0KcOonjak0G0ahsmYd
        Am2S+/Sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgirR-007GLa-EM; Mon, 27 Mar 2023 09:09:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F08663001E5;
        Mon, 27 Mar 2023 11:09:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B002E20F4A288; Mon, 27 Mar 2023 11:09:51 +0200 (CEST)
Date:   Mon, 27 Mar 2023 11:09:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230327090951.GA4253@hirez.programming.kicks-ass.net>
References: <20230327080502.GA570847@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327080502.GA570847@ziqianlu-desk2>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:05:02PM +0800, Aaron Lu wrote:
> Hi Mathieu,
> 
> I was doing some optimization work[1] for kernel scheduler using a
> database workload: sysbench+postgres and before I submit my work, I
> rebased my patch on top of latest v6.3-rc kernels to see if everything
> still works expected and then I found rq's lock became very heavily
> contended as compared to v6.2 based kernels.
> 
> Using the above mentioned workload, before commit af7f588d8f73("sched:
> Introduce per-memory-map concurrency ID"), the profile looked like:
> 
>      7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
>      0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> 
> After that commit:
> 
>     49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
>     43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath

Unlike what the subject says, if it is due to that commit, then it's not
rq lock but that new cid_lock thing.

Can you frob init/Kconfig and make SCHED_MM_CID user configurable and
disable it to confirm?

(also, mathieu, when you do the below, you'll see it is in a weird spot)

diff --git a/init/Kconfig b/init/Kconfig
index 1fb5f313d18f..f2661f73f3dd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1042,7 +1042,8 @@ config RT_GROUP_SCHED
 endif #CGROUP_SCHED
 
 config SCHED_MM_CID
-	def_bool y
+	bool "RSEQ Concurrency ID"
+	default y
 	depends on SMP && RSEQ
 
 config UCLAMP_TASK_GROUP

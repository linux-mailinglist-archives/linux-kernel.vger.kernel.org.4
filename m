Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F15F7831
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJGMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:47:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BBF4733
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kbH8S6o3WcxqjCtSlhxZV5A3sAtC7ojP2nZZ3yNLuMY=; b=Iqs5Iw3VmOdthbpnYeUqASXE8M
        9Zd3cqgcqyBRF8cj8cWMgzCkKwakDFLu6hOrh5/sJzaKRIWlrAPVlc+VuoyRRX6UwU9sxjlvb4T3V
        vAweGWlq/JUWl4Kg85Da7Hkict2rafAel5qDOpVml8mIFhijXhZ77pCeGjo8zg3x7r0YWGIvgaJV+
        PaZpKsw7HZue5yDlBxWnaBC8x2rIm6BJU5vpk8HIoOzUOzhLrhHy7wv5De23oMxAnQHMPRpCpQ+B0
        XDWzAZveOmpzRDLwrKX/QNhcjl7nm7e6CCeRcrZTjpQY/G9xr90hInwj86znJeoVG20Qbsgrwb22q
        7TMNO8ag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogml8-001Sxj-8Q; Fri, 07 Oct 2022 12:47:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0918630017D;
        Fri,  7 Oct 2022 14:47:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8C342BD94364; Fri,  7 Oct 2022 14:47:19 +0200 (CEST)
Date:   Fri, 7 Oct 2022 14:47:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v10 4/5] sched: Handle set_cpus_allowed_ptr(),
 sched_setaffinity() & other races
Message-ID: <Y0Af1zT1QQrMo8hf@hirez.programming.kicks-ass.net>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922180041.1768141-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:00:40PM -0400, Waiman Long wrote:
> Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
> or between multiple sched_setaffinity() calls from different
> CPUs. To resolve these race conditions, we need to update both
> user_cpus_ptr and cpus_mask in a single lock critical section instead
> of separated ones. This requires moving the user_cpus_ptr update
> to set_cpus_allowed_common() by putting the user_mask into a new
> affinity_context structure and using it to pass information around
> various functions.
> 
> This patch also changes the handling of the race between the
> sched_setaffinity() call and the changing of cpumask of the current
> cpuset. In case the new mask conflicts with newly updated cpuset,
> the cpus_mask will be reset to the cpuset cpumask and an error value
> of -EINVAL will be returned. If a previous user_cpus_ptr value exists,
> it will be swapped back in and the new_mask will be further restricted
> to what is allowed in the cpumask pointed to by the old user_cpus_ptr.
> 
> The potential race between sched_setaffinity() and a fork/clone()
> syscall calling dup_user_cpus_ptr() is also being handled.

This is still arse-backwards... You're still fixing races you've
introduced earlier in the series.

Since I don't think telling you again is going to help; I've done it for
you :/ How's this then?

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/affinity



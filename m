Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC276C0C37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCTI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCTI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:28:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045261E2B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dIdNXCU/aLvOzApGXESpuuj1FgGqE5K1Fy2RDuWW/Es=; b=DKS+7xQzmGL8hSmwD1DubPLAUG
        li/99I6dodun161Y4nACc2rT0Q0Jb8lTId7VZlT4ZUcA/9/PJjhMPwfMBFNSclUKWKqTzok6Bn0/0
        ZK3N7K+JgDhMpl9JmKRyQF8Xta+KgN3SzIVoJLzJh7/zQWPf3pYmNCuhKv0aR+GF4nmNPxmaaAFrF
        w+sD/NAoQ/cp+eseGETHE/FC5dvsNGkbuUi0lN06DOgBmskLoKjRKqZwbxt/5wOmi5s59CM8iwltz
        YdEAPVLPcFpYTLV5S41AOLcxsPSLR6Pb6hwGIay+SDJYxzmQmfmrCge4n0EyxyNNTSMBYSEu+fhEU
        YHoE1+1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peAsG-003rfQ-2Y;
        Mon, 20 Mar 2023 08:28:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A115B300392;
        Mon, 20 Mar 2023 09:28:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FA4A2024966D; Mon, 20 Mar 2023 09:28:11 +0100 (CET)
Date:   Mon, 20 Mar 2023 09:28:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Reduce cost of sched_move_task when config
 autogroup
Message-ID: <20230320082811.GD2194297@hirez.programming.kicks-ass.net>
References: <20230319075643.28312-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319075643.28312-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 03:56:43PM +0800, wuchi wrote:
> Some sched_move_task calls of autogroup is useless when the
> task_struct->sched_task_group isn't changed because of task_group
> of cpu_cgroup overlay task_group of autogroup. The overlay key codes
> are as follows:
> 
> sched_cgroup_fork->autogroup_task_group->task_wants_autogroup
> sched_change_group->autogroup_task_group->autogroup_task_group
> 
> sched_move_task eg:
> task A belongs to cpu_cgroup0 and autogroup0, it will always to
> cpu_cgroup0 when doing exit. So there is no need to do {de|en}queue.
> The call graph is as follow.
> 
> do_exit
>   sched_autogroup_exit_task
>     sched_move_task
>       dequeue_task
>         sched_change_group
> 	  A.sched_task_group = sched_get_task_group
>       enqueue_task
> 
> So do some check before dequeue task in sched_move_task.

No immediate objection; but the $subject seems to suggest you did this
for performance reasons, yet there are no performance results in this
Changelog. How much does this save under what load?

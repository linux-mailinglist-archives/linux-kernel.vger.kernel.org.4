Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC77423C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF2KPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjF2KOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8230E5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1274F61505
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5A8C433C8;
        Thu, 29 Jun 2023 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688033398;
        bh=6JXx4Gu6gULpzK0aGRrmMgZMZhQoVcrgwox0JdbALSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO0Vau+QZQq+xbO2IedJ4O5yDAP+PX/bEabGY+lG1ivQVP9527b7uxW01GVBsvuqH
         mwe80WFLHySytfDieAQ+PHXACiGk/ZWOmcmktnxuYWq4I+lhmM4RkhQA6OG0r0A+we
         Fje/c2F7nZ9NehG1QPykWYq7PHJ7k+JLsS/gnFkaBYtGlPDnLJ4ksK83NHsPr0L9Im
         qqc+e+u4xdi93bdvOZjm6GbJhigWf/f1Rj4VZLQJcpONKtvWTiXZ2qR5e8dqkWxMl2
         gNMQWmZ7lTNDZIcPuFXS7yCugyd0IXI60ixQDPl4ZnCzXkB413RXiKD4FuD2qJb4qn
         LQCR2oSsZJrgw==
Date:   Thu, 29 Jun 2023 12:09:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: introduce sched_core_idle_cpu()
Message-ID: <ZJ1YcgcuYCzwz6jI@lothringen>
References: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:02:04PM +0800, Cruz Zhao wrote:
> As core scheduling introduced, a new state of idle is defined as
> force idle, running idle task but nr_running greater than zero.
> 
> If a cpu is in force idle state, idle_cpu() will return zero. This
> result makes sense in some scenarios, e.g., load balance,
> showacpu when dumping, and judge the RCU boost kthread is starving.
> 
> But this will cause error in other scenarios, e.g., tick_irq_exit():
> When force idle, rq->curr == rq->idle but rq->nr_running > 0, results
> that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
> is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
> not become 1, which became 0 in tick_nohz_irq_enter().
> ts->idle_sleeptime won't update in function update_ts_time_stats(), if
> ts->idle_active is 0, which should be 1. And this bug will result that
> ts->idle_sleeptime is less than the actual value, and finally will
> result that the idle time in /proc/stat is less than the actual value.
> 
> To solve this problem, we introduce sched_core_idle_cpu(), which
> returns 1 when force idle. We audit all users of idle_cpu(), and
> change idle_cpu() into sched_core_idle_cpu() in function
> tick_irq_exit().
> 
> v2-->v3: Only replace idle_cpu() with sched_core_idle_cpu() in
> function tick_irq_exit(). And modify the corresponding commit log.
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Reviewed-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

Please wait for people to actually provide you with their Reviewed-by: tags
before writing it.

Aside of that, the patch looks good so you can put this one:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371BF743D25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjF3OEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3OEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CD297C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E56B26175C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A90C433C8;
        Fri, 30 Jun 2023 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688133847;
        bh=TkFu3sGrXfp5wm0KQfWT38jxWszTj/j/h5WBSthzLuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9K2Aa2q7YItf70FCn4bmFr5Uswkz1p1rhN5E8fbncZJwAx5oEJrXGH5rh/JwUeZV
         BwZ2HmMiGk9jSMBOWhRo8yWAtFL/cq/tofXRPlb0vHoSr1LlIBCaAEoO9+ac0PBXC9
         IpjZruapZoYPJxO7FuohEX7BfC07UKgcnR3YY5uf9PqmIhTx2gp82E6ndm4KHS1uMq
         j5ujgaE6gReWnpzwdK4Gf9IyX7bfJb2QvecPqwBCGBGiBoNKt4bo8uhC5dC2IIvyAa
         J6dCEwCODZmFPamkvjGcNJmWSdqrKg1n9L59T0b2/YjR/FjBScLzx49YSr1lzrGMBm
         pnNO9wP+zHz9Q==
Date:   Fri, 30 Jun 2023 16:04:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 14/45] posix-timers: Consolidate interval retrieval
Message-ID: <ZJ7g1NvmxnKqCLC9@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.816970056@linutronix.de>
 <ZJww66Svi84Bvw9Z@localhost.localdomain>
 <87ttuq14xp.ffs@tglx>
 <ZJ67nQ6Q8F3mu6Jb@lothringen>
 <875y75yu7u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875y75yu7u.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 03:07:17PM +0200, Thomas Gleixner wrote:
> On Fri, Jun 30 2023 at 13:25, Frederic Weisbecker wrote:
> > On Thu, Jun 29, 2023 at 08:47:30PM +0200, Thomas Gleixner wrote:
> >> On Wed, Jun 28 2023 at 15:08, Frederic Weisbecker wrote:
> >> 
> >> > Le Tue, Jun 06, 2023 at 04:37:40PM +0200, Thomas Gleixner a écrit :
> >> >> There is no point to collect the current interval in the posix clock
> >> >> specific settime() and gettime() callbacks. Just do it right in the common
> >> >> code.
> >> >> 
> >> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >> >
> >> > The only difference I see is that we now return the old interval
> >> > even if the target is reaped, which probably doesn't matter anyway.
> >> 
> >> But we don't return it to user space because ret != 0 in that case.
> >
> > In the case of ->set yes but in the case of ->get there is no error
> > handling.
> 
> SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
> 		struct __kernel_itimerspec __user *, setting)
> {
> 	struct itimerspec64 cur_setting;
> 
> 	int ret = do_timer_gettime(timer_id, &cur_setting);
> 	if (!ret) {
> 		if (put_itimerspec64(&cur_setting, setting))
> 
> How exactly does this end up being copied to user space if ret != 0?

kc->timer_get() doesn't return any value.

So before the patch, interval is retrieved only if the target is not reaped:

timer_gettime() {
    do_timer_gettime() {
        posix_cpu_timer_get() {
            p = cpu_timer_task_rcu(timer);
            if (p)
                itp->interval = ....
        }
    }
}

After the patch it's retrieved unconditionally:

timer_gettime() {
    do_timer_gettime() {
        //unconditionally set
        itp->interval = ....
        posix_cpu_timer_get() {
            p = cpu_timer_task_rcu(timer);
            if (!p)
                //doesn't return any value so no failure reported
        }
    }
}

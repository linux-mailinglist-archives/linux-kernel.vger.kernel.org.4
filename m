Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693945FFAC2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJOPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJOPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E527156
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oq2KYIbNYR7Y53auqwuF1eehcG0wTStRSZCTq53nCf4=; b=wIN7AP4jTTDWAmAtKuTey8i5r8
        POcT/pw2MLRsOSgQ6oYlHCt/n9ToSAdq/vWbpHc1rk47bos7RslGgCwMHlw80cq8neGO/xFXtWvso
        A9D8JEHscfAe49Tc3UFgLcEw3uuw7xuxt54iIXUm3Cb3ZoxH2TYucPrHmoVByIpEDGf3rDqf17TMA
        9tv0RXMoH8XxEwmFIYzEAnzrku+2P5iHyYcZi4AACuLo8scn3hVMswDaoCPlV+g6sdLv3OzR1x44k
        rGh5n6uhhEMStbNWHxLps+4BgToPYXqyPtCu5WPkZGgycCe0r8nUQPohvpit9vY8NCg9ioWV0w77n
        n90i3dig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojind-008S7W-Pg; Sat, 15 Oct 2022 15:10:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF39130004F;
        Sat, 15 Oct 2022 17:10:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 990D8201FD678; Sat, 15 Oct 2022 17:10:00 +0200 (CEST)
Date:   Sat, 15 Oct 2022 17:10:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0rNSMg+KmVnZ1oe@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-8-connoro@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:44:57PM +0000, Connor O'Brien wrote:
> @@ -703,15 +707,28 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  			break;
>  
>  		if (first) {
> +			bool acquired;
> +
> +			/*
> +			 * XXX connoro: mutex_optimistic_spin() can schedule, so

I'm thinking it might be better to remove that schedule point for
PROXY_EXEC instead of doing this.

Getting preempted right after acquiring a lock is less of a problem with
PE on than it is without it.

> +			 * we need to release these locks before calling it.
> +			 * This needs refactoring though b/c currently we take
> +			 * the locks earlier than necessary when proxy exec is
> +			 * disabled and release them unnecessarily when it's
> +			 * enabled. At a minimum, need to verify that releasing
> +			 * blocked_lock here doesn't create any races.
> +			 */
> +			raw_spin_unlock(&current->blocked_lock);
> +			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
> -			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> +			acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
> +			raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +			raw_spin_lock(&current->blocked_lock);
> +			if (acquired)
>  				break;
>  			trace_contention_begin(lock, LCB_F_MUTEX);
>  		}

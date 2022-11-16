Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0362BA00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiKPKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiKPKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:49:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A96FCE4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J2clWe1CPxV+vvTwVNi4paLinQa+9xorbUTFEpQr4Lw=; b=eypQ7wuroFLD3v6Rzkpc5K5mMR
        mfFN5fTJDEQ5wnZ2E6SAY/vZ++iTiRaM6HWxXRV3oam/PcUHYu0zJrpk70EoFoH7IkFr/YAQIOQaf
        W8BYPDgT4rYxrNu6MisK0WO4eIt9c3gI9z9b7UqE3qJYVkE5mtdSRBjb2dgGeFTHN+TuE/BShAkeu
        rkaZxNey1kyJ38jZybiAmTCvFN34NhwJJhba76CI2noH7kTntJIvoYu0D4dW1YGKWHzivMB0SwNTR
        WGdawHe82uKqVKEFnsjCfo49a8SixLddt05VuBQme/QhcBHeko4SjOLWgVr6E+Sw+ZK4jnJogZB3F
        ZW/tLr1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovFn3-001H0b-Sh; Wed, 16 Nov 2022 10:37:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CD9030062A;
        Wed, 16 Nov 2022 11:37:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7ED732B655978; Wed, 16 Nov 2022 11:37:08 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:37:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH v5 3/3] softirq: defer softirq processing to ksoftirqd if
 CPU is busy with RT
Message-ID: <Y3S9VH+ThqbUDV4Y@hirez.programming.kicks-ass.net>
References: <20221116075929.453876-1-jstultz@google.com>
 <20221116075929.453876-4-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116075929.453876-4-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 07:59:28AM +0000, John Stultz wrote:
> From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> 
> Defer the softirq processing to ksoftirqd if a RT task is
> running or queued on the current CPU. This complements the RT
> task placement algorithm which tries to find a CPU that is not
> currently busy with softirqs.
> 
> Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
> deferred as they can potentially run for long time.
> 
> Additionally, this patch stubs out ksoftirqd_running() logic,
> in the CONFIG_RT_SOFTIRQ_AWARE_SCHED case, as deferring
> potentially long-running softirqs will cause the logic to not
> process shorter-running softirqs immediately. By stubbing it out
> the potentially long running softirqs are deferred, but the
> shorter running ones can still run immediately.

So I'm hating on the new config space, and dubious of the placement
logic (I'm thinking much the same gain can be had when actual softirq
processing stops quickly when we want to reschedule).

However I still have these here patches (revived from the dead):

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=core/softirq

That fix some of this same... I think the last time this fell on its
face due to regressions and me not having time/energy to chase them down
and the author of the hack-of-the-day solution walking off or something
like that.

I think this aspect of the whole softirq thing really needs fixing first
and not hidden under some obscure CONFIG symbol.



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48940734E95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjFSIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFSIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:51:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE04114
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0PCSD36qNRec2QogWftQZPEKlnMfGKrOOih0U0Ntkpk=; b=qfZq7UAcLnCMBoVroEKV5tcRgW
        D3/g9Ea3leV8VIWMbcp0nyparOJzHPaOmfrc48i/1redfzLGkLZa7usaASHCTK0bmHPz4vd1sfeVs
        IM8rMN8LtqNuG0PCkxxjVeXL0w1zKT6m16ORI18/2ZxEcaCptC4hTEBVI/1l9b0rJob0o4ULTePHA
        eCY/POVtEq8TiBpSV67Pq6/2MwjkZh+vjjhW0qdhBNGP7ubw+5RTnJCaWR5xI/IZtBk5knpLP3V37
        URAmZ5NLjEtHMjc1g9kk32XhLGYW8sfB7cyf8v3uvyLiXIB2YZilNpBtzYjZM5pk3JKf7Zv4yghQK
        seaxjiyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBAXf-00EfRQ-2u;
        Mon, 19 Jun 2023 08:49:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 781133002A9;
        Mon, 19 Jun 2023 10:47:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BC632BD11730; Mon, 19 Jun 2023 10:47:17 +0200 (CEST)
Date:   Mon, 19 Jun 2023 10:47:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Robin Jarry <rjarry@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH 0/5] x86/speculation: Disable IBRS when idle
Message-ID: <20230619084717.GJ4253@hirez.programming.kicks-ass.net>
References: <20230616200003.745742-1-longman@redhat.com>
 <CTECMFWMMST3.9FTWRDG7FFKQ@ringo>
 <20230617122115.GA1830050@hirez.programming.kicks-ass.net>
 <55219f3b-992d-ccc3-ba29-7bf33465b5cc@redhat.com>
 <ef2490a0-2768-ba70-e89d-59c0df76f827@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2490a0-2768-ba70-e89d-59c0df76f827@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 11:25:29PM -0400, Waiman Long wrote:

> > We were testing on the RHEL9.2 kernel which doesn't have your

Then keep the tinkering in the RHEL tree, please.

> We may need to extend your current solution to cover more cases.

See below.

> Perhaps adding a module parameter (e.g. idle_no_ibrs) to force the use
> of intel_idle_ibrs(). BTW, is it really the case that we can't disable
> IBRS when irq is enabled?

No, that is an entirely artificial constraint due to not having
intel_idle_ibrs_irq() and having no desire to deal with the
ramifications of such a thing.

That said; it also doesn't make any sense what so ever to add this. The
reason for having this intel_idle_irq() is for C1 state to improve IRQ
response latency. Adding WRMSRs will obviously regress that.

Specifically, we very intentionally did not add CPUIDLE_FLAG_IBRS to the
very shallow idle states to avoid regressions. These WRMSRs are
*EXPENSIVE*.

Additionally, if you were to go do this with IRQs enabled, then you have
to worry about enabling IBRS again on the interrupt path from kernel.

> The idle thread does not really interact with any user
> applications. I don't think there is any risk of information leakage even if
> we disable IBRS with interrupt enabled. Is my assumption incorrect?

Yes:

 - doing the WRMSR on C1 makes no sense, the C1 state is only picked if
   the idle time expectation is *VERY* short, the WRMSR overhead in that
   case is probably more than the expected idle time.

 - doing the WRMSR with IRQs enabled means you now get to touch the
   interrupt/exception from kernel paths, nobody wants more of this
   crap.

 - the whole IBRS thing is a trainwreck, let it be.

 - finally, T0 runs userspace, T1 goes into C1 idle, disables IBRS,
   enables IRQs, takes an IRQ and now T0 can 'see' everything T1 does in
   kernel space, you loose.

Also, did I say that IBRS sucks? Like really? It is horrific -- step
away and let it be.

The possibly better solution is to make sure nothing untrusted what so
ever runs on the DPDK machine, then you can forget about all the
mitigation nonsense.

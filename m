Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E215F6EB8F8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDVLzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 07:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjDVLy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:54:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41121BFF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A3kuEAPb1TggMhilS7MsSCnNi//DsHabrAyFbHO16VA=; b=bSnaxxX3JQ8Avhsw9oS0E5Qof4
        cQdJ7MA66ZcK+4ezEgo7m30T8zBVRu8oU7AnZVu6ETFY8U4DPWvaRaXC2SPuwERnfjJ3DXY60bAv1
        S7zIyxtNS2a64LzdWDcpJ7efrfnXwg5DerzzZoKLDjCLH+agU+KOm7sysgbyXonktX4GjehnD4aQ/
        qSU8YG6FAscn3PWkKOlvLEqvw5HdUrJSpd+6s9Z2MKNDs5Eqsaqt+WKIZiMjRmMZJPB3SxtlQOcyQ
        AqJkzE5zdKiwxD1cL9OXNoefMv9HAXO4sqX1tZirQjLeivC2wDPct3Z0z66KCVWFqJ8zlpB0xAtxQ
        A5tKh3nQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqBp9-006Eck-3C;
        Sat, 22 Apr 2023 11:54:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F2A5300338;
        Sat, 22 Apr 2023 13:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBA2A20979C19; Sat, 22 Apr 2023 13:54:38 +0200 (CEST)
Date:   Sat, 22 Apr 2023 13:54:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 00/14] Generalized Priority Inheritance via Proxy
 Execution v3
Message-ID: <20230422115438.GG1214746@hirez.programming.kicks-ass.net>
References: <20230411042511.1606592-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Anyway... tglx and bigeasy just pointed me at a problem with
pi_blocked_on vs sched_submit_work(), where if that function were to
block (specifically use rt-mutex), then we get:

	__rt_mutex_slowlock()
	  task_blocks_on_rt_mutex()
	    current->pi_blocked_on = waiter;
	  rt_mutex_slowlock_block()
	    schedule()
	      sched_submit_work()
	        ...
		  rt_mutex_lock()
		    ...
		      current->pi_blocked_on = waiter; // <--- OOPS

And AFAICT we have the exact same problem with the current DEBUG_MUTEXES
->blocked_on state which in this patch-set is generalized and relied
upon more heavily.



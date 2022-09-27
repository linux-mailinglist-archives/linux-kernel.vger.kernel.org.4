Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E535EC391
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiI0NFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiI0NFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:05:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6585AB42F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IZnhEU9vC0tniwm8pD4wYzm7wVcz837lGNjq/8287+o=; b=aZRoziNJYaFTV8spmDQfZucCAr
        S4ONSaaEKXr62VfXAhKV8DRAmJhy3Iv5ubjLsC5VQMoRa4FdA3qqfC2EjDuucRTPWhAK4DmxYXt9k
        m88d+K4rkiSymCH2oiSfvfOX30ZFu/al1WziOVYKq+uNxYqSIjHJclMnqZD16hNSO1xmQHGeJM71m
        FZUZdt8mDbqcIYFHLeUHVSllHVLzpN4PawsxNbZ5bnQPzi5BMe9IjhVNi+LEXkiEsyg5/vXnUNXsA
        nJdbc2J8oQL2+b4svluO+G1VDPOuy+Pf8GV8LEXrwlQZaQl18T/7+Zj/CH+VsyzqP4EHscpQ7cITU
        FHxM7aLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odAGO-00GI38-J5; Tue, 27 Sep 2022 13:04:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E87FF30024D;
        Tue, 27 Sep 2022 15:04:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE3872BDF120A; Tue, 27 Sep 2022 15:04:39 +0200 (CEST)
Date:   Tue, 27 Sep 2022 15:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 03/23] sched/core: Initialize the class of a new task
Message-ID: <YzL053SxqWUimANi@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-4-ricardo.neri-calderon@linux.intel.com>
 <YzG92YDyBK/0W+5u@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzG92YDyBK/0W+5u@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:57:29PM +0000, Joel Fernandes wrote:

> > +#ifdef CONFIG_SCHED_TASK_CLASSES
> > +	p->class			= TASK_CLASS_UNCLASSIFIED;
> > +#endif
> 
> I find the term 'class' very broad and unclear what kind of class (without
> further reading). So I am worried about how this generic term usage plays
> with Linux source code in the long-term (like what if someone else comes up
> with a usage of term 'class' that is unrelated to IPC.)

However much I like making a pain for people using C++ to compile the
kernel, I do think ipcc might be better here
(instructions_per_cycle_class for those of the novel per identifier
school of thought).

> To that end, I was wondering if it could be renamed to p->ipc_class, and
> CONFIG_SCHED_TASK_IPC_CLASSES, or something.

Can we *please* shorten those thing instead of writing a novel?
CONFIG_SCHED_IPC_CLASS works just as well, no? Or TASK_IPC, whatever.

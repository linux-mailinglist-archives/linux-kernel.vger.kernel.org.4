Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6171FBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjFBI0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFBIZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:25:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC6E10C4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xnFiTo8a3tBapvJnjbK6ESR6dZC80hyLl3DPImi/jLI=; b=X+dAJdP7g1bRsYisu0QLDdt1nA
        OaYps2tfPbtDLgdh192uBNOUOyiB7cPxaDHeePI4BKQMusa+jwfdKz+S46cwfvxqXvbce6PTAsnLs
        2YZAJ1qA2Pm2lN3wrXH9REWKEL7Wij39Ru+V83+dnYD+m3RbORhBzx6ptaZrlq5GAj2/tRsTLl9kW
        nLxYS+3o2ykklK9A5oUc4nlXYbjPtXl0qSvFzxujU87QB3Kod+cjzjJBC8wsSSFzM+bD/l0Ag+L+a
        dAbhZjRgZHbvXqandFu53rs805FCq5bzKVXKxlfVjFyucRXO2fnEgddv7sXB6Fa+x0LarnUEGIPSu
        Wrs29qxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q505p-0093DT-Po; Fri, 02 Jun 2023 08:25:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6575E30031F;
        Fri,  2 Jun 2023 10:25:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D13D27FF5C14; Fri,  2 Jun 2023 10:25:03 +0200 (CEST)
Date:   Fri, 2 Jun 2023 10:25:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <20230602082503.GA624418@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
 <20230526151335.oPeFiIdq@linutronix.de>
 <20230601091234.GW83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601091234.GW83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> On Fri, May 26, 2023 at 05:13:35PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2023-05-26 10:05:43 [+0200], Peter Zijlstra wrote:
> > > New day, new chances... How's this? Code-gen doesn't look totally
> > > insane, but then, making sense of an optimizing compiler's output is
> > > always a wee challenge.
> > 
> > Noticed it too late but looks good. Tested, works.
> 
> Excellent; full patch below. Will go stick in tip/sched/core soonish.

Urgh, so robot kicked me for breaking !SMP. And that made me realize
that UP wait_task_inactive() is broken on PREEMPT_RT.

Let me figure out what best to do about that..

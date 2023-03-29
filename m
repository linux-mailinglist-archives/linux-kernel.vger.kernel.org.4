Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78596CDAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjC2Ndo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2Ndn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:33:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83033C11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:33:41 -0700 (PDT)
Date:   Wed, 29 Mar 2023 15:33:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680096818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmyOOvcpSIDTxHq+2UdegnaOlX1e2IjEgzhMf071BEc=;
        b=XZKVxVNYhxFpvdJk2l0F1mm8n6DJsSx/zkMJANNHJqsR/HyBUnF5me33hxffUrsw+48ls+
        TSkeo2GAK8tmfWCC/Xt9ZUhZZ8QYR13QNaavj4J2Ma+o73dbZxsbfx8FJFl2UiInH26fVs
        O4V0cWbkxjLnpEq0yBt1VeqO/RF0vbz2QNkzyed2RiYMn6mbZSD6aPw529nhM/OznIgE/n
        4UWkTPPoPnilVyC5Ag2/c48R5OETI4rwTBnYFWibyjlBFXx2A0/swT6gkr1wk5E2m9yAEQ
        r3b3GXvVlMkT6Pl/xukCWrycyzcwkEw93eGd3vCJ7ZazhwNw3NdA7DEkdrHlDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680096818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmyOOvcpSIDTxHq+2UdegnaOlX1e2IjEgzhMf071BEc=;
        b=L9wKObPW3Do96U6x4drnkNelzUp+T67VmJcN0J1uFbTtFRWoZ63M63cmF22Nw4DtOXwdj3
        sCJUlr9AEdWhTzAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20230329133337._HFnQR5R@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <Y/YaTojZ1stY2fAO@hirez.programming.kicks-ass.net>
 <Y/eaGdGD0sOAXWW+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/eaGdGD0sOAXWW+@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-23 17:53:48 [+0100], To Peter Zijlstra wrote:
> On 2023-02-22 14:36:14 [+0100], Peter Zijlstra wrote:
> > Which if the very few wait_task_inactive() users requires this?
> 
> ptrace is the remaining (known) one (just verified on v6.2-rt3).
> ptrace_check_attach() waits for the child which blocks on tasklist_lock.
> 
> tglx argued that wait_task_inactive() should work regardless of the
> task, that is being waited for, blocks on a sleeping lock.

a polite ping.

Sebastian

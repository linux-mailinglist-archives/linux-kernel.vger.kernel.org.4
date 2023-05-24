Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF470F983
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjEXPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjEXO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:59:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B01BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:59:24 -0700 (PDT)
Date:   Wed, 24 May 2023 16:59:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684940361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYy4bXsxae3wYkASTuhXwtSJ/q1srkRcQFuYWoUriqg=;
        b=Brvp9ZR+1cJxCO9/fFD9+Sh5W6z9mDgNPqCybeczJq9IAUGO5a2rl8H8566z7X3TrfyIAd
        4DDAR+rgIva0DmD/ZSaBWpsbrfVPCBVhirc9gU58V8jRy8J9ntIFalmUJXlPnoqlof95wc
        /EGRl0ENtpE9HMeRjbXfWvdPe+mqME1/wiYhGSY1aynmLoVK7hZ21nQeXgJyPkFHB8pzCG
        BOalgo6S4KNIkCkAnvLHPgik0ljuTs8dhGxs807TfbHbbaNMWTlMdLWWGMAH/KqAcJJCpq
        1k4Ayqt9PqdIxkJxUG9O3dTP6AuJ4savtt1zrPRG9QokI5nIiYJkqNaXFkCeSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684940361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYy4bXsxae3wYkASTuhXwtSJ/q1srkRcQFuYWoUriqg=;
        b=X4ZOWaNKuV3yG+ZgMqAoqlX3l1JZCt/SpBpTWoXr0YA21vGChHjjw2FB/GipIMKl8zLcq8
        wvTx/1m7Vv6zFHDQ==
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
Message-ID: <20230524145920.SGZv5D4a@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <Y/YaTojZ1stY2fAO@hirez.programming.kicks-ass.net>
 <Y/eaGdGD0sOAXWW+@linutronix.de>
 <20230329133337._HFnQR5R@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329133337._HFnQR5R@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29 15:33:39 [+0200], To Peter Zijlstra wrote:
> On 2023-02-23 17:53:48 [+0100], To Peter Zijlstra wrote:
> > On 2023-02-22 14:36:14 [+0100], Peter Zijlstra wrote:
> > > Which if the very few wait_task_inactive() users requires this?
> > 
> > ptrace is the remaining (known) one (just verified on v6.2-rt3).
> > ptrace_check_attach() waits for the child which blocks on tasklist_lock.
> > 
> > tglx argued that wait_task_inactive() should work regardless of the
> > task, that is being waited for, blocks on a sleeping lock.
> 
> a polite ping.

a very polity ping.

Sebastian

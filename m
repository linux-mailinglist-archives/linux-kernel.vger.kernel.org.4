Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98ED600358
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJPUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPUsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 16:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB012AC51
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 13:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB5C60E26
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBDEC433D6;
        Sun, 16 Oct 2022 20:48:11 +0000 (UTC)
Date:   Sun, 16 Oct 2022 16:48:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <20221016164809.6cd6871f@rorschach.local.home>
In-Reply-To: <Y0q7TyEWco/PfOAI@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
        <20221003214501.2050087-8-connoro@google.com>
        <Y0YeUhDZWb49mpLo@google.com>
        <Y0q7TyEWco/PfOAI@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2022 15:53:19 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> >From this it is easy to see that the critical secion executes with the  
> direct sum of the blockchain as a whole (all of them will have donated
> their relative time to make the owner elegible again) -- provided the
> critical section is of course long enough for this to matter (or it's
> owner's weight small enough etc..).

Does this mean that a lower priority task could do a sort of DOS attack
on a high priority task, if it creates a bunch of threads that
constantly grabs a shared lock from the higher priority task? That is,
the higher priority task could possibly lose a lot of its quota due to
other tasks running on its behalf in the critical section?

-- Steve

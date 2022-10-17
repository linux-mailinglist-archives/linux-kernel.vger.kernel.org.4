Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFB6007B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJQH05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJQH0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:26:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D715A3D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MQuxp9USYpLXeUl20/SiKvpty8XB9IEambUSzY8WQ8o=; b=Lj0r3XlMKD32EH5VQ+f3X/tmoH
        8qKkGL33XRN0ktLamG5QlPl0ENcAEzBN05gx8Vy66gfLKBspm+Ck0ec8XrpmQ5kkVCKzb1ePk9pni
        G9zskSj6Ue1/exbwjajeTVSFSpgZn41F9/gZNpJvO0fl+PlsKiC/t6ONOw3Q80yk99htlb3ZkKSv6
        EZ6gACxIyvWtXQy4UGC0bMp+Hk+WmItCFcD7ffgU0HP7oHw5lTrwoI+eDS1GclORHObYPVuFSxNrl
        SN0qjALwnd2DN50bu5jNxsD1cT8CXY2PvVwKytVoo+iHDAew++pt7rsbFF2TLb9TPf4Zdixi8/l3k
        tsOM63mQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okKW9-009g1w-Ll; Mon, 17 Oct 2022 07:26:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 764DE300574;
        Mon, 17 Oct 2022 09:26:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F03420426DE2; Mon, 17 Oct 2022 09:26:27 +0200 (CEST)
Date:   Mon, 17 Oct 2022 09:26:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <Y00DoxbG9B2YoSO3@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
 <Y0YeUhDZWb49mpLo@google.com>
 <Y0q7TyEWco/PfOAI@hirez.programming.kicks-ass.net>
 <20221016164809.6cd6871f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016164809.6cd6871f@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 04:48:09PM -0400, Steven Rostedt wrote:
> On Sat, 15 Oct 2022 15:53:19 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >From this it is easy to see that the critical secion executes with the  
> > direct sum of the blockchain as a whole (all of them will have donated
> > their relative time to make the owner elegible again) -- provided the
> > critical section is of course long enough for this to matter (or it's
> > owner's weight small enough etc..).
> 
> Does this mean that a lower priority task could do a sort of DOS attack
> on a high priority task, if it creates a bunch of threads that
> constantly grabs a shared lock from the higher priority task? That is,
> the higher priority task could possibly lose a lot of its quota due to
> other tasks running on its behalf in the critical section?

Less than without PE; without PE the high prio task will be blocked and
starved, with PE at least they'll help push the low prio thing ahead and
get on with things.

Additionally, the highest priotiy waiter will get the lock next.

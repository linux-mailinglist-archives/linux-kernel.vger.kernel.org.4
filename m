Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E76665A75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjAKL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjAKL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:27:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3112767
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:27:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673436419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnm+ywz+v6qAg22yzqr9Q3YUeRd4yzvHh7NAxESwhp4=;
        b=3zypZmkgtv2BCZJBB9H8rdZt67sWWh8uxbiehYqUFH/K0C21uZlrXjrSdDeveKtYf/y6LV
        ets4xWTVDiGMRz1AfUX7pTcnxhnc10JUn2FZfXgjQlNtI8BSng5oKtKH1B0xT71LL9SkF/
        Bbpc8kpVNMDrjhW2BomJO14sYTOWRKCsveLepK2NirohTFi08GrslAybCTEVr/VycNgeD3
        TD0TjIAshf25kvKWt+hMgorQZdjDVcYiZmR+xieAFT9r3VNyuXolJylBBE93/KjXH+jhot
        un9q+dy7i8IlfYhRyp+MOKbrcLDw4libuw5cGzIJE5OOdW5cCMFp1b14WuMRiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673436419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnm+ywz+v6qAg22yzqr9Q3YUeRd4yzvHh7NAxESwhp4=;
        b=Okp/ZW3/ZL8Lq4j9ot9ueLm8Kg/0R/8uGcrDj/jo5nQJf3wQFvZM4rtPz4MTkiIqzUkXQN
        dnO/JkcSUVmpymAA==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH clocksource 5/6] clocksource: Suspend the watchdog
 temporarily when high read latency detected
In-Reply-To: <20230105010701.1773895-5-paulmck@kernel.org>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
 <20230105010701.1773895-5-paulmck@kernel.org>
Date:   Wed, 11 Jan 2023 12:26:58 +0100
Message-ID: <87r0w1ia65.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04 2023 at 17:07, Paul E. McKenney wrote:
> This can be reproduced by running memory intensive 'stream' tests,
> or some of the stress-ng subcases such as 'ioport'.
>
> The reason for these issues is the when system is under heavy load, the
> read latency of the clocksources can be very high.  Even lightweight TSC
> reads can show high latencies, and latencies are much worse for external
> clocksources such as HPET or the APIC PM timer.  These latencies can
> result in false-positive clocksource-unstable determinations.
>
> Given that the clocksource watchdog is a continual diagnostic check with
> frequency of twice a second, there is no need to rush it when the system
> is under heavy load.  Therefore, when high clocksource read latencies
> are detected, suspend the watchdog timer for 5 minutes.

We should have enough heuristics in place by now to qualify the output of
the clocksource watchdog as a random number generator, right?

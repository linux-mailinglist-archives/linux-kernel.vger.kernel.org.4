Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD455682B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAaLIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAaLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:08:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB32D4B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:08:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675163286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXk9LU+ffSQH18+rvTZtyklVo1lqqzKZwwPjeV8WrzA=;
        b=qOexVy1TbeKXdT6QnsMkA5uYQ/7Ud3ZB9yHm1upaIrH9U1o/9ETHVZGh2nr38BYS6LwMrs
        3fBef9ik/OQJ3qWD0kC2x20tAhRGM027QjlDubGxPB2ZPy0n3tOAk+snOMabu/yWezcwqL
        wIS5FCd8Bh3u7CgivByb01yWIde+JtLSmzjR2X2mq0op7ZO+DfDxD7IBf1yW7nvphARDrM
        YWKtdTDWJuiVvaf5EZvl8zY6oNQ67ZNDzobI6eoFgu7isWr3iLf69W0+FyZhsCjr2pUNeM
        nsXUHW+BVC/03aC30nCD2SiaI9qRSC6FF9C/3bFzthUW/hJieaYHPqiXWMi3Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675163286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXk9LU+ffSQH18+rvTZtyklVo1lqqzKZwwPjeV8WrzA=;
        b=8oeZFj2K8verYblEfCLZmjWgP13IeYRsmnDkzFGq7/R1HQ5ffCozVx08kkpq2yNkduSdqB
        ul18aSpf72yGHpCw==
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, arjan@linux.intel.com, mingo@kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [RFC PATCH] hrtimer: interleave timers for improved single
 thread performance at low utilization
In-Reply-To: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
References: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
Date:   Tue, 31 Jan 2023 12:08:06 +0100
Message-ID: <877cx30xnt.ffs@tglx>
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

On Tue, Jan 31 2023 at 11:18, shrikanth hegde wrote:
> As per current design of hrtimer, it uses the _softexpires to trigger the
> timer function.  _softexpires is set as multiple of the period/interval value.

Wrong. _softexpires is _hardexpires + slack. The slack allows for
batching which:

> This will benefit the power saving by less wakeups.

But that has absolutely nothing to do with your problem:

> Due to this, different timers of the same period/interval values align
> and the callbacks functions will be called at the same time.

The whole point of hrtimer_forward_now() is to forward the expiry time
of a timer with the given period so that it expires after 'now'.

That's functionality which is used by a lot of callers to implement
proper periodic timers.

> Came up with a naive patch, more of hack.

A broken hack to be precise because any existing user of
hrtimer_forward() will be broken by this hack.

> Other alternative is to use a slightly modified API for cgroups, so
> that all other timers align and wakeups remain reduced.

I'm not seeing why you need a new API for that. The problem is _NOT_ in
the hrtimer code at all.

Lets look at the math:

    expiry = $INITIAL_EXPIRYVALUE + $N * $PERIOD

If $INITIAL_EXPIRYVALUE is the same then for all instances then
obviously the expiry values of all instances will be all aligned on
multiples of $PERIOD, right?

So why the heck do you need a new hrtimer API? There is an obvious
solution, right?

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113776D9B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjDFPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbjDFPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:03:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F355FF9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:02:58 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:02:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680793376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4mX9pv4PeCziBc3ElC9iuNaE7psMZGOtyWMk2UJfUM=;
        b=Dd3oTTDAAEBR0gIEM2tvELYgko/BhbWD3wHap6BJwYFmZAKgYEqSAB209WZ5HE9spNTedg
        4bIVa+tMQNFnNO5wrPGBN8Rgu3rAFTXbU8mInHXHuHbxZFbBnsWhHnJEUTTH3K6tvLdOIc
        8JbJTNY9NuC1aCKh5ehQqoTgMTfOkxGU7FWZIqHq53n2Zp1CVas+ax7aMtdEx2nLBjMA/x
        vLiwcEFOZP3f++OMDhXiyp4sMCnsDZtzkMpa4zX0G4LG6HwDA5JN6S6xfcnEVLt5Huresc
        Rc6BPS/W31CEgzQTpv7kSs4Ob08Jwjn3dcxNo6m6WbnnCkyOzix/rYro2gEExQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680793376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4mX9pv4PeCziBc3ElC9iuNaE7psMZGOtyWMk2UJfUM=;
        b=bG/3HaHhLZS+nMqzShx8r2s3C3KbjSJUvqx30RLz7iiemuXtOD180NqSv4JkgA1C/TfIyg
        +prlnR1JAVsI4xDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [RFC] tick_sched_timer() is not properly aligned, fixed by chance
Message-ID: <20230406150254.ZrawA2Y-@linutronix.de>
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mt3lqnde.ffs@tglx>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 13:08:29 [+0200], Thomas Gleixner wrote:
> On Thu, Apr 06 2023 at 12:55, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 11:57:35AM +0200, Sebastian Andrzej Siewior wrote:
> >
> >> The tick_sched_timer story is that it uses ktime_get() to set the
> >
> > But but but, ktime_get() does not use sched_clock(), it has it's own TSC
> > reader.
> 
> Correct and at that point during early boot the clocksource which feeds
> ktime_get() should be jiffies and not some other random clocksource.
> 
> Sebastian, can you please evaluate which clocksource is used for
> ktime_get() at the point where the first clock event device is set up?

The first one added is hpet. It points to "jiffies" as name and
jiffies_read() as ->read().

Before the change/ with PeterZ change I get from ktime_get() for
base/nsec something like:
|[    0.004000] tick_next_period Name: jiffies jiffies_read+0x0/0x10
|[    0.004000] tick_next_period base/nsec: -401771248 405771248
|[    0.004000] tick_next_period hpet 4000000

base/nsec is different on each boot but it always ends up with 4000000.
With the optimisation, ktime_get() is:
| [    1.179079] tick_next_period base/nsec: 647439581 518613145
| [    1.179646] tick_next_period hpet 1166052726

so something is using it during init. And this is
	read_persistent_wall_and_boot_offset()

> Thanks,
> 
>         tglx
> 
Sebastian

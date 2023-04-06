Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6486D94B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjDFLIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDFLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47BC7AAC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:08:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680779310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkrlqyskVm2An7yOWFjcS+8WDYp4TB5/lJ2q1Rym75o=;
        b=clAhYk0dJdnO6T/4+UbGoZmgnkApx/PxjNm3Pd1et87XJmwHr95e8n6SQ8+tXfq25LrGlP
        uvWvhfBLXJkL5dat57vcWmOOV2ZIc6i6mnlkdU1QJ3BeF11vdsFWHf/jqVESb6E5b2S95v
        qvpbJ2rMvAB4+ZdaA02A6bCwAlvSEYXDIQbz5qi/Oj5CFSbKWzxAONncMaJn68VObSlEDh
        bQZY7rL+5Whc2fYOMBqvl/fPmgiC8vIt8VGMDWl3L1/GGX+QnLci9SnbPVtrMEHeoE8/CF
        sg40g77uFDPgq5rzw5OXNG6YDhcH+cDJwsQGlzLEjLRLyuOSGlgQPFE+DK0dqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680779310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkrlqyskVm2An7yOWFjcS+8WDYp4TB5/lJ2q1Rym75o=;
        b=po0dQvhjFYnT3HcUkSMcjmo3xkknDGj12hzrwAii35JzHcG49gP06HaX8wc9P6h/hmnrk1
        gIXmDMXvIG/iXeBQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [RFC] tick_sched_timer() is not properly aligned, fixed by chance
In-Reply-To: <20230406105529.GB392176@hirez.programming.kicks-ass.net>
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 13:08:29 +0200
Message-ID: <87mt3lqnde.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06 2023 at 12:55, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 11:57:35AM +0200, Sebastian Andrzej Siewior wrote:
>
>> The tick_sched_timer story is that it uses ktime_get() to set the
>
> But but but, ktime_get() does not use sched_clock(), it has it's own TSC
> reader.

Correct and at that point during early boot the clocksource which feeds
ktime_get() should be jiffies and not some other random clocksource.

Sebastian, can you please evaluate which clocksource is used for
ktime_get() at the point where the first clock event device is set up?

Thanks,

        tglx



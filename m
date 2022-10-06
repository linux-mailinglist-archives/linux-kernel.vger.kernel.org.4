Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBF5F65EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJFM0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJFM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:26:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DA7679;
        Thu,  6 Oct 2022 05:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94AE2B81A76;
        Thu,  6 Oct 2022 12:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2444C433D7;
        Thu,  6 Oct 2022 12:26:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TsTm67Ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665059166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6iPbXN5uNEWV3YZEUMKktzYcuhWOhctZeQ02euetF3U=;
        b=TsTm67LlKD3Gjx0PkIPYMdh+9AE8HCA9QwFABcH6wyYNxUdbzfLcKHnWSK9lhDBErZJmos
        TCnYP4JIuDGVr3slI2hykp9bmVEX2jhkw3DUVyqEFLkbgaf2uDc97s0J4Jpj3NmnMbmXmX
        vwh/HpR0E/moBel5/P+VZgtJsON2D2A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8808a601 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 6 Oct 2022 12:26:05 +0000 (UTC)
Date:   Thu, 6 Oct 2022 06:26:04 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz7JXEaTFWa1VLKJ@zx2c4.com>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
 <Yz55w4gNtZn8JzmG@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz55w4gNtZn8JzmG@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:46:27AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-10-05 23:08:19 [+0200], Jason A. Donenfeld wrote:
> > Hi Sebastian,
> Hi Jason,
> 
> > On Wed, Oct 05, 2022 at 07:26:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > That del_timer_sync() at the end is what you want. If the timer is
> > > pending (as in enqueued in the timer wheel) then it will be removed
> > > before it is invoked. If the timer's callback is invoked then it will
> > > spin until the callback is done.
> > 
> > del_timer_sync() is not guaranteed to succeed with add_timer_on() being
> > used in conjunction with timer_pending() though. That's why I've
> > abandoned this.
> 
> But why? The timer is added to a timer-base on a different CPU. Should
> work.

So it's easier to talk about, I'll number a few lines:

 1 while (conditions) {
 2     if (!timer_pending(&stack.timer))
 3         add_timer_on(&stack.timer, some_next_cpu);
 4 }
 5 del_timer_sync(&stack.timer);


Then, steps to cause UaF:

a) add_timer_on() on line 3 is called from CPU 1 and pends the timer on
   CPU 2.

b) Just before the timer callback runs, not after, timer_pending() is
   made false, so the condition on line 2 holds true again.

c) add_timer_on() on line 3 is called from CPU 1 and pends the timer on
   CPU 3.

d) The conditions on line 1 are made false, and the loop breaks.

e) del_timer_sync() on line 5 is called, and its `base->running_timer !=
   timer` check is false, because of step (c).

f) `stack.timer` gets freed / goes out of scope.

g) The callback scheduled from step (b) runs, and we have a UaF.

That's, anyway, what I understand Sultan to have pointed out to me. In
looking at this closely, though, to write this email, I noticed that
add_timer_on() does set TIMER_MIGRATING, which lock_timer_base() spins
on. So actually, maybe this scenario should be accounted for? Sultan, do
you care to comment here?

Jason

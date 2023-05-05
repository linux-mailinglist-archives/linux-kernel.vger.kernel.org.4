Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2E6F8CD3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjEEXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEEXg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:36:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105C4EE0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:36:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683329783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BamJrSPKBUHXKJJzbzgKWvqXbwAVlB1h73t9LyzGtMs=;
        b=ZIc7dZB0g6TBZVfo/PxTghYveNOAIMntT6q5CAe7llT4h/2kgMTP+suqdm4QZ/XmwWKe0y
        T5jvkpEss4wqVy+yAR/bcaMuzfJjnhBtc7D6OinQVOKc5p2eX+Jmn4D3cKxTQDmFoxbxaF
        Oguj8Rn3k4iNvdlQyWPHwzWvuDh+Yjf151gFszGIbxJ3VRYO67KJrQKdF9fC1gVbX+8kft
        uJAa95JZ85uAwukPsolaDks3R1PbFtgNvLUhTaQGLYtT4kzLsxx6FycVf+r2hWXl+quXYX
        2OpHYNKm90zsLBGcLYBe3x/2cd7GqsoW8RnhgcYfxxRwxn/kwCHu2AUY0XTY1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683329783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BamJrSPKBUHXKJJzbzgKWvqXbwAVlB1h73t9LyzGtMs=;
        b=qkAmRvTIHd6q1u8j2V0mczvuK4bV7tRo+9wv8X30xn1MQs7E77BHwe+BNoXYyRNRFAa/US
        LzEETW/XYGZMqaCQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
In-Reply-To: <87zg6i2xn3.ffs@tglx>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx>
Date:   Sat, 06 May 2023 01:36:22 +0200
Message-ID: <87v8h62vwp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06 2023 at 00:58, Thomas Gleixner wrote:
> On Fri, May 05 2023 at 16:50, Frederic Weisbecker wrote:
> So the whole thing works like this:
>
>    start = READ_LOCKLESS(sig->next_id);
>
>    // Enfore that id and start are different to not terminate right away
>    id = ~start;
>
> loop:
>    if (id == start)
>    	goto fail;
>    lock()
>         id = sig->next_id;                      <-- stable readout
>         sig->next_id = (id + 1) & INT_MAX;      <-- prevent going negative
>
>         if (unused_id(id)) {
>            add_timer_to_hash(timer, id);
>            unlock();
>            return id;
>         }
>    id++;
>    unlock();
>    goto loop;
>
> As the initial lockless readout is guaranteed to be in the positive
> space, how is that supposed to be looping forever?

Unless you think about the theoretical case of an unlimited number of
threads sharing the signal_struct which all concurrently try to allocate
a timer id and then releasing it immediately again (to avoid resource
limit exhaustion). Theoretically possible, but is this a real concern
with a timer ID space of 2G?

I'm sure that it's incredibly hard to exploit this, but what's really
bothering me is the hash table itself. The only reason why we have that
is CRIU.

The only alternative solution I could come up with is a paritioned
xarray where the index space would be segmented for each TGID, i.e.

       segment.start = TGID * MAX_TIMERS_PER_PROCESS
       segment.end    = segment.start + MAX_TIMERS_PER_PROCESS - 1

where MAX_TIMERS_PER_PROCESS could be a copius 2^16 which would work for
both 32bit and 64bit TID limits.

That would avoid the hash table lookups and the related issues, but OTH
it would require to allocate one extra page per TGID if the application
uses a single posix timer.

Not sure whether that's worth it though.

Thanks,

        tglx

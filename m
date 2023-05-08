Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEA66FBA5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjEHV5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjEHV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:57:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06735241
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:57:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683583041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tGCUv5bkdbUJ3J4cUImIxGyAzEBlNK1aC1+DBJOGpk=;
        b=AdrsldnCxqzeqH+B1kpoG4Q8NWv+NjNDjFVWiE2dJNLV6TBjQIgnaNTm06zKNX7mVPEcQ9
        Z7kgJen826Q4YbreKZXoSjed+ycAonCtgAWgkI8wORB0pPmMbK3DTYuROJlYY5QAv0+5HJ
        TCPsWaWrySkxfibkefO1RBucF5TKShUqAPKGsrTleOPBlfAim2PFaTYM8LRAFR42oXprp5
        TQBhG2VMYtJEcppA/67OTgwXPhkV4kEUfx3dnvXUs90LwU+rwQ2Qv1wvu1t3g8YtHhGnp2
        V/M8ECuzvV33+JzfvKGegaBnW48PDctsytyPio1oBYy/q41pUs4+xFHWetSRuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683583041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tGCUv5bkdbUJ3J4cUImIxGyAzEBlNK1aC1+DBJOGpk=;
        b=vRMf/rVcLAnYNPEHlQ0kOdmSalLwu7Ufk9ky/SoC32YwQUgXVEcUmJ4pvLyNGhPIEBUvNA
        5reKUSRrXYCsJFAA==
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
In-Reply-To: <87v8h62vwp.ffs@tglx>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx>
Date:   Mon, 08 May 2023 23:57:21 +0200
Message-ID: <878rdy32ri.ffs@tglx>
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

On Sat, May 06 2023 at 01:36, Thomas Gleixner wrote:
> On Sat, May 06 2023 at 00:58, Thomas Gleixner wrote:
>> On Fri, May 05 2023 at 16:50, Frederic Weisbecker wrote:
>> As the initial lockless readout is guaranteed to be in the positive
>> space, how is that supposed to be looping forever?
>
> Unless you think about the theoretical case of an unlimited number of
> threads sharing the signal_struct which all concurrently try to allocate
> a timer id and then releasing it immediately again (to avoid resource
> limit exhaustion). Theoretically possible, but is this a real concern
> with a timer ID space of 2G?

It only hurts the process which does this and does not inflict any
latencies by holding hash_lock over the full search for a free spot.

> The only alternative solution I could come up with is a paritioned
> xarray where the index space would be segmented for each TGID, i.e.
>
>        segment.start = TGID * MAX_TIMERS_PER_PROCESS
>        segment.end    = segment.start + MAX_TIMERS_PER_PROCESS - 1
>
> where MAX_TIMERS_PER_PROCESS could be a copius 2^16 which would work for
> both 32bit and 64bit TID limits.
>
> That would avoid the hash table lookups and the related issues, but OTH
> it would require to allocate one extra page per TGID if the application
> uses a single posix timer.
>
> Not sure whether that's worth it though.

More thoughts on this. If we go there and accept the extra page of
memory then we can just go all the way and make the xarray per process,
actually per signal.

That would also require another change, namely making the preallocated
sigqueue part of struct k_itimer, which in turn would not be the worst
of all ideas as it gets rid of the lookup in posixtimer_rearm() and
would also allow for some clever handling of the nasty SIG_IGN issues.

Though that's separate from the problem at hand.

Thanks,

        tglx

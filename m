Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1536FC2C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjEIJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjEIJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:30:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A827AD1D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:30:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683624601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NIGDXOvxTL/bkGzowYhEa+foQBHABLn1MZXkESGwuHs=;
        b=YALPAzc1fLbLrc6eFhaqKhJmEuDfc5Uwdutho3QRSndJBKSRIQjy091XI9hKBhBx8ZsuD9
        NjfLOKNynX/eU7W3DAu5A6e1YIV8v2X4AFaxYixpllWJXx3jzVadrYbId+vBlThiaJ6oiX
        J/Zt0EGTojjjeLg9cpvoZa921GZUE0Sn4nqRSgiIMHTS3k6aOYLA1gQwyzxYfzFvSL9v+f
        LKQHuk3btvHz9E7exUXkGIbxMKow978vPEPYauLD0yRXc0QsD6d4Z4SYvg/DhtCOm0oPOX
        FO3mhq2RqVFVRS/zJN+PjW2N5bj6j/Y44XU3mkM/MWQdqi8K8mFcpiagBHBNgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683624601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NIGDXOvxTL/bkGzowYhEa+foQBHABLn1MZXkESGwuHs=;
        b=L+CxZUW+ETVVWrwOj6eom5QQxn7dk6fbIFO7+UsOB77hsxTR2KHNaERExxCYapDLRjGJyl
        5he1UYov/naRIDCg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
In-Reply-To: <878rdy32ri.ffs@tglx>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
Date:   Tue, 09 May 2023 11:30:01 +0200
Message-ID: <87v8h126p2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08 2023 at 23:57, Thomas Gleixner wrote:
> On Sat, May 06 2023 at 01:36, Thomas Gleixner wrote:
>> The only alternative solution I could come up with is a paritioned
>> xarray where the index space would be segmented for each TGID, i.e.
>>
>>        segment.start = TGID * MAX_TIMERS_PER_PROCESS
>>        segment.end    = segment.start + MAX_TIMERS_PER_PROCESS - 1
>>
>> where MAX_TIMERS_PER_PROCESS could be a copius 2^16 which would work for
>> both 32bit and 64bit TID limits.
>>
>> That would avoid the hash table lookups and the related issues, but OTH
>> it would require to allocate one extra page per TGID if the application
>> uses a single posix timer.
>>
>> Not sure whether that's worth it though.
>
> More thoughts on this. If we go there and accept the extra page of
> memory then we can just go all the way and make the xarray per process,
> actually per signal.

Thinking more about it. The current scheme how timer ID allocation works
is really interesting vs. CRIU.

Assume a process creates/deletes timers frequently. It's not hard to
move the next ID close to INT_MAX, i.e. 2G

Now checkpoint that thing and restore it which means to do the
create/delete dance to move next ID up to the last one-1. Will only take
a couple of hours....

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02406FD960
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjEJIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjEJIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:31:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CAA449E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:30:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683707457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usGwrNqwocT5ZlgBtBjsBCzaf/mufKvIc8NIljU8lj4=;
        b=MH2VtSK+aP3fFv+wfunCTyL92HVxXBkunD0KDuuyeEn024DOAWjklVSbrsLIx+vqOJAS5e
        Q6SU+Bhik8RujQK45hX1bREqQ+lr5KjUTERaRtV93MYT6JQvIhgjsRHlOZ8ecg49mwR1g9
        rrxfZnMWoA+Pj8allejcsgJMsoAy4iefDp5UOz533l/vPv53b5tfdpAs4VQn1eBHXEVUFe
        SLauYoOoRV1ut3OKY2Es29k4H8fmD6XPwkoZR5vyV0+pjZ9WTWFwcpsiAX/ePtv8ei023E
        zKF7/yBNLALoZeCKvRtn3l0xd60lJY3QeiijA9qOmkPqRLHtaSXDGxGpHEC6TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683707457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usGwrNqwocT5ZlgBtBjsBCzaf/mufKvIc8NIljU8lj4=;
        b=7Iq46h07djEVdcpH62BXAS7r7IyJNXLH8nWZCXmnlr9SidmOl1ciVS2EZ4ofGDD6xv6FvM
        VGENJv79VSevXPCg==
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [RFD] posix-timers: CRIU woes
In-Reply-To: <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com>
Date:   Wed, 10 May 2023 10:30:57 +0200
Message-ID: <87wn1gy4e6.ffs@tglx>
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

Pavel!

On Wed, May 10 2023 at 12:36, Pavel Tikhomirov wrote:
> On 10.05.2023 05:42, Thomas Gleixner wrote:
>> So because of that half thought out user space ABI we are now up the
>> regression creek without a paddle, unless CRIU can accomodate to a
>> different restore mechanism to lift this restriction from the kernel.
>> 
>> Thoughts?
>
> Maybe we can do something similar to /proc/sys/kernel/ns_last_pid? 
> Switch to per-(process->signal) idr based approach with idr_set_cursor 
> to set next id for next posix timer from new sysctl?

I'm not a fan of such sysctls. We have already too many of them and that
particular one does not buy much.

We can simply let timer_create() or a new syscall create a timer at a
given ID.

That allows CRIU to restore any checkpointed process no matter which
kernel version it came from without doing this insane create/delete
dance.

The downside is that this allows to create stupidly sparse timer IDs
even for the non CRIU case, which increases per process kernel memory
consumption and creates slightly more overhead in the signal delivery
path. The latter is a burden on the process owning the timer and not
affecting expiry, which is a context stealing operation. The memory part
needs eventually some thoughts vs. accounting.

If the 'explicit at ID' option is not used then the ID mechanism is
optimzied for dense IDs by using the first available ID in a bottom up
search, which recovers holes created by a timer_delete() operation.

Thanks,

        tglx

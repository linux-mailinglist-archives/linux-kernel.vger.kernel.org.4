Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE76DB202
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDGRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDGRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD752B469
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:47:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680889660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0k1aH3SN6RIb4G5Py8osu0QB7lf5RDZkIrsmh2XPXg=;
        b=iAmuhZZ0LvoCUFe/y7VuyMmKTHOxNRXP81+ZpXXYxYOXLkFMPbcnFvh7F2UbujK0An98u5
        2M+LK5EVTyFFQbhtXEZxTQzkIgh3sNK8CnEfikbatxJxpwZbfp0NlyADCEefzCgPCrRIma
        Xz+X+IrgSxCIAZJuVmjV4NDENXZU7XXUferzXMbIsaFylvlYRXvFyf/mjrRI8uSCcolblX
        3FnEOlO639h4tg1VufBUkpowDxVm7AHbwNxgng0EqSciBa9n3ipWmBPxJ9GYaeZvHajWVi
        ZpZRe/Tf5OILFyST4dto9OOys4KvVgkea59T8efmU8nI0oH8m5use85+OFIN4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680889660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0k1aH3SN6RIb4G5Py8osu0QB7lf5RDZkIrsmh2XPXg=;
        b=xqhRk2V4R4Wghzp494BP4lRPr/lYX5QPjwfmGgNr46DKJYKkZjkH6Zf4Y8OGo+AfGQKDu9
        pv9jIpnGq72RHkBw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
In-Reply-To: <ZDADdMnY0oW2k5BV@lothringen>
References: <87h6tsred7.ffs@tglx> <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen>
Date:   Fri, 07 Apr 2023 19:47:40 +0200
Message-ID: <87lej3twhv.ffs@tglx>
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

On Fri, Apr 07 2023 at 13:50, Frederic Weisbecker wrote:
> On Fri, Apr 07, 2023 at 10:44:22AM +0200, Thomas Gleixner wrote:
>> Now memory came back. The problem with posix CPU timers is that it is
>> not really known to the other side which task is actually doing the
>> expiry. For process wide timers this could be any task in the process.
>> 
>> For hrtimers this works because the expiring context is known.
>
> So if posix_cpu_timer_del() were to clear ctmr->pid to NULL and then
> delay put_pid() with RCU, we could retrieve that information without
> holding the timer lock (with appropriate RCU accesses all around).

No, you can't. This only gives you the process, but the expiry might run
on any task of that. To make that work you need a mutex in sighand.

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992216DAA53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbjDGIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbjDGIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:44:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449F4EED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:44:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680857063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=jHJMUpRuhMUlelEnZK8+DRD6C/ir55kUOiM/K4/4Lfs=;
        b=H45JRJMAr+ngJ5tF1yNnBK9nsYsNbtp9f8b6VZG2LDI1qbJmwE2M3PEoAHGaOVmemHJp4k
        Ez/M0x0wkEikw3ef3jU5EgAHQqaOF9tMNnt34D4ZI3nPYEgO8qb7+wi1qp1k36rPPQuvFh
        c9vXm/KnLQQfhhq6b3ITfXjHHbxhDUWeeSuBduYvDo027GMeAok08+HT0WGrZijA+aii1z
        mROuo1fUouiwBGuQJds2yRdAvEoDn4vGwe1g/RixOYt9jtL72tzriml6x7jCBmg2sbt1jY
        2ERJzGd9HQD6RST3PjfvFmNtAl5X5KyvPA5NcuMxqJy3Fk6UzUkYNz87bSnRdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680857063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=jHJMUpRuhMUlelEnZK8+DRD6C/ir55kUOiM/K4/4Lfs=;
        b=lOTj9qBCMSqr7dzpOP1JE0OLf1cyletpr6r9AvWUCQuXJInLPzhjnS9wdpAXCY1eCRteUo
        ytryji7PqWWQLYAg==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
In-Reply-To: <87h6tsred7.ffs@tglx>
Date:   Fri, 07 Apr 2023 10:44:22 +0200
Message-ID: <874jpsqdy1.ffs@tglx>
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

On Thu, Apr 06 2023 at 21:37, Thomas Gleixner wrote:
> On Thu, Apr 06 2023 at 00:19, Frederic Weisbecker wrote:
>> We could arrange for doing the same thing as hrtimer_cancel_wait_running()
>> but for posix cpu timers, with taking a similar lock within
>> handle_posix_cpu_timers() that timer_wait_running() could sleep on and
>> inject its PI into.
>
> I have a faint memory that we discussed something like that, but there
> was an issue which completely escaped my memory.

Now memory came back. The problem with posix CPU timers is that it is
not really known to the other side which task is actually doing the
expiry. For process wide timers this could be any task in the process.

For hrtimers this works because the expiring context is known.

> But yes, something like this could work.

Needs some more thought, but still can be made work.

> Though we should quickly shut this warning up for the !RT case by
> providing an callback which does
>
>   WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT);
>
> and let the RT folks deal with it.

OTOH, this is not only a RT issue.

On preemptible kernels the task which collected the expired timers onto
a local list and set the firing bit, can be preempted after dropping
sighand lock. So the other side still can busy wait for quite a while.
Same is obviously true for guests independent of preemption when the
vCPU gets scheduled out.

Thanks,

        tglx


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5A5F4262
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJDLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJDLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:51:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF974E861
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:50:55 -0700 (PDT)
Date:   Tue, 4 Oct 2022 13:50:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664884253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onb90q9L5H6X7W0l7Dl1yguaYppoinyJV9qx5QYpuRE=;
        b=jSNylEiloctqRfQwltkBEdHeLSkcp6e2xFqZWjICKrKhedsetTgb51NdK+fn0hMsiu9BR8
        H42hkVKobgMyMazf1sY+8/FPqCiRMz8htPbeaqSQ+6ScyRiF6tvbgviaV66N075pjAkYcD
        6ka2oSjfiWSRIVk85w/uKuRiprt7w8dZSby5NjEDJvQY4WTgGm0lKx/qbOwoxzK/MASMg9
        OaokKG03llFDttov1fuzWAX7cXMXG8kEieTtQWe/jybz7rN9kBB+Bnr3we8fpG/Ne/qlM6
        4uR1+xpEqgxE90lH9PmQFKKFCdF1fCby0eFaVYdA6oNDFjh5BcgZPgFFyF9GfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664884253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onb90q9L5H6X7W0l7Dl1yguaYppoinyJV9qx5QYpuRE=;
        b=M4Ey4Cyk8N+lnff8fTE4QGnRMeGXgUK+vfDMdD4XJt6g06lsMomlwNh/3Y/XEIcJl2M3EY
        UhFc7vXaCdXNJ5AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Sum of weights idea for CFS PI
Message-ID: <YzweGw5l3HxQVcGN@linutronix.de>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30 13:34:49 [-0400], Joel Fernandes wrote:
> In this case, there is no lock involved yet you have a dependency. But I =
don't
> mean to sound depressing, and just because there are cases like this does=
 not
> mean we should not solve the lock-based ones. When I looked at Android, I=
 saw
> that it uses futex directly from Android Runtime code instead of using pt=
hread.
> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what=
 we do
> in the kernel will JustWork(Tm) ?

The easy part is just to replace the lock/unlock functions with
FUTEX_LOCK_PI/UNLOCK_PI syscalls. The slightly advanced part is where
you use an atomic operation to replace 0 with threads's ID in the lock
path to avoid going into the kernel for locking if the lock is not
contended. If it is, then you need to use the syscall.

=E2=80=A6
> > Proxy execution seems to be the nice solution to all of these problems,=
 but
> > it's a long way away. I'm interested to learn how this inheritance will=
 be
> > implemented. And whether there are any userspace conversion issues. i.e=
: do
> > we need to convert all locks to rt-mutex locks?
>=20
> I am not an expert on FUTEX_LOCK_PI and this could be a good time for tgl=
x to
> weigh in, but I think converting all userspace locks to use FUTEX_LOCK_PI=
 sounds
> reasonable to me.

Based on my understanding with proxy-execution, all in-kernel locks
should be covered.
Priority inheritance (PI) works only with FUTEX_LOCK_PI for userpace and
rtmutex for the in-kernel locks. Regular FUTEX_LOCK does only wait/wake
in userspace so there is no way for the kernel to "help". Ah and for PI
to work you need priorities that you can inherit. With two threads
running as SCHED_OTHER there will be just "normal" sleep+wake in the
kernel. If the blocking thread is SCHED_FIFO then it will inherit its
priority to the lock owner.

> Other thoughts?
>=20
> thanks,
>=20
>  - Joel

Sebastian

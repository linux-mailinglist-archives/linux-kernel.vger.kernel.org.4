Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B007468C26E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBFQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:04:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C51172F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:04:11 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:04:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675699449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjCO6CQsOWM3FcKl9zFN/LO3PfSuVj2mpPbOEMGSBpo=;
        b=OggRWWAgSAK8HGF5CgG/G1NtwPARnKC9dq44Vn0edbsyrNByyGZWUx1hrJqTWNbqchNC7C
        ssruuUx6WLs5m9wo//3227HJQIDfOf1KXhK47ZYw7Rm/GtpLv7oY8AwfGqoR0xQ7WNNw55
        7QT5hNVsjUQ8T5MG/MppaZhB9xPQsHOVO5Vj9bsgnGkLou5qt7LwQsFx/dfzBHXLujo1tI
        /72DxuQj7C+BzUFg5eXiPZctgP9mJUpnH3ElFZASn8lcpRCzZIMgic5K/2FY0MkJrv+YCd
        WgVW7aIxfBcGpnjqUOBuYgpWGQv6HXiIRVP/Hz15YK+G4J55uxVdujd5EezHAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675699449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjCO6CQsOWM3FcKl9zFN/LO3PfSuVj2mpPbOEMGSBpo=;
        b=Id6lNKpZ5BYmVKFlSN79U3SEecI/m0akuKJDwqPB97lUxbAUuxL7vItrbaMBSvhoJXUgng
        42xMFdAxsPYYWNAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <Y+Ek98n1xUhTP+8a@linutronix.de>
References: <20230206130449.41360-1-wander@redhat.com>
 <Y+EVNz4ORkFSvTfP@linutronix.de>
 <20230206152712.GA1487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230206152712.GA1487@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 16:27:12 [+0100], Oleg Nesterov wrote:
> On 02/06, Sebastian Andrzej Siewior wrote:
> >
> > On 2023-02-06 10:04:47 [-0300], Wander Lairson Costa wrote:
> >
> > > @@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk)
> > =E2=80=A6
> > > +void __put_task_struct(struct task_struct *tsk)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
> >
> > Is it safe to use the rcu member in any case?
>=20
> I thinks it is safe but deserves a comment. I guess Wander misunderstood
> me when I asked him to do this...
>=20
> __put_task_struct() is called when refcount_dec_and_test(&t->usage) succe=
eds.
>=20
> This means that it can't "conflict" with put_task_struct_rcu_user() which
> abuses ->rcu the same way; rcu_users has a reference so task->usage can't
> be zero after rcu_users 1 -> 0 transition.

Sounds good.

> > If so why not use it
> > unconditionally?
>=20
> performance ?

All the free() part is moved from the caller into rcu.

>=20
> And... I still don't like the name of delayed_put_task_struct_rcu() to me
> ___put_task_struct_rcu() looks a bit less confusing, note that we already
> have delayed_put_task_struct(). But this is minor.

So if we do it unconditionally then we could get rid of
put_task_struct_rcu_user().
Otherwise we could use put_task_struct_rcu_user() in that timer
callback because it will lead to lockdep warnings once printk is fixed.

> Oleg.
Sebastian

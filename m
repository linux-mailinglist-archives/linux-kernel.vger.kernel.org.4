Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9769DC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjBUIr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBUIrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:47:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD4234E9;
        Tue, 21 Feb 2023 00:47:23 -0800 (PST)
Date:   Tue, 21 Feb 2023 09:47:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676969242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ifHJbagiL5YEhYtLCRPf3BHvO+fc4Ql1bGPL7SfJQg=;
        b=nqdf/4jn7+lWx16zM1bED3vFcRF/5G5eCKGlID/rOFCwWfXOSQKaSy0TH6SIvHe8bm996A
        YJZjYVY1enUn/xYt3S6JA/DILq7xCH8vgx25rWxVVRRAZfa2Qsp9JphtO+hephshjzJG8d
        YPK+KkcC4wiMVyyTKvw7gsx7ryeqY/AJqCGHOZxjClD7KB8+Gf9Gsc/NnH6eQ/shpDLbAA
        59DW58WKV5NLU4Yy/Jfj25hdjsVt+KhXpVVAFwwBswhNQTxX8ct85ChAfgS386OGd+sXNJ
        /6jPqzVKwqkHQ6gBitJaqjd24h76JARp0FVtL9sml7apHVkcimlrUeq9XhMeKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676969242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ifHJbagiL5YEhYtLCRPf3BHvO+fc4Ql1bGPL7SfJQg=;
        b=94MONM7HSBIAiimj4nW3tsCZLMWQBsl9BD1FtJRDiva56JZrypdTnAShA6lO2qPGMS7xXF
        am41Jy2SHt7VFYAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] locking/rwbase: Mitigate indefinite writer starvation
Message-ID: <Y/SFGM29TXAumoTZ@linutronix.de>
References: <Y+0W0wgyaJqYHKoj@linutronix.de>
 <877cwbq4cq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <877cwbq4cq.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-21 00:55:33 [+0100], Thomas Gleixner wrote:
> On Wed, Feb 15 2023 at 18:30, Sebastian Andrzej Siewior wrote:
> > diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> > index 1d264dd086250..b969b1d9bb85c 100644
> > --- a/include/linux/rwbase_rt.h
> > +++ b/include/linux/rwbase_rt.h
> > @@ -10,12 +10,14 @@
> > =20
> >  struct rwbase_rt {
> >  	atomic_t		readers;
> > +	unsigned long		waiter_timeout;
>=20
> I'm still not convinced that this timeout has any value and if it has
> then it should be clearly named writer_timeout because that's what it is
> about.
>=20
> The only reason for this timeout I saw so far is:
>=20
> > +/*
> > + * Allow reader bias with a pending writer for a minimum of 4ms or 1 t=
ick. This
> > + * matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
>=20
> Clearly RT and !RT have completely different implementations and
> behaviour vs. rwsems and rwlocks. Just because !RT has a timeout does
> not make a good argument.
>=20
> Just for the record: !RT has the timeout applicable in both directions
> to prevent writer bias via lock stealing. That's not a problem for RT
> because?

Once the writer got the lock, then all further reader and writer queue
up on rtmutex and will be processed one after the other. It only becomes
a problem once a writer with elevated priority acquires the lock
repeatedly to the point that tasks with lower priority starve.

> Can we finally get a proper justification for this?

Avoid writer starvation caused by having at least one reader in the
critical section all the time blocking the writer to make any progress.
Reader starvation is not an issue because all tasks line up on the
rtmutex and will be processed in FIFO order.
Tasks with elevated priority will be preferred and can lead starvation
of the tasks with lower priority. This is by design and can happen with
other lock types, too.

> > @@ -264,12 +285,20 @@ static int __sched rwbase_write_lock(struct rwbas=
e_rt *rwb,
> >  		if (__rwbase_write_trylock(rwb))
> >  			break;
> > =20
> > +		/*
> > +		 * Record timeout when reader bias is ignored. Ensure timeout
> > +		 * is at least 1 in case of overflow.
> > +		 */
> > +		rwb->waiter_timeout =3D (jiffies + RWBASE_RT_WAIT_TIMEOUT) | 1;
> > +
>=20
> So this has two sillies:
>=20
>    1) It resets the timeout once per loop which is plain wrong
>=20
>    2) The "| 1" is really a sloppy hack
>=20
> Why not doing the obvious:

Sure. Let me look at this once we agreed on the justification.

=E2=80=A6
> Thanks,
>=20
>         tglx
Sebastian

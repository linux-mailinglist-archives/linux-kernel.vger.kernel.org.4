Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EEF5ED88D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiI1JNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiI1JMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:12:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C398A43
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:11:58 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:11:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664356314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bzqdpid2WywEoy1uq9VaBpqfQyNiF5s61b4BwqVJFI=;
        b=CWR0s3kTknIFxCjpH0jMsnyRWvRDJQHWhvTTWn4/vSD4mbPX3mwHTgYMneE3OTDYhhod9e
        ag6B1x14DfciG6+jpQyQB4jazRO7mOIypGfSpemJR8g+q+RKvk1LRe4JzDvDBVDxKT7LMP
        UK6sDdCSaJiJMPprtHdJuKBoaFgvMsB53BMZT8W7l5SDdglRMhVja0TnxPVIcpW0vspKU1
        LEJn5b+GKzIJN0G8WBJa5a0sLdoV40IUcR/zKxfqAkfXF56bz4XxjlFsLimUCobGvXoB8r
        Z5baI/WWCZkpouBvScvkCkOTw3g7+bJ9rpwfcZ4/9XNPMcobGNVa7vxFmDpigg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664356314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bzqdpid2WywEoy1uq9VaBpqfQyNiF5s61b4BwqVJFI=;
        b=Rb4Ith7+CKRliXzYISqczpzZQe6jBxjUo71xPpyW8UZElwXBpOYbyFkkEHOrfQrloDsk18
        wPfi4dhf6FAkxNDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YzQP2OEVKgWtwsD4@linutronix.de>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-3-bigeasy@linutronix.de>
 <YzMnb8NWlCpqsqSG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YzMnb8NWlCpqsqSG@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 18:40:15 [+0200], Petr Mladek wrote:
> Another advantage is that it removes a nested lock from the printk()
> code path. A deadlock was partly prevented by the trylock. But there was
> still a risk of a deadlock when printk() was called under base_crng.lock.

Okay.

> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index bce63cbf23779..44b39ba56b796 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
=E2=80=A6
> I have tried it and system_wq works well here. It actually
> even initializes the hash earlier here. But it is only by chance
> because it happens on the 2nd attempt instead of 3rd one.

Yeah. I added a reschedule of two seconds since it looked okay and I
didn't want to do very often. I have an old box where it takes ~12 secs
to setup and here it is the fifth attempt on average. (Before the rework
it needed way longer to initialize).

> > +		return;
> > +	}
> > +
> > +	get_random_bytes(&ptr_key, sizeof(ptr_key));
> > +
> > +	/* Pairs with smp_rmb() before reading ptr_key. */
> > +	smp_wmb();
> > +	WRITE_ONCE(filled_random_ptr_key, true);
> > +}
>=20
> With "system_wq":
>=20
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>=20
> I could replace "system_unbound_wq" with "system_wq" when
> pushing. Is anybody against it, please?

so schedule_delayed_work() then?
I don't mind at all. I used that one just because serialisation is not
needed and neither is the CPU important.

If you are going to replace it, then I am not going to send an update
(unless I'm old otherwise).

> I am sorry that I have missed it when looking at the previous
> version.

No worries.

> Best Regards,
> Petr

Sebastian

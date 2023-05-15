Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB9702CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbjEOMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbjEOMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:42:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0BA2D7C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:41:37 -0700 (PDT)
Date:   Mon, 15 May 2023 14:41:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684154495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgnJRr+6tGl+ERH0LB9f8Zux5UNbJl7YXqeiYA/30IE=;
        b=oKZwlskCvODDO+onukDmXNxXzcEM3URrTRcl2AthHNxatCIY+CoysWqDqANSNkHOp8nks9
        /cH1LEWU6sQERzNJhO0nKJuTfM0utzDcxo9DdmC2/Wp2pq3cTgigp75NNQHLXKfQt1vFt7
        3uz800KdHxTmfY9QuATeUFW+28DF4gi2LvzDf7NOTX/YvxXlhv7Fe6vH4Iz6n3kS7es/hf
        lr2h59YrYF4jzheRni8EmX/XO/nHJ4wp2oY+U7AOtXlVlYts5ElLOmb7jLor6mEgs8rUZz
        WSKhnc3I7pmt+yskDAef27rY7RZjNYnCPyVNMsM+WH+p5PqCR5AIcZxdaFsKDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684154495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgnJRr+6tGl+ERH0LB9f8Zux5UNbJl7YXqeiYA/30IE=;
        b=B/4eP7Y7N/fOcO94f9BeJYY3w7EBFS6G91vB6zua+Sm0NDchJcXUH0Vvl47vb7DkNpeYuF
        1YiqdAkxAN1dptBw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <20230515124133.XkKOksjW@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
 <ZFty1fNMlnuLk4qF@localhost.localdomain>
 <20230515101936.3amAvw0T@linutronix.de>
 <398d7731-f5ca-a34-9e4-77da60c49d21@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <398d7731-f5ca-a34-9e4-77da60c49d21@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-15 12:50:25 [+0200], Anna-Maria Behnsen wrote:
> The part will be replaced by:
>=20
> ---8<----
>=20
> 	local_irq_disable();
> 	timer_lock_remote_bases(cpu);

Do you s/raw_spin_lock_irq/raw_spin_lock/ in timer_lock_remote_bases()?
Otherwise you disable interrupts twice. Not wrong but not needed.

> 	raw_spin_lock(&tmc->lock);
>=20
> 	if (!tmc->online || !tmc->idle) {
> 		timer_unlock_remote_bases(cpu);
> 		goto unlock;
> 	} else {
> 	        fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
> 	}
>=20
> 	timer_unlock_remote_bases(cpu);

The locking, unlocking and fetch_next_timer_interrupt_remote() is only
used here. So it if it wouldn't be for tmc-> then you could do
everything timer.c in once place=E2=80=A6

> 	-> do the preparation and the walk
>=20
> unlock:
> 	raw_spin_unlock_irq(&tmc->lock);
>=20
> ---8<----
>=20
> As menitoned in the reply last week to Frederics objections regarding the
> locking asymmetry, I would like to keep it to make the locking region of
> timer base locks as small as possible and to prevent holding up to five
> locks during the walk.

This looks okay. I wouldn't suggest to hold the timer_base::lock or
tmigr_cpu::lock longer than needed. Both can be acquired independently
cross CPU and have explicit locking order. So it is fine.

> Thanks,
>=20
> 	Anna-Maria

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEB6E4D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjDQPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjDQPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:34:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489145276
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:34:34 -0700 (PDT)
Date:   Mon, 17 Apr 2023 17:34:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681745671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VL7dg9uo2qhScoy6sa9a+uqebfUngJJARNadBOtXDoQ=;
        b=MyFDFAnKFmcE6BWm2qSE06JHe1DgiikAVv8A+du58YjOLvDHet5z5sQtZyqepgcYOEb/+9
        tPrKEQ6OOCSxD+KCc6+W6SSa+aoBUG9R3oLgk4VV50U8uSCSY+PP3N8jVUyvKKqLlqFyMB
        ga8Zl8unmHX/+MXQlCmRrwhnBMzvJSOnlvVTZD0s0ZLAMprfzA66M2oaD2nWNCa625VBI5
        CaAzlAg/79J90xwpWDyV3e96KzE/mYeyee0tkM5ZU3+o2vOTunQ1lXrWBdOeTK9K5FLSN/
        zr1O13yJAk8xPbjWzaH31/k51lBGL2ZVTvW6r9E1Ie/OhzdtC1lOh0J0t25YGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681745671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VL7dg9uo2qhScoy6sa9a+uqebfUngJJARNadBOtXDoQ=;
        b=RmM9hLHZkdvq2/sLLIbPuc5i8fpKA2ftpzbC3aX+bEN0MoZ4gmCz9U4ipMoFzcwswz8rKL
        lCU90qPqj3ubHkDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] posix-cpu-timers: Implement the missing
 timer_wait_running callback
Message-ID: <20230417153429.SGsy36RL@linutronix.de>
References: <87h6tsred7.ffs@tglx>
 <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen>
 <87lej3twhv.ffs@tglx>
 <ZDBin2ZQwc69hGX4@lothringen>
 <87ile7trv7.ffs@tglx>
 <CANpmjNOFxGa6iuVbzVcXPyWO-6Zmd=edhatmDBHPKcZ-au35dg@mail.gmail.com>
 <87zg764ojw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87zg764ojw.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-17 15:37:55 [+0200], Thomas Gleixner wrote:
=E2=80=A6
>=20
> Reported-by: Marco Elver <elver@google.com>
> Fixes: ec8f954a40da ("posix-timers: Use a callback for cancel synchroniza=
tion on PREEMPT_RT")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I didn't manage to trigger the warning via timer-warn.c, does not cause
any problems as far as I can see.

Sebastian

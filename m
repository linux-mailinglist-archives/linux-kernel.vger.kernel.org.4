Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C735BB1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIPSL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIPSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:11:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24641AB184
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:11:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h194so16316532iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=MqXEURyLnpmL3G43dGeg3N/8zDnGsAGL3mOe1kcuvho=;
        b=CLz9mygkk22dS6Zysvq67YjGUob2U2cPE9UZq2PGUL07eySSV82cgbacNTFBHiKehc
         03zux8CUm/9XDwT8g5lbrTOSt/uLOTn8VlBOvMWYOIpjrsl5CZF9LQiOoR2juWxYj8g6
         c2CktvmHV6bzcNOl+ra684/vT0uWo5P+AI1A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MqXEURyLnpmL3G43dGeg3N/8zDnGsAGL3mOe1kcuvho=;
        b=Ff1OBmxNBa7Dz3JqZbky4ubjPiIQueO+ijl7hGB6+SyvXuE8oZS8pznq2F10OQbQPN
         M8N0fUkokX/Y2mX9bIbyD2vQBn27F6d13t4+iIK+HbkBn0Ja2Y8Zv+BZIHz02N/dWGiC
         50B3K9apzvZFlv73lA4wYW2Flfk659rU/SMYdOcCZiPlWo4kYpKqZfcYtT2i/7Hto4Tv
         unVbEyulEbGAw9SfXHDwOHsiXzgs4kk+Z6tN3vMxv5WA3ApteVn0i0621gZ2BFIzd6zf
         HmGmh8Qxo/AxmA+MUjV0peQy0lAPwHFlWf2namheMvCdqJLk671aVqQmiS970FIPiDsD
         kQXg==
X-Gm-Message-State: ACrzQf20Aao8nYuSgObax9LMI0l2uNS8oVcUeZEhBj6bJq31l3juxRcL
        dF8zbmnRLk+uCmcJE/Q5Q0HAF8V5umQEWtyw1QPEoA==
X-Google-Smtp-Source: AMsMyM5xt+1XNtpGt15WPYuaOUG8TAbossPcoZfNedS+xRkp7vr0QS1phTSKLTsv9pfes4Et9zQ7cJYt1uTvF2qszYM=
X-Received: by 2002:a05:6638:2391:b0:35a:19da:f05f with SMTP id
 q17-20020a056638239100b0035a19daf05fmr3064144jat.232.1663351882449; Fri, 16
 Sep 2022 11:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1> <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1> <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1> <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
In-Reply-To: <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 16 Sep 2022 14:11:10 -0400
Message-ID: <CAEXW_YTN7mnQSN2eJCysLsZOq+8JEOV6pvgw3LDTT=0mnkC2SA@mail.gmail.com>
Subject: Re: RCU vs NOHZ
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Sep 16, 2022 at 5:20 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
[...]
> > It wasn't enabled for ChromeOS.
> >
> > When fully enabled, it gave them the energy-efficiency advantages Joel
> > described.  And then Joel described some additional call_rcu_lazy()
> > changes that provided even better energy efficiency.  Though I believe
> > that the application should also be changed to avoid incessantly openin=
g
> > and closing that file while the device is idle, as this would remove
> > -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
> > use cases would likely remain.
>
> So I'm thinking the scheme I outlined gets you most if not all of what
> lazy would get you without having to add the lazy thing. A CPU is never
> refused deep idle when it passes off the callbacks.
>
> The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
> and do our utmost bestest to move work away from it. You *want* to break
> affinity at this point.
>
> If you hate on the global, push it to a per rcu_node offload list until
> the whole node is idle and then push it up the next rcu_node level until
> you reach the top.
>
> Then when the top rcu_node is full idle; you can insta progress the QS
> state and run the callbacks and go idle.

In my opinion the speed brakes have to be applied before the GP and
other threads are even awakened. The issue Android and ChromeOS
observe is that even a single CB queued every few jiffies can cause
work that can be otherwise delayed / batched, to be scheduled in. I am
not sure if your suggestions above address that. Does it?

Try this experiment on your ADL system (for fun). Boot to the login
screen on any distro, and before logging in, run turbostat over ssh
and observe PC8 percent residencies. Now increase
jiffies_till_first_fqs boot parameter value to 64 or so and try again.
You may be surprised how much PC8 percent increases by delaying RCU
and batching callbacks (via jiffies boot option) Admittedly this is
more amplified on ADL because of package-C-states, firmware and what
not, and isn=E2=80=99t as much a problem on Android; but still gives a nice
power improvement there.

thanks,

 - Joel

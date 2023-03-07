Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864316AF68E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjCGUTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCGUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:19:38 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5C9F21D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:19:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y14so14462564ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678220376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkmQMMVPk+Yw2dJvu0OIfKDhJCjSC2uwhQ9BCPbLMRM=;
        b=Cv4ZAfemJq1Kf23D1q4pD9QCoWgvXTvKioLVvf6QRV476xgTviy1A8jfX6i/MuKcTG
         07ljd0ZeAobPxPH7w34+KHbf7Emxw8TmHanBwMKawkrGDN1P61LKltqYOu99Gb4/M39n
         Zc/+Bke3yXJ1TdO4UHDfKLD4wJEQ25t9IWCII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678220376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkmQMMVPk+Yw2dJvu0OIfKDhJCjSC2uwhQ9BCPbLMRM=;
        b=j80X6shb0/o7gj0Ib0sz07/TOP08Nww5OKrfObmYw0eBVuXAPo7tC1SmlLZRqSZR+1
         UxrqwQTcJv/9/a2Jay9hQM9wLRZIq0KEJan9XvM7G78zQIlUox2gtN6PJSUPw6ODtiYU
         Ha5uEqsJJbtfv5vPQpWlPzAj61v8J0VPn//pBqyq63XZLbQ83fW/62MH42Pq5sxwYIFU
         /dqFAwtt1b+FglTW8l9YCsXn4GYw3ZWj1NjTJBitIFbQ3cPNTgM99LUipltEWiIa8PTL
         c9abRgh+MejOZm6w3ivyhITtTtbJxyiVKHw4GoaZubpIPyQxk2Q7d5v8fZVixC7S4qqg
         RLPw==
X-Gm-Message-State: AO0yUKVgU1Hypfy5f3VwoKp7dGL/E1VmSDkJd6tSOh+W9LnGNk6OUG3H
        2gIqmSvaTqaw8cxswGwUTBgzlvJBs/TdxNKiCVo5dA==
X-Google-Smtp-Source: AK7set9+7DnQMZwVOMzXdjeZI9hX7a6VUXv1CvLxMLPN/QRU4Z2rnY6NBb89+grK/YBpa92EeG+34OJzNcvbYC9j34Y=
X-Received: by 2002:a2e:b94a:0:b0:293:39fe:b712 with SMTP id
 10-20020a2eb94a000000b0029339feb712mr4789273ljs.3.1678220375823; Tue, 07 Mar
 2023 12:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com> <20230302082414.77613351@gandalf.local.home>
 <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home> <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home> <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home> <20230303181134.GA1837196@google.com>
 <20230307140858.GE2017917@hirez.programming.kicks-ass.net>
In-Reply-To: <20230307140858.GE2017917@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Mar 2023 15:19:23 -0500
Message-ID: <CAEXW_YQY64XdhuxYuwqBkeYQFKTt4yDyHwUfBip4hf+A83mL-g@mail.gmail.com>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 9:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Mar 03, 2023 at 06:11:34PM +0000, Joel Fernandes wrote:
> > What  makes the rtmutex spin logic different from normal mutex in this
> > scenario, so that rtmutex wants to do that but normal ones dont?
>
> Regular mutex uses osq 'lock' to serialize waiters and only the top
> spinner gets to spin on the mutex itself, this greatly reduces the
> contention on the mutex.
>
> OSQ is FIFO, which is not what RT-mutex needs.

Got it, so basically OSQ ensures fairness as its FIFO and also reduces
lock contention because I am guessing the OSQ-spinners are spinning on
a per-spinner MCS node (that per-CPU optimistic_spin_node it appears).

This makes perfect sense now, thank you Peter!!!


 - Joel

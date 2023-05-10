Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6746FDF04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjEJNr6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 09:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjEJNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:47:53 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570BE449C;
        Wed, 10 May 2023 06:47:24 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a8019379fso67188277b3.0;
        Wed, 10 May 2023 06:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726430; x=1686318430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsvbCwwIGv4dAIbBM02PnYE01RolXqtsmvWU0E9eNRk=;
        b=jmB2YYUS0hRXfIEBYkN3my+TfTVmkiqj07hlSZZXMxEKYAZRJRzOv13c5MmLUH2UwR
         w7fQ9w8GgCOVry4Pjgfu8/IXfN/jWF5Pyq/Opwue8R3UH/xf7HtyQ2CVXFy7kOBBJW46
         vNKhGgqSfZUvqLDtKf8THVIeA2xIevsY5IhU/NTCwiAbGc1ViSckFf8HDwaJrmum+uJW
         XF23I/pRlgsVc3OWPvvK+zy3p//97MgZUK5IiB0PaVkfyQ2JA6Vo2lX6AuED5iAo96u6
         sD9lYnC8F05rfUpsnOMPGThZruyTCbUpS0u2mhIcqAft7JJ+7Y5yNGq5kR+S88yuVqhp
         ByzQ==
X-Gm-Message-State: AC+VfDxp+l0ONyI05s3Z3clF8/rN+yHe5IVQuYD+VwDKZLpnkrtRhfla
        oUj0egyfG8hzx2OpyDEKdy2j8PnHsvJ59Q==
X-Google-Smtp-Source: ACHHUZ7V9poDkTGqNR7uVc53kNrwN1umkv4zjUS2A20wMoCEcHPBPYTQSu8Um2rwSE4OowDfC2h4Nw==
X-Received: by 2002:a25:54b:0:b0:b99:f279:10dc with SMTP id 72-20020a25054b000000b00b99f27910dcmr17719598ybf.28.1683726430167;
        Wed, 10 May 2023 06:47:10 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 130-20020a250888000000b00ba1a0346360sm3743231ybi.13.2023.05.10.06.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 06:47:09 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b9a6d9dcbebso6359671276.2;
        Wed, 10 May 2023 06:47:08 -0700 (PDT)
X-Received: by 2002:a25:c74c:0:b0:b95:9b76:34a5 with SMTP id
 w73-20020a25c74c000000b00b959b7634a5mr16457612ybe.64.1683726428473; Wed, 10
 May 2023 06:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
 <02ce0541-08cf-4e14-a9b1-c53efea85178@app.fastmail.com>
In-Reply-To: <02ce0541-08cf-4e14-a9b1-c53efea85178@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 May 2023 15:46:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUg0gk3QUmC+OiBDQuZAWdJ2cbPpwaDX+TGoq1EPO1v-A@mail.gmail.com>
Message-ID: <CAMuHMdUg0gk3QUmC+OiBDQuZAWdJ2cbPpwaDX+TGoq1EPO1v-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, May 10, 2023 at 3:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 10, 2023, at 15:23, Geert Uytterhoeven wrote:
> > read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> > feature, just like its non-atomic counterpart.  However, there are
> > several issues with this, due to its use in atomic contexts:
> >
> >   1. When called in the s2ram path (as typically done by clock or PM
> >      domain drivers), timekeeping may be suspended, triggering the
> >      WARN_ON(timekeeping_suspended) in ktime_get():
> >
> >       WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_get+0x28/0x78
> >
> >      Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
> >      rid of that warning.  However, that would break timeout handling,
> >      as (at least on systems with an ARM architectured timer), the time
> >      returned by ktime_get_mono_fast_ns() does not advance while
> >      timekeeping is suspended.
> >      Interestingly, (on the same ARM systems) the time returned by
> >      ktime_get() does advance while timekeeping is suspended, despite
> >      the warning.
> >
> >   2. Depending on the actual clock source, and especially before a
> >      high-resolution clocksource (e.g. the ARM architectured timer)
> >      becomes available, time may not advance in atomic contexts, thus
> >      breaking timeout handling.
> >
> > Fix this by abandoning the idea that one can rely on timekeeping to
> > implement timeout handling in all atomic contexts, and switch from a
> > global time-based to a locally-estimated timeout handling.  In most
> > (all?) cases the timeout condition is exceptional and an error
> > condition, hence any additional delays due to underestimating wall clock
> > time are irrelevant.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This looks reasonable to me,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> I assume you sent this because you ran into the bug on a
> particular driver. It might help to be more specific about
> how this can be reproduced.

I first ran into it when converting open-coded loops to
read*_poll_timeout_atomic().
Later, I also saw the issue with the existing
read*_poll_timeout_atomic() calls in the R-Car SYSC driver, but only
after applying additional patches from the BSP that impact the moment
PM Domains are powered during s2ram.
The various pointers to existing mitigations in the cover letter should
give you other suggestions for how to reproduce...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

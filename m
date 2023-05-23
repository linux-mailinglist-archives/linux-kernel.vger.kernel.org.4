Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76A70D541
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjEWHhO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjEWHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:36:43 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6051BB;
        Tue, 23 May 2023 00:35:36 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ba82956d3e0so6567097276.0;
        Tue, 23 May 2023 00:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684827335; x=1687419335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+dC08pX0/tIIqa2IQ59EpZ+jAMVvJj02nvq1d4VL18=;
        b=X9ZHL/bniT61HdavOItx+T1WIquKJrexE+DFjGxu/p6nlPWX3NuBK3onVOvHX8sNW1
         hs+KmnluB2DuJBlZg5BGRYPDKalmMA+k7GRhj8nKYXdbj3AG5KcDxEmL5oboc7XW5tHB
         X1wpDylGO6k7A69xLe7gg6w9UZEUw6E6L5+DoO3pIdifvXNaalj2FeR+GbegYS8M8m2E
         a6HA2lQoplGz0uXwfaxIYmHBJYWZpWYD6SYZ87wKjDOc0cG8b1sbiGiRBP0TdpnXQy5X
         8U41Yw+bltCQlEoQ7WZuopOU5PWnzZQSsCLvEL9KSUkdMK2jC+UmLomb9RQyH8R0U8/S
         dUxA==
X-Gm-Message-State: AC+VfDxjRd0JEXdsnnguebfWS6VZwDc02Jt3GIcfezn9s4wyFbEmWzYW
        S7zOfVGW/Pa1E+iRubBi0sJSyQj0R/U/dg==
X-Google-Smtp-Source: ACHHUZ63dGDl+mcVAAI9TRP8BVbsNuq+ha2aSaR+g1PrhopXLYfg/alKwcZYYasC6CmbR787jepwcA==
X-Received: by 2002:a25:328e:0:b0:b9d:88a7:dbf with SMTP id y136-20020a25328e000000b00b9d88a70dbfmr14953535yby.4.1684827335335;
        Tue, 23 May 2023 00:35:35 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id c12-20020a25880c000000b00ba7da8f72ebsm1946195ybl.0.2023.05.23.00.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:35:34 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ba8cf3cb34fso6554631276.1;
        Tue, 23 May 2023 00:35:34 -0700 (PDT)
X-Received: by 2002:a25:211:0:b0:b25:a1e1:5b65 with SMTP id
 17-20020a250211000000b00b25a1e15b65mr13676838ybc.5.1684827004960; Tue, 23 May
 2023 00:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683722688.git.geert+renesas@glider.be> <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
 <20230511064839.GG14287@atomide.com> <494a000774b546e4aae00ae0a7dfeae4@AcuMS.aculab.com>
In-Reply-To: <494a000774b546e4aae00ae0a7dfeae4@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 May 2023 09:29:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXttS3mkA+BNC69e6MYniRyGtR2vde35BYgBZ_+SuYs_Q@mail.gmail.com>
Message-ID: <CAMuHMdXttS3mkA+BNC69e6MYniRyGtR2vde35BYgBZ_+SuYs_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
To:     David Laight <David.Laight@aculab.com>
Cc:     Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, May 11, 2023 at 12:49 PM David Laight <David.Laight@aculab.com> wrote:
> > * Geert Uytterhoeven <geert+renesas@glider.be> [230510 13:23]:
> > > It is considered good practice to call cpu_relax() in busy loops, see
> > > Documentation/process/volatile-considered-harmful.rst.  This can not
> > > only lower CPU power consumption or yield to a hyperthreaded twin
> > > processor, but also allows an architecture to mitigate hardware issues
> > > (e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
> > > architecture-specific cpu_relax() implementation.
>
> Don't you also need to call cond_resched() (at least some times).
> Otherwise the process can't be pre-empted and a RT process
> that last ran on that cpu will never be scheduled.

According to [1], cond_resched() must be called at least once per few
tens of milliseconds.

read_poll_timeout() uses usleep_range(), which calls schedule_hrtimeout_range().
read_poll_timeout_atomic() should not be used with multi-ms timeouts anyway.

So I guess we're OK?

[1] https://elixir.bootlin.com/linux/latest/source/Documentation/RCU/Design/Requirements/Requirements.rst#L2348

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

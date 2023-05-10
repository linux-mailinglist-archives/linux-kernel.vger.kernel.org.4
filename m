Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82A6FDE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjEJNXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjEJNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:23:40 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E95BAE
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:23:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:cc75:d8ef:4074:8af9])
        by michel.telenet-ops.be with bizsmtp
        id v1PG290093l7qvk061PGka; Wed, 10 May 2023 15:23:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwjme-001nDj-DC;
        Wed, 10 May 2023 15:23:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwjmm-00F6qH-2e;
        Wed, 10 May 2023 15:23:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Stephen Boyd <sboyd@kernel.org>,
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
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] iopoll: Busy loop and timeout improvements
Date:   Wed, 10 May 2023 15:23:12 +0200
Message-Id: <cover.1683722688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

When implementing a polling loop, a common review comment is to use one
of the read*_poll_timeout*() helpers.  Unfortunately this is not always
possible, or might introduce subtle bugs.  This patch series aims to
improve these helpers, so they can gain wider use.

  1. The first patch improves busy-looping behavior of both the atomic
     and non-atomic read*_poll_timeout*() helpers.
     The issue addressed by this patch was discussed before[1-2], but I
     am not aware of any patches moving forward.

  2. The second patch fixes timeout handling of the atomic variants.
     Some of the issues addressed by this patch were mitigated in
     various places[3-5], and some of these findings may of interest to
     the authors of [6-8].

The first patch was sent before, and already received some acks, but I
hadn't queued it yet as a depedency for more read*_poll_timeout*() use,
because I ran into the issue fixed by the second patch.

Changes compared to v1[9]:
  - Add Acked-by,
  - Add compiler barrier and inlining explanation (thanks, Peter!),
  - Add patch [2/2].

Thanks for your comments!

[1] "Re: [PATCH 6/7] clk: renesas: rcar-gen3: Add custom clock for PLLs"
    https://lore.kernel.org/all/CAMuHMdWUEhs=nwP+a0vO2jOzkq-7FEOqcJ+SsxAGNXX1PQ2KMA@mail.gmail.com
[2] "Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
    PLL set_rate ops"
    https://lore.kernel.org/all/20200811164628.GA7958@kozik-lap
[3] b3e9431854e8f305 ("bus: ti-sysc: Fix timekeeping_suspended warning
		       on resume")
[4] 44a9e78f9242872c ("clk: samsung: Prevent potential endless loop in
		       the PLL ops")
[5] 3d8598fb9c5a7783 ("clk: ti: clkctrl: use fallback udelay approach if
		      timekeeping is suspended")
[6] bd40cbb0e3b37a4d ("PM: domains: Move genpd's time-accounting to
		       ktime_get_mono_fast_ns()")
[7] c155f6499f9797f2 ("PM-runtime: Switch accounting over to
		       ktime_get_mono_fast_ns()")
[8] 15efb47dc560849d ("PM-runtime: Fix deadlock with ktime_get()")

[9] https://lore.kernel.org/r/8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be/

Geert Uytterhoeven (2):
  iopoll: Call cpu_relax() in busy loops
  iopoll: Do not use timekeeping in read_poll_timeout_atomic()

 include/linux/iopoll.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

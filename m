Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1755471FC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjFBIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjFBIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:51:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E051723
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:51:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by xavier.telenet-ops.be with bizsmtp
        id 48qo2A0031tRZS8018qoDE; Fri, 02 Jun 2023 10:51:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50UO-00BhY8-RL;
        Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50Uh-00APxP-UC;
        Fri, 02 Jun 2023 10:50:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/7] iopoll: Busy loop and timeout improvements + conversions
Date:   Fri,  2 Jun 2023 10:50:35 +0200
Message-Id: <cover.1685692810.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
     various places[3-5], and some of these findings may be of interest
     to the authors of [6-8].

The first two patches were sent before, and already received some acks
and reviews.  I plan to queue these in an immutable and tagged branch
after the weekend, for consumption by myself, and by other interested
parties.

The last five patches are new, and convert several Renesas-specific
drivers from open-coded loops to the fixed read*_poll_timeout_atomic()
helpers:
  - I plan to queue the clk and soc patches in renesas-devel resp.
    renesas-clk for v6.5,
  - The IOMMU patch can wait for v6.6, unless the IOMMU maintainers
    already want to merge the immutable branch, too.

Thanks for your comments!

Changes compared to v2[9]:
  - Add Acked-by, Reviewed-by,
  - Add comment about not using timekeeping, and its impact,
  - Add conversion patches 3-7.

Changes compared to v1[10]:
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

[9] https://lore.kernel.org/all/cover.1683722688.git.geert+renesas@glider.be

[10] https://lore.kernel.org/r/8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be/

Geert Uytterhoeven (7):
  iopoll: Call cpu_relax() in busy loops
  iopoll: Do not use timekeeping in read_poll_timeout_atomic()
  clk: renesas: cpg-mssr: Convert to readl_poll_timeout_atomic()
  clk: renesas: mstp: Convert to readl_poll_timeout_atomic()
  clk: renesas: rzg2l: Convert to readl_poll_timeout_atomic()
  soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()
  iommu/ipmmu-vmsa: Convert to read_poll_timeout_atomic()

 drivers/clk/renesas/clk-mstp.c         | 18 ++++++---------
 drivers/clk/renesas/renesas-cpg-mssr.c | 31 +++++++++-----------------
 drivers/clk/renesas/rzg2l-cpg.c        | 16 +++++--------
 drivers/iommu/ipmmu-vmsa.c             | 15 +++++--------
 drivers/soc/renesas/rmobile-sysc.c     | 31 +++++++++-----------------
 include/linux/iopoll.h                 | 24 +++++++++++++++-----
 6 files changed, 58 insertions(+), 77 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

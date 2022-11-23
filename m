Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A246636218
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiKWOl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiKWOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:41:38 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542EC5916F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:41:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by albert.telenet-ops.be with bizsmtp
        id nqhS2800949U0Rd06qhSTc; Wed, 23 Nov 2022 15:41:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-001Rqf-F7; Wed, 23 Nov 2022 15:41:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-0012HA-00; Wed, 23 Nov 2022 15:41:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/6] memory: renesas-rpc-if: Rebind fixes and misc cleanups
Date:   Wed, 23 Nov 2022 15:41:16 +0100
Message-Id: <cover.1669213027.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The Renesas RPC-IF provides either HyperFlash or SPI host access.
To handle this, three drivers are used:
  1. The RPC-IF core diver,
  2. An HyperFlash child driver,
  3. An SPI child driver.

Currently this driver collection suffers from a sub-optimal division of
roles and reponsibilities, leading to (un)bind issues: after manually
unbinding the child driver, rebinding the child driver fails with
-EBUSY.

This patch series aims to fix this, by splitting off private data and
making the RPC-IF core driver responsible for resource acquisition.
After that, a few customary cleanups are provided.

This has been tested on the Salvator-X(S) and Ebisu-4D (HyperFlash) and
White-Hawk (QSPI FLASH) development boards.

Changes compared to v1[1]:
  - Move the two fixes forward and add Fixes-tags to ease backporting,
    as requested by Krzysztof,
  - Add Acked-by,
  - Rebased cleanups,
  - Remove Runtime PM wrappers,
  - Drop patch to add system suspend/resume support to the RPC-IF core
    driver, as this is apparently not needed on R-Car M3-N and R-Car E3,
    nor fixes the issue on R-Car H3 ES2.0.  I will reply to the original
    patch with my latest investigation results.

Thanks for your comments!

[1] [PATCH 0/7] memory: renesas-rpc-if: Rebind and s2ram fixes
    https://lore.kernel.org/r/cover.1656341824.git.geert+renesas@glider.be

Geert Uytterhoeven (6):
  memory: renesas-rpc-if: Split-off private data from struct rpcif
  memory: renesas-rpc-if: Move resource acquisition to .probe()
  memory: renesas-rpc-if: Always use dev in rpcif_probe()
  memory: renesas-rpc-if: Improve Runtime PM handling
  memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
  memory: renesas-rpc-if: Remove Runtime PM wrappers

 drivers/memory/renesas-rpc-if.c | 152 ++++++++++++++++++++------------
 drivers/mtd/hyperbus/rpc-if.c   |  18 ++--
 drivers/spi/spi-rpc-if.c        |  14 +--
 include/memory/renesas-rpc-if.h |  34 +------
 4 files changed, 118 insertions(+), 100 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

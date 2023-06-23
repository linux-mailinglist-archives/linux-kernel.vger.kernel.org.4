Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279BB73B134
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFWHUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFWHT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206982134;
        Fri, 23 Jun 2023 00:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575AB61985;
        Fri, 23 Jun 2023 07:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF94C433C8;
        Fri, 23 Jun 2023 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687504795;
        bh=mRTvW/o0xmVdwrv39D1Fas9Eznwc5euBRtXh8CpBW0o=;
        h=From:To:Cc:Subject:Date:From;
        b=eIptzNpzAjuBrYBJgzYUHiNnP/v7uie4yD6pV7JQFjQqwmhlgC4/nhDdYUM02+8O9
         3G7oa5knVtIplakMilPOwkiF3ZmEczXIM1gufU9nNrQ5t7jR6dIPagGytX2kAUrcHa
         yMhSS84S70R8a8Bv2L/UQaKJmS6Nd23kstz2sT6nS4vrLDRUlMU9/jH92gMwVO72xm
         K64bC+ABCK8JuKvtEUoOlcydNFLU90y0vKE6jl/1wwgAASOp0FXpRY/dtGyrp2AX85
         Y7EMZ6BEe6K3d+Ay7Nzu4x2a39BxXZmV/Ev6VPqmul46ivLOoOMWNSQtfCMGPY7sSM
         gEWAaRgepjNBA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: Drop inclusion of unused header <soc/imx/timer.h>
Date:   Fri, 23 Jun 2023 09:19:19 +0200
Message-Id: <20230623071948.3254789-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After removing this header in the clocksource tree, the clk drivers no
longer build:

drivers/clk/imx/clk-imx1.c:13:10: fatal error: 'soc/imx/timer.h' file not found
drivers/clk/imx/clk-imx27.c:11:10: fatal error: 'soc/imx/timer.h' file not found

This patch was originally posted as part of a three-patch series, but only
patches 1 and 3 got applied.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: 9e9d7570485d7 ("clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h> into its only user")
Link: https://lore.kernel.org/all/20230328100531.879485-2-u.kleine-koenig@pengutronix.de/
Signed-off-by: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I would suggest merging this through the clocksource tree as well, which
now has the third patch.
---
 drivers/clk/imx/clk-imx1.c  | 1 -
 drivers/clk/imx/clk-imx27.c | 1 -
 drivers/clk/imx/clk-imx31.c | 1 -
 drivers/clk/imx/clk-imx35.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
index 22fc7491ba008..f6ea7e5052d56 100644
--- a/drivers/clk/imx/clk-imx1.c
+++ b/drivers/clk/imx/clk-imx1.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx1-clock.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 5d177125728df..99618ded09397 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -8,7 +8,6 @@
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index c44e18c6f63f7..4c8d9ff0b2ad5 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 7dcbaea3fea35..3b6fdb4e0be78 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/err.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723E723E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbjFFJzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbjFFJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:55:49 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0FAE60
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:55:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a3e8:6562:a823:d832])
        by michel.telenet-ops.be with bizsmtp
        id 5lvk2A0041Tjf1k06lvkck; Tue, 06 Jun 2023 11:55:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6TPP-005EIs-2y;
        Tue, 06 Jun 2023 11:55:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6TPj-00BR14-Qp;
        Tue, 06 Jun 2023 11:55:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacky Huang <ychuang3@nuvoton.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: RESET_NUVOTON_MA35D1 should depend on ARCH_MA35
Date:   Tue,  6 Jun 2023 11:55:42 +0200
Message-Id: <011578db5fc4426d7df5d8ce2cf5ac09b7080531.1686045287.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nuvoton MA35D1 reset controller is only present on Nuvoton MA35
SoCs.  Hence add a dependency on ARCH_MA35, to prevent asking the user
about this driver when configuring a kernel without MA35 SoC support.
Also, do not enable the driver by default when merely compile-testing.

While at it, fix a misspelling of "Nuvoton".

Fixes: e4bb55d6ccf0f774 ("reset: Add Nuvoton ma35d1 reset driver support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 0cdf9d64c2185c89..ccd59ddd76100a51 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -144,8 +144,9 @@ config RESET_NPCM
 	  BMC SoCs.
 
 config RESET_NUVOTON_MA35D1
-	bool "Nuvton MA35D1 Reset Driver"
-	default ARCH_MA35 || COMPILE_TEST
+	bool "Nuvoton MA35D1 Reset Driver"
+	depends on ARCH_MA35 || COMPILE_TEST
+	default ARCH_MA35
 	help
 	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
 
-- 
2.34.1


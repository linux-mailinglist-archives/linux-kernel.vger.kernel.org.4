Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6F6B74F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCMK7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCMK6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:58:50 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F225E0D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by laurent.telenet-ops.be with bizsmtp
        id Xmyg2900301Vtj801mygXU; Mon, 13 Mar 2023 11:58:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbfsQ-00C3I0-Ew;
        Mon, 13 Mar 2023 11:58:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbft1-008cWd-SS;
        Mon, 13 Mar 2023 11:58:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Min Li <min.li.xe@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] mfd: rsmu_spi: Remove unneeded casts of void *
Date:   Mon, 13 Mar 2023 11:58:33 +0100
Message-Id: <ae84c1751e79cb49ab584557f4ecd835a8493d7c.1678704562.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678704562.git.geert+renesas@glider.be>
References: <cover.1678704562.git.geert+renesas@glider.be>
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

There is no need to cast a "void *" to a different type of pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mfd/rsmu_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index d2f3d8f1e05af054..2428aaa9aaed9e43 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -129,7 +129,7 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u16 reg)
 
 static int rsmu_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
-	struct rsmu_ddata *rsmu = spi_get_drvdata((struct spi_device *)context);
+	struct rsmu_ddata *rsmu = spi_get_drvdata(context);
 	u8 addr = (u8)(reg & RSMU_LOWER_ADDR_MASK);
 	int err;
 
@@ -146,7 +146,7 @@ static int rsmu_reg_read(void *context, unsigned int reg, unsigned int *val)
 
 static int rsmu_reg_write(void *context, unsigned int reg, unsigned int val)
 {
-	struct rsmu_ddata *rsmu = spi_get_drvdata((struct spi_device *)context);
+	struct rsmu_ddata *rsmu = spi_get_drvdata(context);
 	u8 addr = (u8)(reg & RSMU_LOWER_ADDR_MASK);
 	u8 data = (u8)val;
 	int err;
-- 
2.34.1


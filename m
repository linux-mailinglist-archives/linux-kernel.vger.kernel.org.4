Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17074C53F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjGIPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjGIPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363D19B2;
        Sun,  9 Jul 2023 08:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F1360C1E;
        Sun,  9 Jul 2023 15:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6C3C433CC;
        Sun,  9 Jul 2023 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915645;
        bh=cYERX19L3V+eUJUB67jPFLLDmLp9pyRhGPVzzYToiIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrSSbAVDiesB/xQAsAOGt5myxBVeZoiyTiBPY4vBpH1K9gGM5uJv2vVg0v49vh2NE
         ux71iyyvfIHnyWSsPIMCKhPmOCZqWk+MpvgZzBR/mJsP1uHWepIc9rqzbcluiepOVc
         9fRtdxpgy4NwWYpNk8uM8BNX4na2NF4O+8aVMuW3uufqp5yzXLUmY5JRZuHgqel8kl
         3Vxd+F2guUNBFih2uHVDkDaWZLN4fLM7S9ng1IOfuaL/Dl5J4M8n9CN/Pve4TrAPh4
         bSu656VdC5q4BqX3xKjXOU6dJ6aEjpBQGzucjUKYgiO5dHOmMTeKaqbds3N+KGZ/TF
         0f7516nJkBWlA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Sasha Levin <sashal@kernel.org>, andi.shyti@kernel.org,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 04/22] spi: s3c64xx: change polling mode to optional
Date:   Sun,  9 Jul 2023 11:13:38 -0400
Message-Id: <20230709151356.513279-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaewon Kim <jaewon02.kim@samsung.com>

[ Upstream commit d1a7718ee8dbcc488d3243d52e19c755123e0024 ]

Previously, Polling mode was supported as quirk for SOC without DMA.
To provide more flexible support for polling mode, it changed to polling
mode when the 'dmas' property is not present in the devicetree, rather than
using a quirk.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org
Link: https://lore.kernel.org/r/20230502062813.112434-2-jaewon02.kim@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-s3c64xx.c                 | 4 ++--
 include/linux/platform_data/spi-s3c64xx.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 71d324ec9a70a..66ac94022a1ba 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -19,7 +19,6 @@
 #include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
-#define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -116,7 +115,7 @@
 #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
+#define is_polling(x)	(x->cntrlr_info->polling)
 
 #define RXBUSY    (1<<2)
 #define TXBUSY    (1<<3)
@@ -1068,6 +1067,7 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 	}
 
 	sci->no_cs = of_property_read_bool(dev->of_node, "no-cs-readback");
+	sci->polling = !of_property_present(dev->of_node, "dmas");
 
 	return sci;
 }
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 5df1ace6d2c98..cb7b8ddc899fb 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -35,6 +35,7 @@ struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
 	bool no_cs;
+	bool polling;
 	int (*cfg_gpio)(void);
 };
 
-- 
2.39.2


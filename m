Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6174C4F8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGIPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGIPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACD129;
        Sun,  9 Jul 2023 08:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B6F60C0F;
        Sun,  9 Jul 2023 15:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7125DC433CD;
        Sun,  9 Jul 2023 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915585;
        bh=tvc5t0jTo/2AsKb4nX3c9HZPyNl0VeVsb3Bm30zrepA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUcnfjT7O+0FbBYdBcUzgqzVrbbpEEW65IN2XQjXywJix29n8MQoEZ9+m9tAJOBRJ
         6UBUhXMmpWyRBiMgQiI3q94ooRsAy5L2C158WKExic04zSjuv/kcCC9tL5bV7lxtnK
         DsyOFFVNNJ33dO7cKcg/bPkopcsl54bITfv4DypdXlIw3yziGDgjpy4Vh8YcKJPZmv
         TjEnChntwC/cdJ8jFJlVys2GdhfGEagHySk6ZR/DFcB1mtpR4nfamgBuAw/fuDv48P
         LdNnxpQPurS5ZXANvBdpWsUsTgmtHV/1YIFiX3zBTFepV4wJ5C6IYAcVxNb7blFwjE
         rBz2esTnHsTww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Sasha Levin <sashal@kernel.org>, andi.shyti@kernel.org,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 04/26] spi: s3c64xx: change polling mode to optional
Date:   Sun,  9 Jul 2023 11:12:33 -0400
Message-Id: <20230709151255.512931-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
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
index 7ac17f0d18a95..5f59d6f8c8d8f 100644
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
index 3101152ce449f..1d6e6c424fc69 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -36,6 +36,7 @@ struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
 	bool no_cs;
+	bool polling;
 	int (*cfg_gpio)(void);
 };
 
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E286669409
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbjAMKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbjAMKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:23:42 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF2DEA9;
        Fri, 13 Jan 2023 02:23:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0606E42597;
        Fri, 13 Jan 2023 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673605420; bh=fxnUPxMQfOKf9QNHPBDaDANUADvv1JFN7DwbvKgCdNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YZrgvujqp8be2tc3lP2yhiK7xnACtPrFKRW8NFtP3GuVfQ+IPnZsmzqk0sqY7arBi
         4xLm1P09TugAtLEe27leiv7gMugA+o0x7omi1CYVz4k6khlFEwheC+iVn1oms1/V1f
         69Z0RgW5z+VG40bjNBsNKl9ocrLzjjByhPlDGqipwGs6QqZP8Gqfir29ikEy2wcOFB
         8WtWpqmf8hWe4GiKOWrlEnjUKB0PSoZmQKXzSeqTfplqg7li1LooPURQVoaOSvu+kO
         TAXpDL9qllak0WN5i2rdy96JCdXTEB2ZDt7zYJDBWIgegCVubpqhv98Br4ew/7Sluu
         9sXSwo+3WWSGA==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v2 3/3] spi: Parse hold/inactive CS delay values from the DT
Date:   Fri, 13 Jan 2023 19:23:10 +0900
Message-Id: <20230113102309.18308-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230113102309.18308-1-marcan@marcan.st>
References: <20230113102309.18308-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Grunau <j@jannau.net>

Now that we support parsing the setup time from the Device Tree, we can
also easily support the remaining hold and inactive time delay values.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f33934f5429..fc4f6308efd8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2327,6 +2327,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
+	of_spi_parse_dt_cs_delay(nc, &spi->cs_hold, "spi-cs-hold-delay-ns");
+	of_spi_parse_dt_cs_delay(nc, &spi->cs_inactive, "spi-cs-inactive-delay-ns");
 
 	return 0;
 }
-- 
2.35.1


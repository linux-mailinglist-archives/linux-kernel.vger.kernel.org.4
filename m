Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2D65CFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjADJiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjADJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:37:45 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C117E2B;
        Wed,  4 Jan 2023 01:37:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7E0C0420D8;
        Wed,  4 Jan 2023 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672825060; bh=rdmw0AAv8JUVqSABjH94DjQUi17V4aIuJjoXwrcyMYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cB9pcZPr25EvIeGxKjVqZHlQdUkDe0DMt87brdQs51n36VswtMKLT06WVoYsrWJUU
         PA9zQke30TKjaDmuT/lHa4ZiPqOy/KTMNnNyjpUbfdM1ecv1JdxdhIjDG6A3Z/PN4o
         pctFhC6SGPlOUh6rsit/sol6qmJv0oP97jEr9UTp6cb35o+2ymFBoO6Ron0qoiyP2/
         p7t+rfdH675btv20WPEU+iUxUvujYi5oha6sc6x3zdgfUnt90SfWDeWbt/yqlmBqaL
         OE6v1LNYR2730Lrhdu/XlqKfIqdsxq7svw3pIXf5KMKUXGd3tKo/nuQVWop/XKSHyA
         5BtWOzosrkMyw==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 5/5] spi: Parse hold/inactive CS delay values from the DT
Date:   Wed,  4 Jan 2023 18:36:31 +0900
Message-Id: <20230104093631.15611-6-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104093631.15611-1-marcan@marcan.st>
References: <20230104093631.15611-1-marcan@marcan.st>
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
index 370e4c85dc54..0d84f90ab218 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2328,6 +2328,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
+	of_spi_parse_dt_cs_delay(nc, &spi->cs_hold, "spi-cs-hold-delay-ns");
+	of_spi_parse_dt_cs_delay(nc, &spi->cs_inactive, "spi-cs-inactive-delay-ns");
 
 	return 0;
 }
-- 
2.35.1


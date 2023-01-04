Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840665CFC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjADJiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjADJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:37:31 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E9F013;
        Wed,  4 Jan 2023 01:37:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B7D28420D8;
        Wed,  4 Jan 2023 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672825049; bh=G5TX+anFIWoHfncOvTyCwezW20GEHFXk9oFHLEBFckQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lZku2SsDXtQgkl+j/JnSAI0Sc4jUBUce48BoVpuaugQ0McVzrb3comLL2fiS68SoB
         NS0Z/IAYGGoaClPSXDNap/gv5wj2RrvXopGO5H5lb5noedGMZI2uHKbUxfIJ1uhBIs
         arS+tsrzsRakh65bSU6I69socaF6XVSe6miN5ZiDkEiwYZ4R4aUH+k3desfmF3xogA
         8yqK5gJtK6Mw/v5gQeXqBgclCXtpBGkLsWVwYOFIdDj+7GoDx06StYgOreEzHo0RTA
         mRYA3gV83KjvEMElxr4RJPCifKL0qdLacUCjf1ZaB1z0k+sf+X37T5oFG5Dle09fs/
         Uwh+DgGrivTRw==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 2/5] spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns
Date:   Wed,  4 Jan 2023 18:36:28 +0900
Message-Id: <20230104093631.15611-3-marcan@marcan.st>
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

As mentioned in the corresponding DT binding commit, the naming scheme
for delay properties includes "delay" in the name, so let's keep that
consistent.

Fixes: 33a2fde5f77b ("spi: Introduce spi-cs-setup-ns property")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3cc7bb4d03de..15f174f4e056 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2310,7 +2310,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
 
-	if (!of_property_read_u16(nc, "spi-cs-setup-ns", &cs_setup)) {
+	if (!of_property_read_u16(nc, "spi-cs-setup-delay-ns", &cs_setup)) {
 		spi->cs_setup.value = cs_setup;
 		spi->cs_setup.unit = SPI_DELAY_UNIT_NSECS;
 	}
-- 
2.35.1


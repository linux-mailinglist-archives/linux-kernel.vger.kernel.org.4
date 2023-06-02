Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9D72002A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjFBLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFBLL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:11:57 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFFCE;
        Fri,  2 Jun 2023 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685704316;
  x=1717240316;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=HAYerDlgV9aVzcCAwUf44mPymd1bdfq886ZinB7URNU=;
  b=MvM8keXrHoN5BSLztZdg9/JsbAf0v6m9v4luIhaSyB0nf64EJpW6Att8
   WeGFpLw4aG8xRjtOsQUOPq4C/sp0DTvFdZHjvUOr4icfulIZALM41KoGa
   E2DN5wMXB/XExnTbiJW+wZvCCXnmkw6jEDoe6RF+mt5jUWR8W0Fu1/YSF
   GAdqLYPCh7OZWBLWt5FPgBlWzjLGoGviOkd1h+0CUt9QN1NCKhKYXRlf6
   ZE5ccPuo8B6hK3S+CF33ysIwwmnfMk1ZnxZ6EGfYcQhn5dpijyOs+JU4m
   V3sI+PJ5F1Tw8+5NDkEjv/doTMeX9tOAmox2JemODACYz8F3DAoOyOcCZ
   A==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Fri, 2 Jun 2023 13:11:51 +0200
Subject: [PATCH] spi: spl022: Probe defer is no error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230602-pl022-defer-fix-v1-1-b80bfca3e1b4@axis.com>
X-B4-Tracking: v=1; b=H4sIAHbOeWQC/x2NQQqDQAxFryJZN5CmINKrlC5mxkQD7VSSUgTx7
 h1dPt5//A1C3CTg3m3g8rOwT21wvXRQ5lQnQRsbAxPfqCfG5UXMOIqKo9qKpEMeCuVeVKFVOYV
 g9lTLfHTvFF/xQywubX9ePZ77/gcsbRW5egAAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685704313; l=1252;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=jQmw6Hv0CHzSP4IR3Cic/x0BJQN8cQk+MMfyUTJIvp4=;
 b=4fqQqkaAMTKgQmiutciZ4xy/njINhRTGW0CGAsJgyTQZCA1kwaBML1P6FZaTE4OxOSQH148k5
 vrPXTT817obDyhE2mkJftGjlCkKdUEiF3uHzTRwGn6a+rr9mySbMj0w
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the spi controller is registered and the cs_gpiods cannot be
assigned, causing a defer of the probe, there is an error print saying:
"probe - problem registering spi master"

This should not be announced as an error. Print this message for all
errors except for the probe defer.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/spi/spi-pl022.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 982407bc5d9f..520471dfeb11 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2217,8 +2217,9 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	amba_set_drvdata(adev, pl022);
 	status = devm_spi_register_master(&adev->dev, master);
 	if (status != 0) {
-		dev_err(&adev->dev,
-			"probe - problem registering spi master\n");
+		if (status != -EPROBE_DEFER)
+			dev_err(&adev->dev,
+				"probe - problem registering spi master\n");
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeeded\n");

---
base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
change-id: 20230602-pl022-defer-fix-0f8b8c0b6eff

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>


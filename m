Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311927208D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjFBSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:13:06 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6A123;
        Fri,  2 Jun 2023 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685729585;
  x=1717265585;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Cz4/oyVTpm1XtHq2S7r1WKawWesnC6O3HFsEfsnf6Lc=;
  b=g2JmgrUBqnRzwPqaqFHvkkUUTSoeFCFvNm7YWKOfZAy438F/CQ/MvVqo
   M9QCSutctNpvCUTjuQPshKKEsdF0OX5Mjsquub67q+RbdZBC0/hblSXDj
   HCydR318ZjRhC/7+qNObG8F99lO93JREPOovLNfhuFNtBW5WhYsJ5nRdv
   N1fK0ezs4gHI5kA4UrUjr5sNqEAcZS8fwDL+hlQ1oo4Fi6JJ9yZ7pqwrv
   3iaVRDGeeLvCRjUbH3X3EY1lNttCs0xJanFIMSNLfN7UDPHwX+a3DsobZ
   gmQW2uE9UNiwWwrcMP5Xr4jvblzzg8g4BtASGeIQ6q3uhML8ux6H6Jb70
   A==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Fri, 2 Jun 2023 20:12:54 +0200
Subject: [PATCH v2] spi: spl022: Probe defer is no error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230602-pl022-defer-fix-v2-1-383f6bc2293a@axis.com>
X-B4-Tracking: v=1; b=H4sIACUxemQC/3WNywqDMBBFf0Vm3SlJLCJd9T+Ki0yc1EB9MCOii
 P/e6L7Lcx+cHZQlscKz2EF4SZrGIYO7FRA6P3wYU5sZnHGlqYzD6Wucw5YjC8a0ook11cFQxTF
 CfpFXRhI/hO789V5nlrOYhPP+Ur2bzF3SeZTtMi/2TP9LFosWqTYUgy/Z0uPl16T3MPbQHMfxA
 8anScjGAAAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685729582; l=1403;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=cVacumkzCzwk4AF23TT8WPfUhn25G7/IQ77V7w4A7lU=;
 b=LUtrFCa49KsO2HEgsR8925P9uaWYYhbLFwAOh/H+pYcGuZyS3Nzb2lw7LgOrscmGy4KDbZMfc
 WYHOFLuPayVDIs9kWyByhbEytIJIp/oCGsG3262RZrukAL0ebqFpt2R
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
Changes in v2:
- Use dev_err_probe instead of standalone check with print.
- Link to v1: https://lore.kernel.org/r/20230602-pl022-defer-fix-v1-1-b80bfca3e1b4@axis.com
---
 drivers/spi/spi-pl022.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 982407bc5d9f..1af75eff26b6 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2217,8 +2217,8 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	amba_set_drvdata(adev, pl022);
 	status = devm_spi_register_master(&adev->dev, master);
 	if (status != 0) {
-		dev_err(&adev->dev,
-			"probe - problem registering spi master\n");
+		dev_err_probe(&adev->dev, status,
+			      "problem registering spi master\n");
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeeded\n");

---
base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
change-id: 20230602-pl022-defer-fix-0f8b8c0b6eff

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>


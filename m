Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375EA6069BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJTUn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:43:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FA20C990;
        Thu, 20 Oct 2022 13:43:12 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-059-009.ewe-ip-backbone.de [91.96.59.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71B0F6602542;
        Thu, 20 Oct 2022 21:42:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666298577;
        bh=TH5RKawR8fUzI9ml8ZupcHOujoAZfQCPkmxXhLYxYXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YS8m+Io1N5iGo+oUb06XsEGo/O8Wnd11migN+2lOJ7v61WtNSbIryRkUk7jCaTOhn
         2/w7ZmqLQOgsi6tmIfUzAaKDUx+JdoMMCus5ttIaRdLdJ4zMRtcTE29tX5ukXjlkhV
         p+J6MECb37kApdzNR4MDelWdXWTvR93raciHztPXjGdwYqA5NECuSCz9vYifw44oM5
         3QHG09ehHYqEapxs+qdYXF4vdC8y8jDTWJKt/TE/dFmgE2AXKEaybi263RGTQQ8Pt1
         UEG0uzFZRYJSQC/uB8fdLMbnExSbuwOSd04GLebm+f2AOcIl7jGf5m3zAjmS+x0vw1
         Kpd/jVnBjAN5g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 66A664808A0; Thu, 20 Oct 2022 22:42:52 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv4 11/13] regulator: rk808: Use dev_err_probe
Date:   Thu, 20 Oct 2022 22:42:49 +0200
Message-Id: <20221020204251.108565-12-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020204251.108565-1-sebastian.reichel@collabora.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print error message for potential EPROBE_DEFER error using
dev_err_probe, which captures the reason in
/sys/kernel/debug/devices_deferred and otherwise silences
the message.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/rk808-regulator.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index ce9c64cadeba..fa9fc1aa1ae3 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1343,11 +1343,9 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < nregulators; i++) {
 		rk808_rdev = devm_regulator_register(&pdev->dev,
 						     &regulators[i], &config);
-		if (IS_ERR(rk808_rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %d regulator\n", i);
-			return PTR_ERR(rk808_rdev);
-		}
+		if (IS_ERR(rk808_rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rk808_rdev),
+					     "failed to register %d regulator\n", i);
 	}
 
 	return 0;
-- 
2.35.1


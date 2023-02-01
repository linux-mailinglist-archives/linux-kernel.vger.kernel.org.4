Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED6686C68
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjBARHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBARHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:07:19 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F859019;
        Wed,  1 Feb 2023 09:07:16 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A4A83CD5EB;
        Wed,  1 Feb 2023 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675271234; bh=mU7WO+CJjepkCD5wdLsQaRzi/CFzaplHDhayDwUy6aA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=b2Bh+LKHoX3KAH1UKadOHh9E1tdN13Qf7BuwSpo4jr4/dV+jESpmtLqltSTbn+W6B
         ZeMUfubzDnlr4P2/GQu/M4Xg4U0FlRH/Uo4qQVJAF2o95WFuH3lkSDp4ti/dGwTari
         9oKigdBt5w7Cbj1Y2di0ip5TYjKV8pavVdk1EPxg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 01 Feb 2023 18:06:58 +0100
Subject: [PATCH v2 1/4] media: i2c: ov2685: Make reset gpio optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v2-1-210400f2b63e@z3ntu.xyz>
References: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=mU7WO+CJjepkCD5wdLsQaRzi/CFzaplHDhayDwUy6aA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj2pw/44cBYLYqME0Suaw12Qm51b7+wZrJgODj3ilO
 BGXhH0GJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9qcPwAKCRBy2EO4nU3XViUND/
 9LDqVTJP5Rq64Wk2VvpY4Kz4p77GTLO8ULRGU/cQzF9ce9oPOrGCTLMm35RI1QpXS10X2WTVjKoRGZ
 ErDeZuhgw/nusCg+uBfdL15c2h5rHyKll/H712EMKY70GiQ6bnNuQr4FlBc+z0H2h+P3YYGPMWGqq4
 SDBQrb2tzjJ6EebqFVZoR4ualFXX0vTz+rzcQ7WKb9aauur46h9HFrVutNjK4TKJip0ZS4TdRMD0zi
 95yx9SjOCG8sulKzcAACmJcerQBGqYRtWMVLHTo8VWFCJyVcylUyseZuRYttTDXV57Nkp81S0v5RNy
 Lr5bz4zpQIRS6WRrmRGDTWhRDrp+La5nvkHZSLJcdEfjxgtitamQwcVSK5gge17PMpmDchS98T1Oez
 25NWpq0a4Td4pIyYtXIp8dZFS7r15DkmLufsWY2DXAkvP86pgmC8DZ5wkCwmzqL96IUGzid3tAJr1d
 fdz5cpXscgJtEG6ZZLXnvwwdjxBct3E+WBpS65vFu/xaodmbXfudPPBnmvzBbZyH2Z8AwY4l+V2K/v
 hCeZJa2cMM69abm6oFA3fb4DooVgoAGBDAy0dR2wK3IXLsCOfyE9fewbTnxfFfNDqoYA2FhQtqqi3W
 +ReNa9fXd2Yj4YqFc2yESBzF5MUp/rH+LMCJXGsphhQP2KfNLsCSjC4bHokg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some setups XSHUTDOWN is connected to DOVDD when it's unused,
therefore treat the reset gpio as optional.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index a3b524f15d89..a422f4c8a2eb 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -734,7 +734,7 @@ static int ov2685_probe(struct i2c_client *client,
 	if (clk_get_rate(ov2685->xvclk) != OV2685_XVCLK_FREQ)
 		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
 
-	ov2685->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ov2685->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ov2685->reset_gpio)) {
 		dev_err(dev, "Failed to get reset-gpios\n");
 		return -EINVAL;

-- 
2.39.1


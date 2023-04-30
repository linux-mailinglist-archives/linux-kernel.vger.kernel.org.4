Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2D6F2A42
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjD3SVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3SVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 14:21:35 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB6F1728;
        Sun, 30 Apr 2023 11:21:34 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 09A17CEB83;
        Sun, 30 Apr 2023 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682878892; bh=2KDm+MfmQDPFzRhM3HuRPWRDE4x8ieq6b/WlHIl9jK0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=YfpFwhRy8QJv97qougAH4t8sLJG+/Am0Bumbrt96VeHjGjj/Q/aOmWplSHNW46q+k
         RmaBlZlNEjjOai+CABQNobYyORT/0tZmBKcizGdcODdARBXmZk1agFmc+CjnLRWQXa
         JUXlnkHaWY24939X13CqV3E0yCFqbNeb75hq4njI=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 30 Apr 2023 20:20:54 +0200
Subject: [PATCH 2/5] Input: drv260x - sleep between polling GO bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-drv260x-improvements-v1-2-1fb28b4cc698@z3ntu.xyz>
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
In-Reply-To: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=2KDm+MfmQDPFzRhM3HuRPWRDE4x8ieq6b/WlHIl9jK0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkTrGnuoEsRTAkX895HNLQSK31eIpbRae/YptSw
 7CkOkDUZH6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZE6xpwAKCRBy2EO4nU3X
 Vp5qEACtdUzv1B33TViLXCnVQagZdBhCzFgGnvNikuW5vMJOjg7aSJA8Aa1S0a5t5B5YOToCbCM
 QK2Sj28kuCYDnxaiFpfUL9Ip75zq4oM9dUudZ6VCmk0lEHs/ZXQQQYBiR/YcMzJ7yJsOXrMHPBk
 BmNPiU+SvcJrS69TPRDRmCUalgaiT/vpeynwcoSy4LDKLccTNYplmGrciXXERhQ7BF1inK/fz/w
 E8a4L4OWYuHpNqxSDAHsvw3jnE+Pk8GpGSJgO8Oivsr3yEUF7Qyt88EH5G8DiFKAScLaqabMDC1
 HZIHs8pOgzz1mXKBB33DxYvS6j05WSYfKge0kFl0JVNasl4pK+DsnH1E5Q7+mFR6MqR9/+Xyyaf
 c7YeJwQlHXVAkPLm5A++c1wa5fmrMQEQgRMXY2ulEFvPZtfAaxcEZNOsIoPTjphPSLxJRdCzKrW
 KKUiem/rSn7IA6JdicfnMaySANKDSw0DL1zx0s8zW9CHt2v7+eQpnU2ErBALMzvvqqEtU0IdusZ
 FJwBvZAcVxNHWXLiLTsh7mS7i4zgynKjLbeae4u2+bzS2uxulMh9Xbn/Tm6Lx98eTS52wjo6wA+
 V+7gKdPES8S8Y8zPfUwba7+YUNi1D9d41Ve8On8O9i/8iakZlqzfOh9esI3L0G1ambMAIhr+R4P
 bPfXMMt7GYldNMg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing the initial startup there's no need to poll without any
delay and spam the I2C bus.

Let's sleep 15ms between each attempt, which is the same time as used
in the vendor driver.

Fixes: 7132fe4f5687 ("Input: drv260x - add TI drv260x haptics driver")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/drv260x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index e95c4e775b5d..884d43eb4b61 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -435,6 +435,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 	}
 
 	do {
+		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
 		if (error) {
 			dev_err(&haptics->client->dev,

-- 
2.40.1


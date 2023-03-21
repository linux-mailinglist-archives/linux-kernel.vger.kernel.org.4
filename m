Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994206C38DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCUSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCUSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:04:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EAA28D0A;
        Tue, 21 Mar 2023 11:04:05 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3D5AAD255C;
        Tue, 21 Mar 2023 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679421843; bh=ncpXLQ6qGgg6hVHefO9DqumuQvrhX7L+dhXzJdi5hVA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=TVPCV1+Ij+FRy7+KSyMvO9Kii3m0GcVODfcxCWfYqZ95mzRNqC0mIWCJd68FMHotn
         ZHplRNTdPweJ0fb28+JJnqZkzHenLPIk1Acy+6VRjhsN0NVZSdU48PHUKttoMCgEuE
         H8GSaq2e06VaazXgfsp1EXlEq3M5+1z/EFiMcIAM=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 21 Mar 2023 19:03:57 +0100
Subject: [PATCH v3 3/3] media: i2c: ov2685: Make reset gpio optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v3-3-d9737d0707f6@z3ntu.xyz>
References: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=ncpXLQ6qGgg6hVHefO9DqumuQvrhX7L+dhXzJdi5hVA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkGfGQ02yqbUUyL+5UW3wwrvIUKbBBdDKM2vUQv
 zFYH0zH/iuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZBnxkAAKCRBy2EO4nU3X
 VvlHD/45ASJR8lIV6H/nsRjW6prmblVEscbhEdsAukK0w8p2LeLTI6aUIuz75lxqK6V4RFpJtgU
 8b/J28B+vgi8yCT+rJTUACGiXRydIPan/Khsjgx3MPTX8ERq9FhwWr0+A67ulslfd/OLrNbeTMW
 UTWDNca9OKuk0it8Ro0ouVt2rajWuTDHVOOhe9HWm3GnfoulXhRVPlucLmIrnYJObhoa2S/s+2b
 zaDt2QwHJMQ65CyhcRKp67O7OJ0CpaoWiiEpiQKabH0c7ZCJx3/fLBg1s1j1AUG3m+xVXVemp19
 JAeE+Pf9NL67wFfGouoqV/ek0J1nA1KusgEWrXPg5trsjen9hY0hZpAzYbwkb1M8PAqp6BwYJWQ
 74qJNfSb4m7tFU9dCxUPa4vkhkP5Y1gEQ7q5lVos7Ey9rP6cdzu28pelN/T+ZrCn2VIHNTJcxgx
 5aumzyGAIt35JpXT7pf0ijaEGzPK2vu1A+aYoGtiYcg6Max3N6CHLhL1ql9FfnVpWVPw3SaxUej
 9hcitY76DZI/g1oj10fJLlYE9aK9tu2ALCXhFtDbGo5sL1N0R7tOxRGvVS4fZzRyFk7aGHd0Msq
 M9BjBUBmVp+H0EXGgf1/cEKBLWQImTRlhFzDQ6iMDz3L3GMZragCsNp8HqeTOZBi82glxiHs00V
 4uRjtKt8e8ZoGMQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index fdf3e06133302..f119a93e7c647 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -807,7 +807,7 @@ static int ov2685_probe(struct i2c_client *client)
 	if (clk_get_rate(ov2685->xvclk) != OV2685_XVCLK_FREQ)
 		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
 
-	ov2685->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ov2685->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ov2685->reset_gpio)) {
 		dev_err(dev, "Failed to get reset-gpios\n");
 		return -EINVAL;

-- 
2.40.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D966C6FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCWR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:58:02 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B0E2132;
        Thu, 23 Mar 2023 10:58:01 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B0939D2586;
        Thu, 23 Mar 2023 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679594280; bh=ncpXLQ6qGgg6hVHefO9DqumuQvrhX7L+dhXzJdi5hVA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=xauDcQvsQWTNROmsZ/waVuFjN6M43bG0+gulylEte6y7OK14ej1K5FV1O9BYTVy7s
         W0JUygJ3R+0Dfj1EPZFLQYEPRkXfHgTEstC2Jq35VaWVTEzR502xYfjYWn0Q+vTjq7
         Fvhdih/lLsHszJMrdBq1K9Sk/cI0S7WEP0JNFWmg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 23 Mar 2023 18:57:51 +0100
Subject: [PATCH v4 3/3] media: i2c: ov2685: Make reset gpio optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v4-3-e71985c5c848@z3ntu.xyz>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
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
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkHJMk5TIQR0cLMxfZ28w9hmVhXNFGqcUgpMKQz
 EuErPxrI8SJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZByTJAAKCRBy2EO4nU3X
 Vv8yD/9YkeSVJ8+GVv4ZKNLCeSGzKFGEurXBBitFIx13KhGwv5RziY1V0DEZo9hvHPi5oxoeFOp
 lO3yy2CcMU2boIWovJT8B2fmZ42WKHX2yaMZ3934HfdMktjEQxBdRC7WFrYCLXb9vdzcHbiStiz
 W3U0+3grhCtpqU1cSMtna9b0HY+LpC8NI5IOJHUiqowb0mS/l2RssmR/rzaueXvNm3xJA4HRjUM
 UeJyTKdPHGV8k9xBBCzIiYHb/0313bNoP3Le4GZUlXT6e4+44HwtprbTieOZX+nIsEVxLZBXXOI
 4AQd/lrQC0k07nPJq4wSXeRNrFUFrORL1R/EGOM14f9Zf6j4bvg0wWj0eUMNLW4QGULhJap2L0I
 EiI/mA/kswoSOKRv2WOn6NRW+ngrqSjlf+sekb1yKna54Crk/jkOx00MriofUcGgY7HV/+/M8hk
 T8Exh8xIiQ9ZxmnvKyk6vCd4jJcHxCEbd2JinYgISk6iKpITn6PWthG8fD1bopzA0rShrbdejS5
 z1aZvTIPk4dbiJumIZbwcfJx+ndflrMYA8oUAUDqzDDPYiMehxr61TAFbB7ybjTpOTzJQ14Rh3k
 GhvdKghKRqJur9+cDOWhqIdL6GhEe3hhKkR9y2VRb+nJeLjZdcHKAce9w6g0IBrbqszykMUWQIP
 3AI0ruNoGN4U9EQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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


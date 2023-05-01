Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B16F3078
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjEALbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjEALbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:31:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2B1709;
        Mon,  1 May 2023 04:31:05 -0700 (PDT)
Received: from koko.localdomain ([213.196.213.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MbAYi-1qQJaa1ZbE-00bcJw; Mon, 01 May 2023 13:30:56 +0200
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 4/6] Input: cyttsp5 - properly initialize the device as a pm wakeup device
Date:   Mon,  1 May 2023 13:30:08 +0200
Message-Id: <20230501113010.891786-5-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501113010.891786-1-mweigand@mweigand.net>
References: <20230501113010.891786-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wfa4Bim49+9ZHMV6kgEjh/JopXEgYM9Shx9nCM4xZ0drjqVvbwV
 ZtGJYmqqbwX0zMuDKyTatjvCl2UoglmSHLkjSB4tom3uzCAcPAvv6kyuNGRcYEQIwnMucIY
 ErQ6LCMCGxcsHXL9yM0X765oQHJ2wBJwEJOZfXqEXVdXSe5bJ6wR0FgQ3VOaUpUkRqknTy0
 noW/VbpVIhqx3896AdPVw==
UI-OutboundReport: notjunk:1;M01:P0:Yx+pFtBIbTs=;9DC6+cxtWB0bVBKORgPv+KcC+Lx
 YoQmeEGDa7BT5jporOT4Pt8luHuHDhaqszuzyqXp3vYn3MhzdPwy7NxjNoA0Qa3sDgFfmEjZh
 y3Rc4n64mK6lnQ9AlNkw+Vh1ahvB2lQ8J6huplTyUWRBV0t0Tp2p0NEvJT/IaXhKBQzAEcQ3s
 zTG09W56PL7juLuZzk6/bu+dxEsVNsHj4VYjIR6a4iL5cx/PDOan+Stom1b7tW2ZF2CJ+ci9u
 RgZuYNUiqn+YXrFD7icYEwzHms2aRwhyYC4vjlqJUQ7mLkNbsPJmQ0m+bQdSFNuH2RE3YTznk
 6WvrUiY3fgvcW1S9L3Cmk1X4pwRgvY8/gn355vOC+VJkqiG7YYwL9XgaXOFaO3yePeaZ0QRg/
 FayLyRlhv8+WcADN7KcIXEJoPXm+/LLRVnXICA6Tte5zg2Cyt4IAIbe+DRt4p3nPdrgmd9rxp
 pqRFxhVWGFi5kxkw3KtKXtmjTUTXVLQE34OZcO5oC34PPk5FgPPFM24aUEVBM7s2cPLbUlPh9
 2quOanF6OyedCJ51vcRa9u1WrgbLe6MrtICezbtYmU/G/KdHObRqKugPcNmkarDpY/Nw+Cris
 nMH5LkvAttfKmRGGzd7iiGwoCaKLgxUPFR/1E9qaToEMYWhpHrvJfJTZrGsWriPoWlHkhquUA
 aVK6kIxOqo8Q8R/sW+lXsBbHMMIGJfJHjbg8XkaWzw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When used as a wakeup source the driver should be properly registered
with the pm system using device_init_wakeup.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 55abf568bdf6..f701125357f0 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -830,6 +830,9 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 		return error;
 	}
 
+	if (device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	error = cyttsp5_startup(ts);
 	if (error) {
 		dev_err(ts->dev, "Fail initial startup r=%d\n", error);
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C067C876
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjAZKXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAZKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:23:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB8A6;
        Thu, 26 Jan 2023 02:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E6461791;
        Thu, 26 Jan 2023 10:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E52EC433A0;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728284;
        bh=qU4Q3J1fFonZuS+YU1KqT+9kIdY4hzcAiMKc28trpZo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=fz2kUwy80l2Q2jiZqRG0VV2pZthSay7Hs1MWAJZBaVmV31KA2sVRXqQVdN0Hlrkig
         H5RrJ2EAv7KY95m6VobQK6W/oH2IWpY1NybHAP564cNJowBr1e0xzCs8Qt4lhvl5tr
         dr43yNTGNhwwC+y3XsuF2XroQ6em3apWZP60KZbO2Yx/iwclQOUCa/A/90CCKygdbP
         YJapmYOUaBGl9aPKKJCvAAmDQKaxVtrxUJx1S2So7P+OA9Cjx8x5bSHgKmiPWw+iBA
         h2AjuE+JB+Uj0aPIZeL2MZ650xabCs436Hiwkgtmc2sB4CFQczjLLEDdd10K4SD35E
         HWbOwRFmxWwMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 791D3C54EAA;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Date:   Thu, 26 Jan 2023 10:17:24 +0000
Subject: [PATCH 3/3] gpio: mmio: Use new flag BGPIOF_NO_INPUT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-gpio-mmio-fix-v1-3-8a20ce0e8275@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=IQwtrgDKf2QgNZYU9DD7LFbObPBPz/lwtIwlOPLwcgM=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj0lNb1kkol71okHDULBf/ympbk?=
 =?utf-8?q?NCY51FLhZrC3D+p_/4DXpGiJAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9JTWwAKCRBRoiK2BQ9j/9qRD/_0YdRZAqSpG3MI+yJpsuDqitYC+N/uNu/v5o?=
 =?utf-8?q?KauNCl5ffRzn7xP9x0j64U3Ay2fj5KpSAfvprbpAZ17_4P0I27QVxSXsnMsrfW+Zk?=
 =?utf-8?q?9Krt9U+hgDx4vHPfFk7urdkRom4VLl1K4mUsntZezSHwaJ+2Y0MD0icSl_nvuGUs4?=
 =?utf-8?q?OcStu3AGHZOXb1jhZUH69rq3pajhat/jdUwThy6RnMBm2KXFbh06nHBEmqSlHN4k3?=
 =?utf-8?q?qRj2Mw_vswbTQoljF4WwTFtHjMGvpRDV5/5wqsHoDRS5SPVN52fr91c0VkloXgXCe?=
 =?utf-8?q?BODh6xfEyqSSaJx05B8b_3H8BYQa1EzbmnzmmKY4zGpjgmCCCl80Byxa8xHQsC1hX?=
 =?utf-8?q?CWRSISA5v5JILarfCPmsiUIi7WrlsEAxr+_hCIzt0MHm8Uf/hapQsWk4Px5XfxahR?=
 =?utf-8?q?8LwhYuNer/HyCZZci4nwH5Nnji6nXGghHl69lbqhFC13Qe3D_DGPEy19G8cerxkPG?=
 =?utf-8?q?0o7fKVPHOoWWm4NN14lTIkok0n6mVvGlxnftghzeRlfryy+NnTZFXNLbvWPO3S_ER?=
 =?utf-8?q?WMg1XsUC+luqyVg8RNcOmBs+21PYwnH6jlY++pgWivj7m7yAnwEDapHpMpB+9AQRd?=
 =?utf-8?q?mZvBPADbZbS?=
 2tbR+WI3rWcJSs0DjceTnocqXhnsJxqDES5FEQoCX8+tu8OEzSQWXARhQGCQ==
X-Developer-Key: i=nl250060@ncr.com; a=openpgp;
 fpr=A16B510F8E1EA152A76DC19351A222B6050F63FF
X-Endpoint-Received: by B4 Submission Endpoint for nl250060@ncr.com/default with auth_id=26
X-Original-From: Niall Leonard <nl250060@ncr.com>
Reply-To: <nl250060@ncr.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niall Leonard <nl250060@ncr.com>

Use the existing shadow data register 'bgpio_data' to allow
the last written value to be returned by the read operation
when BGPIOF_NO_INPUT flag is set.

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
 drivers/gpio/gpio-mmio.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..7125bd8caaa4 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -164,6 +164,11 @@ static int bgpio_get_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	return 0;
 }
 
+static int bgpio_get_shadow(struct gpio_chip *gc, unsigned int gpio)
+{
+	return !!(gc->bgpio_data & bgpio_line2mask(gc, gpio));
+}
+
 static int bgpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	return !!(gc->read_reg(gc->reg_dat) & bgpio_line2mask(gc, gpio));
@@ -526,7 +531,10 @@ static int bgpio_setup_io(struct gpio_chip *gc,
 		 * reading each line individually in that fringe case.
 		 */
 	} else {
-		gc->get = bgpio_get;
+		if (flags & BGPIOF_NO_INPUT)
+			gc->get = bgpio_get_shadow;
+		else
+			gc->get = bgpio_get;
 		if (gc->be_bits)
 			gc->get_multiple = bgpio_get_multiple_be;
 		else
@@ -630,7 +638,11 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	if (ret)
 		return ret;
 
-	gc->bgpio_data = gc->read_reg(gc->reg_dat);
+	if (flags & BGPIOF_NO_INPUT)
+		gc->bgpio_data = 0;
+	else
+		gc->bgpio_data = gc->read_reg(gc->reg_dat);
+
 	if (gc->set == bgpio_set_set &&
 			!(flags & BGPIOF_UNREADABLE_REG_SET))
 		gc->bgpio_data = gc->read_reg(gc->reg_set);
@@ -711,6 +723,9 @@ static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
 	if (of_property_read_bool(pdev->dev.of_node, "no-output"))
 		*flags |= BGPIOF_NO_OUTPUT;
 
+	if (of_property_read_bool(pdev->dev.of_node, "no-input"))
+		*flags |= BGPIOF_NO_INPUT;
+
 	return pdata;
 }
 #else

-- 
2.34.1


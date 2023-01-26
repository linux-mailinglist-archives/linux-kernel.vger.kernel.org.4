Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69EA67C858
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbjAZKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbjAZKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:18:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5B61846;
        Thu, 26 Jan 2023 02:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB635B81D58;
        Thu, 26 Jan 2023 10:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81FA7C4339B;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728284;
        bh=jQyK54Ac2Nf4g5m1Qyhvp73lWbZ9baHSRpo8ImPR0Tc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=aKoZkWz5/wCTW4C9GZvNGsjrUBj97qXkGfxxJmttMRQ6x5G2TMbntSr9zFZvw4FLa
         6L/cJF3fkDNQqAd2Z7RnsO3VGgZQ6856UKrbJcDSC1EtHAxBdeiaOVjLlGXYkbEUU2
         4TI7r5Ddx7n9qbWmYlhsz2/xWPEg24iwr3XXcWYdaNReS8Ak4vkwbUPi7KJL1M89qM
         vcgWv1EQz68Dangvivk/zIp3YLajvTep1+Vq6qx2KuYK62iTIl2e+nfX6NoFmahNMx
         h5BcmSyG0vDZYgNjJL83kg3iC1svacBXWcbPQtMmQ63g+z9zqm525xL4sh2sQK4TxN
         XQr9HoFV9qfMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3DEC61DA2;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Date:   Thu, 26 Jan 2023 10:17:23 +0000
Subject: [PATCH 2/3] gpio: Add new flag BGPIOF_NO_INPUT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-gpio-mmio-fix-v1-2-8a20ce0e8275@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=725; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=TggMaJeCcpeNdUyuVzDRaxsQqKzgRTR7wrZ7HE9dDhg=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj0lNal1QTJQw+z/cl0dkuF4eBM?=
 =?utf-8?q?GFEgzNxPwt88RAJ_yEncf7CJAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9JTWgAKCRBRoiK2BQ9j/2wzEA_CMVU+Aqyd/S4fxzF9epmJOp+NTI0QKcCM6A?=
 =?utf-8?q?45WtIHkfL24d6XnOrzA2WFb7Q1vaVC3rQp4+8RfvBMv_sAziC5leMO2WOG9GdYmi/?=
 =?utf-8?q?if320+fJ607I4yILRKqDhS5MDm4UHSc2m8LTrIpz1XkxpUTOeLQPNiof6_3nXXDMF?=
 =?utf-8?q?Pv0fekhtnODoKjU0Phjug+zP4mG8pN6eaGSmlLSrMTCrcdX8CPWxOS35eeE7dLmqD?=
 =?utf-8?q?pafFzP_v+wurMIZ2e82Wr2e+RYw3d/66R95x6ydrRY9V/x4eFFQ5bDGeHSinITtfn?=
 =?utf-8?q?t2Dbmjwp7vMzKwOWFEtE_Ja1luHGeJXr7Ohj4zK6/GTBqf2Ok12BlSbAkKZqtLXXC?=
 =?utf-8?q?R8QQ1WBuG7TAYLStl40iYLRakboE7mF11X_7V+AdaEeJmAuDt/3xVTqeq4h8xaEx9?=
 =?utf-8?q?/ve4saAexZd8BBOnTzusBNLg3/mlJu7pGK5hpaAePb164wpz_3vnCzYB2fQSt9gI5?=
 =?utf-8?q?jEUPtBbflj2SbU97YRXMhq2du1x28HBoXWn540z/1LNtlcxm4VfDkZkKGJ/bZs_4V?=
 =?utf-8?q?8Z35PJUWbdcMbiYmnxI4Av4J4wxwb5isvVMpd5txE4xXCIv1C4vIQs1blJ9HWbHs8?=
 =?utf-8?q?7pQZliGoyIN?=
 LPjBqKZaMKmtP4STpIsEqABTWONFeEbzXv5LfkPTxKCSQWuh5ye426xXsUdQ==
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

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
 include/linux/gpio/driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 44783fc16125..e8e57310e3b8 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -682,6 +682,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 #define BGPIOF_READ_OUTPUT_REG_SET	BIT(4) /* reg_set stores output value */
 #define BGPIOF_NO_OUTPUT		BIT(5) /* only input */
 #define BGPIOF_NO_SET_ON_INPUT		BIT(6)
+#define BGPIOF_NO_INPUT				BIT(7)	/* only output */
 
 int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 		     irq_hw_number_t hwirq);

-- 
2.34.1


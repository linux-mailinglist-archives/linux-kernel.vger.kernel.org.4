Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5971963F7BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiLASsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiLASsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:48:18 -0500
X-Greylist: delayed 1879 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 10:48:16 PST
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000C532DC;
        Thu,  1 Dec 2022 10:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eyZxP11TPKJBHc55O9hn51hFwkyobIyf/8zksyyPN3Y=; b=aDG7UD8HHwQzmGlOZh4R6PSWli
        UWxTCXMM6z2iNDmpMMJ2vPO8EsfthUOOY21oy5fMIxFp3Z7qegnO2UeczUXk2nt5TkVbLc69IISff
        yiCoG5PB43sYLhXl0CMGmKckXfxw4HQLM6cjKXgLNxocl9lOFYkLfwTaxz1VE8pvY3vQYvKsWeMHe
        BpeQ2cJaTi7gPHf+97pzB1ljtJcrRotf1LndgxuY+2AQADuvdVqLdNhs0lZtVCUIWeUHhZpaXSprl
        9UOnF5MYZpX1nAe9WTFuep1ntCaU+eGCPGrenO1j+l30JgZGLpGua4rm/MVWS55q5/WQ4AhGFFAla
        /GhK8u9Q==;
Received: from p200300ccff169a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff16:9a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1p0o70-0008FX-Vp; Thu, 01 Dec 2022 19:16:43 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1p0o70-00EmUm-2K; Thu, 01 Dec 2022 19:16:42 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, andreas@kemnade.info,
        jiasheng@iscas.ac.cn, paul@crapouillou.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] iio:adc:twl6030: Enable measurements of VUSB, VBAT and others
Date:   Thu,  1 Dec 2022 19:16:35 +0100
Message-Id: <20221201181635.3522962-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some inputs need to be wired up to produce proper measurements,
without this change only near zero values are reported.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/adc/twl6030-gpadc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index f53e8558b560c..40438e5b49702 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -57,6 +57,18 @@
 #define TWL6030_GPADCS				BIT(1)
 #define TWL6030_GPADCR				BIT(0)
 
+#define USB_VBUS_CTRL_SET			0x04
+#define USB_ID_CTRL_SET				0x06
+
+#define TWL6030_MISC1				0xE4
+#define VBUS_MEAS				0x01
+#define ID_MEAS					0x01
+
+#define VAC_MEAS                0x04
+#define VBAT_MEAS               0x02
+#define BB_MEAS                 0x01
+
+
 /**
  * struct twl6030_chnl_calib - channel calibration
  * @gain:		slope coefficient for ideal curve
@@ -927,6 +939,26 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = twl_i2c_write_u8(TWL_MODULE_USB, VBUS_MEAS, USB_VBUS_CTRL_SET);
+	if (ret < 0) {
+		dev_err(dev, "failed to wire up inputs\n");
+		return ret;
+	}
+
+	ret = twl_i2c_write_u8(TWL_MODULE_USB, ID_MEAS, USB_ID_CTRL_SET);
+	if (ret < 0) {
+		dev_err(dev, "failed to wire up inputs\n");
+		return ret;
+	}
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
+				VBAT_MEAS | BB_MEAS | BB_MEAS,
+				TWL6030_MISC1);
+	if (ret < 0) {
+		dev_err(dev, "failed to wire up inputs\n");
+		return ret;
+	}
+
 	indio_dev->name = DRIVER_NAME;
 	indio_dev->info = &twl6030_gpadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809C6FF16E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjEKMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjEKMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:21:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3941FF1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:21:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so15155140a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683807664; x=1686399664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRf/7bYU3ASVbppzqAIJlZclrPxE6HVJTYG/JZAScRs=;
        b=IjNOKKeLlSTBGJQ5hlvyvuNhUoMndixw8BoDl8FUcqJmrL4ZtUZDA0Dfw9+/3nI5eX
         XjSX2KyVbQ8m6Kgc4hZ7ZccYFTZ5nWM34c35ZFO1lgWZptGlvjG/h+mN3Re/6pJNUPH+
         1Mv83Qel463mvsnP7RWk/Jfiyw9k4DE1uVeJOk1RTv6YsLwZKIVEEzn/4xn/W+8F51ac
         Pa2PVcACAGDB7zVFAQs0prDXdSVMprsF82xCMo7o5PVt7jpD6mXKKKiZeDeLc9MkWHRW
         CPl+DsJAVhs3HjzI8Tliyv8BfR5eLg4dUqnVn1RMriFW95nxXy4PVL6ozsjxlaYPL8MH
         BLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683807664; x=1686399664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRf/7bYU3ASVbppzqAIJlZclrPxE6HVJTYG/JZAScRs=;
        b=CPzWgHNrBUrMQd6HrFTkiJgxyyaF414lbasdmpGAKYXvCB7sAl1xfSmpRzuGMM5XuH
         FNOL/Ham7h4wneyuibRDXjRgScDuVF7NN1AX5zKL3pcmswSuHwhEJtemGJguzEhLEGgx
         lF/ZhoX75ElfLvmRcXnIYHRaOLcn/dX6UXZPcnpA2NZu5fEyeKEPKWbgJhjsKT/YIGkh
         SKgDOZ8ydKagd2T2RXMP2aOxFCvJJRVndcWPXE4eCXtSSRIaNfIuDXWjj+1w5HRtZyEO
         lHZTCUTnUy8x1EACB1Vmp2+7wr1IZD01cPmewN3elSeDyuD5Lpa14ovgvSuHu6Ciiygr
         I4VQ==
X-Gm-Message-State: AC+VfDzqsI39Q3CXIiHnMahEFcNHFJuSCouGTKOYdYmT0Yv2nD8SIPxi
        7Bm5d+FqSZJ+g7krwV8sZE0qQw==
X-Google-Smtp-Source: ACHHUZ6iZtjroYyNPUNLVmJno1jDVvsHwKiW4Ji4CvqXcp98aqd9dZG+s1pVtR1LF/DIkAE/+Cv3dw==
X-Received: by 2002:a17:907:6d8d:b0:96a:3e39:f567 with SMTP id sb13-20020a1709076d8d00b0096a3e39f567mr4844456ejc.47.1683807664369;
        Thu, 11 May 2023 05:21:04 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00960005e09a3sm3990513ejb.61.2023.05.11.05.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:21:03 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     tony@atomide.com, lee@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, nm@ti.com, afd@ti.com, msp@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off API
Date:   Thu, 11 May 2023 14:21:00 +0200
Message-Id: <20230511122100.2225417-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new API for power-off mode support:
Link: https://lwn.net/Articles/894511/
Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/

sys-off API allows support of shutdown handler and restart handler.

Shutdown was not supported before that enhancement.
This is required for platform that are not using PSCI.

Test:
- restart:
  # reboot
  Default is cold reset:
  # cat /sys/kernel/reboot/mode
  Switch boot mode to warm reset:
  # echo warm > /sys/kernel/reboot/mode
- power-off:
  # halt

Tested on AM62-LP-SK board.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Suggested-by: Andrew Davis <afd@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---

Notes:
    Change-log v2 to v1
    v1: Link: https://lore.kernel.org/all/20230203140150.13071-1-jneanne@baylibre.com/
    Andrew Davis Review:
    - Use new helpers devm_register_restart_handler and devm_register_power_off_handler
    Vignesh Raghavendra:
    - Fix typo on board name in commit message

 drivers/mfd/tps65219.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e402fda206b..5115d0a66701 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -25,25 +25,34 @@ static int tps65219_cold_reset(struct tps65219 *tps)
 				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
 }
 
-static int tps65219_restart(struct notifier_block *this,
-			    unsigned long reboot_mode, void *cmd)
+static int tps65219_soft_shutdown(struct tps65219 *tps)
 {
-	struct tps65219 *tps;
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
+				  TPS65219_MFP_I2C_OFF_REQ_MASK,
+				  TPS65219_MFP_I2C_OFF_REQ_MASK);
+}
 
-	tps = container_of(this, struct tps65219, nb);
+static int tps65219_power_off_handler(struct sys_off_data *data)
+{
+	tps65219_soft_shutdown(data->cb_data);
+	return NOTIFY_DONE;
+}
 
+static int tps65219_restart(struct tps65219 *tps,
+			    unsigned long reboot_mode)
+{
 	if (reboot_mode == REBOOT_WARM)
 		tps65219_warm_reset(tps);
 	else
 		tps65219_cold_reset(tps);
-
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block pmic_rst_restart_nb = {
-	.notifier_call = tps65219_restart,
-	.priority = 200,
-};
+static int tps65219_restart_handler(struct sys_off_data *data)
+{
+	tps65219_restart(data->cb_data, data->mode);
+	return NOTIFY_DONE;
+}
 
 static const struct resource tps65219_pwrbutton_resources[] = {
 	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
@@ -269,13 +278,23 @@ static int tps65219_probe(struct i2c_client *client)
 		}
 	}
 
-	tps->nb = pmic_rst_restart_nb;
-	ret = register_restart_handler(&tps->nb);
+	ret = devm_register_restart_handler(tps->dev,
+					    tps65219_restart_handler,
+					    tps);
+
 	if (ret) {
 		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
 		return ret;
 	}
 
+	ret = devm_register_power_off_handler(tps->dev,
+					      tps65219_power_off_handler,
+					      tps);
+	if (ret) {
+		dev_err(tps->dev, "failed to register power-off handler: %d\n",
+			ret);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.34.1


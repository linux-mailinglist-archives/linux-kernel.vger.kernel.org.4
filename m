Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1640A7127C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbjEZNvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjEZNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:51:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A7194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:51:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30adc51b65cso399705f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685109065; x=1687701065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4070cfF5PAleKzRCTMiKt0VwtD6qDiaa/t3zF9r6Pw=;
        b=pvGkeNBfoRheM12DuzPmXZ7ahlXtPI/eLYGPgDI+QWpbkSnRhVb/ljv7GjNBWelAOv
         JLfoN7uasjATN3lYLg2sA5l1g2N5X5KpDb9WBbZCrNcqaa5eneVCa+pC3f3zTCaAstLX
         awTb6Oy8js8ThYd5At6mPLUaoGEWcPJV8ZDjTGqKXRvp6sd8WbZ3jrgpZvZaDtRKCH6v
         BpCY1hJRPonDwNP9zMttwGlCgJLaDoqgXr8yXPdyovn/RQ6bymgY2DMD6SpDULCpPY5r
         COarShaZ9mBr7JClEXLBrjGYhmTSBTuWtVXn5/69GbBft65zptn5jScE63S/Vl2EuitN
         35XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685109065; x=1687701065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4070cfF5PAleKzRCTMiKt0VwtD6qDiaa/t3zF9r6Pw=;
        b=audpXB5Ikq/qYoIilbThXySZnzEu+m93LoPKPk7SY/r5Nd7wEMwSF7AySVrCOL5Mi2
         Ze+EGq/9lURyidep7rayyDUC0Z2vfQD8ToYPtflU65MfapjuVhsbRP+plg/1gm6I/hlA
         QoulfOqj/kg+h5zh/FBQ/+sEj5i1AT2b+KwD/UY6bblpBoKsjN4zKjIiVHwYaHmr+tEV
         KTj2xbmDCFIn2+NsaKUXUVlQnFuK3epejfs3BqkNPRQ2bQOOUC6JYkbOL4aqk54utsjU
         b8rxIf9Y6KzCXP4axZz9k25md4FXIuXgoOER5Uc/tJy+uOlDzaeQVsdXUhg/SLStHzak
         IGLQ==
X-Gm-Message-State: AC+VfDxM8w/5dgL99LPIwUXZL08YAH/feMo3CrDp5WsZ3OiDHlC9yx4x
        +duJl9cr7AoL3ttflzwZYlJR0A==
X-Google-Smtp-Source: ACHHUZ59GzzDMqpiu+zvEl5DmMgWH/+NYpooPinDueRtYO4GKCtFr2pcv/fUkO296/l8mRcn7QpijQ==
X-Received: by 2002:a5d:6b86:0:b0:30a:d867:da29 with SMTP id n6-20020a5d6b86000000b0030ad867da29mr1175624wrx.33.1685109065377;
        Fri, 26 May 2023 06:51:05 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003eddc6aa5fasm8839828wmd.39.2023.05.26.06.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 06:51:04 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     tony@atomide.com, lee@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, nm@ti.com, afd@ti.com, msp@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH v3] mfd: tps65219: Add support for soft shutdown via sys-off API
Date:   Fri, 26 May 2023 15:51:00 +0200
Message-Id: <20230526135100.2867741-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
    Change-log v3 to v2
    v2: Link: https://lore.kernel.org/lkml/20230511122100.2225417-1-jneanne@baylibre.com/
    Lee Jones Review:
    nits: rm not needed line wraps and restore a cr deleted not related with the patch.
    
    Change-log v2 to v1
    v1: Link: https://lore.kernel.org/all/20230203140150.13071-1-jneanne@baylibre.com/
    Andrew Davis Review:
    - Use new helpers devm_register_restart_handler and devm_register_power_off_handler
    Vignesh Raghavendra:
    - Fix typo on board name in commit message

 drivers/mfd/tps65219.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e402fda206b..3d9164491e20 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -25,13 +25,21 @@ static int tps65219_cold_reset(struct tps65219 *tps)
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
 
+static int tps65219_restart(struct tps65219 *tps, unsigned long reboot_mode)
+{
 	if (reboot_mode == REBOOT_WARM)
 		tps65219_warm_reset(tps);
 	else
@@ -40,10 +48,11 @@ static int tps65219_restart(struct notifier_block *this,
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
@@ -269,13 +278,22 @@ static int tps65219_probe(struct i2c_client *client)
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
+		dev_err(tps->dev, "failed to register power-off handler: %d\n", ret);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.34.1


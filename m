Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195E6675792
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjATOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjATOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:41:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C915643446
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674225644; x=1705761644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETrCqr1esSdpLl/whNaGbQbj8ly4dFAvvv640kfUFd4=;
  b=v+G4fhXRROkNubAj9uB8lEyZjJ5c33z2Wv5dzL2pLaNfZPQWKvooQekl
   vOU8Sb5JtDL+Y1/KILRUGMEteQtygXX1mhKLSY0en621bcJHPBnqBe3eZ
   d1sY5EfQkDC7sWzp0nkWSvYvYpxkINvswm7tEXj3viC7MTARUsq8lXeon
   kOAVxKJPW2QaY09Z3yzrafqeS+fZrBGDCrAO0UOq6O23gM5RpGrHTWjXo
   U+kLTJsFoJ/R2pORqieSVfoYolu4RIpNQJC8QeiMbPMT+YkVBA86XFodj
   jYQtyWHrMAdegEZMtMCHNfd5jE8turwb+v3nHn+vEZ/V2PVeJMiamJ6m2
   A==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="208646938"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:38:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:38:18 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:38:17 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/7] soc: microchip: mpfs: simplify error handling in mpfs_blocking_transaction()
Date:   Fri, 20 Jan 2023 14:37:34 +0000
Message-ID: <20230120143734.3438755-7-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120143734.3438755-1-conor.dooley@microchip.com>
References: <20230120143734.3438755-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling has a kinda weird nested-if setup that is not really
adding anything. Switch it to more of an early return arrangement as a
predatory step for adding different handing for timeouts and failed
services.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 28 ++++++++++-----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index e76a5e38f655..da9cfeda6f78 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -36,28 +36,26 @@ struct mpfs_sys_controller {
 int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct mpfs_mss_msg *msg)
 {
 	unsigned long timeout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
-	int ret, err;
+	int ret;
 
-	err = mutex_lock_interruptible(&transaction_lock);
-	if (err)
-		return err;
+	ret = mutex_lock_interruptible(&transaction_lock);
+	if (ret)
+		return ret;
 
 	reinit_completion(&sys_controller->c);
 
 	ret = mbox_send_message(sys_controller->chan, msg);
-	if (ret >= 0) {
-		if (wait_for_completion_timeout(&sys_controller->c, timeout)) {
-			ret = 0;
-		} else {
-			ret = -ETIMEDOUT;
-			dev_warn(sys_controller->client.dev,
-				 "MPFS sys controller transaction timeout\n");
-		}
-	} else {
-		dev_err(sys_controller->client.dev,
-			"mpfs sys controller transaction returned %d\n", ret);
+	if (ret < 0)
+		goto out;
+
+	ret = 0; /* mbox_send_message returns positive integers on success */
+	if (!wait_for_completion_timeout(&sys_controller->c, timeout)) {
+		ret = -ETIMEDOUT;
+		dev_warn(sys_controller->client.dev,
+			 "MPFS sys controller transaction timeout\n");
 	}
 
+out:
 	mutex_unlock(&transaction_lock);
 
 	return ret;
-- 
2.39.0


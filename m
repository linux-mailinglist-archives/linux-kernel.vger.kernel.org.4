Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D4665CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjAKNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjAKNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:46:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C96377
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673444760; x=1704980760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqNf1ACM7VOxiqPM+Nc/J8oy1t3x6F1UdtTIb0rpr7I=;
  b=HNgQT6/xqaclpb6BB9Ms3IT/aqfWjwVaIw2SeWoG+7pJBAlm+XlfWRn5
   b/wOm2xqlXW+DswFNVuvQ+WV4lF2w3MsEmN0erqf234Afo8L/F1Xo87eG
   v+t/GnPTBkxeAW0Y+gMxNq8m5OdLp/CjeNp8dSIOILV0wTAHzLKaXJBIv
   JHGtJiLnyLjWNpuOxs1sUSBG182yzWVmWJ0strW6QyEtvm9dNDcPOg/Ff
   sot3XpAY3dvfHmvF2mi3tkbaTXSyU3y/+I5k8auFunfQrODP6dNYmND7+
   LnCe25E5VEHj6mXlcC83kXAoszQWtCvibXCOMIbHezUyumnpjLXqo3Eo4
   w==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="131834669"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 06:45:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 06:45:56 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Wed, 11 Jan 2023 06:45:55 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 6/7] soc: microchip: mpfs: simplify error handling in mpfs_blocking_transaction()
Date:   Wed, 11 Jan 2023 13:45:12 +0000
Message-ID: <20230111134513.2495510-7-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111134513.2495510-1-conor.dooley@microchip.com>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
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
index 738ecd624d64..4aadd05769d2 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -32,28 +32,26 @@ struct mpfs_sys_controller {
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
+	ret = 0; /* mbox_send_message returns postitive integers on success */
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


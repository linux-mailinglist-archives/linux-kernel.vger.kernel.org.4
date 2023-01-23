Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02A67753C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAWGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjAWGyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:22 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73EE12F21
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:54:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3EFB1424EC;
        Mon, 23 Jan 2023 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1674456860; bh=3ATZOYbwia5bXZiTe4S5ArLfc1jiIEHgvpFPv0DhVeI=;
        h=From:To:Cc:Subject:Date;
        b=npXBRqiUm+EM+RWevPNma/xz+UbtBNb9c48qZoNCGt0CFRsTTtg1Mpuqo9LNJOrKM
         vcp7qQK5bC9v/yJqcwB7wOgOQwvBzhdDELhGuYRhBFhrrMBwuVd0X+QaTeWj86rhpF
         Vd1Sq3LUAayez0qO59P+A3bwJVbfr5f1YBuV8XCYTIeUuaZTObU2EIusG06c99lnCY
         kQNeSZrp+CMY3hJjeSXKHVS4ft2rnJO9jwL9XIUNqvOr2zgxGsZAxlM/ReU6fSRwrE
         rBPJJMckQh2K/IdpXgUKdPSveh1bLBr1EitCbfS3omgH9dEZQNP4AdXM0OYcRpHicV
         mhInNYynK515g==
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] soc: apple: rtkit: Add apple_rtkit_idle() function
Date:   Mon, 23 Jan 2023 15:53:54 +0900
Message-Id: <20230123065354.28179-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another low power mode, used by DCP.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/soc/apple/rtkit.c       | 21 +++++++++++++++++++++
 include/linux/soc/apple/rtkit.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index ceb4516e442c..509b050cf040 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -9,6 +9,7 @@
 enum {
 	APPLE_RTKIT_PWR_STATE_OFF = 0x00, /* power off, cannot be restarted */
 	APPLE_RTKIT_PWR_STATE_SLEEP = 0x01, /* sleeping, can be restarted */
+	APPLE_RTKIT_PWR_STATE_IDLE = 0x201, /* sleeping, retain state */
 	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10, /* running but no communication */
 	APPLE_RTKIT_PWR_STATE_ON = 0x20, /* normal operating state */
 };
@@ -882,6 +883,26 @@ int apple_rtkit_shutdown(struct apple_rtkit *rtk)
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_shutdown);
 
+int apple_rtkit_idle(struct apple_rtkit *rtk)
+{
+	int ret;
+
+	/* if OFF is used here the co-processor will not wake up again */
+	ret = apple_rtkit_set_ap_power_state(rtk,
+					     APPLE_RTKIT_PWR_STATE_IDLE);
+	if (ret)
+		return ret;
+
+	ret = apple_rtkit_set_iop_power_state(rtk, APPLE_RTKIT_PWR_STATE_IDLE);
+	if (ret)
+		return ret;
+
+	rtk->iop_power_state = APPLE_RTKIT_PWR_STATE_IDLE;
+	rtk->ap_power_state = APPLE_RTKIT_PWR_STATE_IDLE;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_idle);
+
 int apple_rtkit_quiesce(struct apple_rtkit *rtk)
 {
 	int ret;
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index 2a0edb5fa6fe..f8d9cc0691de 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -132,6 +132,11 @@ int apple_rtkit_wake(struct apple_rtkit *rtk);
  */
 int apple_rtkit_shutdown(struct apple_rtkit *rtk);
 
+/*
+ * Put the co-processor into idle mode
+ */
+int apple_rtkit_idle(struct apple_rtkit *rtk);
+
 /*
  * Checks if RTKit is running and ready to handle messages.
  */
-- 
2.35.1


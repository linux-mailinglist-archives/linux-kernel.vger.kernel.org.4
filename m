Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF26EC994
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjDXJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjDXJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:55:47 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8A40F0;
        Mon, 24 Apr 2023 02:55:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id DA6EB5EA88;
        Mon, 24 Apr 2023 12:35:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-ogYNo2U7;
        Mon, 24 Apr 2023 12:35:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328959;
        bh=iOOPWZopx7qpDvb3sEH1pWrdV4nbUnzXRBxcuSzX3T8=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=srLCbG2GEk+PzfcAIp2h75Rauh7y4FAEXroJ2CLQVVLBTaSJHBixNK/vNcv5SpXNH
         paCsCyk06nCMV0Os8fszEmttapHpsfUh4QHl/Qj7+Uvnhc3FUhAb0SFd2R3zRMtVv8
         pHmhtGOkY/pJov6sAsk80DmR+/JPlUYygKNRK9Hw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/43] pata: cirrus: add DT support for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:41 +0300
Message-Id: <20230424123522.18302-26-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- find register range from the device tree
- get interrupts from device tree

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - wildcards ep93xx to something meaningful, i.e. ep9301
    - drop wrappers

 drivers/ata/pata_ep93xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 47845d920075..09c95758389e 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -40,6 +40,8 @@
 #include <linux/ata.h>
 #include <linux/libata.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/ktime.h>
@@ -1016,9 +1018,16 @@ static int ep93xx_pata_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_pata_of_ids[] = {
+	{ .compatible = "cirrus,ep9312-pata" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pata_of_ids);
+
 static struct platform_driver ep93xx_pata_platform_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ep93xx_pata_of_ids,
 	},
 	.probe = ep93xx_pata_probe,
 	.remove = ep93xx_pata_remove,
-- 
2.39.2


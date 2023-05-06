Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7ED6F9070
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjEFIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:07:34 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9047D84;
        Sat,  6 May 2023 01:07:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VhsmiiL_1683360447;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VhsmiiL_1683360447)
          by smtp.aliyun-inc.com;
          Sat, 06 May 2023 16:07:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dario.binacchi@amarulasolutions.com
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] can: bxcan: Remove unnecessary print function dev_err()
Date:   Sat,  6 May 2023 16:07:25 +0800
Message-Id: <20230506080725.68401-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

./drivers/net/can/bxcan.c:970:2-9: line 970 is redundant because platform_get_irq() already prints an error.
./drivers/net/can/bxcan.c:964:2-9: line 964 is redundant because platform_get_irq() already prints an error.
./drivers/net/can/bxcan.c:958:2-9: line 958 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4878
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/can/bxcan.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index e26ccd41e3cb..7b285eeb08a1 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -954,22 +954,16 @@ static int bxcan_probe(struct platform_device *pdev)
 	}
 
 	rx_irq = platform_get_irq_byname(pdev, "rx0");
-	if (rx_irq < 0) {
-		dev_err(dev, "failed to get rx0 irq\n");
+	if (rx_irq < 0)
 		return rx_irq;
-	}
 
 	tx_irq = platform_get_irq_byname(pdev, "tx");
-	if (tx_irq < 0) {
-		dev_err(dev, "failed to get tx irq\n");
+	if (tx_irq < 0)
 		return tx_irq;
-	}
 
 	sce_irq = platform_get_irq_byname(pdev, "sce");
-	if (sce_irq < 0) {
-		dev_err(dev, "failed to get sce irq\n");
+	if (sce_irq < 0)
 		return sce_irq;
-	}
 
 	ndev = alloc_candev(sizeof(struct bxcan_priv), BXCAN_TX_MB_NUM);
 	if (!ndev) {
-- 
2.20.1.7.g153144c


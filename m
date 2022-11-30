Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABF263CFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiK3HUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3HU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:20:28 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874712A24D;
        Tue, 29 Nov 2022 23:20:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VW1oelD_1669792816;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VW1oelD_1669792816)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 15:20:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     p.zabel@pengutronix.de, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] media: rzg2l-cru: Fix missing error code in rzg2l_cru_start_streaming_vq()
Date:   Wed, 30 Nov 2022 15:20:14 +0800
Message-Id: <20221130072014.95092-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failed to allocate scratch buffer, add the error code '-ENOMEM' to the
return value 'ret'.

drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:676 rzg2l_cru_start_streaming_vq() warn: missing error code 'ret'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3275
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Modified the subject line to "media: rzg2l-cru:".

 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 9533e4069ecd..91b57c7c2e56 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -673,6 +673,7 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int count
 	if (!cru->scratch) {
 		return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
 		dev_err(cru->dev, "Failed to allocate scratch buffer\n");
+		ret = -ENOMEM;
 		goto free_image_conv_irq;
 	}
 
-- 
2.20.1.7.g153144c


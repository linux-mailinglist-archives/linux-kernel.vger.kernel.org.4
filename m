Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8396A513A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjB1Cc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB1Cc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:32:56 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB744B7;
        Mon, 27 Feb 2023 18:32:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vch6SxF_1677551565;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vch6SxF_1677551565)
          by smtp.aliyun-inc.com;
          Tue, 28 Feb 2023 10:32:51 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] spi/bcm63xx: Remove the unused function bcm_spi_readw()
Date:   Tue, 28 Feb 2023 10:32:43 +0800
Message-Id: <20230228023243.118429-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function bcm_spi_readw is defined in the spi-bcm63xx.c file, but
not called elsewhere, so remove this unused function.

drivers/spi/spi-bcm63xx.c:160:19: warning: unused function 'bcm_spi_readw'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4242
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/spi/spi-bcm63xx.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 3686d78c44a6..7279e6b883c1 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -157,16 +157,6 @@ static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
 	return readb(bs->regs + bs->reg_offsets[offset]);
 }
 
-static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
-				unsigned int offset)
-{
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	return ioread16be(bs->regs + bs->reg_offsets[offset]);
-#else
-	return readw(bs->regs + bs->reg_offsets[offset]);
-#endif
-}
-
 static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
 				  u8 value, unsigned int offset)
 {
-- 
2.20.1.7.g153144c


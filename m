Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420836B8B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCNGcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCNGcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:32:23 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C98F525;
        Mon, 13 Mar 2023 23:32:21 -0700 (PDT)
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdqyGsC_1678775538)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 14:32:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] crypto: stm32-hash - Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 14 Mar 2023 14:32:16 +0800
Message-Id: <20230314063216.21470-1-yang.lee@linux.alibaba.com>
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

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/crypto/stm32/stm32-hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 7bf805563ac2..1422d609824b 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1616,8 +1616,7 @@ static int stm32_hash_probe(struct platform_device *pdev)
 	if (!hdev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdev->io_base = devm_ioremap_resource(dev, res);
+	hdev->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hdev->io_base))
 		return PTR_ERR(hdev->io_base);
 
-- 
2.20.1.7.g153144c


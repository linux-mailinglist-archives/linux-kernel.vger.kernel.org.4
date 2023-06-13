Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6701872D6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjFMBTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFMBTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:19:05 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF6110C6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:19:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl.rCPw_1686619134;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vl.rCPw_1686619134)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 09:19:01 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] tee: optee: Use kmemdup() to replace kmalloc + memcpy
Date:   Tue, 13 Jun 2023 09:18:53 +0800
Message-Id: <20230613011853.6385-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation.

./drivers/tee/optee/smc_abi.c:1542:12-19: WARNING opportunity for kmemdup.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5480
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Add one commit message.

 drivers/tee/optee/smc_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 3861ae06d902..d5b28fd35d66 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1541,12 +1541,11 @@ static int optee_load_fw(struct platform_device *pdev,
 	 * This uses the GFP_DMA flag to ensure we are allocated memory in the
 	 * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
 	 */
-	data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
+	data_buf = kmemdup(fw->data, fw->size, GFP_KERNEL | GFP_DMA);
 	if (!data_buf) {
 		rc = -ENOMEM;
 		goto fw_err;
 	}
-	memcpy(data_buf, fw->data, fw->size);
 	data_pa = virt_to_phys(data_buf);
 	reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
 	reg_pair_from_64(&data_size_high, &data_size_low, data_size);
-- 
2.20.1.7.g153144c


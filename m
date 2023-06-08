Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD6727C82
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjFHKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFHKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:13:40 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430602D4A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:13:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkdsXMR_1686219202;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VkdsXMR_1686219202)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 18:13:24 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     tianruidong@linux.alibaba.com, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: tmc: Explicit type conversions to prevent integer overflow
Date:   Thu,  8 Jun 2023 18:13:10 +0800
Message-Id: <20230608101310.66129-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"nr_pages << PAGE_SHIFT" will overflow when nr_pages is integer and
nr_pages >= 0x80000. That means Coresight ETR can not alloc more than
1G buffer. Explicit convert nr_pages to 64 bit to avoid overflow.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 766325de0e29..1425ecd1cf78 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1267,7 +1267,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	 * than the size requested via sysfs.
 	 */
 	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
-		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
+		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
 					    0, node, NULL);
 		if (!IS_ERR(etr_buf))
 			goto done;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index b97da39652d2..0ee48c5ba764 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
-	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
+	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
-- 
2.33.1


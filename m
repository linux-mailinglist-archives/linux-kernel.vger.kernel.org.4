Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250A96719A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjARKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjARKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:50:36 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE448584;
        Wed, 18 Jan 2023 01:59:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VZpnINn_1674035937;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VZpnINn_1674035937)
          by smtp.aliyun-inc.com;
          Wed, 18 Jan 2023 17:59:10 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     vneethv@linux.ibm.com
Cc:     oberpar@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] s390/chsc: Switch over to memdup_user()
Date:   Wed, 18 Jan 2023 17:58:23 +0800
Message-Id: <20230118095823.18785-1-jiapeng.chong@linux.alibaba.com>
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

Use memdup_user rather than duplicating its implementation, this is a
little bit restricted to reduce false positives.

./drivers/s390/cio/chsc_sch.c:703:7-14: WARNING opportunity for
memdup_user.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3785
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Add free_page((unsigned long)sccl_area); 

 drivers/s390/cio/chsc_sch.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 180ab899289c..09dcce7ff24b 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -700,15 +700,13 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccl_area)
 		return -ENOMEM;
-	ccl = kzalloc(sizeof(*ccl), GFP_KERNEL);
-	if (!ccl) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
-		ret = -EFAULT;
-		goto out_free;
+
+	ccl = memdup_user(user_ccl, sizeof(*ccl));
+	if (IS_ERR(ccl)) {
+		free_page((unsigned long)sccl_area);
+		return PTR_ERR(ccl);
 	}
+
 	sccl_area->request.length = 0x0020;
 	sccl_area->request.code = 0x0030;
 	sccl_area->fmt = ccl->req.fmt;
-- 
2.20.1.7.g153144c


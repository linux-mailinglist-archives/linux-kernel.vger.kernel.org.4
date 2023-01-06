Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A865F90C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjAFBZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAFBZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:25:10 -0500
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261946FE1A;
        Thu,  5 Jan 2023 17:19:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYxJXpw_1672967833;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VYxJXpw_1672967833)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 09:17:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     quic_schowdhu@quicinc.com
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] soc: qcom: dcc: Fix unsigned comparison with less than zero
Date:   Fri,  6 Jan 2023 09:17:10 +0800
Message-Id: <20230106011710.2827-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from the call to kstrtouint_from_user() is int.
However, the return value is being assigned to
an unsigned int variable 'ret', so making 'ret' an int.

Eliminate the following warning:
./drivers/soc/qcom/dcc.c:815:5-8: WARNING: Unsigned expression compared with zero: ret < 0

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3638
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/soc/qcom/dcc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index d4101f79cb5d..5b50d638771d 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -808,7 +808,8 @@ static ssize_t config_reset_write(struct file *filp,
 				  const char __user *user_buf, size_t count,
 				  loff_t *ppos)
 {
-	unsigned int val, ret;
+	unsigned int val;
+	int ret;
 	struct dcc_drvdata *drvdata = filp->private_data;
 
 	ret = kstrtouint_from_user(user_buf, count, 0, &val);
-- 
2.20.1.7.g153144c


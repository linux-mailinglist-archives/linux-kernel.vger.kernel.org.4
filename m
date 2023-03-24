Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3706C7582
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCXCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCXCTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:19:30 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE35BBF;
        Thu, 23 Mar 2023 19:19:29 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PjQrb3fXtz50FXF;
        Fri, 24 Mar 2023 10:19:27 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 32O2IqSS000686;
        Fri, 24 Mar 2023 10:19:22 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 24 Mar 2023 10:18:53 +0800 (CST)
Date:   Fri, 24 Mar 2023 10:18:53 +0800 (CST)
X-Zmail-TransId: 2afa641d088dffffffffd44-a8819
X-Mailer: Zmail v1.0
Message-ID: <202303241018532824420@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <agross@kernel.org>
Cc:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzb2M6IHFjb206IHNtc206IFVzZSBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32O2IqSS000686
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641D08AF.000/4PjQrb3fXtz50FXF
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/soc/qcom/smsm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index 8c137dff7dac..c58cfff64856 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -452,11 +452,10 @@ static int smsm_get_size_info(struct qcom_smsm *smsm)
 	} *info;

 	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_SMSM_SIZE_INFO, &size);
-	if (IS_ERR(info) && PTR_ERR(info) != -ENOENT) {
-		if (PTR_ERR(info) != -EPROBE_DEFER)
-			dev_err(smsm->dev, "unable to retrieve smsm size info\n");
-		return PTR_ERR(info);
-	} else if (IS_ERR(info) || size != sizeof(*info)) {
+	if (IS_ERR(info) && PTR_ERR(info) != -ENOENT)
+		return dev_err_probe(smsm->dev, PTR_ERR(info),
+				     "unable to retrieve smsm size info\n");
+	else if (IS_ERR(info) || size != sizeof(*info)) {
 		dev_warn(smsm->dev, "no smsm size info, using defaults\n");
 		smsm->num_entries = SMSM_DEFAULT_NUM_ENTRIES;
 		smsm->num_hosts = SMSM_DEFAULT_NUM_HOSTS;
-- 
2.25.1

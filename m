Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564F3638413
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKYGhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:37:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E29FF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:37:41 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJQ6t6wdrzqSd7;
        Fri, 25 Nov 2022 14:33:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 14:37:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 14:37:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <viresh.kumar@linaro.org>, <Tushar.Khandelwal@arm.com>,
        <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailbox: arm_mhuv2: Fix return value check in mhuv2_probe()
Date:   Fri, 25 Nov 2022 14:35:48 +0800
Message-ID: <20221125063549.2546364-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_of_iomap() fails, it returns ERR_PTR() and never
return NULL, so replace NULL pointer check with IS_ERR()
to fix this problem.

Fixes: 5a6338cce9f4 ("mailbox: arm_mhuv2: Add driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mailbox/arm_mhuv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index a47aef8df52f..c6d4957c4da8 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -1062,8 +1062,8 @@ static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
 	int ret = -EINVAL;
 
 	reg = devm_of_iomap(dev, dev->of_node, 0, NULL);
-	if (!reg)
-		return -ENOMEM;
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
 	if (!mhu)
-- 
2.25.1


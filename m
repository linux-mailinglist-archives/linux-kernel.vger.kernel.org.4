Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73C7630DED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiKSJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKSJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:48:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319A61004E;
        Sat, 19 Nov 2022 01:48:31 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDpdy2ykgzqSWc;
        Sat, 19 Nov 2022 17:44:38 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:48:29 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:48:28 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - fix 'QM_XEQ_DEPTH_CAP' mask value
Date:   Sat, 19 Nov 2022 17:48:43 +0800
Message-ID: <20221119094843.10707-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'QM_XEQ_DEPTH_CAP' mask value is GENMASK(31, 0) instead of GENMASK(15, 0).
If the mask value is incorrect, will cause abnormal events cannot be
handled. So fix it.

Fixes: 129a9f340172 ("crypto: hisilicon/qm - get qp num and depth from hardware registers")
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 36d70b9f6117..9072bee7336f 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -336,7 +336,7 @@ static const struct hisi_qm_cap_info qm_cap_info_vf[] = {
 static const struct hisi_qm_cap_info qm_basic_info[] = {
 	{QM_TOTAL_QP_NUM_CAP,   0x100158, 0,  GENMASK(10, 0), 0x1000,    0x400,     0x400},
 	{QM_FUNC_MAX_QP_CAP,    0x100158, 11, GENMASK(10, 0), 0x1000,    0x400,     0x400},
-	{QM_XEQ_DEPTH_CAP,      0x3104,   0,  GENMASK(15, 0), 0x800,     0x4000800, 0x4000800},
+	{QM_XEQ_DEPTH_CAP,      0x3104,   0,  GENMASK(31, 0), 0x800,     0x4000800, 0x4000800},
 	{QM_QP_DEPTH_CAP,       0x3108,   0,  GENMASK(31, 0), 0x4000400, 0x4000400, 0x4000400},
 	{QM_EQ_IRQ_TYPE_CAP,    0x310c,   0,  GENMASK(31, 0), 0x10000,   0x10000,   0x10000},
 	{QM_AEQ_IRQ_TYPE_CAP,   0x3110,   0,  GENMASK(31, 0), 0x0,       0x10001,   0x10001},
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8460831D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJVBXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJVBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:23:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809152B2E3D;
        Fri, 21 Oct 2022 18:23:38 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MvNnd2YPdzJn6v;
        Sat, 22 Oct 2022 09:20:53 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 09:23:35 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 22 Oct
 2022 09:23:35 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH v3 1/3] crypto: hisilicon/qm - increase the memory of local variables
Date:   Sat, 22 Oct 2022 01:17:44 +0000
Message-ID: <20221022011746.27197-2-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221022011746.27197-1-yekai13@huawei.com>
References: <20221022011746.27197-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the buffer to prevent stack overflow by fuzz test. The maximum
length of the qos configuration buffer is 256 bytes. Currently, the value
of the 'val buffer' is only 32 bytes. The sscanf does not check the dest
memory length. So the 'val buffer' may stack overflow.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e3edb176d976..5d79e9f0e7e1 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -250,7 +250,6 @@
 #define QM_QOS_MIN_CIR_B		100
 #define QM_QOS_MAX_CIR_U		6
 #define QM_QOS_MAX_CIR_S		11
-#define QM_QOS_VAL_MAX_LEN		32
 #define QM_DFX_BASE		0x0100000
 #define QM_DFX_STATE1		0x0104000
 #define QM_DFX_STATE2		0x01040C8
@@ -4612,7 +4611,7 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 			       unsigned int *fun_index)
 {
 	char tbuf_bdf[QM_DBG_READ_LEN] = {0};
-	char val_buf[QM_QOS_VAL_MAX_LEN] = {0};
+	char val_buf[QM_DBG_READ_LEN] = {0};
 	u32 tmp1, device, function;
 	int ret, bus;
 
-- 
2.17.1


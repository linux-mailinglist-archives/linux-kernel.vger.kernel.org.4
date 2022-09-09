Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD845B3494
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiIIJuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIIJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127E33A00;
        Fri,  9 Sep 2022 02:49:52 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB2Y11TnzmVLR;
        Fri,  9 Sep 2022 17:46:13 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:50 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Zhiqi Song <songzhiqi1@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 07/10] crypto: hisilicon/hpre - optimize registration of ecdh
Date:   Fri, 9 Sep 2022 17:47:01 +0800
Message-ID: <20220909094704.32099-8-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220909094704.32099-1-qianweili@huawei.com>
References: <20220909094704.32099-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqi Song <songzhiqi1@huawei.com>

Use table to store the different ecdh curve configuration,
making the registration of ecdh clearer and expansion more
convenient.

Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 136 +++++++++-----------
 1 file changed, 63 insertions(+), 73 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index ad1475feb313..ac7fabf65865 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -2008,55 +2008,53 @@ static struct kpp_alg dh = {
 	},
 };
 
-static struct kpp_alg ecdh_nist_p192 = {
-	.set_secret = hpre_ecdh_set_secret,
-	.generate_public_key = hpre_ecdh_compute_value,
-	.compute_shared_secret = hpre_ecdh_compute_value,
-	.max_size = hpre_ecdh_max_size,
-	.init = hpre_ecdh_nist_p192_init_tfm,
-	.exit = hpre_ecdh_exit_tfm,
-	.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
-	.base = {
-		.cra_ctxsize = sizeof(struct hpre_ctx),
-		.cra_priority = HPRE_CRYPTO_ALG_PRI,
-		.cra_name = "ecdh-nist-p192",
-		.cra_driver_name = "hpre-ecdh-nist-p192",
-		.cra_module = THIS_MODULE,
-	},
-};
-
-static struct kpp_alg ecdh_nist_p256 = {
-	.set_secret = hpre_ecdh_set_secret,
-	.generate_public_key = hpre_ecdh_compute_value,
-	.compute_shared_secret = hpre_ecdh_compute_value,
-	.max_size = hpre_ecdh_max_size,
-	.init = hpre_ecdh_nist_p256_init_tfm,
-	.exit = hpre_ecdh_exit_tfm,
-	.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
-	.base = {
-		.cra_ctxsize = sizeof(struct hpre_ctx),
-		.cra_priority = HPRE_CRYPTO_ALG_PRI,
-		.cra_name = "ecdh-nist-p256",
-		.cra_driver_name = "hpre-ecdh-nist-p256",
-		.cra_module = THIS_MODULE,
-	},
-};
-
-static struct kpp_alg ecdh_nist_p384 = {
-	.set_secret = hpre_ecdh_set_secret,
-	.generate_public_key = hpre_ecdh_compute_value,
-	.compute_shared_secret = hpre_ecdh_compute_value,
-	.max_size = hpre_ecdh_max_size,
-	.init = hpre_ecdh_nist_p384_init_tfm,
-	.exit = hpre_ecdh_exit_tfm,
-	.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
-	.base = {
-		.cra_ctxsize = sizeof(struct hpre_ctx),
-		.cra_priority = HPRE_CRYPTO_ALG_PRI,
-		.cra_name = "ecdh-nist-p384",
-		.cra_driver_name = "hpre-ecdh-nist-p384",
-		.cra_module = THIS_MODULE,
-	},
+static struct kpp_alg ecdh_curves[] = {
+	{
+		.set_secret = hpre_ecdh_set_secret,
+		.generate_public_key = hpre_ecdh_compute_value,
+		.compute_shared_secret = hpre_ecdh_compute_value,
+		.max_size = hpre_ecdh_max_size,
+		.init = hpre_ecdh_nist_p192_init_tfm,
+		.exit = hpre_ecdh_exit_tfm,
+		.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
+		.base = {
+			.cra_ctxsize = sizeof(struct hpre_ctx),
+			.cra_priority = HPRE_CRYPTO_ALG_PRI,
+			.cra_name = "ecdh-nist-p192",
+			.cra_driver_name = "hpre-ecdh-nist-p192",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.set_secret = hpre_ecdh_set_secret,
+		.generate_public_key = hpre_ecdh_compute_value,
+		.compute_shared_secret = hpre_ecdh_compute_value,
+		.max_size = hpre_ecdh_max_size,
+		.init = hpre_ecdh_nist_p256_init_tfm,
+		.exit = hpre_ecdh_exit_tfm,
+		.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
+		.base = {
+			.cra_ctxsize = sizeof(struct hpre_ctx),
+			.cra_priority = HPRE_CRYPTO_ALG_PRI,
+			.cra_name = "ecdh-nist-p256",
+			.cra_driver_name = "hpre-ecdh-nist-p256",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.set_secret = hpre_ecdh_set_secret,
+		.generate_public_key = hpre_ecdh_compute_value,
+		.compute_shared_secret = hpre_ecdh_compute_value,
+		.max_size = hpre_ecdh_max_size,
+		.init = hpre_ecdh_nist_p384_init_tfm,
+		.exit = hpre_ecdh_exit_tfm,
+		.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
+		.base = {
+			.cra_ctxsize = sizeof(struct hpre_ctx),
+			.cra_priority = HPRE_CRYPTO_ALG_PRI,
+			.cra_name = "ecdh-nist-p384",
+			.cra_driver_name = "hpre-ecdh-nist-p384",
+			.cra_module = THIS_MODULE,
+		},
+	}
 };
 
 static struct kpp_alg curve25519_alg = {
@@ -2123,46 +2121,38 @@ static void hpre_unregister_dh(struct hisi_qm *qm)
 
 static int hpre_register_ecdh(struct hisi_qm *qm)
 {
-	int ret;
+	int ret, i;
 
 	if (!hpre_check_alg_support(qm, HPRE_DRV_ECDH_MASK_CAP))
 		return 0;
 
-	ret = crypto_register_kpp(&ecdh_nist_p192);
-	if (ret) {
-		dev_err(&qm->pdev->dev, "failed to register ecdh_nist_p192 (%d)!\n", ret);
-		return ret;
-	}
-
-	ret = crypto_register_kpp(&ecdh_nist_p256);
-	if (ret) {
-		dev_err(&qm->pdev->dev, "failed to register ecdh_nist_p256 (%d)!\n", ret);
-		goto unregister_ecdh_p192;
-	}
-
-	ret = crypto_register_kpp(&ecdh_nist_p384);
-	if (ret) {
-		dev_err(&qm->pdev->dev, "failed to register ecdh_nist_p384 (%d)!\n", ret);
-		goto unregister_ecdh_p256;
+	for (i = 0; i < ARRAY_SIZE(ecdh_curves); i++) {
+		ret = crypto_register_kpp(&ecdh_curves[i]);
+		if (ret) {
+			dev_err(&qm->pdev->dev, "failed to register %s (%d)!\n",
+				ecdh_curves[i].base.cra_name, ret);
+			goto unreg_kpp;
+		}
 	}
 
 	return 0;
 
-unregister_ecdh_p256:
-	crypto_unregister_kpp(&ecdh_nist_p256);
-unregister_ecdh_p192:
-	crypto_unregister_kpp(&ecdh_nist_p192);
+unreg_kpp:
+	for (--i; i >= 0; --i)
+		crypto_unregister_kpp(&ecdh_curves[i]);
+
 	return ret;
 }
 
 static void hpre_unregister_ecdh(struct hisi_qm *qm)
 {
+	int i;
+
 	if (!hpre_check_alg_support(qm, HPRE_DRV_ECDH_MASK_CAP))
 		return;
 
-	crypto_unregister_kpp(&ecdh_nist_p384);
-	crypto_unregister_kpp(&ecdh_nist_p256);
-	crypto_unregister_kpp(&ecdh_nist_p192);
+	for (i = ARRAY_SIZE(ecdh_curves) - 1; i >= 0; --i)
+		crypto_unregister_kpp(&ecdh_curves[i]);
 }
 
 static int hpre_register_x25519(struct hisi_qm *qm)
-- 
2.33.0


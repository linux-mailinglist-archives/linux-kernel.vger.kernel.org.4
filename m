Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4D63898B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKYMSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKYMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:18:21 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44883192A8;
        Fri, 25 Nov 2022 04:18:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVfPnZI_1669378695;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VVfPnZI_1669378695)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 20:18:16 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] crypto: ccree,hisilicon - Fix dependencies to correct algorithm
Date:   Fri, 25 Nov 2022 20:18:11 +0800
Message-Id: <20221125121811.88031-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory") moves
the SM3 and SM4 stand-alone library and the algorithm implementation for
the Crypto API into the same directory, and the corresponding relationship
of Kconfig is modified, CONFIG_CRYPTO_SM3/4 corresponds to the stand-alone
library of SM3/4, and CONFIG_CRYPTO_SM3/4_GENERIC corresponds to the
algorithm implementation for the Crypto API. Therefore, it is necessary
for this module to depend on the correct algorithm.

Fixes: d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/crypto/Kconfig           | 4 ++--
 drivers/crypto/hisilicon/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 2947888d3b82..dfb103f81a64 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -800,8 +800,8 @@ config CRYPTO_DEV_CCREE
 	select CRYPTO_ECB
 	select CRYPTO_CTR
 	select CRYPTO_XTS
-	select CRYPTO_SM4
-	select CRYPTO_SM3
+	select CRYPTO_SM4_GENERIC
+	select CRYPTO_SM3_GENERIC
 	help
 	  Say 'Y' to enable a driver for the REE interface of the Arm
 	  TrustZone CryptoCell family of processors. Currently the
diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 27e1fa912063..743ce4fc3158 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -26,7 +26,7 @@ config CRYPTO_DEV_HISI_SEC2
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
-	select CRYPTO_SM4
+	select CRYPTO_SM4_GENERIC
 	depends on PCI && PCI_MSI
 	depends on UACCE || UACCE=n
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
-- 
2.24.3 (Apple Git-128)


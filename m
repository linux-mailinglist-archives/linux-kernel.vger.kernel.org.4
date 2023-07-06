Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EEB7496AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjGFHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjGFHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:40:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11CF1FED;
        Thu,  6 Jul 2023 00:39:53 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3666e8eF007738;
        Thu, 6 Jul 2023 09:39:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=FZKwpNeBGlxN/ZIvsZPy3W+zmOhekBrbZPOvSP0D2ZU=;
 b=5HoHR1oPoBJr9gIwXYu4497yaPXosZDZhQAFns8q982Yx6JJ+PT3xIsoJcnnzV2uHulv
 sZbWceX1qPdmPPbA+8r966N8nIJPklZ/Mf6p8HYJNItaqeSSlRDAn+28Kzl6e88InyVw
 D4a6CGMP7ngYcSAZV3VuDqcfSqC3BNSlFedlAIF2Q3qd+uA6auhVNUaAaWC5d8HWyuVw
 t1RZvFGezisqQMAaoaxeJeHGQkWYjhIiv7yhOVPZqP/DWaY0BCvd2bXK6Jsi/MZb4aDM
 eMCr3xfIIkR4vCKezKi8GwhzG1tpBTY1WL4AUYqeaJ2THQiGMJpHj9kOpoe7GPPUCEU1 ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rna75nd2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:39:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B880C10005B;
        Thu,  6 Jul 2023 09:39:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACAF8212FB7;
        Thu,  6 Jul 2023 09:39:36 +0200 (CEST)
Received: from localhost (10.201.22.9) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 6 Jul
 2023 09:39:36 +0200
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] crypto: stm32 - remove flag HASH_FLAGS_DMA_READY
Date:   Thu, 6 Jul 2023 09:37:19 +0200
Message-ID: <20230706073719.1156288-8-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706073719.1156288-1-thomas.bourgoin@foss.st.com>
References: <20230706073719.1156288-1-thomas.bourgoin@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_04,2023-07-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

Remove flag HASH_FLAGS_DMA_READY as it can put the driver in a deadlock
state.
If the DMA automatically set the DCAL bit, the interrupt indicating the
end of a computation can be raised before the DMA complete sequence.

Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 0b5e580efbba..a50d73c18d5c 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -84,12 +84,11 @@
 #define HASH_FLAGS_INIT			BIT(0)
 #define HASH_FLAGS_OUTPUT_READY		BIT(1)
 #define HASH_FLAGS_CPU			BIT(2)
-#define HASH_FLAGS_DMA_READY		BIT(3)
-#define HASH_FLAGS_DMA_ACTIVE		BIT(4)
-#define HASH_FLAGS_HMAC_INIT		BIT(5)
-#define HASH_FLAGS_HMAC_FINAL		BIT(6)
-#define HASH_FLAGS_HMAC_KEY		BIT(7)
-#define HASH_FLAGS_SHA3_MODE		BIT(8)
+#define HASH_FLAGS_DMA_ACTIVE		BIT(3)
+#define HASH_FLAGS_HMAC_INIT		BIT(4)
+#define HASH_FLAGS_HMAC_FINAL		BIT(5)
+#define HASH_FLAGS_HMAC_KEY		BIT(6)
+#define HASH_FLAGS_SHA3_MODE		BIT(7)
 #define HASH_FLAGS_FINAL		BIT(15)
 #define HASH_FLAGS_FINUP		BIT(16)
 #define HASH_FLAGS_ALGO_MASK		GENMASK(20, 17)
@@ -585,8 +584,6 @@ static void stm32_hash_dma_callback(void *param)
 	struct stm32_hash_dev *hdev = param;
 
 	complete(&hdev->dma_completion);
-
-	hdev->flags |= HASH_FLAGS_DMA_READY;
 }
 
 static int stm32_hash_hmac_dma_send(struct stm32_hash_dev *hdev)
@@ -1241,11 +1238,9 @@ static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 			hdev->flags &= ~HASH_FLAGS_OUTPUT_READY;
 			goto finish;
 		}
-	} else if (HASH_FLAGS_DMA_READY & hdev->flags) {
-		if (HASH_FLAGS_DMA_ACTIVE & hdev->flags) {
-			hdev->flags &= ~HASH_FLAGS_DMA_ACTIVE;
-				goto finish;
-		}
+	} else if (HASH_FLAGS_DMA_ACTIVE & hdev->flags) {
+		hdev->flags &= ~HASH_FLAGS_DMA_ACTIVE;
+			goto finish;
 	}
 
 	return IRQ_HANDLED;
-- 
2.25.1


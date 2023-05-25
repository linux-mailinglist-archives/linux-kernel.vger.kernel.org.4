Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961BA710364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjEYDmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEYDmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:42:15 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2DD3;
        Wed, 24 May 2023 20:42:14 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OMaJNq025096;
        Wed, 24 May 2023 20:42:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=MGUEVrU5fDXX90/F1fmdkjV9kvu25Wlft4HKJZcgusg=;
 b=VdX4YQRhNNA/ykyz0UfjPJA9xuCsksW+lcJtj+wAlYFgKVEQ4dUFeG+392jFQVeYHgU1
 yrYj/jsXQQHpc5GlgrOaxoK94VLRFFYuFYx6Ihozj3TVbTsPXAJinBWsejMXv+uIHs+J
 WHQxOLgchTwqiP0zCazG3CwJb+rZCv2usaGQPDzWg8blNhCQiKauHk8tCtHg4wlNZwjh
 weGVS7XHpMvXKZjfpKGeZJUIqKyrFZoF7eMs81HTtrzTLzNi3/tKFWR3pbH+JE+gBJk6
 QaCWOP6BdZhFxCAWVM5B/xmSqWFWdWLBN61JtYzOd6ijLr5bLM57rUlAoqNVHX8H7mLN pA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qsbxewb82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 20:42:08 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 May
 2023 20:42:06 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 24 May 2023 20:42:04 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <Jason@zx2c4.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v2] hwrng: cn10k: Add extended trng register support
Date:   Thu, 25 May 2023 09:12:00 +0530
Message-ID: <20230525034200.22298-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xf_uL481ZZ7k9_YsfwtgfpVuIbhbGnD8
X-Proofpoint-GUID: Xf_uL481ZZ7k9_YsfwtgfpVuIbhbGnD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_01,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way random data is read from hardware has changed from
Octeon CN10KA-B0 and later SoCs onwards. A new set of registers
have been added to read random data and to verify whether the
read data is valid or not. This patch extends and uses
RNM_PF_TRNG_DAT and RNM_PF_TRNG_STS CSRs to read random number
and status for the applicable silicon variants.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2:
 - Change return type of cn10k_read_trng() to bool

 drivers/char/hw_random/cn10k-rng.c | 63 ++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/cn10k-rng.c b/drivers/char/hw_random/cn10k-rng.c
index c1193f85982c..0cd7e1a8e499 100644
--- a/drivers/char/hw_random/cn10k-rng.c
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -23,14 +23,49 @@
 #define RNM_PF_RANDOM		0x400
 #define RNM_TRNG_RESULT		0x408
 
+/* Extended TRNG Read and Status Registers */
+#define RNM_PF_TRNG_DAT		0x1000
+#define RNM_PF_TRNG_RES		0x1008
+
 struct cn10k_rng {
 	void __iomem *reg_base;
 	struct hwrng ops;
 	struct pci_dev *pdev;
+	/* Octeon CN10K-A A0/A1, CNF10K-A A0/A1 and CNF10K-B A0/B0
+	 * does not support extended TRNG registers
+	 */
+	bool extended_trng_regs;
 };
 
 #define PLAT_OCTEONTX_RESET_RNG_EBG_HEALTH_STATE     0xc2000b0f
 
+#define PCI_SUBSYS_DEVID_CN10K_A_RNG	0xB900
+#define PCI_SUBSYS_DEVID_CNF10K_A_RNG	0xBA00
+#define PCI_SUBSYS_DEVID_CNF10K_B_RNG	0xBC00
+
+static bool cn10k_is_extended_trng_regs_supported(struct pci_dev *pdev)
+{
+	/* CN10K-A A0/A1 */
+	if ((pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_RNG) &&
+	    (!pdev->revision || (pdev->revision & 0xff) == 0x50 ||
+	     (pdev->revision & 0xff) == 0x51))
+		return false;
+
+	/* CNF10K-A A0 */
+	if ((pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_RNG) &&
+	    (!pdev->revision || (pdev->revision & 0xff) == 0x60 ||
+	     (pdev->revision & 0xff) == 0x61))
+		return false;
+
+	/* CNF10K-B A0/B0 */
+	if ((pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_RNG) &&
+	    (!pdev->revision || (pdev->revision & 0xff) == 0x70 ||
+	     (pdev->revision & 0xff) == 0x74))
+		return false;
+
+	return true;
+}
+
 static unsigned long reset_rng_health_state(struct cn10k_rng *rng)
 {
 	struct arm_smccc_res res;
@@ -63,9 +98,23 @@ static int check_rng_health(struct cn10k_rng *rng)
 	return 0;
 }
 
-static void cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
+/* Returns true when valid data available otherwise return false */
+static bool cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
 {
+	u16 retry_count = 0;
 	u64 upper, lower;
+	u64 status;
+
+	if (rng->extended_trng_regs) {
+		do {
+			*value = readq(rng->reg_base + RNM_PF_TRNG_DAT);
+			if (*value)
+				return true;
+			status = readq(rng->reg_base + RNM_PF_TRNG_RES);
+			if (!status && (retry_count++ > 0x1000))
+				return false;
+		} while (!status);
+	}
 
 	*value = readq(rng->reg_base + RNM_PF_RANDOM);
 
@@ -82,6 +131,7 @@ static void cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
 
 		*value = (upper & 0xFFFFFFFF00000000) | (lower & 0xFFFFFFFF);
 	}
+	return true;
 }
 
 static int cn10k_rng_read(struct hwrng *hwrng, void *data,
@@ -100,7 +150,8 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
 	size = max;
 
 	while (size >= 8) {
-		cn10k_read_trng(rng, &value);
+		if (!cn10k_read_trng(rng, &value))
+			goto out;
 
 		*((u64 *)pos) = value;
 		size -= 8;
@@ -108,7 +159,8 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
 	}
 
 	if (size > 0) {
-		cn10k_read_trng(rng, &value);
+		if (!cn10k_read_trng(rng, &value))
+			goto out;
 
 		while (size > 0) {
 			*pos = (u8)value;
@@ -118,6 +170,7 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
 		}
 	}
 
+out:
 	return max - size;
 }
 
@@ -144,9 +197,11 @@ static int cn10k_rng_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!rng->ops.name)
 		return -ENOMEM;
 
-	rng->ops.read    = cn10k_rng_read;
+	rng->ops.read = cn10k_rng_read;
 	rng->ops.priv = (unsigned long)rng;
 
+	rng->extended_trng_regs = cn10k_is_extended_trng_regs_supported(pdev);
+
 	reset_rng_health_state(rng);
 
 	err = devm_hwrng_register(&pdev->dev, &rng->ops);
-- 
2.17.1


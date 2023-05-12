Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9EC700794
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjELMVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbjELMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:21:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E5D059;
        Fri, 12 May 2023 05:21:52 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBoaKT025544;
        Fri, 12 May 2023 12:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=+LndOLhgaboh2RsKKF5Vywj7MYfEohnX8f2bSvtXnJc=;
 b=hzvElVH8/qg6QZp0u/YZl9uFAMQYN+YcgqxcIdDARHGVHklcAKWsuK6/6eO6Z09X4Val
 fROG3aJ1eeHtywLgUaEKyu5Yff6ljMkqsEz2iWDhkyTVW1rKLVumpfTjN1/mYUitbBXL
 v7FnODiorGuJaLqJa2G/oglHUCZo50C6pridnaMSP5ysedvw1hRb+mmh36oku/Yzkus9
 1cPt4AcIm6lEfpFBLwf5VxV/PH/Ry16VPnHMymxUJikYNjBMusnv4Yz6RADACS92ZMsx
 /HTdoKofCFNuAUx9Ab2Z+FZHlUAhqGWhhld4GvE2We5Uyck1IdQy64HOK8vo/yQr530H 7Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh8hm1hgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLj5V028989;
        Fri, 12 May 2023 12:21:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1un-1;
        Fri, 12 May 2023 12:21:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLi9Y028984;
        Fri, 12 May 2023 12:21:45 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLiUn028983;
        Fri, 12 May 2023 12:21:44 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 353AC52974D; Fri, 12 May 2023 17:51:44 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 01/10] nvmem: qfprom: Add support for secure reading
Date:   Fri, 12 May 2023 17:51:25 +0530
Message-Id: <20230512122134.24339-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tj4wnpfm4LZLj-oioTeMjT-Mx1gp-aLE
X-Proofpoint-ORIG-GUID: Tj4wnpfm4LZLj-oioTeMjT-Mx1gp-aLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of the Qualcomm SoC's, it is possible that
some of the fuse regions or entire qfprom region is
protected from non-secure access. In such situations,
linux will have to use secure calls to read the region.
With that motivation, add the support of reading secure
regions in qfprom driver. Ensuring the address to read
is word aligned since our secure I/O only supports word
size I/O.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/nvmem/Kconfig  |  1 +
 drivers/nvmem/qfprom.c | 69 +++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index b291b27048c7..3d896ba29b89 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -209,6 +209,7 @@ config NVMEM_QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
+	select QCOM_SCM
 	help
 	  Say y here to enable QFPROM support. The QFPROM provides access
 	  functions for QFPROM data to rest of the drivers via nvmem interface.
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c1e893c8a247..20662e2d3732 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/firmware/qcom/qcom_scm.h>

 /* Blow timer clock frequency in Mhz */
 #define QFPROM_BLOW_TIMER_OFFSET 0x03c
@@ -59,21 +60,22 @@ struct qfprom_soc_data {
 /**
  * struct qfprom_priv - structure holding qfprom attributes
  *
- * @qfpraw:       iomapped memory space for qfprom-efuse raw address space.
- * @qfpconf:      iomapped memory space for qfprom-efuse configuration address
- *                space.
+ * @qfpraw: iomapped memory space for qfprom-efuse raw address space.
+ * @qfpconf: iomapped memory space for qfprom-efuse configuration address space.
  * @qfpcorrected: iomapped memory space for qfprom corrected address space.
- * @qfpsecurity:  iomapped memory space for qfprom security control space.
- * @dev:          qfprom device structure.
- * @secclk:       Clock supply.
- * @vcc:          Regulator supply.
- * @soc_data:     Data that for things that varies from SoC to SoC.
+ * @qfpsecurity: iomapped memory space for qfprom security control space.
+ * @qfpseccorrected: starting physical address for qfprom secure corrected address space.
+ * @dev: qfprom device structure.
+ * @secclk: Clock supply.
+ * @vcc: Regulator supply.
+ * @soc_data: Data that for things that varies from SoC to SoC.
  */
 struct qfprom_priv {
 	void __iomem *qfpraw;
 	void __iomem *qfpconf;
 	void __iomem *qfpcorrected;
 	void __iomem *qfpsecurity;
+	phys_addr_t qfpseccorrected;
 	struct device *dev;
 	struct clk *secclk;
 	struct regulator *vcc;
@@ -99,10 +101,12 @@ struct qfprom_touched_values {
  *
  * @keepout: Array of keepout regions for this SoC.
  * @nkeepout: Number of elements in the keepout array.
+ * @secure: Is qfprom region for this SoC protected from non-secure access.
  */
 struct qfprom_soc_compatible_data {
 	const struct nvmem_keepout *keepout;
 	unsigned int nkeepout;
+	bool secure;
 };

 static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
@@ -334,6 +338,34 @@ static int qfprom_reg_read(void *context,
 	return 0;
 }

+static int qfprom_sec_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
+{
+	struct qfprom_priv *priv = context;
+	u8 *val = _val;
+	int buf_start, buf_end, index, i = 0;
+	char *buffer;
+	u32 read_val;
+
+	buf_start = ALIGN_DOWN(reg, 4);
+	buf_end = ALIGN(reg + bytes, 4);
+	buffer = kzalloc(buf_end - buf_start, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	for (index = buf_start; index < buf_end; index += 4, i += 4) {
+		if (qcom_scm_io_readl(priv->qfpseccorrected + index, &read_val)) {
+			dev_err(priv->dev, "Couldn't access feature register\n");
+			kfree_sensitive(buffer);
+			return -EINVAL;
+		}
+		memcpy(buffer + i, &read_val, 4);
+	}
+
+	memcpy(val, buffer + reg % 4, bytes);
+	kfree_sensitive(buffer);
+	return 0;
+}
+
 static void qfprom_runtime_disable(void *data)
 {
 	pm_runtime_disable(data);
@@ -373,13 +405,6 @@ static int qfprom_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;

-	/* The corrected section is always provided */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->qfpcorrected = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->qfpcorrected))
-		return PTR_ERR(priv->qfpcorrected);
-
-	econfig.size = resource_size(res);
 	econfig.dev = dev;
 	econfig.priv = priv;

@@ -390,6 +415,20 @@ static int qfprom_probe(struct platform_device *pdev)
 		econfig.nkeepout = soc_data->nkeepout;
 	}

+	/* The corrected section is always provided */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (soc_data && soc_data->secure) {
+		priv->qfpseccorrected = res->start;
+		econfig.reg_read = qfprom_sec_reg_read;
+	} else {
+		priv->qfpcorrected = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->qfpcorrected))
+			return PTR_ERR(priv->qfpcorrected);
+	}
+
+	econfig.size = resource_size(res);
+
 	/*
 	 * If more than one region is provided then the OS has the ability
 	 * to write.
--
2.17.1


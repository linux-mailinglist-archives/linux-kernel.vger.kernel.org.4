Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCC26732CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjASHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjASHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:42:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566D654C1;
        Wed, 18 Jan 2023 23:42:35 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5U9jx005303;
        Thu, 19 Jan 2023 07:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EZfzLFHPCaQRaOMBIBrl1Zlxo7Sld1GLQx2E2cQ6DBs=;
 b=N2pbK21XlFZf3jjpLUHd6k/IVi4AaacSoVe0vO9XUBCryrf2341XwMptUmpEjgoPzdmq
 FvxH2JQaR2ln7XVvNBb/p4y74nJNy0lY2qRc1kNxkblcE4KPyJ4zVAJ+gac6wwSMGXTi
 um8tUQXhHj2t+jkuGcuNzBcR+PlQOwM4mAu+7d0TeexUsqaNuI7b0m/G3MV/OAPdr8Lg
 5XmCtxV21ARg9Dc+xI9CI1ca5AVwPIs5TE4/282syzKP2tkHKt54NaAzWRmj6o3m4g+V
 nEX+aiIEypYBCPcklBxfXGhJ1VWyOYz/hmOzBuy7c4CigLYjuXUN4XKN+YwlLI78cYAW fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6ya2re1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J7gKaD028908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:20 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 23:42:15 -0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
Subject: [PATCH v2 2/9] coresight-tpda: Add DSB dataset support
Date:   Thu, 19 Jan 2023 15:41:38 +0800
Message-ID: <1674114105-16651-3-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bbiAiNV1Txg7hakV9994iIGgE-ViIZC0
X-Proofpoint-GUID: bbiAiNV1Txg7hakV9994iIGgE-ViIZC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the DSB element size from the device tree. Set the register
bit that controls the DSB element size of the corresponding port.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 62 ++++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 5989798..be13e08 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -37,6 +37,15 @@ static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 	u32 val;
 
 	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
+	/*
+	 * Configure aggregator port n DSB data set element size
+	 * Set the bit to 0 if the size is 32
+	 * Set the bit to 1 if the size is 64
+	 */
+	if (drvdata->dsb_esize[port] == 32)
+		val &= ~TPDA_Pn_CR_DSBSIZE;
+	else if (drvdata->dsb_esize[port] == 64)
+		val |= TPDA_Pn_CR_DSBSIZE;
 	/* Enable the port */
 	val |= TPDA_Pn_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
@@ -105,6 +114,55 @@ static const struct coresight_ops tpda_cs_ops = {
 	.link_ops	= &tpda_link_ops,
 };
 
+static int tpda_parse_dsb(struct tpda_drvdata *drvdata)
+{
+	int len, port, i;
+	const __be32 *prop;
+	struct device_node *node = drvdata->dev->of_node;
+
+	/* Read the size of DSB element */
+	prop = of_get_property(node, "qcom,dsb-elem-size", &len);
+	if (prop) {
+		len /= sizeof(__be32);
+		/*
+		 * The read set of data is port and size, so the number of data
+		 * is a multiple of two. And the number of data will not exceed
+		 * two times that of the TPDA inpurts number.
+		 */
+		if (len < 2 || len >= (2 * TPDA_MAX_INPORTS) || len % 2 != 0) {
+			dev_err(drvdata->dev,
+				"Dataset DSB width entries are wrong\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < len; i += 2) {
+			port = be32_to_cpu(prop[i]);
+			if (port >= TPDA_MAX_INPORTS) {
+				dev_err(drvdata->dev,
+					"Wrong port specified for DSB\n");
+				return -EINVAL;
+			}
+			/* Set DSB element size for corresponding port to dsb_esize*/
+			drvdata->dsb_esize[port] = be32_to_cpu(prop[i + 1]);
+		}
+	}
+
+	return 0;
+}
+
+static int tpda_parse_of_data(struct tpda_drvdata *drvdata)
+{
+	int ret;
+
+	ret = tpda_parse_dsb(drvdata);
+	if (ret) {
+		dev_err(drvdata->dev, "Fail to get DSB data set element size\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int tpda_init_default_data(struct tpda_drvdata *drvdata)
 {
 	int atid;
@@ -151,6 +209,10 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&drvdata->spinlock);
 
+	ret = tpda_parse_of_data(drvdata);
+	if (ret)
+		return ret;
+
 	ret = tpda_init_default_data(drvdata);
 	if (ret)
 		return ret;
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 0399678..9ec5870 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -10,6 +10,8 @@
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 /* Aggregator port enable bit */
 #define TPDA_Pn_CR_ENA		BIT(0)
+/* Aggregator port DSB data set element size bit */
+#define TPDA_Pn_CR_DSBSIZE		BIT(8)
 
 #define TPDA_MAX_INPORTS	32
 
@@ -23,6 +25,7 @@
  * @csdev:      component vitals needed by the framework.
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
+ * @dsb_esize:   DSB element size
  */
 struct tpda_drvdata {
 	void __iomem		*base;
@@ -30,6 +33,7 @@ struct tpda_drvdata {
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	u8			atid;
+	u32			dsb_esize[TPDA_MAX_INPORTS];
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.7.4


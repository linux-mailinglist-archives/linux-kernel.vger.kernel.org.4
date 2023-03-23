Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961D6C5F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCWGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCWGFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:05:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7A226C0E;
        Wed, 22 Mar 2023 23:05:07 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5h18O029123;
        Thu, 23 Mar 2023 06:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=a0KJ2Ixr7wCyt3Sz77Gt0PUj6x8JwmpHQa7jNGesVvU=;
 b=AQcPh6lf2/GJzeVi5kC+wgv5qHIE9iKUjGUJUYn5WotTyYNtJQEceM7ePjI5Ty+eZb1s
 d3JPpF+wZJ7gqG7muK7hTU0LvJ4aBIkLtjvtH/d6EcUEMNMsizNIcHpr6Tz7RnTrsXFs
 8bKMKVPYgsBHr4yoiG6WK96x5iMS3a0vJElrOdwj/UD3zgk/U3qRQ+W+J4PsluFfCGoq
 9kx8GX558r1LBBexzeYF1yWUbod+u0/bbvSkQN7aklFWb4mAT+uWiG6WcoD0kc3Wxh++
 RtHdvY2rGiqB2zK70OzGnl6I8c8wAnTAU31f8ATfjDzaRh/seRBUOpVuALBAOEihHnHe 0A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgghj0288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:04:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N64iTu031817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:04:44 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:04:39 -0700
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH v3 02/11] coresight-tpda: Add DSB dataset support
Date:   Thu, 23 Mar 2023 14:03:59 +0800
Message-ID: <1679551448-19160-3-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G7pz1sAOCTkxq7USSSZxWOxHBJ0q1YgW
X-Proofpoint-ORIG-GUID: G7pz1sAOCTkxq7USSSZxWOxHBJ0q1YgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230045
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the DSB element size from the device tree. Set the register
bit that controls the DSB element size of the corresponding port.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 58 ++++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index f712e11..8dcfc4a 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -21,6 +21,47 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
 
+/* Search and read element data size from the TPDM node in
+ * the devicetree. Each input port of TPDA is connected to
+ * a TPDM. Different TPDM supports different types of dataset,
+ * and some may support more than one type of dataset.
+ * Parameter "inport" is used to pass in the input port number
+ * of TPDA, and it is set to 0 in the recursize call.
+ * Parameter "parent" is used to pass in the original call.
+ */
+static int tpda_set_element_size(struct tpda_drvdata *drvdata,
+			   struct coresight_device *csdev, int inport, bool parent)
+{
+	static int nr_inport;
+	int i;
+	struct coresight_device *in_csdev;
+
+	if (inport > (TPDA_MAX_INPORTS - 1))
+		return -EINVAL;
+
+	if (parent)
+		nr_inport = inport;
+
+	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
+		in_csdev = csdev->pdata->in_conns[i].remote_dev;
+		if (!in_csdev)
+			break;
+
+		if (parent)
+			if (csdev->pdata->in_conns[i].port != inport)
+				continue;
+
+		if (in_csdev && strstr(dev_name(&in_csdev->dev), "tpdm")) {
+			of_property_read_u32(in_csdev->dev.parent->of_node,
+					"qcom,dsb-element-size", &drvdata->dsb_esize[nr_inport]);
+			break;
+		}
+		tpda_set_element_size(drvdata, in_csdev, 0, false);
+	}
+
+	return 0;
+}
+
 /* Settings pre enabling port control register */
 static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 {
@@ -37,6 +78,18 @@ static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
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
+	else
+		dev_err(drvdata->dev,
+			"DSB data size input from port[%d] is invalid\n", port);
 	/* Enable the port */
 	val |= TPDA_Pn_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
@@ -57,6 +110,11 @@ static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
 static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
 {
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret;
+
+	ret = tpda_set_element_size(drvdata, csdev, inport, true);
+	if (ret)
+		return ret;
 
 	spin_lock(&drvdata->spinlock);
 	if (atomic_read(&csdev->refcnt[inport]) == 0)
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


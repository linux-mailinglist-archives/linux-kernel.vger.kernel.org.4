Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581546C5F75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCWGGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCWGGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:06:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B29228862;
        Wed, 22 Mar 2023 23:05:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4A9AW014933;
        Thu, 23 Mar 2023 06:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PABeRwgm7smZILa6KOy469iBjz3t9AmX/db4PxWe2ms=;
 b=e1gUzYR5vLDr3M63Rs5cd3deFt0MhCwbsVSxj1X4SutB0cqLxekH/7guX59VQmLjCjuA
 Kw9tv3T7aJhteX3qsFLKT7ONDP36gNVjp8zxLLcUCRRYeVjQMr7//GTCzGUGRVhDt2is
 xGr7h0uEx4MH8BJv+gY2/lulUyw9/lq0pcKg9prPzq/IrxDhamoRyblZMpZLB9LXrG0j
 czpXuUF83uApksyspWpFHYmEhCYjSmCILCD92gH95yodo2QS7RPLt65V009V9Wo3brVT
 gKyStvRH7lbDvVMVKkU1vzESSDfT9EldcM/Zaf7Spv3UyfGiLAcutyiBPv+pXmzAklsI 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k1ek8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:05:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N65Ujd007814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:05:30 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:05:25 -0700
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
Subject: [PATCH v3 11/11] coresight-tpdm: Add nodes for dsb msr support
Date:   Thu, 23 Mar 2023 14:04:08 +0800
Message-ID: <1679551448-19160-12-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cva3ww9Jog-1kc5F2-X2iqKmsu6TIqNo
X-Proofpoint-ORIG-GUID: cva3ww9Jog-1kc5F2-X2iqKmsu6TIqNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230046
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes for DSB subunit MSR(mux select register) support.
The TPDM MSR (mux select register) interface is an optional
interface and associated bank of registers per TPDM subunit.
The intent of mux select registers is to control muxing structures
driving the TPDM’s’ various subunit interfaces.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 12 +++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 53 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h       | 17 ++++---
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 60ff660..6bdba7d 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -143,3 +143,15 @@ Description:
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Set the DSB pattern type to false
 		1 : Set the DSB pattern type to true
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the MSR(mux select register) of DSB tpdm. Read
+		the MSR(mux select register) of DSB tpdm.
+
+		Accepts the following two values.
+		value 1: Index number of MSR register
+		value 2: The value need to be written
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index c740681..5aaee06 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -42,6 +42,14 @@ static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
 						    sizeof(*drvdata->dsb), GFP_KERNEL);
 			if (!drvdata->dsb)
 				return -ENOMEM;
+			if (!of_property_read_u32(drvdata->dev->of_node,
+					   "qcom,dsb_msr_num", &drvdata->dsb->msr_num)) {
+				drvdata->dsb->msr = devm_kzalloc(drvdata->dev,
+					(drvdata->dsb->msr_num * sizeof(*drvdata->dsb->msr)),
+					GFP_KERNEL);
+					if (!drvdata->dsb->msr)
+						return -ENOMEM;
+				}
 		} else
 			memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
 
@@ -769,6 +777,50 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_trig_ts);
 
+static ssize_t dsb_msr_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int i;
+	ssize_t size = 0;
+
+	if (drvdata->dsb->msr_num == 0)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "%u 0x%x\n", i, drvdata->dsb->msr[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+
+static ssize_t dsb_msr_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int num, val;
+	int nval;
+
+	if (drvdata->dsb->msr_num == 0)
+		return -EINVAL;
+
+	nval = sscanf(buf, "%u %x", &num, &val);
+	if ((nval != 2) || (num >= (drvdata->dsb->msr_num - 1)))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->msr[num] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_msr);
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
@@ -781,6 +833,7 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_trig_patt_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
+	&dev_attr_dsb_msr.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index f9d4dd9..1872f26 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -18,6 +18,7 @@
 #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
 #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
+#define TPDM_DSB_MSR(n)		(0x980 + (n * 4))
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
@@ -92,17 +93,19 @@
  * @trig_type:        Enable/Disable trigger type.
  */
 struct dsb_dataset {
-	u32				mode;
-	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
-	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
-	u32				patt_val[TPDM_DSB_MAX_PATT];
-	u32				patt_mask[TPDM_DSB_MAX_PATT];
+	u32			mode;
+	u32			edge_ctrl[TPDM_DSB_MAX_EDCR];
+	u32			edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
+	u32			patt_val[TPDM_DSB_MAX_PATT];
+	u32			patt_mask[TPDM_DSB_MAX_PATT];
 	bool			patt_ts;
 	bool			patt_type;
-	u32				trig_patt_val[TPDM_DSB_MAX_PATT];
-	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
+	u32			trig_patt_val[TPDM_DSB_MAX_PATT];
+	u32			trig_patt_mask[TPDM_DSB_MAX_PATT];
 	bool			trig_ts;
 	bool			trig_type;
+	u32			msr_num;
+	u32			*msr;
 };
 
 /**
-- 
2.7.4


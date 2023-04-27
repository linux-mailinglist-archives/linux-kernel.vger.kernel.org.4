Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B486F0303
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbjD0JDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbjD0JDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:03:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E555AF;
        Thu, 27 Apr 2023 02:03:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R5Wc4C015988;
        Thu, 27 Apr 2023 09:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UaxooDr7ehm/68Nui88ZmexVMahZ4HXut41Qs3E+wk4=;
 b=acVjIDHJZqncF1LPjXrouSgkGGGMzOWlZPir7zw2POZlQfdgmuIwtS43jgyMzWR8eRBn
 637+8DEgyiaLVokaVf9cM5qtBbn/Wp8YmG3C0FPDKczhlHQNInvF6uZXocwsSX6UInaH
 ZY7IRwxbsGpfUmNb14CB9SkvLBYXceweTTJH24eWI7ixDke2DTPhx+ukCKi2ktKuoVn1
 nWCx0Ye++IyjbWGsxyY0ndKJ2I/2gN9QVpH/l9v/jBuebWLrJFJpWXXK74pqKkEwLodB
 w2hdPOnkRKnp7vWX+F0ausXPr8ZbUE85PV7WLMox58lUZWXTokPRtwr9Y0liveHU0cEA 4Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7k090e12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 09:01:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33R91rr5003734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 09:01:53 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 02:01:47 -0700
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
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v4 11/11] coresight-tpdm: Add nodes for dsb msr support
Date:   Thu, 27 Apr 2023 17:00:37 +0800
Message-ID: <1682586037-25973-12-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4PPAXmT7hbhQwkwcJzfzTWlKqaPcSK-J
X-Proofpoint-GUID: 4PPAXmT7hbhQwkwcJzfzTWlKqaPcSK-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 15 ++++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 53 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h       |  3 ++
 3 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 639b6fb8..f746f25 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -170,3 +170,18 @@ Description:
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Set the DSB pattern type to value.
 		1 : Set the DSB pattern type to toggle.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the MSR(mux select register) of DSB tpdm. Read
+		the MSR(mux select register) of DSB tpdm.
+
+		Expected format is the following:
+		<integer1> <integer2>
+
+		Where:
+		<integer1> : Index number of MSR register
+		<integer2> : The value need to be written
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 627de36..5fe0bd5c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -240,6 +240,14 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 			if (!drvdata->dsb)
 				return -ENOMEM;
 		}
+		if (!of_property_read_u32(drvdata->dev->of_node,
+			   "qcom,dsb_msr_num", &drvdata->dsb->msr_num)) {
+			drvdata->dsb->msr = devm_kzalloc(drvdata->dev,
+				   (drvdata->dsb->msr_num * sizeof(*drvdata->dsb->msr)),
+				   GFP_KERNEL);
+			if (!drvdata->dsb->msr)
+				return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -765,6 +773,50 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
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
@@ -777,6 +829,7 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_trig_patt_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
+	&dev_attr_dsb_msr.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 9ad32a6..05e9f8e 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -18,6 +18,7 @@
 #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
 #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
 #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
+#define TPDM_DSB_MSR(n)		(0x980 + (n * 4))
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
@@ -113,6 +114,8 @@ struct dsb_dataset {
 	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
 	bool			trig_ts;
 	bool			trig_type;
+	u32				msr_num;
+	u32				*msr;
 };
 
 /**
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730326CD527
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjC2ItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjC2Isi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02640E8;
        Wed, 29 Mar 2023 01:48:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T7OvXW002401;
        Wed, 29 Mar 2023 08:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FT8jIE6CqAkWKSPy/13QapZZX7btBX1ZdzJlOq5x9C4=;
 b=NRmFTIMxbOKgnNMBWKlGJj0RO9Ff57cPMLJRMIG1mu2MWVj5KHinvzHA4NyWGyya/1wA
 0jg2tPMsZJt97z9FtRe4a3+p2AXoJqmvBMI26f4c3cDWATH1vqP8g4F2SG72EUBxEBdJ
 jQuEpHA4fnofR8XIDLGV3CqLZMOqvsiejYGkKwwVRrHkVipL2vt8EXGq6q/A2cco0Um8
 KodNQ3k23wC9RCgBGedBTAVosVyTzTfcL2yTSXzH+sO+v2FQJ+Sv/S4l7gB28HsJt9yA
 kALhujRCVVxREpoKHVaWvM36aArozFjSSM5pkoZ7yD4lgOhnSSkRcL23mIfUYvGKbIbf rQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkv45k929-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8lwJa031753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:58 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 01:47:57 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 5/8] coresight-tpdm: Add msr register support for CMB
Date:   Wed, 29 Mar 2023 01:47:41 -0700
Message-ID: <20230329084744.5705-6-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
References: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5tWVQbd9LbMdwNEIrnME1Nqj7ty9YYci
X-Proofpoint-ORIG-GUID: 5tWVQbd9LbMdwNEIrnME1Nqj7ty9YYci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290071
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes for CMB subunit MSR(mux select register) support.
CMB MSRs(mux select registers) is to separate mux,arbitration,
,interleaving,data packing control from stream filtering control.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  6 ++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 59 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  6 ++
 3 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index aa357f463d03..403c45fcdcfe 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -212,3 +212,9 @@ Description:	(RW) Read or write the status of timestamp upon all interface.
 		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
 		timestamp to all trace packet.
 
+What:           /sys/bus/coresight/devices/<tpdm-name>/cmb_msr
+Date:           March 2023
+KernelVersion   6.3
+Contact:        Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:    (RW) Read or write the value of CMB msr.
+
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 88bb740cddd6..91b9ec80bf23 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -72,6 +72,14 @@ static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
 			if (!drvdata->cmb)
 				return -ENOMEM;
 		}
+
+		/* Get cmb msr number*/
+		of_property_read_u32(drvdata->dev->of_node, "qcom,cmb-msr-num",
+				&drvdata->cmb->msr_num);
+		drvdata->cmb->msr = devm_kzalloc(drvdata->dev,
+					(drvdata->cmb->msr_num * sizeof(u32)), GFP_KERNEL);
+		if (!drvdata->cmb->msr)
+			return -ENOMEM;
 	}
 
 	return 0;
@@ -206,6 +214,12 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 		val = val & ~TPDM_CMB_TIER_TS_ALL;
 	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
 
+	/* Configure MSR registers */
+	if (drvdata->cmb->msr_num != 0)
+		for (i = 0; i < drvdata->cmb->msr_num; i++)
+			writel_relaxed(drvdata->cmb->msr[i],
+				drvdata->base + TPDM_CMB_MSR(i));
+
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
 	 * Set to 0 for continuous CMB collection mode,
@@ -1159,6 +1173,50 @@ static ssize_t cmb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmb_trig_ts);
 
+static ssize_t cmb_msr_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int i;
+	ssize_t size = 0;
+
+	if (drvdata->cmb->msr_num == 0)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < drvdata->cmb->msr_num; i++) {
+		size += sysfs_emit_at(buf, size,
+				  "%u 0x%x\n", i, drvdata->cmb->msr[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+
+static ssize_t cmb_msr_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int num, val;
+	int nval;
+
+	if (drvdata->cmb->msr_num == 0)
+		return -EINVAL;
+
+	nval = sscanf(buf, "%u %x", &num, &val);
+	if ((nval != 2) || (num >= (drvdata->cmb->msr_num - 1)))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->msr[num] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_msr);
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
@@ -1184,6 +1242,7 @@ static struct attribute *tpdm_cmb_attrs[] = {
 	&dev_attr_cmb_patt_ts.attr,
 	&dev_attr_cmb_ts_all.attr,
 	&dev_attr_cmb_trig_ts.attr,
+	&dev_attr_cmb_msr.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 88ade2f2ef6c..d783fc94252b 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -22,6 +22,8 @@
 #define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
 /*CMB subunit trigger pattern mask registers*/
 #define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
+/* CMB MSR register */
+#define TPDM_CMB_MSR(n)		(0xA80 + (n * 4))
 
 /* Enable bit for CMB subunit */
 #define TPDM_CMB_CR_ENA		BIT(0)
@@ -145,6 +147,8 @@ struct dsb_dataset {
  * @patt_mask:        Save value for pattern mask
  * @trig_patt_val:    Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @msr_num:	      The number of msr register
+ * @msr:	      Save value for msr registers
  * @patt_ts:	      Indicates if pattern match for timestamp is enabled.
  * @trig_ts:	      Indicates if CTI trigger for timestamp is enabled.
  * @ts_all:	      Indicates if timestamp is enabled for all packets.
@@ -155,6 +159,8 @@ struct cmb_dataset {
 	u32				patt_mask[TPDM_CMB_MAX_PATT];
 	u32				trig_patt_val[TPDM_CMB_MAX_PATT];
 	u32				trig_patt_mask[TPDM_CMB_MAX_PATT];
+	u32				msr_num;
+	u32				*msr;
 	bool				patt_ts;
 	bool				trig_ts;
 	bool				ts_all;
-- 
2.39.0


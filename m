Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2366CD51E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjC2Isq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjC2IsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:48:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D21172B;
        Wed, 29 Mar 2023 01:48:22 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T1Co8p012346;
        Wed, 29 Mar 2023 08:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bx8oVsuQ3IjguArMCDxtBpJ1u3h2J0XhbOIDrGFFIQU=;
 b=fiaM97aAFvcgiZsY/hjbIgLEGh1v6Xcjl8CjGrW+FUemyTXJKruJiqT8RGEcltQLobMq
 OLVo9AH4GhiK5TdicTL02JrcJZWIo74woJoQiXvYmJJtO1igAAonH8on9dl6OUjKi4yI
 3boCJ1v3pysUUG6dS32kh+9yU3ghe0dks2pkdHxIDxHq+XisFxQUz6aYkSG/zByCvwcW
 st7X4MpXr3PBErvo/6WKhoWmc7WRlA+DzMkgWkvZis6Kx7iyS4SSOeXjYnLRcPVVNyoO
 +lJtPkvM8aIQY6RInSNSMxaPJPWBcJrjsAKa6QvYOpx+2qK4JHPQOksw4pUnDd52riDc dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmawsgw0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T8lvpN017485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 08:47:57 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 01:47:56 -0700
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
Subject: [PATCH v1 2/8] coresight-tpdm: Add support to configure CMB collection mode
Date:   Wed, 29 Mar 2023 01:47:38 -0700
Message-ID: <20230329084744.5705-3-quic_jinlmao@quicinc.com>
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
X-Proofpoint-GUID: otC5jpbn-7XqgVTanm08PsNgyiNfu3zF
X-Proofpoint-ORIG-GUID: otC5jpbn-7XqgVTanm08PsNgyiNfu3zF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=867 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290071
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPDM CMB subunits support two forms of CMB data set element creation:
continuous and trace-on-change collection mode. Continuous change
creates CMB data set elements on every CMBCLK edge. Trace-on-change
creates CMB data set elements only when a new data set element differs
in value from the previous element in a CMB data set. Set CMB_CR.MODE
to 0 for continuous CMB collection mode. Set CMB_CR.MODE to 1 for
trace-on-change CMB collection mode

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  8 ++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 77 ++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  | 12 +++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 6bdba7d375c9..89051018dd70 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -155,3 +155,11 @@ Description:
 		Accepts the following two values.
 		value 1: Index number of MSR register
 		value 2: The value need to be written
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_mode
+Date:		March 2023
+KernelVersion	6.3
+Contact:	Jinlong Mao <quic_jinlmao@quicinc.com>
+Description:	(RW) Read or write CMB data collection mode. Only value 0 and 1 can be written to this node.
+		Set to 0 is for continuous CMB collection mode. Set to 1 is for  trace-on-change CMB
+		collection mode.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index d92432329c9c..68244abfc8b9 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -34,6 +34,21 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t tpdm_cmb_is_visible(struct kobject *kobj,
+							struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata) {
+		if (drvdata->datasets & TPDM_PIDR0_DS_CMB)
+			return attr->mode;
+	}
+
+	return 0;
+}
+
+
 static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
 {
 	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
@@ -50,6 +65,15 @@ static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
 			   &drvdata->dsb->msr_num);
 	}
 
+	if (drvdata->datasets & TPDM_PIDR0_DS_CMB) {
+		if (!drvdata->cmb) {
+			drvdata->cmb = devm_kzalloc(drvdata->dev,
+						sizeof(*drvdata->cmb), GFP_KERNEL);
+			if (!drvdata->cmb)
+				return -ENOMEM;
+		}
+	}
+
 	return 0;
 }
 
@@ -154,9 +178,18 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 	u32 val;
 
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
-	val |= TPDM_CMB_CR_ENA;
+	/*
+	 * Set to 0 for continuous CMB collection mode,
+	 * 1 for trace-on-change CMB collection mode.
+	 */
+	if (drvdata->cmb->trace_mode)
+		val |= TPDM_CMB_CR_MODE;
+	else
+		val &= ~TPDM_CMB_CR_MODE;
 
 	/* Set the enable bit of CMB control register to 1 */
+	val |= TPDM_CMB_CR_ENA;
+
 	writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
 }
 
@@ -819,6 +852,37 @@ static ssize_t dsb_msr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_msr);
 
+static ssize_t cmb_mode_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%x\n",
+			 drvdata->cmb->trace_mode);
+
+}
+
+static ssize_t cmb_mode_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long trace_mode;
+	int ret;
+
+	ret = kstrtoul(buf, 16, &trace_mode);
+	if (ret || (trace_mode & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->trace_mode = trace_mode;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_mode);
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_edge_ctrl.attr,
@@ -835,14 +899,25 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_cmb_attrs[] = {
+	&dev_attr_cmb_mode.attr,
+	NULL,
+};
+
 static struct attribute_group tpdm_dsb_attr_grp = {
 	.attrs = tpdm_dsb_attrs,
 	.is_visible = tpdm_dsb_is_visible,
 };
 
+static struct attribute_group tpdm_cmb_attr_grp = {
+	.attrs = tpdm_cmb_attrs,
+	.is_visible = tpdm_cmb_is_visible,
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
+	&tpdm_cmb_attr_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 4c065a4b8a75..d716963bee10 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -15,6 +15,8 @@
 
 /* Enable bit for CMB subunit */
 #define TPDM_CMB_CR_ENA		BIT(0)
+/* Trace collection mode for CMB subunit*/
+#define TPDM_CMB_CR_MODE	BIT(1)
 
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
@@ -117,6 +119,14 @@ struct dsb_dataset {
 	u32				*msr;
 };
 
+/*
+ * struct cmb_dataset
+ * @trace_mode:		Dataset collection mode
+ */
+struct cmb_dataset {
+	u32				trace_mode;
+};
+
 /**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
@@ -125,6 +135,7 @@ struct dsb_dataset {
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
  * @datasets:   The datasets types present of the TPDM.
+ * @cmb:	cmb dataset struct data.
  */
 
 struct tpdm_drvdata {
@@ -135,6 +146,7 @@ struct tpdm_drvdata {
 	bool			enable;
 	unsigned long		datasets;
 	struct dsb_dataset	*dsb;
+	struct cmb_dataset	*cmb;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.39.0


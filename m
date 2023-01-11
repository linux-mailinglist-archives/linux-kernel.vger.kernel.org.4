Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB716655EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjAKIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAKIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:22:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDE6575;
        Wed, 11 Jan 2023 00:22:23 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B6s1cc011232;
        Wed, 11 Jan 2023 08:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ObGRnYiwhVjyzgR4V5/l+Rg0AQd+3msxVowvmas19MM=;
 b=HFy8cOSgmGWf4ax8qAH/Tfjpkjtla5Yy4v/fIU2ImIUAbRlueg+IGv+qOcvCbZUyAGqp
 PYoJIvncSHb8GnnHXmzLKYiWAR5RT09e0oPd4zw/2uk5JbuCGuIOBm9yB6bCT7wog+ic
 ASnQaOwgIs20c3MVO0Ob/aTE48qxaNSFSfq69LpNg+txK+FKKjbtcfB4dCat/H8HqFy1
 8qDCiypIIIL8qmdeqEQHFJSrvWswUXIs7Wu7llJBWeycbngLlNoKkPJXvRYpvQ8znEXs
 QaPVOt8lQsr+3pbgGnD5IQ+tFDVHvOAuS7TPqV//XmhV8aRxIrruhO73AeDO23chR5AL mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kgg0r8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 08:22:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B8MIve012547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 08:22:18 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 00:22:15 -0800
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add sysfs attributes for fields in v2-v6
Date:   Wed, 11 Jan 2023 13:51:41 +0530
Message-ID: <20230111082141.18109-3-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111082141.18109-1-quic_namajain@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: odWvLrK10hfoMPJ8jvWJeEErqs9czW0c
X-Proofpoint-GUID: odWvLrK10hfoMPJ8jvWJeEErqs9czW0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in sysfs custom attributes for fields in socinfo version
v2-v6. This is to support SoC based operations in userland scripts
and test scripts. Also, add name mappings for hw-platform type to
make the sysfs information more descriptive.

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 181 +++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 251c0fd94962..ff92064c2246 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -41,6 +41,52 @@
  */
 #define SMEM_HW_SW_BUILD_ID            137
 
+enum {
+	HW_PLATFORM_UNKNOWN = 0,
+	HW_PLATFORM_SURF = 1,
+	HW_PLATFORM_FFA = 2,
+	HW_PLATFORM_FLUID = 3,
+	HW_PLATFORM_SVLTE_FFA = 4,
+	HW_PLATFORM_SVLTE_SURF = 5,
+	HW_PLATFORM_MTP_MDM = 7,
+	HW_PLATFORM_MTP = 8,
+	HW_PLATFORM_LIQUID = 9,
+	HW_PLATFORM_DRAGON = 10,
+	HW_PLATFORM_QRD = 11,
+	HW_PLATFORM_HRD = 13,
+	HW_PLATFORM_DTV = 14,
+	HW_PLATFORM_RCM = 21,
+	HW_PLATFORM_STP = 23,
+	HW_PLATFORM_SBC = 24,
+	HW_PLATFORM_HDK = 31,
+	HW_PLATFORM_ATP = 33,
+	HW_PLATFORM_IDP = 34,
+	HW_PLATFORM_INVALID
+};
+
+static const char * const hw_platform[] = {
+	[HW_PLATFORM_UNKNOWN] = "Unknown",
+	[HW_PLATFORM_SURF] = "Surf",
+	[HW_PLATFORM_FFA] = "FFA",
+	[HW_PLATFORM_FLUID] = "Fluid",
+	[HW_PLATFORM_SVLTE_FFA] = "SVLTE_FFA",
+	[HW_PLATFORM_SVLTE_SURF] = "SLVTE_SURF",
+	[HW_PLATFORM_MTP_MDM] = "MDM_MTP_NO_DISPLAY",
+	[HW_PLATFORM_MTP] = "MTP",
+	[HW_PLATFORM_RCM] = "RCM",
+	[HW_PLATFORM_LIQUID] = "Liquid",
+	[HW_PLATFORM_DRAGON] = "Dragon",
+	[HW_PLATFORM_QRD] = "QRD",
+	[HW_PLATFORM_HRD] = "HRD",
+	[HW_PLATFORM_DTV] = "DTV",
+	[HW_PLATFORM_STP] = "STP",
+	[HW_PLATFORM_SBC] = "SBC",
+	[HW_PLATFORM_HDK] = "HDK",
+	[HW_PLATFORM_ATP] = "ATP",
+	[HW_PLATFORM_IDP] = "IDP",
+	[HW_PLATFORM_INVALID] = "Invalid",
+};
+
 #ifdef CONFIG_DEBUG_FS
 #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
 #define SMEM_IMAGE_VERSION_SIZE                4096
@@ -368,6 +414,140 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QRU1062) },
 };
 
+/* sysfs attributes */
+#define ATTR_DEFINE(param) \
+	static DEVICE_ATTR(param, 0644, qcom_get_##param, NULL)
+
+/* Version 2 */
+static ssize_t
+qcom_get_raw_id(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 le32_to_cpu(soc_info->raw_id));
+}
+ATTR_DEFINE(raw_id);
+
+static ssize_t
+qcom_get_raw_version(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 le32_to_cpu(soc_info->raw_ver));
+}
+ATTR_DEFINE(raw_version);
+
+/* Version 3 */
+static ssize_t
+qcom_get_hw_platform(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	uint32_t hw_plat = le32_to_cpu(soc_info->hw_plat);
+
+	hw_plat = (hw_plat >= HW_PLATFORM_INVALID) ? HW_PLATFORM_INVALID : hw_plat;
+	return scnprintf(buf, PAGE_SIZE, "%-.32s\n",
+			hw_platform[hw_plat]);
+}
+ATTR_DEFINE(hw_platform);
+
+/* Version 4 */
+static ssize_t
+qcom_get_platform_version(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 le32_to_cpu(soc_info->plat_ver));
+}
+ATTR_DEFINE(platform_version);
+
+/* Version 5 */
+static ssize_t
+qcom_get_accessory_chip(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			le32_to_cpu(soc_info->accessory_chip));
+}
+ATTR_DEFINE(accessory_chip);
+
+/* Version 6 */
+static ssize_t
+qcom_get_platform_subtype_id(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 le32_to_cpu(soc_info->hw_plat_subtype));
+}
+ATTR_DEFINE(platform_subtype_id);
+
+static struct attribute *qcom_custom_socinfo_attrs[7];
+
+static const struct attribute_group custom_soc_attr_group = {
+	.attrs = qcom_custom_socinfo_attrs,
+};
+
+static void qcom_socinfo_populate_sysfs(struct qcom_socinfo *qcom_socinfo)
+{
+	int i = 0, socinfo_format = le32_to_cpu(soc_info->fmt);
+
+	/* Note: qcom_custom_socinfo_attrs[] size needs to be in sync with attributes added here. */
+	switch (socinfo_format) {
+	case SOCINFO_VERSION(0, 16):
+		fallthrough;
+	case SOCINFO_VERSION(0, 15):
+		fallthrough;
+	case SOCINFO_VERSION(0, 14):
+		fallthrough;
+	case SOCINFO_VERSION(0, 13):
+		fallthrough;
+	case SOCINFO_VERSION(0, 12):
+		fallthrough;
+	case SOCINFO_VERSION(0, 11):
+		fallthrough;
+	case SOCINFO_VERSION(0, 10):
+		fallthrough;
+	case SOCINFO_VERSION(0, 9):
+		fallthrough;
+	case SOCINFO_VERSION(0, 8):
+		fallthrough;
+	case SOCINFO_VERSION(0, 7):
+		fallthrough;
+	case SOCINFO_VERSION(0, 6):
+		qcom_custom_socinfo_attrs[i++] =
+			&dev_attr_platform_subtype_id.attr;
+		fallthrough;
+	case SOCINFO_VERSION(0, 5):
+		qcom_custom_socinfo_attrs[i++] = &dev_attr_accessory_chip.attr;
+		fallthrough;
+	case SOCINFO_VERSION(0, 4):
+		qcom_custom_socinfo_attrs[i++] = &dev_attr_platform_version.attr;
+		fallthrough;
+	case SOCINFO_VERSION(0, 3):
+		qcom_custom_socinfo_attrs[i++] = &dev_attr_hw_platform.attr;
+		fallthrough;
+	case SOCINFO_VERSION(0, 2):
+		qcom_custom_socinfo_attrs[i++] = &dev_attr_raw_id.attr;
+		qcom_custom_socinfo_attrs[i++] = &dev_attr_raw_version.attr;
+		fallthrough;
+	case SOCINFO_VERSION(0, 1):
+		break;
+	default:
+		pr_err("Unknown socinfo format: v%u.%u\n",
+				SOCINFO_MAJOR(socinfo_format),
+				SOCINFO_MINOR(socinfo_format));
+		break;
+	}
+
+	qcom_custom_socinfo_attrs[i] = NULL;
+	qcom_socinfo->attr.custom_attr_group = &custom_soc_attr_group;
+}
+
 static const char *socinfo_machine(struct device *dev, unsigned int id)
 {
 	int idx;
@@ -696,6 +876,7 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 							"%u",
 							le32_to_cpu(soc_info->serial_num));
 
+	qcom_socinfo_populate_sysfs(qs);
 	qs->soc_dev = soc_device_register(&qs->attr);
 	if (IS_ERR(qs->soc_dev))
 		return PTR_ERR(qs->soc_dev);
-- 
2.17.1


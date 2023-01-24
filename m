Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA367A722
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjAXXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjAXXrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:47:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F09776B9;
        Tue, 24 Jan 2023 15:47:14 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OMdYux009362;
        Tue, 24 Jan 2023 23:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Hxx4aX+g3p2ggEJ5LuDFh79LNNcb8nZD2I2P+rCtMlM=;
 b=CyaYpRetPJeacjtI2A2M38ndyv7Zizcxxcyco1KSu9wsfxw2mxdQuEOMyMJQGtCeW/g5
 6ZkrInM4dIgsEPLrlNN86EEFbwwUdydS1RIUNS1FMiR64+cfZU0/uCxuOCCjIlN1tRS9
 ZvOMxGfYb0TUDpJJLuHTJMJ4PIvLKSKEpaszXG1UPS81LRe19rQ6Dtlj2hac4dGtfncj
 oJl47WKJKMz0zNjTTZpUDAFjVkABOMGUarpHv1tDTKgSE0hB9ukyG4q/glm9Zjd2t2q9
 pc5zOJ4VZDHznRo1zfbRdhS/TUBCXO8iMlTcLas9F55ae4Lp3V0LwoYGTPklNmb0HhLy YQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najqa8se0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 23:47:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ONl5id008667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 23:47:05 GMT
Received: from hu-collinsd-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 15:47:04 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 1/3] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date:   Tue, 24 Jan 2023 15:46:04 -0800
Message-ID: <57466b092dd16ed2a25e5a472dfd0b856a5cca00.1674602698.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1674602698.git.quic_collinsd@quicinc.com>
References: <cover.1674602698.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IjM-NRbRxbcgvt4EEmKBeob68dAw8v8n
X-Proofpoint-ORIG-GUID: IjM-NRbRxbcgvt4EEmKBeob68dAw8v8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240219
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
stage 2 automatic PMIC partial shutdown to be enabled in order to
avoid repeated faults in the event of reaching over-temperature
stage 3.  Modify the stage 2 shutdown control logic to ensure that
stage 2 shutdown is enabled on all affected PMICs.  Read the
digital major and minor revision registers to identify these
PMICs.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index ad84978109e6..e2e52703ac4d 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -18,6 +19,7 @@
 #include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -73,6 +75,7 @@ struct qpnp_tm_chip {
 	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
 	unsigned int			subtype;
+	unsigned int			dig_revision;
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
@@ -224,6 +227,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
 	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
 	bool disable_s2_shutdown = false;
+	bool require_s2_shutdown = false;
 	u8 reg;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
@@ -256,9 +260,25 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 				 temp, stage2_threshold_max, stage2_threshold_max);
 	}
 
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (chip->dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			require_s2_shutdown = true;
+			break;
+		}
+	}
+
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
+	if (disable_s2_shutdown && !require_s2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
@@ -373,7 +393,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
+	u8 type, subtype, dig_major, dig_minor;
 	u32 res;
 	int ret, irq;
 
@@ -429,6 +449,14 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not read dig_minor\n");
+		return ret;
+	}
+
+	chip->dig_revision = (dig_major << 8) | dig_minor;
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
-- 
2.25.1


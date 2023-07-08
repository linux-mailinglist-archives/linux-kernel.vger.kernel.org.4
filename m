Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5874BCAE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGHHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjGHHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:31:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B13D270F;
        Sat,  8 Jul 2023 00:31:22 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687IDZA008781;
        Sat, 8 Jul 2023 07:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QJ+Cw8l24SNPIrphGTuZzU1yLO5BpvVRyjhWd4V/wiE=;
 b=CmaNFjFmL/Wryz7/HepKaIC2urRMtOeJl0PmpSptst++jibQGPJXiXpcuPhy9kSu03WC
 jbK3p8+ZNvJbJkML0ee1jN/5v9IIJXo8B/bafHpZ1wa/Ann+WfgW92ZwcylGAsugK7aQ
 zvJJ+r8fR6MHcvOHGNEq/dbUX8+/EM/uxCAW3BMG3VhuY16HaJ1dmVmNlTVPyMoqvWJG
 1jFsIwK8MvmSU4qxirX7zjfEWlq4mYSSEwK1daJcQuD75cC1ty79MEstHbk0gNEwaMja
 UyM8hvsSzvomrAXTyriv7JrQnN1VOp4BBxO9KVIgZIFHl+QD6MqS0O+QHJ1wH9FuphnN Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq06d06e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:31:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687V1EK019689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:31:01 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:30:54 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH 09/11] iio: adc: Update QCOM ADC drivers for bindings path change
Date:   Sat, 8 Jul 2023 12:58:33 +0530
Message-ID: <20230708072835.3035398-10-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XtKuNKbMJJsxjk9msN2rrrfLpHBmYIso
X-Proofpoint-GUID: XtKuNKbMJJsxjk9msN2rrrfLpHBmYIso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=712 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADC dt-bindings file paths in QCOM ADC driver files to
match the dt-bindings change moving the files from 'iio' to
'iio/adc' folder.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
 drivers/iio/adc/qcom-spmi-adc5.c      | 2 +-
 drivers/iio/adc/qcom-spmi-vadc.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index fe5515ee8451..78ece8fccbae 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define ADC5_GEN3_HS				0x45
 #define ADC5_GEN3_HS_BUSY			BIT(7)
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 6cebeaa69a75..5dfcb770d663 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -21,7 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index f5c6f1f27b2c..c3602c53968a 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/log2.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
-- 
2.25.1


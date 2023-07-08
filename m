Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873CC74BC8A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGHH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHH3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:29:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD89710CE;
        Sat,  8 Jul 2023 00:29:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687BR1p018966;
        Sat, 8 Jul 2023 07:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=fa4crDmWzyhVad6ao5l+sFMQ4oZ2W3OiYCbVgIJlTe4=;
 b=EV/WYKUonpvdsvTuN2H4rqAmeIIV9NTaKqs0eAwdl6EMuduHK412AtdIaCVoAMQeZpUV
 ei+UBUkTelEOKqzYURqaLK+LkPNj/TanoeIgYk2t+I+SvkAJ7pNCyN7/Ra0mFvYmdTGK
 iND2MzNGyW9eVokxGLKQDqI7ter5ggqHY1BDrImqO70XRuItj91ZKLmiRqSvS1dgbxS2
 chRjBuOywcKj+INgyQ1uQiGZq7Cn4NyNRiysaVFxqYzWMWtBnHVGefWujDUaleD/QYRZ
 8yT7qYqMfztVrSDo4DffVk5WDNioy8oOo96+JDhNi/lTBwPjTILMHwT9DJQ8dJVvZZkJ /w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyw1r6yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:28:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687Su7V031175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:28:56 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:28:50 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH 00/11] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
Date:   Sat, 8 Jul 2023 12:58:24 +0530
Message-ID: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A6t6Bn8aPGAJguQizCDwB6zn7eyy4FGG
X-Proofpoint-ORIG-GUID: A6t6Bn8aPGAJguQizCDwB6zn7eyy4FGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=839 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same driver.

Patches 1-5 update the name of the previous generation of PMIC5 ADC peripherals
from ADC7 to ADC5 Gen2, as this is the correct name and it makes more sense now
to update it, with the addition of the latest ADC5 Gen3 peripheral support.

Patches 6 and 7 add bindings and driver support respectively for ADC5 Gen3.

Patches 8-11 are for an additional change, where the QCOM ADC dt-bindings files
are moved from dt-bindings/iio to dt-bindings/iio/adc folder, as they are
specifically for ADC devices.

Jishnu Prakash (11):
  iio: adc: Update bindings for ADC7 name used on QCOM PMICs
  iio: adc: Update driver files for ADC7 rename for QCOM PMICs
  ARM: dts: qcom: Update devicetree for ADC7 rename for QCOM PMICs
  iio: adc: Update bindings to remove support for ADC7 name used on QCOM
    PMICs
  iio: adc: qcom-spmi-adc5: remove support for ADC7 compatible string
  iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  dt-bindings: iio: adc: Copy QCOM ADC bindings files
  iio: adc: Update QCOM ADC drivers for bindings path change
  ARM: dts: qcom: Update devicetree for QCOM ADC bindings path change
  dt-bindings: iio: remove QCOM ADC files from iio folder

 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  131 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   19 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi           |    2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         |    4 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |    2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |    4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |    4 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |    8 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   48 +-
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |    2 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |    4 +-
 drivers/iio/adc/Kconfig                       |   25 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 1193 +++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c              |   93 +-
 drivers/iio/adc/qcom-spmi-vadc.c              |    2 +-
 drivers/iio/adc/qcom-vadc-common.c            |   36 +-
 .../iio/adc/qcom,spmi-adc5-gen2-pm8350.h      |   64 +
 .../iio/adc/qcom,spmi-adc5-gen2-pm8350b.h     |   89 ++
 .../iio/adc/qcom,spmi-adc5-gen2-pmk8350.h     |   47 +
 .../iio/adc/qcom,spmi-adc5-gen2-pmr735a.h     |   29 +
 .../iio/adc/qcom,spmi-adc5-gen2-pmr735b.h     |   28 +
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |   48 +
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |   97 ++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |   20 +
 .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |   54 +
 .../iio/{ => adc}/qcom,spmi-vadc.h            |  209 ++-
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   |   63 -
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350b.h  |   88 --
 .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  |   46 -
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735a.h  |   28 -
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |   28 -
 include/linux/iio/adc/qcom-vadc-common.h      |   12 +-
 50 files changed, 2088 insertions(+), 474 deletions(-)
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pm8350.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pm8350b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmk8350.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmr735a.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmr735b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (59%)
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h

-- 
2.25.1


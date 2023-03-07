Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24096AD645
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCGEmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGEmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:42:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAE04D28B;
        Mon,  6 Mar 2023 20:42:00 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3272qbil012056;
        Tue, 7 Mar 2023 04:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=J6SXEN96JQzGueQot0vFg6fsyyCKptxY/7flN3T2FaQ=;
 b=fqF1xe4BsfNEMmRV8YAdKdva6D3QxrUo2NiTjBjRY/8VS13mNUPs/t69GqRZUpQpjrOD
 kUsETPKBGuGeQhZ0+N8XtHKLZR9vFK8KDUxwFxCQu1eKdwP2auP+Vws6MTXQardt86rn
 RUuFmOxqKIvmdYlNt8CAjFEYWubmQHw/OQ8eS91oOnzBqWigsJWkPP3/jdGPIhN1mX+p
 62Px/okJJzgh09GijnZv81IbkbHpmW58LwXyW+nFarOCkfwm1p2Y0GSQ5DjzOr2o1Owd
 IcRdQrEb1l4gQu8xenP4UguY7Iu+aa5C8pMYscm7eq5PlPqi6NAbSSAe+WwVU2BIBPYB Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5usx0bru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:41:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274fr2L014413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:41:53 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 20:41:46 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_mmanikan@quicinc.com>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 00/11] Add multipd remoteproc support
Date:   Tue, 7 Mar 2023 10:11:26 +0530
Message-ID: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AQVgYzGTS4YzrKyC_mVqDdtUDGtHYhsk
X-Proofpoint-GUID: AQVgYzGTS4YzrKyC_mVqDdtUDGtHYhsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=681 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on the IPQ5018, IPQ9574 baseport patches available here
https://lore.kernel.org/linux-arm-msm/20220621161126.15883-1-quic_srichara@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20230217142030.16012-1-quic_devipriy@quicinc.com/

APSS brings Q6 out of reset and then Q6 brings
WCSS block (wifi radio's) out of reset.

				   ---------------
			      -->  |WiFi 2G radio|
			      |	   --------------
			      |
--------	-------	      |
| APSS | --->   |QDSP6|  -----|
---------	-------       |
                              |
      			      |
			      |   --------------
			      --> |WiFi 5G radio|
				  --------------

Problem here is if any radio crashes, subsequently other
radio also should crash because Q6 crashed. Let's say
2G radio crashed, Q6 should pass this info to APSS. Only
Q6 processor interrupts registered with APSS. Obviously
Q6 should crash and raise fatal interrupt to APSS. Due
to this 5G radio also crashed. But no issue in 5G radio,
because of 2G radio crash 5G radio also impacted.

In multi pd model, this problem is resolved. Here WCSS
functionality (WiFi radio's) moved out from Q6 root pd
to a separate user pd. Due to this, radio's independently
pass their status info to APPS with out crashing Q6. So
other radio's won't be impacted.

						---------
					    	|WiFi    |
					    --> |2G radio|
					    | 	---------
------	Start Q6     		-------     |
|    |	------------------>     |     |     |
|    |  Start WCSS PD1 (2G)   	|     |	    |
|APSS|	----------------------->|QDSP6|-----|
|    |	Start WCSS PD1 (5G)	|     |
|    |	----------------------->|     |-----|
------		     		-------     |
					    |
					    |	-----------
					    |-->|WiFi	  |
						|5G radio |
						-----------
According to linux terminology, here consider Q6 as root
i.e it provide all services, WCSS (wifi radio's) as user
i.e it uses services provided by root.

Since Q6 root & WCSS user pd's able to communicate with
APSS individually, multipd remoteproc driver registers
each PD with rproc framework. Here clients (Wifi host drivers)
intrested on WCSS PD rproc, so multipd driver start's root
pd in the context of WCSS user pd rproc start. Similarly
on down path, root pd will be stopped after wcss user pd
stopped.

Here WCSS(user) PD is dependent on Q6(root) PD, so first
q6 pd should be up before wcss pd. After wcss pd goes down,
q6 pd should be turned off.

rproc->ops->start(userpd_rproc) {
	/* Boot root pd rproc */
	rproc_boot(upd_dev->parent);
	---
	/* user pd rproc start sequence */
	---
	---
}
With this way we ensure that root pd brought up before userpd.

rproc->ops->stop(userpd_rproc) {
	---
	---
	/* user pd rproc stop sequence */
	---
	---
	/* Shutdown root pd rproc */
	rproc_shutdown(upd_dev->parent);
}
After userpd rproc stops, root pd rproc will be stopped.
IPQ5018, IPQ9574 supports multipd remoteproc driver.

Manikanta Mylavarapu (11):
  dt-bindings: remoteproc: qcom: Add support for multipd model
  dt-bindings: mailbox: qcom: Add IPQ5018 APCS compatible
  dt-bindings: scm: Add compatible for IPQ5018
  dt-bindings: arm: qcom: Add ipq5018-mp03.5-c1
  dt-bindings: clock: qcom: gcc-ipq9574: Add Q6 gcc clock control
  clk: qcom: IPQ9574: Add q6/wcss clocks
  mailbox: qcom-apcs-ipc: Add IPQ5018 APCS IPC support
  remoteproc: qcom: Add Hexagon based multipd rproc driver
  arm64: dtsi: qcom: ipq5018: enable nodes required for multipd
  arm64: dts: qcom: ipq5018: Add MP03.5-c1 board support
  arm64: dtsi: qcom: ipq9574: Add nodes to bring up multipd

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/firmware/qcom,scm.yaml           |   1 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |   2 +
 .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts |  64 ++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 130 ++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 145 ++++
 drivers/clk/qcom/gcc-ipq9574.c                | 119 ++++
 drivers/firmware/qcom_scm.c                   | 114 +++
 drivers/firmware/qcom_scm.h                   |   6 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       |   1 +
 drivers/remoteproc/Kconfig                    |  20 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/qcom_common.c              |  23 +
 drivers/remoteproc/qcom_common.h              |   1 +
 drivers/remoteproc/qcom_q6v5.c                |  41 +-
 drivers/remoteproc/qcom_q6v5.h                |  15 +-
 drivers/remoteproc/qcom_q6v5_adsp.c           |   5 +-
 drivers/remoteproc/qcom_q6v5_mpd.c            | 668 ++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_mss.c            |   4 +-
 drivers/remoteproc/qcom_q6v5_pas.c            |   3 +-
 drivers/soc/qcom/mdt_loader.c                 | 314 ++++++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  | 159 +++--
 include/linux/firmware/qcom/qcom_scm.h        |   3 +
 include/linux/soc/qcom/mdt_loader.h           |  19 +
 26 files changed, 2057 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
 create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c

--
2.34.1


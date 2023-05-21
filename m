Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56C70B179
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjEUW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEUW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:29:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3822EDE;
        Sun, 21 May 2023 15:29:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMSYaX007750;
        Sun, 21 May 2023 22:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=n5ptajVHTuzBLYXfFcRkoFuin90Tu5SSz+cp+G+yHKI=;
 b=I1T4bNzKEsi3e2QZFwxW1mDJgak3FE+T7Vhutu4AWYNl/D5BmfW72YJodMQ4ZcwiwlbK
 K7s+YS7FJgFT9wpSZdP0eoeWyEuTgH5bIauSe6erRG5goU93Mk/sWSXz/x1/Ynxf6vBM
 6xBzuEBwHptH0UtN2E65fGc2P/gsuANHbQM2Hopt0b1JMA6gva+vn6/tlcC4Iogj0kmg
 AWP2nWOv+DlzrgKOKFhh6/ptEnnGqjFjB52jQQ9Suom67L+F9aZxFagw37i10wQdscac
 UcwaJAczK8KewyqLfX4NoW00F21iiNFY4F/+ATLrffQ+neMzLOv2dybmaSk2/aaGnQTN GQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpn7f2bmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:29:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMTGBG010444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:29:16 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:29:08 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 00/13] Add multipd remoteproc support
Date:   Mon, 22 May 2023 03:58:39 +0530
Message-ID: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y7pxhY4MegK2_kpqNF6sO1C7g0SRe8hQ
X-Proofpoint-ORIG-GUID: y7pxhY4MegK2_kpqNF6sO1C7g0SRe8hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=695
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Pd means protection domain. It's similar to process in Linux.
Here QDSP6 processor runs each wifi radio functionality on a
separate process. One process can't access other process
resources, so this is termed as PD i.e protection domain.

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

DTS patch [13/13] is based on below series
https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
	
[V2]
	- This patch is depends on the below series
https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20230519125409.497439-1-quic_srichara@quicinc.com/
	- Fixed all comments and rebased for TOT.
	- Strip off SCM code changes from https://lore.kernel.org/linux-arm-msm/1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com/
	  and made new patchset [08/13]
	- Strip off qcom_q6v5 changes from https://lore.kernel.org/linux-arm-msm/1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com/
	  and made new patchset [09/13]
	- since clocks handled by QDSP6 firmware
	  Dropped https://lore.kernel.org/linux-arm-msm/1678164097-13247-6-git-send-email-quic_mmanikan@quicinc.com/,
	  https://lore.kernel.org/linux-arm-msm/1678164097-13247-7-git-send-email-quic_mmanikan@quicinc.com/.
 	  Added [04/13], [05/13], [06/13], [07/13] patches.

Manikanta Mylavarapu (13):
  dt-bindings: remoteproc: qcom: Add support for multipd model
  dt-bindings: mailbox: qcom: Add IPQ5018 APCS compatible
  dt-bindings: arm: qcom: Document the Qualcomm rdp432-c1 board
  dt-bindings: clock: qcom: gcc-ipq5018: remove q6 clocks macros
  dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring up clock macros
  clk: qcom: ipq5018: remove q6 bring up clocks
  clk: qcom: ipq9574: remove q6 bring up clocks
  firmware: qcom_scm: ipq5018: Add WCSS AHB pd support
  remoteproc: qcom: q6v5: Add multipd interrupts support
  remoteproc: qcom: Add Hexagon based multipd rproc driver
  arm64: dtsi: qcom: ipq5018: enable nodes required for multipd
  arm64: dts: qcom: ipq5018: Add RDP432-c1 board support
  arm64: dtsi: qcom: ipq9574: Add nodes to bring up multipd

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |   1 +
 .../bindings/remoteproc/qcom,multipd-pil.yaml | 265 +++++++
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts |  49 ++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 140 ++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 118 +++
 drivers/clk/qcom/gcc-ipq5018.c                | 414 -----------
 drivers/clk/qcom/gcc-ipq9574.c                | 326 ---------
 drivers/firmware/qcom_scm.c                   | 114 +++
 drivers/firmware/qcom_scm.h                   |   6 +
 drivers/remoteproc/Kconfig                    |  20 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/qcom_common.h              |   9 +
 drivers/remoteproc/qcom_q6v5.c                |  37 +-
 drivers/remoteproc/qcom_q6v5.h                |  11 +
 drivers/remoteproc/qcom_q6v5_mpd.c            | 677 ++++++++++++++++++
 drivers/soc/qcom/mdt_loader.c                 | 332 +++++++++
 include/dt-bindings/clock/qcom,gcc-ipq5018.h  |  21 -
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  18 -
 include/linux/firmware/qcom/qcom_scm.h        |   3 +
 include/linux/soc/qcom/mdt_loader.h           |  19 +
 22 files changed, 1801 insertions(+), 782 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
 create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c


base-commit: dbd91ef4e91c1ce3a24429f5fb3876b7a0306733
--
2.17.1


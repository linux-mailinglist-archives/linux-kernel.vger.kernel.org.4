Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE669585A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjBNFP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjBNFPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:15:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85BC3;
        Mon, 13 Feb 2023 21:15:07 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E3d1xg026852;
        Tue, 14 Feb 2023 05:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fd2UEzMOvF59hx01J91ct4H3+bj7xNH6Mn+xRBEHyEA=;
 b=LLfePAb41OkI0DYTIXr3YN+1xYG4JlMExGOH2UapKtJwZLCI6S+SL3erBAJsJHw6Hx24
 ZP1KTfdTG1oHN2piDN7Ix1xbvEC79wPtD6QN7uQ+vIgbnTtT6SSy2KrwHYh7LcZytxAD
 7AkcrONz1T0l66Y0d5JZnCVGOedL2Xn/1m36zf3SLka8Sgk6tu+JX1sEPm9tsF14IvHj
 C186ywwscMIffGZwEEEVBbiLTpAaEmfHVFYam+n2KS2yGdAIt+bTk4lOxkmw7I2+WvVd
 2vvnbxpnUgyd+RwFEqVLXF9yFJ72jHZ9rp1fs7TH7hw3gUmNOVjbL8XLVQCFdaLAA9zY 7A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0qpx1jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:14:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E5EeUT017671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:14:40 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 21:14:30 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V4 0/5] Enable crashdump collection support for IPQ9574
Date:   Tue, 14 Feb 2023 10:44:09 +0530
Message-ID: <20230214051414.10740-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bjw5tdUVZ_bwDYRKmAu2kM0fLSLu3wOQ
X-Proofpoint-ORIG-GUID: bjw5tdUVZ_bwDYRKmAu2kM0fLSLu3wOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_02,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=974
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashdump collection is enabled based on the DLOAD bit in the TCSR register.
This bit is set during bootup and clearing during shutdown. During crash,
dload bit is not cleared, due to which uboot starts crashdump collection.

Enable the support for download mode to collect the crashdumps if
system crashes, to debug crashes extensively.

During the bootup, bootloaders initialize the SMEM. However the bootup
after crash, SMEM will not be initialized again. If the memory for the
SMEM is not reserved, linux consumes that region, which leads to the
loss of SMEM data. So, during the next bootup after crash, bootloaders
will hang due to invalid data present in the SMEM region. Due to this,
added the SMEM support along with crashdump collection series.

This patch series adds the support for crashdump collection.

DTS patch depends on the IPQ9574 baseport series
	https://lore.kernel.org/linux-arm-msm/20230206103337.21000-1-quic_devipriy@quicinc.com/

V4:
	- change logs are added to the respective patches.

V3 can be found at
	https://lore.kernel.org/linux-arm-msm/20230208053332.16537-1-quic_poovendh@quicinc.com/

Changes in V2:
	- rebased on linux-next/master
	- dropped co-developed by tag wherever applicable
	- V1 can be found at
	  https://lore.kernel.org/linux-arm-kernel/20230113160012.14893-1-quic_poovendh@quicinc.com/

Poovendhan Selvaraj (5):
  dt-bindings: scm: Add compatible for IPQ9574
  dt-bindings: mfd: Add the tcsr compatible for IPQ9574
  arm64: dts: qcom: ipq9574: Enable the download mode support
  arm64: dts: qcom: ipq9574: Add SMEM support
  firmware: scm: Modify only the DLOAD bit in TCSR register for download
    mode

 .../bindings/firmware/qcom,scm.yaml           |  1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 26 ++++++++++++++++++-
 drivers/firmware/qcom_scm.c                   | 15 +++++++----
 4 files changed, 37 insertions(+), 6 deletions(-)


base-commit: 09e41676e35ab06e4bce8870ea3bf1f191c3cb90
-- 
2.17.1


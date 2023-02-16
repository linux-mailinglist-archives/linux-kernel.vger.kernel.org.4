Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E796993C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBPMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBPMA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:00:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3A4DE2E;
        Thu, 16 Feb 2023 04:00:57 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G9v5BE006060;
        Thu, 16 Feb 2023 12:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=W8ePcFtZmfge+Cu/kfzfYiGRGfZljIUF6Q7OM1E9kkQ=;
 b=QIDaQ5Z8GOt0VsU1TIxk9iGzVY1FX1EmdGe740aRfI0ElZsi40LvQquuKbApGG6Y0d97
 qDEYfZwkYbP7Y/s0A46CEoOQiwDhqEPaCQz0L/1/lI5+KCQ7WsgxsyTFYwGA6llBbCs9
 JPkVJJK0nP24mWU2jsb7bPgeYky56r1M1UikI/INGgArFucKv9GIMmb35uYZZORN4uCH
 +FzBYWFFuL3Rjzldb/6NnMdmGbK2YKUC8JzGjhu620ItnUMVY41IJfpeMvxrPJU7aDmh
 cX8O1glAaygYkkxQhn6Qz93rfepX3GSLjDyCljfvHDXEZnchvCnZ4dRVgH+9Sy19plnZ BQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsja9092b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 12:00:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GC0ctp030979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 12:00:38 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Feb 2023 04:00:30 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V5 0/5] Enable crashdump collection support for IPQ9574
Date:   Thu, 16 Feb 2023 17:30:07 +0530
Message-ID: <20230216120012.28357-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8vQeDNHWVkNdYQDcMh_tTfCDSK2kYwKv
X-Proofpoint-ORIG-GUID: 8vQeDNHWVkNdYQDcMh_tTfCDSK2kYwKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_09,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=996
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160102
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
	https://lore.kernel.org/linux-arm-kernel/20230214163116.9924-1-quic_devipriy@quicinc.com/

V5:
	- change logs are added to the respective patches.

V4 can be found at
	https://lore.kernel.org/linux-arm-kernel/20230214051414.10740-1-quic_poovendh@quicinc.com/

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
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 25 +++++++++++++++++++
 drivers/firmware/qcom_scm.c                   | 21 ++++++++++++----
 4 files changed, 43 insertions(+), 5 deletions(-)


base-commit: 509583475828c4fd86897113f78315c1431edcc3
-- 
2.17.1


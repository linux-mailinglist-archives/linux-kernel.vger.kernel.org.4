Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB96B0A30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCHN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjCHN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:56:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577ED90F0;
        Wed,  8 Mar 2023 05:55:33 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Cp7dm029875;
        Wed, 8 Mar 2023 13:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=CcrsohLDRpbrter+vKyPvH5Z7xlgXzEN2lBYKNnJskg=;
 b=ZXObca4jXOuzkvqAOPMY9ZvXla1vdnC2I+NXS1ZIOtTgw5p2UJ5OD+yZgaGKdXsj0oAM
 mvflZBg799+DYZJUukOIJd8illmiUtr6AtSdSdaZCZCYPV59xIQJZ54piekpmKwLgHfo
 VpSkVkqzdep38C0yJ5TtTergYXCU6a/7BvtrlrfqwhK5fn/uG8LUjsV3NY2RM+Bwp1fq
 wOORfZkG8K7wHt4cC7Pc6m94e4nCdvgLzUO7r0qsAmnOTQsJ6ie8Yam04w/O78nKEYDv
 ESEpUiYyxJSBqJ0zroRVhBCQToW1TTsV8GimQGdxRVrBUkujBO0xtNe5/CXgqi2KVUua sQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fmm1syc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:54:55 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328DspKK004217;
        Wed, 8 Mar 2023 13:54:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fftc0fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 13:54:51 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DsoLn004202;
        Wed, 8 Mar 2023 13:54:51 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 328Dso28004200;
        Wed, 08 Mar 2023 13:54:50 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0D8E14FB2; Wed,  8 Mar 2023 19:24:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/2] Add support for PCIe PHY in SDX65
Date:   Wed,  8 Mar 2023 19:24:46 +0530
Message-Id: <1678283688-4020-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T9jW8JeEJSGqsPbrwUYFqQc-WK2-MAMX
X-Proofpoint-ORIG-GUID: T9jW8JeEJSGqsPbrwUYFqQc-WK2-MAMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=948 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080118
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2:
 - Addressing Dmitry's comments and adjusting according to new bindings.
 - Rebased on top of 6.3-rc1.

This series adds support for PCIe PHY found in Qualcomm SDX65 platform.
The PHY version is v5.20 which has different register offsets compared with
previous v5.0x and v4.0x versions. So separate defines are introducted to
handle the differences.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: phy: qcom,qmp: Add SDX65 QMP PHY binding
  phy: qcom-qmp: Add support for SDX65 QMP PCIe PHY

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 165 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |  24 +++
 5 files changed, 194 insertions(+)

-- 
2.7.4


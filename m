Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5776B6FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCMHOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCMHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:14:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53034C26;
        Mon, 13 Mar 2023 00:14:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2INKT006885;
        Mon, 13 Mar 2023 07:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=OFJDzavBxKhCnrLoHXy25NE3CtzAgaTKwbIfky7Dhgc=;
 b=dbQXK5IibRvax1T/H0voHpl7rQ7OdEof8oyH1BO0DrkyYZwBlS/XBLNEIZB0uPmUYjG0
 zV47l47db4c3jx1nK7yq5M4llTqzHIBdKCLSwllnY35DeM7x90WeIGeIs8THtCkMRl6c
 mjXIMbd5Ew3aCuGmumfkW5RLWvkWqLCYYQYmE8arj64QLsXmTIr1mV4WP8ie0H7PXJLy
 /x7kbfAo7I4mSvLMefiVMoBIrjzOvNwi5HI/HVSY8qaEH3ziNkAdJImATlRjmeCCVV9c
 ZyytHs7cX4+SD0I9KmXRiClwwt66tJB7RkwIzqWTBePQJiN+zDd/VJ85gxlAiECbuk4r eQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8jds4141-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 07:13:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7DgZ6032097;
        Mon, 13 Mar 2023 07:13:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkkyk1-1;
        Mon, 13 Mar 2023 07:13:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32D7DfF1032092;
        Mon, 13 Mar 2023 07:13:42 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32D7Df4B032091;
        Mon, 13 Mar 2023 07:13:41 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id C4710D8;
        Mon, 13 Mar 2023 12:43:40 +0530 (IST)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/5] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Mon, 13 Mar 2023 12:43:20 +0530
Message-Id: <20230313071325.21605-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -ozMKBk6KJudAV0russ96ojXDRqjiUtE
X-Proofpoint-GUID: -ozMKBk6KJudAV0russ96ojXDRqjiUtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=852 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset refactor LLCC driver and adds LLCC support for the
Qualcomm QDU1000 and QRU1000 SoCs. Since QDU1000/QRU1000 supports
multi channel DDR, add support for multi channel DDR configuration
in LLCC.

Komal Bajaj (5):
  soc: qcom: llcc: Refactor llcc driver to support multiple
    configuration
  dt-bindings: arm: msm: Add bindings for multi channel DDR in LLCC
  dt-bindings: arm: msm: Add LLCC compatible for QDU1000/QRU1000
  soc: qcom: Add LLCC support for multi channel DDR
  soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support

 .../bindings/arm/msm/qcom,llcc.yaml           |  10 +
 drivers/soc/qcom/llcc-qcom.c                  | 308 +++++++++++++-----
 include/linux/soc/qcom/llcc-qcom.h            |   4 +-
 3 files changed, 240 insertions(+), 82 deletions(-)

-- 
2.39.1


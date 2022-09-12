Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849105B6276
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiILVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILVHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:07:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D5237C6;
        Mon, 12 Sep 2022 14:06:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CJkHEe004643;
        Mon, 12 Sep 2022 21:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8fc6O0cXtlVSu3DRZJSbE3M7uGjd7xxHSUaHVdLgRBs=;
 b=RrM6obL6GQVpwq6XAeFgGoWjspJPBejn+UOOXmSfpJ4f2sQa9mL9vL2WWhrH4ik1674y
 3N3ilvJQWFPmn8NTx9DuKkN2E8n7yxLxMg/doGTzRr35wFZdZ+9ZAOCiua7RIprNLREH
 Utt2UmcW/lLWJaKIcEFVIBoYdvMxISSMedPN3Uxs2xRSl6Rf2yMlRBR3lqmd3dAtTTet
 S8cjZyOz6wG4L0xeKiwcEuhhFW9GyclCtah715Q7ifiSZ10bW2K29r2EzWbsYedYtRDc
 1hUHivb/lPa2etdzetxEMVFm6nFoHGB4nquQczN9G8JgIvCmU+LBd49aLZMlidJwnDZ7 hQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk3bda8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:06:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CL6puG023066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:06:51 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 14:06:51 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 0/4] Add Support for Qualcomm SPMI GPIOs
Date:   Mon, 12 Sep 2022 14:06:21 -0700
Message-ID: <20220912210624.4527-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B4MBDsdCE1-_7LY-KaY94hZT_dLf7H-L
X-Proofpoint-GUID: B4MBDsdCE1-_7LY-KaY94hZT_dLf7H-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=777 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides support and fixes for Qualcomm SPMI GPIOs.

Changes since v1:
   - Updated 2/4 so that changes only take place in driver
   - Updated 4/4 to add in allOf: constraints

Anjelique Melendez (2):
  pinctrl: qcom: spmi-gpio: Fix the GPIO strength mapping
  dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450 bindings

David Collins (1):
  pinctrl: qcom: spmi-gpio: add support for LV_VIN2 and MV_VIN3 subtypes

Jishnu Prakash (1):
  pinctrl: qcom: spmi-gpio: Add compatible for PM7250B

 .../bindings/pinctrl/qcom,pmic-gpio.yaml      |  4 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      | 41 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.35.1


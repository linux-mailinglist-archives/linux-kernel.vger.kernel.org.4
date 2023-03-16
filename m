Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1FF6BD8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCPTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCPTWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:22:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B40C9E333;
        Thu, 16 Mar 2023 12:22:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GBglHB015969;
        Thu, 16 Mar 2023 19:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=TGMGaP1AV6OuyURUeypOIgu/eGAUNg19K5lBm5AWlO0=;
 b=lPvjeVLM2Et0nsEzBJfeUS/ThHeFjCOGTiEBB+pSD5EN8d8K7MgI95PzMvLay32tTxom
 UPwaFLxvJMoAS04AbCDWzg6uAxU35PyiE2SHGAv4OfxIStUKWeL6rbM8ExV6xNXss+H5
 lypuGjH7uBwyj6dn5e8NW3+6FDJcnzJBR2oo+6NvmEpNa2rZkZ+Ene45ypkI1+drVKTT
 14Wd8JDZGu55bZ/s2FV60ipkoat00KdNIANDKyjjGtuMsdq3lpvE3JLS9NYheLazyCOs
 y38R+iwhmLb1UStGzaKq2NGEmjgtfL1kLz6rJzvuyueHU5GRSFnhdRS9nXq8bl9Wpuab wA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxju00v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 19:22:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GJM30I022380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 19:22:03 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 12:22:02 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_c_skakit@quicinc.com>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 0/3] Add support for high resolution PWMs
Date:   Thu, 16 Mar 2023 12:21:31 -0700
Message-ID: <20230316192134.26436-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0H7qFtWLHtkhUseCh3ldbhntBtLPfpPN
X-Proofpoint-ORIG-GUID: 0H7qFtWLHtkhUseCh3ldbhntBtLPfpPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=589 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain PMICs have a high reolution PWM module which can support from 8-bit
to 15-bit PWM. This change series adds support for those PMICs. Thanks!

Anjelique Melendez (3):
  dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm compatible string
  leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
  leds: rgb: leds-qcom-lpg: Add support for PMK8550 PWM

 .../bindings/leds/leds-qcom-lpg.yaml          |   1 +
 drivers/leds/rgb/leds-qcom-lpg.c              | 151 +++++++++++++-----
 2 files changed, 110 insertions(+), 42 deletions(-)

-- 
2.39.0


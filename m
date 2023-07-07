Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24374AA58
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjGGFUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:20:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5351171D;
        Thu,  6 Jul 2023 22:20:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3673V1H1002161;
        Fri, 7 Jul 2023 05:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Uk9qVLF1JBzwJ+a7KyImaFRK1wdkQWj32AIwwKSnDCA=;
 b=OYCARzJz7+8aV+N28d3N4g9mtqgmo+Czk1lqWmy9vejj2SUClQGE3a7V8DngbITtT8Vo
 44h9eXNzGxip63jg5UCf1/t7GikS9uolErTaT69S0AWD8H0v3MMZOdbOqIbbLVMKcm4V
 ddgwP72GWuf28U6HgsSCsKJReOTQM6pGKITZNuS09rGgBSJE3+oL0X0nFDGGaainwGkc
 HJdOm3EYMQXN3HXymUj5pL95Caa+yPJbNQgEoxwKFLB+GEGUkTYJVIoq9U4Yv8nhVOA2
 Bv75WgurNmxftQj89G29KsXij2tl2qPbAOPH4ZiQSfLD9ba2QCDkTmRC+62/O/UjsnJe gg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnb5a3wck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 05:20:19 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3675KG9s029553;
        Fri, 7 Jul 2023 05:20:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kp6yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 05:20:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3675KF5v029547;
        Fri, 7 Jul 2023 05:20:15 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3675KFtS029546;
        Fri, 07 Jul 2023 05:20:15 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 138574EF7; Fri,  7 Jul 2023 10:50:15 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/4] Add pinctrl support for SDX75 PMICs
Date:   Fri,  7 Jul 2023 10:50:05 +0530
Message-Id: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -NwC9BIXU-lYHgKG_fpCYN8R4TAxpMAj
X-Proofpoint-ORIG-GUID: -NwC9BIXU-lYHgKG_fpCYN8R4TAxpMAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=822
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070048
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
 - Corrected the versioing in this version of patch series.
 - Keeping the Reviewed tag as there is no change in the patch.
 - Updated the patch series subject.

Changes in v2:
 - Link to v2 series [1] (Added because of versioning mismatch).
 - Breaking the original series [2] into smaller series.
 - Collected reviewed tag from Krzysztof.

[1] https://lore.kernel.org/all/1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com/
[2] https://lore.kernel.org/all/1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (4):
  dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
  dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
  pinctrl: qcom-pmic-gpio: Add support for pm7550ba
  pinctrl: qcom-pmic-gpio: Add support for pmx75

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 6 ++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                      | 2 ++
 2 files changed, 8 insertions(+)

-- 
2.7.4


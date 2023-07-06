Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9472749DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGFNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGFNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:30:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136501BFC;
        Thu,  6 Jul 2023 06:30:38 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Bk5HN022342;
        Thu, 6 Jul 2023 13:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=DXJ7iCPmN8B01ER7gogfn1DNv1Gl9miavFIuJe9pjHI=;
 b=TOr5YOF/YpHoRJktCwqbiz2jxPG28AKHrV3bZEJRjt6DmoAWFR3JY1v5BP5+fDvfdmoR
 HTc+ae4UrRgnr7Loklaeir0oDHahKLDxuc/77P2G5pW4aC2p4xkFWiPhmDYvwg7rkSg8
 fdTh3qnESAq8Rlk50xWVwjuPdeOdFc39o1pja3JEQAWCjD21K/tRkd+CAxu/zN7AUvPD
 TW0FME1P06DIHikhJru/Ss33+UfW19fBijO/ptzTjRocw/t2SZsLHSk6PMI5PK6MNl2T
 7aSI+VAIa2zE2DvYrxDepEBMrzcH9P/YM9StNCDw6xcE/YfgDAlmakGv0xntdFvLEJRS vQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5mfu5fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 13:30:21 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 366DUHvP011565;
        Thu, 6 Jul 2023 13:30:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kkq3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 13:30:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 366DUHOm011550;
        Thu, 6 Jul 2023 13:30:17 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 366DUHNo011548;
        Thu, 06 Jul 2023 13:30:17 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 9794D4E6C; Thu,  6 Jul 2023 19:00:16 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/4] Add support for pinctrl in pmic chips. 
Date:   Thu,  6 Jul 2023 19:00:05 +0530
Message-Id: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vFDQ6vG58U4Miq8Yw6VvhS71ofIPC5ZV
X-Proofpoint-ORIG-GUID: vFDQ6vG58U4Miq8Yw6VvhS71ofIPC5ZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=513 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060120
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds GPIO support for PM7550ba and PMX75 pmic.

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


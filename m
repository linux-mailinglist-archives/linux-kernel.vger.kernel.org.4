Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A274E893
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGKIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGKIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:00:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6E3AF;
        Tue, 11 Jul 2023 01:00:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6TqpC000364;
        Tue, 11 Jul 2023 08:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=6ZMtSrvijaC8ncQkhniQv7HOU7McCC2SYfET5rXnIGM=;
 b=pzB9zWf3HGLIC/pieUvcoeHN65knT+8dwpB+Y2cx2yC/CHrPAZdBJKnmaFCFM2bhCKMH
 gqhuKl/RDP4/p6Bvj/gncdyt996QobKFaTfu7bFSrOilwaJaXi2PNYlEX9wj13Ylrmnf
 RTEb8NTUl2MuBClm7+9fVK+0BKGqiZC90n7khxxiXKWDINmfdwL4e33R39g5s6lA+W7r
 M+k5V9Jt/YEjV7SGw0wZVWqKgeQqrQCDWAbatpoK8rp2engkk1UwR5VBDMmWlKbywoRo
 AY8mG3jIR62OWyJ7JXLFQqfjbcEJkyfJ6OvioaoSJ1c4uVef9fabx+i99l55PFcfSHmu VA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0vqr8g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:00:26 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B80Ncn006354;
        Tue, 11 Jul 2023 08:00:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2xkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 08:00:22 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B80MvN006338;
        Tue, 11 Jul 2023 08:00:22 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B80MpU006334;
        Tue, 11 Jul 2023 08:00:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 811095033; Tue, 11 Jul 2023 13:30:21 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/3] Add regulators support for PMX75
Date:   Tue, 11 Jul 2023 13:30:11 +0530
Message-Id: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oeK1vbbqdyE7FaBpKjXnHbsYDroCkG1M
X-Proofpoint-ORIG-GUID: oeK1vbbqdyE7FaBpKjXnHbsYDroCkG1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=836 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110070
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
 - Created a separate patch for updating the entry in pmx65 bindings.
 - Changed the subject of patches [1/3] and [2/3] according to the convention.

Changes in v2:
 - Addressed Krzysztof to update the if:then: in bindings patch.
 - Breaking the original series [1] into smaller series.

This series adds regulators supports in PMX75 found on
SDX75 platform.

[1] https://lore.kernel.org/all/1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (3):
  regulator: dt-bindings: qcom,rpmh: Update PMX65 entry
  regulator: dt-bindings: qcom,rpmh: Add PMX75 compatible
  regulator: qcom-rpmh: Add regulators support for PMX75

 .../bindings/regulator/qcom,rpmh-regulator.yaml    | 22 ++++++++++++-
 drivers/regulator/qcom-rpmh-regulator.c            | 38 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

-- 
2.7.4


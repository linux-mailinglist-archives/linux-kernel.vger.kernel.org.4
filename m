Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CC74E67A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGKFrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGKFrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:47:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6656C1A4;
        Mon, 10 Jul 2023 22:47:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B5kwhN025506;
        Tue, 11 Jul 2023 05:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=i2xzS9asfvF/XqZGfAdvIsj1rRf15yFiAhquZN/NWQs=;
 b=YDgf8o/WnsqZ5dtkKkE5cCmhGNLkUlq9dGW08vEtrrZUlKOQxO9JfW+z2oRcX9OjX1Cb
 Wl1DQurUzGFhD4eCymOXgGuIMXZYxNLSz5Z5Qp/ZoYR7luk0VBfKAEsg4LgRqa4nwvk7
 6MiXeSSOvFEIypbYQi/eVx2rlkkUDf3UX3izVNvV9XDXWB2DTl0PSjNXlju3AZHuKGBQ
 XhUtUdD7HN/bcWQvGcix1kyRuF39vcqrrirwvqAnEwXGJHoL9vsi5QdWx8Uf7p34LowZ
 N7XjN/8dFoHJM6ET5h44yWGlgCIqDFxBqa29l5hfnou0ny4Q9p6rGFzguehiNGFP7nWu mQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs17rr01c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:47:09 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B5l5fM008319;
        Tue, 11 Jul 2023 05:47:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2hgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 05:47:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B5l4pu008313;
        Tue, 11 Jul 2023 05:47:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B5l4oL008312;
        Tue, 11 Jul 2023 05:47:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id ED85C5033; Tue, 11 Jul 2023 11:17:03 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/2] Add regulators support for PMX75
Date:   Tue, 11 Jul 2023 11:16:53 +0530
Message-Id: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FtudUR5C6QgY5L7h5wvBpkkZ_iFehQZe
X-Proofpoint-ORIG-GUID: FtudUR5C6QgY5L7h5wvBpkkZ_iFehQZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=801 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110050
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2:
 - Addressed Krzysztof to update the if:then: in bindings patch.
 - Breaking the original series [1] into smaller series.

This series adds regulators supports in PMX75 found on
SDX75 platform.

[1] https://lore.kernel.org/all/1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: regulator: Add PMX75 compatible
  regulator: qcom-rpmh: Add regulators for PMX75

 .../bindings/regulator/qcom,rpmh-regulator.yaml    | 22 ++++++++++++-
 drivers/regulator/qcom-rpmh-regulator.c            | 38 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

-- 
2.7.4


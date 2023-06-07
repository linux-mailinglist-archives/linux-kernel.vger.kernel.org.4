Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70C07258C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjFGIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbjFGIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:55:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363AF2111;
        Wed,  7 Jun 2023 01:54:19 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3578dDVk012891;
        Wed, 7 Jun 2023 08:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=goMxTImT6rE+E+h/Km3Yj4js6nWKl/eiPEeoaq5yC8A=;
 b=AxTMkKVKKDF6LHIjggjrIF2Emb+be5IufT1k4mCvh755mAA+p7qXbUhFA24e7XkqFYMf
 OAQoDlfCuK+dxWhtNHI6gmHZJ3rj+Ptu8f+uz9DQlD2ZRp6MuXgTHn2mfvCcRHdRkXJv
 eZLhs2w5e8X7EpE4VTAGhE8lVfpYlqSaIVILBOyPYfwICizDZluAKXTHZihB9vCp4SK9
 796Kk0BghXD7vkRXqGt/gqO8+PKLFwFeVWusLoy2Iuwvy2WELxAmxpgOrUF6JK4aG2gB
 LlL+Mu6WSg9qvyaQQe/ZaFEoNjMRNlYPOqgkmSnagyPg7WnmeJeLySxf2g/0YojpsJrD 3g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a6y9d2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 08:53:25 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3578rOLv015539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 08:53:24 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 01:53:18 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v6 0/3] Enable IPQ9574 TSENS support
Date:   Wed, 7 Jun 2023 14:23:07 +0530
Message-ID: <cover.1686125196.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 66E8xlCTmn7NBS-NCJa-GsrZrpcdUTw4
X-Proofpoint-ORIG-GUID: 66E8xlCTmn7NBS-NCJa-GsrZrpcdUTw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=791 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set enables tsens in IPQ9574

Depends on
	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
[v6]:
	Remove comments from tsens node in dtsi
[v5]:
	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors without removing existing entries

[v4]:
	Drop the sm6375-tsens and qcm2290-tsens related bindings
	fix as it is already posted

	Remove unnecessary changes from previous version

[v3]:
	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors

[v2]:
	Drop the driver change (https://lore.kernel.org/lkml/b45d33d38a334aabbd52c83b0d6028af1f4c74c8.1682682753.git.quic_varada@quicinc.com/)
	since the tsens device is compatible with 8074's tsens
	and use 8074's compatible itself

	Rename clusterX nodes as cpussX

[v1]:
	Fix DT node names

[v0]:
	Initial patch introducing TSENS support

Praveenkumar I (1):
  dt-bindings: thermal: tsens: Add ipq9574 compatible

Varadarajan Narayanan (2):
  arm64: dts: qcom: ipq9574: add tsens node
  arm64: dts: qcom: ipq9574: add thermal zone nodes

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   6 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 218 +++++++++++++++++++++
 2 files changed, 224 insertions(+)

-- 
2.7.4


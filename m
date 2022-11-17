Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F184562E8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiKQWuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbiKQWuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:50:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E4767A;
        Thu, 17 Nov 2022 14:50:04 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHMat7d017777;
        Thu, 17 Nov 2022 22:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=pzSbmaUvI4S0IoNIETI2m39wqhl+bHLvWMXpFTSKcBI=;
 b=EgcgyUrUkw+0/ucmwCyVpv8rvks2zKheUsplgww4HN2W8nJMrWdtuE1CExc5/jSm9O/W
 xD/t2XMaHzJB98t6uNfWDbE+LQcI6Hr9bF3JjDPGjv3JMkkEUua1oCvjA459DH9lIR3v
 VxnlGUR6B+vwQz+cT9RjxfHKDIGd97VuxV7dwh6aJcHCwfT4dDa9j3KC9k+7L0TC4o86
 8psl+Wr/S08Q6eQ/rlGUo5hbJtcdegcF0s5cxoIJyaaFqTzGFlpX7jdjD2uReaOdsYwe
 PQPQalPCDx0Lt0asolBBjY983saztMuHoeNRHcpv9R7Mto7rBCe3zXnUbglybc8C6rbE Eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwwvj8147-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:49:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHMnodA015219
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:49:50 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 17 Nov 2022 14:49:50 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add data-lanes and link-frequencies to dp_out endpoint
Date:   Thu, 17 Nov 2022 14:49:27 -0800
Message-ID: <1668725369-6331-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J8xI3fRw7q8wM4_GRE-BwwhZKPF4GMYz
X-Proofpoint-GUID: J8xI3fRw7q8wM4_GRE-BwwhZKPF4GMYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=796 clxscore=1015
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
functions to DP driver.

Kuogee Hsieh (2):
  arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
    endpoint
  drm/msm/dp: add support of max dp link rate

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   |  9 +++++++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi           |  5 -----
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 10 ++++++++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi           |  6 +-----
 drivers/gpu/drm/msm/dp/dp_display.c            |  4 ++++
 drivers/gpu/drm/msm/dp/dp_panel.c              |  7 +++---
 drivers/gpu/drm/msm/dp/dp_panel.h              |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c             | 30 +++++++++++++++++++-------
 drivers/gpu/drm/msm/dp/dp_parser.h             |  2 ++
 9 files changed, 51 insertions(+), 23 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


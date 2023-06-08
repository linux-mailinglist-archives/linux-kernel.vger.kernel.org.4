Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999F1727AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjFHI4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFHI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:56:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE71272E;
        Thu,  8 Jun 2023 01:56:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3587h1M0023948;
        Thu, 8 Jun 2023 08:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bn9KhC8FKFvue6z73xOS+tpNfMXdjDhem7nRo2uOZ5k=;
 b=Tvs7y1Kyj5lcja3tCBS1XH/ICPrAjanwDOJHEyoVQfYTCMV5jj5Fr5yCH5eh+tlNmxLF
 dpIac4HU7Q6NZKnLkT6xWUwdTMr7GblSjXCdec99sYapipPvWOMJ4rPEVIpC1IQNG5+1
 wnAKheSEMsL+HeHT0+bxQgsi9K/lipdVt7PzAG1wmSMsk/sZJN33mLab78ihGpdq6mvH
 lXcS7hrAGpgCSvsr4EV1r7JuQ3O4WxAE9qeLjlcnbeManRhrw1gcvHCJf5QVCpFGXxd2
 MH2zYynEJRXY1OartHkSZW8FRDCkq52ib2h5T8I4eukUSXCPGplf+mc1OvdQi+E41jgR 5Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r39ku89kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 08:56:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3588uIYR026503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 08:56:18 GMT
Received: from hu-tnimkar-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 01:56:15 -0700
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>, Tushar Nimkar <quic_tnimkar@quicinc.com>
Subject: [PATCH 2/2] cpuidle: dt: Add support to keep idle state disabled
Date:   Thu, 8 Jun 2023 14:25:44 +0530
Message-ID: <20230608085544.16211-4-quic_tnimkar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9C8DWiqLhxnEVGl0Q8LGS2q6QT_vF4e5
X-Proofpoint-ORIG-GUID: 9C8DWiqLhxnEVGl0Q8LGS2q6QT_vF4e5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_05,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=895 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the idle state as disabled using CPUIDLE_FLAG_OFF when
idle-state-disabled property is present.

Such idle states stays disabled and can be enabled using below command.

echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable

Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
---
 drivers/cpuidle/dt_idle_states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 12fec92a85fd..3d50181512a3 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -79,6 +79,9 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	idle_state->flags = CPUIDLE_FLAG_RCU_IDLE;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+	if (of_property_read_bool(state_node, "idle-state-disabled"))
+		idle_state->flags |= CPUIDLE_FLAG_OFF;
 	/*
 	 * TODO:
 	 *	replace with kstrdup and pointer assignment when name
-- 
2.17.1


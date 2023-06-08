Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C7727A98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjFHI4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjFHI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:56:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B479E;
        Thu,  8 Jun 2023 01:56:08 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35871LUw012648;
        Thu, 8 Jun 2023 08:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EamPgHssDf9HEfUsU8S3cRk7WTB3uyBndmz/eSNwkd8=;
 b=Ac5xJyr+jwFyT3/TI5ArrLTYs9VOV3+AErHfcpnBKYmT4lA+mbjx8p0gfDrga/skNr2K
 +cC6Af8PGPU+9cmkMxMP08cDwUHG7yhiUHZyl650OF3uy/Iw6hAzsYjuxNE3QQPkizk9
 2ERBX0RImwkFoySx7rsHvq0XvHMOV+QRTWRXwEpgqi2aa8osWxhs7w8NIHH/I+O+nFxM
 SiZq+TGKT5pJ+K6RpdauoXT6Nl0gCkPS+cOfWR9iUAqkT7YyZ4VGBXnCV9l95ZPPGziA
 GcQgbS0S/BUHJDOlW8x2JOJ4L8yxq/xwhWNFcnk6QBu6gNtjY4pZ1c+MGYn5X/Kz2BbH UQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2rbtjbuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 08:56:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3588u29R030290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 08:56:02 GMT
Received: from hu-tnimkar-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 01:55:59 -0700
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>, Tushar Nimkar <quic_tnimkar@quicinc.com>
Subject: [PATCH 0/2] Add provision to keep idle state disabled
Date:   Thu, 8 Jun 2023 14:25:41 +0530
Message-ID: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rmwnFDlLF6DaDud_m63PrVqdPeo6blC2
X-Proofpoint-ORIG-GUID: rmwnFDlLF6DaDud_m63PrVqdPeo6blC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_05,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=605 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUidle already has CPUIDLE_FLAG_OFF to keep idle state disabled,
Lets extend the support to set this flag using device tree.

This allows to keep an idle state disabled and they can be enabled back using
sysfs after certain point using below command.

echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable 

This helps in cases where vendors want to keep cpuidle off until home
screen comes up. In the past attempt was done at [1] but it was not considered
safe option to export cpu_idle_poll_ctrl().

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com/

Thanks,
Tushar Nimkar.

Tushar Nimkar (2):
  dt-bindings: cpu: idle-states: Add idle-state-disabled property
  cpuidle: dt: Add support to keep idle state disabled

 Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
 drivers/cpuidle/dt_idle_states.c                       | 3 +++
 2 files changed, 11 insertions(+)

-- 
2.17.1


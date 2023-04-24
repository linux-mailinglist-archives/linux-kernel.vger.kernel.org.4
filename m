Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5426ECB06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjDXLKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjDXLKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:10:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8B210A;
        Mon, 24 Apr 2023 04:09:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OB02sh004295;
        Mon, 24 Apr 2023 11:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zmahdaoM6k87NjKwbmk+k24D6UKRC47KOG/fmcMM4zM=;
 b=JzmjITIFmi2wP01nr/Jyl/iqNyE61pQ0gn9GqanjEZLF6K6I4IBSMXUeNnyUwcuqZXJ1
 yxpwx3fE1ma9nAnOxcVg3OvpEf+8bvzwDdaPepVD9kjZXFSKd0aZcLN9do3EObI2OD75
 p5IRrezfTcq2R7zp+RWebDGrb2omwo5GBNyjhy0t/qGXb6FTYxzz3ytrwcyx90NIHu5n
 33GxuO6HXBY1/v77vu7/gyjvBTZ/etyUHHi7gS7GJ5+dRFm0v3HiepjO2dQxM+mdJO9u
 uMx9EJJTFyKibPkRMY9MgARCClwvZ+fPSq4I7xCgtSZUk4IkYjUPgaZAlYOVAAvv6XHA dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q488s37qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:09:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33OB9n00008569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:09:49 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 04:09:44 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v4 0/3] Use PSCI OS initiated mode for sc7280
Date:   Mon, 24 Apr 2023 16:39:30 +0530
Message-ID: <20230424110933.3908-1-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cK1BtPNso0r_iCphJb4xyOJ7Ha0Ic5F8
X-Proofpoint-GUID: cK1BtPNso0r_iCphJb4xyOJ7Ha0Ic5F8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=738 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
- Add missing s-o-b line and reviewed by in patch 1
- Address ulf's comments for error handling in patch 2

Changes in v3:
- Add new change to provide helper function dt_idle_pd_remove_topology()
- Address ulf's comments for error handling
- Add reviewed by ulf for devicetree change

Changes in v2:
- Add new change to Move enabling OSI mode after power domains creation
- Fix compatible string to domains-idle-states for cluster idle state.
- Update cover letter with some more details on OSI and PC mode
  comparision

The dependency [2] is now merged in trustedfirmware project.

Stats comparision between OSI and PC mode are captured at [3] with
usecase
details, where during multiple CPUs online the residency in cluster idle
state is better with OSI and also inline with single CPU mode. In PC
mode
with multiple CPUs cluster idle state residency is dropping compare to
single CPU mode.

Recording of this meeting is also available at [4].

This change adds power-domains for cpuidle states to use PSCI OS
initiated mode for sc7280.

This change depends on external project changes [1] & [2] which are
under review/discussion to add PSCI os-initiated support in Arm Trusted
Firmware.

I can update here once the dependency are in and change is ready to
merge.

[1] https://review.trustedfirmware.org/q/topic:psci-osi
[2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
[3] https://www.trustedfirmware.org/docs/PSCI-OS-initiated.pdf
[4] https://www.trustedfirmware.org/meetings/tf-a-technical-forum

Maulik Shah (3):
  cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
  cpuidle: psci: Move enabling OSI mode after power domains creation
  arm64: dts: qcom: sc7280: Add power-domains for cpuidle states

 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 98 ++++++++++++++++++++-------
 drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++-------
 drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++
 drivers/cpuidle/dt_idle_genpd.h       |  7 ++
 4 files changed, 117 insertions(+), 51 deletions(-)

-- 
2.17.1


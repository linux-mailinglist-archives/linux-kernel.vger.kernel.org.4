Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C56697742
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBOHRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjBOHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:17:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1892B617;
        Tue, 14 Feb 2023 23:17:10 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F3M89I025352;
        Wed, 15 Feb 2023 07:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=A41b8vi8uVHE21BZpcTKIRqcXmIuZW89KzYNu8RsW5I=;
 b=Z98VXGJcQTMni1P2TC19uUfxPuy987L4DaGCEPjEfX3/tMYG/HgXdM/lIrPrpW0p5+1J
 qtn9SajocVOeoQHryVAMJlE/JLTkN8EZiBVqz66hdJ+Np6iLTVGeJhkWN/OVUpejdF1C
 evQdowVQK0veCneO/z8DBdcv1mE9IHXLRVTscU5tcEZ/SXWYUKPU8WIbNNPDUTNxL4wD
 OafGyU0cU/nSO/RXZT0cNaY6z+Ih0VoX+HAbhzqJbS5NhZqM3KXxcVGIHOZHCPmG+SUa
 cu+Ie3HZLNSKK7o8KGwV6iC7pBeKC5gkonVmCUOU9GXEQRquimLlEkeVt0+jmwLss3Ap WA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0ckss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 07:17:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F7H1mB031881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 07:17:02 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 23:16:58 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_lsrao@quicinc.com>, <quic_rjendra@quicinc.com>,
        Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 0/1] Use PSCI OS initiated mode for sc7280
Date:   Wed, 15 Feb 2023 12:46:48 +0530
Message-ID: <20230215071649.9078-1-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZIR5IFfZXL-ZJQxwHmY4xvcMpJyfTqkk
X-Proofpoint-ORIG-GUID: ZIR5IFfZXL-ZJQxwHmY4xvcMpJyfTqkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_03,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=542 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds power-domains for cpuidle states to use PSCI OS
initiated mode for sc7280.

This change depends on external project changes [1] & [2] which are under
review/discussion to add PSCI os-initiated support in Arm Trusted Firmware.

I can update here once the dependency are in and change is ready to merge.

[1] https://review.trustedfirmware.org/q/topic:psci-osi
[2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487

Maulik Shah (1):
  arm64: dts: qcom: sc7280: Add power-domains for cpuidle states

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 96 +++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 24 deletions(-)

-- 
2.17.1


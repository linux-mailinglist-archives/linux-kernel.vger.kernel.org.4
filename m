Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE97654607
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLVSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:36:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391B1C932;
        Thu, 22 Dec 2022 10:36:20 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMGakWL027508;
        Thu, 22 Dec 2022 18:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=angBxj1ZZnrquUXUXON4yYp5Mv8a17Ux/EMs/hfOYP8=;
 b=NwBnqb/4TCJHgc5npH+m/V6AdPGSoff226kBxBX61SxN6xv8h9VLVfZVe4iQ2oHHO7Am
 33vPsWcBMvcbayB+goPfDwVWMPoi4o2rMVwFZC0Ayz4GUXlbvT8vEcZ41f0/TiyJjTvA
 R+7DqpfZxschwGtXSPSVXH+lzkVppeEhRKONjzDMesIiF31Fi4v0o4NqjXl850X/NyUj
 6IbyMv6rhjo0GnLws1sd/IlvIszx9YxxkqIU3ayhQI4Sx1CkZoyTMwvICbJmBunElKaT
 Lpltlrea1DdHm2cWBxMkDRhxn3PYQSxJYrxHDZpznmH4KMWRYcmROvnseZbh6yDQQJxd Bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mmn3n93s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 18:35:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMIZvuk024567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 18:35:57 GMT
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 10:35:54 -0800
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, Yogesh Lal <quic_ylal@quicinc.com>
Subject: [PATCH] irqchip: gic-v3: Handle failure case of CPU enters low power state
Date:   Fri, 23 Dec 2022 00:05:40 +0530
Message-ID: <1671734140-15935-1-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OoDu_oxLBu-VO7PMoJe_vOmadZobEiFZ
X-Proofpoint-ORIG-GUID: OoDu_oxLBu-VO7PMoJe_vOmadZobEiFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_10,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=640
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220158
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU enter in low power mode it disable the redistributor and
Group1 interrupts. And re-initialise the system registers on wakeup.

But in case of failure to enter low power mode need to enable
the redistributor and Group1 interrupts.

Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d..4904f00 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1376,7 +1376,7 @@ static int gic_retrigger(struct irq_data *data)
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_init();
-- 
2.7.4


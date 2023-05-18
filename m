Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82239707E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjERKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjERKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:34:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B924F0;
        Thu, 18 May 2023 03:34:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IARYb4028857;
        Thu, 18 May 2023 10:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=iYXEmN22HFIjbTUbP/SZ6j1jySC3oY3gTEzP7pqB/3M=;
 b=pCVNne/kk+Q2BvdR+ewDlxbafyZSnhOljIlZr9lBtVB3VVfPdWmAWFPVXQE66kxQ0BDf
 TsC9DajWlYHUUhBNzu3RHh3MrynFy/Pio0DBjATn3Z3XOUl6Ml3lAN7cJib+f6cvriU9
 tV/C102/qlNQGSZZPGAMBPD0Phi9kLKU4F5eJD0Jm388vCYgsk5kAQMwfrBJSDBTui1P
 owbWU89vj/sLFwTVN/ljWjca51HIXixt9Sfh47IienzyIF1zbX93mXU+Z6VutOx2r6RA
 II8OxbhAipmSiGdG8csorAxuiOEID0iIJSClqsNtFGRl2uzPJCcyhJYMfHPmRznDV2Xe AA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn3fshp7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:33:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IAXc7N013158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:33:52 GMT
Received: from hu-pbaronia-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 03:33:37 -0700
From:   Prathu Baronia <quic_pbaronia@quicinc.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Prathu Baronia <quic_pbaronia@quicinc.com>
Subject: [PATCH] arm: omap1: replace printk() with pr_err macro
Date:   Thu, 18 May 2023 16:03:24 +0530
Message-ID: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tR_Txb035mb03VXmVoWJtSjy54hQ1HCj
X-Proofpoint-GUID: tR_Txb035mb03VXmVoWJtSjy54hQ1HCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 mlxlogscore=944 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_err() macro instead of printk(KERN_ERR "...").

Signed-off-by: Prathu Baronia <quic_pbaronia@quicinc.com>
---
 arch/arm/mach-omap1/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 9761d8404949..6a5815aa05e6 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -632,7 +632,7 @@ static int __init omap_pm_init(void)
 
 	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
 	if (error)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		pr_err("sysfs_create_file failed: %d\n", error);
 
 	if (cpu_is_omap16xx()) {
 		/* configure LOW_PWR pin */
-- 
2.25.1


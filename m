Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213016ECB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjDXLKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjDXLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:10:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93335B8;
        Mon, 24 Apr 2023 04:10:07 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O9rgRh031496;
        Mon, 24 Apr 2023 11:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=W4sivDyQiR1sJqLrzFkVJUpy4fz///ShfG3gX+MxuJY=;
 b=XUmGtqyks3ZeXi5Pudd4eEEVJIWb1UQJhGNwTNI290cYpuwh2gCbCQ1ltx4TepfWDLvy
 JUq6CpXXdtSpVDlycAEZtdK2bxjIkM9y27pgRIgrlFULPuJUbQdtUJU1dRDKh1F47v0x
 l81a2ugIDr9wOWq0XPATz6s6MAiRuyvRRICgWovtbT3jbuI9hbAZvmLtdz77II4dF1jA
 SNOTCJhQGrKXytsIRY0i6NujcKn84TGXULUiDzMfmZYYHq5FmaQUSlfhFvz8NkcrmadZ
 fDyDZ1AAyeegmgTOeeypnsbJDreoy2I+yqyFXYk3zoy28x+pvc7QefBE3aGt4Nu0XRl2 ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48s234gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:09:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33OB9wXZ008975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:09:58 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 04:09:53 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v4 2/3] cpuidle: psci: Move enabling OSI mode after power domains creation
Date:   Mon, 24 Apr 2023 16:39:32 +0530
Message-ID: <20230424110933.3908-3-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424110933.3908-1-quic_mkshah@quicinc.com>
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W3mJSV8radRcwkV1g_EhARcov3msQ4ox
X-Proofpoint-GUID: W3mJSV8radRcwkV1g_EhARcov3msQ4ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A switch from OSI to PC mode is only possible if all CPUs other than the
calling one are OFF, either through a call to CPU_OFF or not yet booted.

Currently OSI mode is enabled before power domains are created. In cases
where CPUidle states are not using hierarchical CPU topology the bail out
path tries to switch back to PC mode which gets denied by firmware since
other CPUs are online at this point and creates inconsistent state as
firmware is in OSI mode and Linux in PC mode.

This change moves enabling OSI mode after power domains are created,
this would makes sure that hierarchical CPU topology is used before
switching firmware to OSI mode.

Fixes: 70c179b49870 ("cpuidle: psci: Allow PM domain to be initialized even if no OSI mode")
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 39 +++++++++------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c2d6d9c3c930..b88af1262f1a 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -120,20 +120,6 @@ static void psci_pd_remove(void)
 	}
 }
 
-static bool psci_pd_try_set_osi_mode(void)
-{
-	int ret;
-
-	if (!psci_has_osi_support())
-		return false;
-
-	ret = psci_set_osi_mode(true);
-	if (ret)
-		return false;
-
-	return true;
-}
-
 static void psci_cpuidle_domain_sync_state(struct device *dev)
 {
 	/*
@@ -152,15 +138,12 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *node;
-	bool use_osi;
+	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;
 
 	if (!np)
 		return -ENODEV;
 
-	/* If OSI mode is supported, let's try to enable it. */
-	use_osi = psci_pd_try_set_osi_mode();
-
 	/*
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
@@ -170,33 +153,37 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 			continue;
 
 		ret = psci_pd_init(node, use_osi);
-		if (ret)
-			goto put_node;
+		if (ret) {
+			of_node_put(node);
+			goto exit;
+		}
 
 		pd_count++;
 	}
 
 	/* Bail out if not using the hierarchical CPU topology. */
 	if (!pd_count)
-		goto no_pd;
+		return 0;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
 	ret = dt_idle_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
+	/* let's try to enable OSI. */
+	ret = psci_set_osi_mode(use_osi);
+	if (ret)
+		goto remove_pd;
+
 	pr_info("Initialized CPU PM domain topology using %s mode\n",
 		use_osi ? "OSI" : "PC");
 	return 0;
 
-put_node:
-	of_node_put(node);
 remove_pd:
+	dt_idle_pd_remove_topology(np);
 	psci_pd_remove();
+exit:
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-no_pd:
-	if (use_osi)
-		psci_set_osi_mode(false);
 	return ret;
 }
 
-- 
2.17.1


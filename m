Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4CC6E1C04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDNFzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDNFzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:55:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0F2729;
        Thu, 13 Apr 2023 22:55:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E5jUZM025696;
        Fri, 14 Apr 2023 05:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=El0JRGq5oStlkWJM2eLlBLWxV2Y/6wTqIU6apgkiKyM=;
 b=a7XUgMyqb3vIlryiTbhFDJB9VmVVTQ+fYp8EKYbHqN5PVGMTSKbADBr30pUgscnpMuk3
 4+nCM46WcEG2nI301WrPNLj2QqU1g9fAj7Tj8AIG5B1L4bk6L7LWHjdVB7h1ZZU3GSLi
 8+PSgRWdzbSYYoP1TDsIoArOqkAYZ0dKihLIvjxJ4OJZgaKPiywU31Qpj2gH/46EjSdX
 XP4GEJeXSx/h7nokGAN6ueX0P+O0bJCWxJ6j0ogTLdsJIKpxwJamNmmhOniIIcBmQetp
 N68fg0r6WYTgu7y6CIuBQp78fsjRNKgfqJ0OMRLYlp/JnjzYplTCKXuvarhdcP4bgBPV uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py0xur0um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:55:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E5tQUZ027624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:55:26 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 22:55:22 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v3 2/3] cpuidle: psci: Move enabling OSI mode after power domains creation
Date:   Fri, 14 Apr 2023 11:25:01 +0530
Message-ID: <20230414055502.23920-3-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414055502.23920-1-quic_mkshah@quicinc.com>
References: <20230414055502.23920-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qNaEFIeYCdYHXGpcw32AzIGmeP9eDPkR
X-Proofpoint-ORIG-GUID: qNaEFIeYCdYHXGpcw32AzIGmeP9eDPkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/cpuidle/cpuidle-psci-domain.c | 37 +++++++++------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c2d6d9c3c930..c3993df24eef 100644
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
@@ -178,25 +161,29 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 
 	/* Bail out if not using the hierarchical CPU topology. */
 	if (!pd_count)
-		goto no_pd;
+		goto remove_pd;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
 	ret = dt_idle_pd_init_topology(np);
 	if (ret)
-		goto remove_pd;
+		goto remove_pd_topology;
+
+	/* let's try to enable OSI. */
+	ret = psci_set_osi_mode(use_osi);
+	if (ret)
+		goto remove_pd_topology;
 
 	pr_info("Initialized CPU PM domain topology using %s mode\n",
 		use_osi ? "OSI" : "PC");
 	return 0;
 
-put_node:
-	of_node_put(node);
+remove_pd_topology:
+	dt_idle_pd_remove_topology(np);
 remove_pd:
 	psci_pd_remove();
+put_node:
+	of_node_put(node);
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-no_pd:
-	if (use_osi)
-		psci_set_osi_mode(false);
 	return ret;
 }
 
-- 
2.17.1


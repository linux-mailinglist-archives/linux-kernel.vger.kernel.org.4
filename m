Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFC7457D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGCI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGCI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:56:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07482BB;
        Mon,  3 Jul 2023 01:56:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3637xgDY025449;
        Mon, 3 Jul 2023 08:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7Oo2oAjQnv/GNjcrX7nURUZpjTdTnuE7w2bkjBikW5c=;
 b=Gb5WTMU6lRQ9XWyCLPyVd/X7dZoOzMRP0Qblb9INHL1BFnkNfJ6PAiyK61YyXUx0omcG
 FnbXPSca3rgf4YMW3nDAImO597rWw5iUFHGTX1i9FkKCqB0CxeuOJ4derKvfoGOOdOUT
 dzuhN9BzvrrHGMw+sXXpTSRgc3BCn/ClBEWKDgtzQa5CY0WQrGbRTcNnXnxy+9QZnzUJ
 grb3G2EyndMyAA7lXWo9Ktet9yCK2F9KedmxYRY+gsaSdgO6IYrE7ES0L4WveZCeyiwA
 +EancB2gxkOOmffVP4Mid5jO5RgkWd9W9ViXonRbwwfqpAnjdXsKsbGn2SlF71hm94wc Hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjcwnkdnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 08:56:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3638uQ6I028277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 08:56:26 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Mon, 3 Jul 2023 01:56:20 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>, <daniel.lezcano@linaro.org>,
        <rafael@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [RESEND v4 1/3] cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
Date:   Mon, 3 Jul 2023 14:25:53 +0530
Message-ID: <20230703085555.30285-2-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703085555.30285-1-quic_mkshah@quicinc.com>
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nWtHKtSi05I9KbslUs5-raUSyS3ShzUd
X-Proofpoint-ORIG-GUID: nWtHKtSi05I9KbslUs5-raUSyS3ShzUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_07,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=877 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Genpd parent and child domain topology created using dt_idle_pd_init_topology()
needs to be removed during error cases.

Add new helper function dt_idle_pd_remove_topology() for same.

Cc: stable@vger.kernel.org
Reviewed-by: Ulf Hanssson <ulf.hansson@linaro.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/cpuidle/dt_idle_genpd.c | 24 ++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.h |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
index b37165514d4e..1af63c189039 100644
--- a/drivers/cpuidle/dt_idle_genpd.c
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -152,6 +152,30 @@ int dt_idle_pd_init_topology(struct device_node *np)
 	return 0;
 }
 
+int dt_idle_pd_remove_topology(struct device_node *np)
+{
+	struct device_node *node;
+	struct of_phandle_args child, parent;
+	int ret;
+
+	for_each_child_of_node(np, node) {
+		if (of_parse_phandle_with_args(node, "power-domains",
+					"#power-domain-cells", 0, &parent))
+			continue;
+
+		child.np = node;
+		child.args_count = 0;
+		ret = of_genpd_remove_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 struct device *dt_idle_attach_cpu(int cpu, const char *name)
 {
 	struct device *dev;
diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
index a95483d08a02..3be1f70f55b5 100644
--- a/drivers/cpuidle/dt_idle_genpd.h
+++ b/drivers/cpuidle/dt_idle_genpd.h
@@ -14,6 +14,8 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
 
 int dt_idle_pd_init_topology(struct device_node *np);
 
+int dt_idle_pd_remove_topology(struct device_node *np);
+
 struct device *dt_idle_attach_cpu(int cpu, const char *name);
 
 void dt_idle_detach_cpu(struct device *dev);
@@ -36,6 +38,11 @@ static inline int dt_idle_pd_init_topology(struct device_node *np)
 	return 0;
 }
 
+static inline int dt_idle_pd_remove_topology(struct device_node *np)
+{
+	return 0;
+}
+
 static inline struct device *dt_idle_attach_cpu(int cpu, const char *name)
 {
 	return NULL;
-- 
2.17.1


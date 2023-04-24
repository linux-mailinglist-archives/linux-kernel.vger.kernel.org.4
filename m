Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA46E1C05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNFzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDNFzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:55:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC824200;
        Thu, 13 Apr 2023 22:55:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E5iTD1022711;
        Fri, 14 Apr 2023 05:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4KipvpIFB6LE7NVD/y/qijx4OvlEB5MxdzpH4RWRsKQ=;
 b=Cl++4jxjx9nWYItzlK3Cbt9S5WvcNBBP0q74pSONZoNfJQbH1/SXPLSNDP9InY19BwJl
 fJ/rwRJ5pocT/lR6iAvpoBc59KSOB9JJLJSrhe0sUzAndwIc1fW62BXGqyEZhMuvb2dz
 qxmDxufp6LlmqByOm5DSuYnB4UK34yS6vVSx+HZ8FpPVwu8vJjwqnUCtEOEkEl4HhUxY
 YEvhSCGzCohbD69+5TyP3tudEqeWNVwrKiyD4yT44gDXvSgisx0RJiROjgivYAoY+Z7p
 79gdKh78O1b6VCAGrVTyLGdEspFnZSGSVjAKC//KP7H0YeBVrA3sz0rgzouTigSCvYia eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py0xur0uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:55:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E5tMsx016638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:55:22 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 22:55:17 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v3 1/3] cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
Date:   Fri, 14 Apr 2023 11:25:00 +0530
Message-ID: <20230414055502.23920-2-quic_mkshah@quicinc.com>
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
X-Proofpoint-GUID: o2h-kyLIuKkRoKZqCERxEY860UKxG3BU
X-Proofpoint-ORIG-GUID: o2h-kyLIuKkRoKZqCERxEY860UKxG3BU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=855 priorityscore=1501 bulkscore=0 malwarescore=0
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

Genpd parent and child domain topology created using dt_idle_pd_init_topology()
needs to be removed during error cases.

Add new helper function dt_idle_pd_remove_topology() for same.
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


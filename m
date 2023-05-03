Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F186F5C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjECRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjECRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:05:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04D72BE;
        Wed,  3 May 2023 10:04:24 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Dk6qk019750;
        Wed, 3 May 2023 17:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z7TBLVIWftvevykt00VdUy6/bEMw/yxMZI8QU+9rmjE=;
 b=beImjkKNCPeAuaa0P6wv5cHby9VSvE+6DVxcDw/ffD2LkSGM75ZJdhRwTxtVLVCrLIGg
 wiocef7eTyc8mLS52pwjXWfH9ecFOF3Ho4I3EzVnd++zlGSzfX4WPWG9OYMQf48YKt4g
 lLfC85OLEx/Q4R8LlwHD5haFgUATk+9o5NVm2c2sNmXm3NOdLlLhfLZxUZCgWLSruUAn
 I8rzJMwrv2IDC/mv+y/r9PknqE+jsxXilEi5PxDZjWhnVCwSHfdq9+kVR2eO1ZGcPOk0
 cvxeKpqwsW0BdGSTIZIpRAlOhFAp0J7F8U8Nfz4etSPPICR/E/hbbot34QBTrCtPPlaG kw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbn0a8yfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:03:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H3MmI002780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:03:22 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:03:16 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 05/18] soc: qcom: minidump: Add pending region registration support
Date:   Wed, 3 May 2023 22:32:19 +0530
Message-ID: <1683133352-10046-6-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bvl1Frxt2Tf3ja90bvBzY24ChEsPq1DX
X-Proofpoint-ORIG-GUID: Bvl1Frxt2Tf3ja90bvBzY24ChEsPq1DX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030145
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pending regions are those apss minidump regions which came for
registration before minidump was initialized or ready to do
register the region.

We can add regions to pending region list and register them from
apss minidump driver probe in one go.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c | 114 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index d107a86..6d29371 100644
--- a/drivers/soc/qcom/qcom_minidump.c
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -49,6 +49,25 @@ struct minidump {
 	struct device			*dev;
 };
 
+/**
+ * struct minidump_pending_region - Minidump pending region
+ * @list	: Pending region list pointer
+ * @region	: APSS minidump client region
+ */
+struct minidump_pending_region {
+	struct list_head			list;
+	struct qcom_apss_minidump_region	region;
+};
+
+/**
+ * struct minidump_pending_region_list - Minidump pending region list
+ * @pregion_list	: List of pending region to be registered
+ * @pregion_cnt		: Count of the pending region to be registered
+ */
+struct minidump_pending_region_list {
+	struct list_head	pregion_list;
+	int			pregion_cnt;
+};
 /*
  * In some of the Old Qualcomm devices, boot firmware statically allocates 300
  * as total number of supported region (including all co-processors) in
@@ -62,6 +81,10 @@ struct minidump {
 
 static struct minidump *__md;
 static DEFINE_MUTEX(minidump_lock);
+static struct minidump_pending_region_list md_pregion_list = {
+	.pregion_list = LIST_HEAD_INIT(md_pregion_list.pregion_list),
+	.pregion_cnt = 0,
+};
 
 static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx)
 {
@@ -312,6 +335,26 @@ struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_in
 }
 EXPORT_SYMBOL_GPL(qcom_minidump_subsystem_desc);
 
+static struct minidump_pending_region *
+get_qcom_apss_pending_region(const struct qcom_apss_minidump_region *region)
+{
+	struct minidump_pending_region *md_pregion;
+	struct minidump_pending_region *tmp;
+	bool found = false;
+
+	list_for_each_entry_safe(md_pregion, tmp, &md_pregion_list.pregion_list, list) {
+		struct qcom_apss_minidump_region *md_region;
+
+		md_region = &md_pregion->region;
+		if (!strcmp(md_region->name, region->name)) {
+			found = true;
+			break;
+		}
+	}
+
+	return found ? md_pregion : NULL;
+}
+
 /**
  * qcom_apss_minidump_region_register() - Register a region in Minidump table.
  * @region: minidump region.
@@ -320,34 +363,58 @@ EXPORT_SYMBOL_GPL(qcom_minidump_subsystem_desc);
  */
 int qcom_apss_minidump_region_register(const struct qcom_apss_minidump_region *region)
 {
+	struct minidump_pending_region *md_pregion;
 	unsigned int num_region;
-	int ret;
-
-	if (!__md)
-		return -EPROBE_DEFER;
+	int ret = 0;
 
 	if (!qcom_apss_minidump_valid_region(region))
 		return -EINVAL;
 
 	mutex_lock(&minidump_lock);
-	ret = get_apss_minidump_region_index(region);
-	if (ret >= 0) {
-		dev_info(__md->dev, "%s region is already registered\n", region->name);
+	if (!__md) {
+		md_pregion = get_qcom_apss_pending_region(region);
+		if (md_pregion) {
+			pr_info("%s region is already registered\n", region->name);
+			ret = -EEXIST;
+			goto unlock;
+		}
+		/*
+		 * Maintain a list of client regions which came before
+		 * minidump driver was ready and once it is ready,
+		 * register them in one go from minidump probe function.
+		 */
+		md_pregion = kzalloc(sizeof(*md_pregion), GFP_KERNEL);
+		if (!md_pregion) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		md_pregion->region = *region;
+		list_add_tail(&md_pregion->list, &md_pregion_list.pregion_list);
+		md_pregion_list.pregion_cnt++;
+		goto unlock;
+	}
+
+	if (get_apss_minidump_region_index(region) >= 0) {
+		pr_info("%s region is already registered\n", region->name);
 		ret = -EEXIST;
 		goto unlock;
 	}
 
-	/* Check if there is a room for a new entry */
+	/*
+	 * Check if there is a room for a new region.
+	 * Also, here the check for pregion_cnt is against one less
+	 * than MAX_NUM_ENTRIES as we need one entry for ELF header.
+	 */
 	num_region = le32_to_cpu(__md->md_apss_toc->region_count);
-	if (num_region >= MAX_NUM_ENTRIES) {
-		dev_err(__md->dev, "maximum region limit %u reached\n", num_region);
+	if (md_pregion_list.pregion_cnt >= (MAX_NUM_ENTRIES - 1) ||
+	    num_region >= MAX_NUM_ENTRIES) {
+		pr_err("maximum region limit %u reached\n", num_region);
 		ret = -ENOSPC;
 		goto unlock;
 	}
 
 	qcom_apss_minidump_add_region(region);
 	qcom_apss_minidump_update_elf_header(region);
-	ret = 0;
 unlock:
 	mutex_unlock(&minidump_lock);
 	return ret;
@@ -443,17 +510,23 @@ qcom_apss_minidump_clear_header(const struct qcom_apss_minidump_region *region)
  */
 int qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region *region)
 {
+	struct minidump_pending_region *md_pregion;
 	struct minidump_region *mdr;
 	unsigned int num_region;
 	unsigned int idx;
-	int ret;
+	int ret = 0;
 
-	if (!region)
+	if (!qcom_apss_minidump_valid_region(region))
 		return -EINVAL;
 
 	mutex_lock(&minidump_lock);
 	if (!__md) {
-		ret = -EPROBE_DEFER;
+		md_pregion = get_qcom_apss_pending_region(region);
+		if (!md_pregion)
+			goto unlock;
+		list_del(&md_pregion->list);
+		kfree(md_pregion);
+		md_pregion_list.pregion_cnt--;
 		goto unlock;
 	}
 
@@ -513,6 +586,8 @@ static int qcom_minidump_init_apss_subsystem(struct minidump *md)
 
 static int qcom_minidump_probe(struct platform_device *pdev)
 {
+	struct minidump_pending_region *md_pregion;
+	struct minidump_pending_region *tmp;
 	struct minidump_global_toc *mdgtoc;
 	struct minidump *md;
 	size_t size;
@@ -551,8 +626,19 @@ static int qcom_minidump_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to add elf header: %d\n", ret);
 		memset(md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
 		__md = NULL;
+		goto unlock;
 	}
 
+	list_for_each_entry_safe(md_pregion, tmp, &md_pregion_list.pregion_list, list) {
+		struct qcom_apss_minidump_region *region;
+
+		region = &md_pregion->region;
+		qcom_apss_minidump_add_region(region);
+		qcom_apss_minidump_update_elf_header(region);
+		list_del(&md_pregion->list);
+		kfree(md_pregion);
+		md_pregion_list.pregion_cnt--;
+	}
 unlock:
 	mutex_unlock(&minidump_lock);
 	return ret;
-- 
2.7.4


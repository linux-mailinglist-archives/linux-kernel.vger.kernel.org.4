Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C900741114
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF1Mhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:37:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:62976 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbjF1Mgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7R01b029236;
        Wed, 28 Jun 2023 12:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zUyJ/QKLk3qWrZpElgacmwy8J+Ca7776duwwY9ZJ+Hw=;
 b=F5PuK+eAdFLoh1DqWB6Yi76yJ4s+iW4IO3VfeaiPetFSuyNl8kZPT8QKbRbBe1u+fcZX
 CtNkwzW9uZrAE0ljfr/OINZF4aXt0aXmiSSGVTaO/Q+khiCqmFauwbprp0zXELhtfaOM
 0EpVNRoAFprjW1jGInhcUu78LOnSZQB6oCbH3IDcuwizKwtekAcdVLk5S+uo2yjFOTnF
 pyGfuoiceFokYEjz3IMKbsCKYiCwDz3ayOY7++F9UlKgsodTn9Za20S9cZCj8Xk9SIUz
 pNL/3rzqklxf/5lGlv75zI4XB/QkFZZp2HOYJQNqhYih6UrVk832+Do7rajOZIwM3dzr 1Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgbfss8dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCa3Ee024026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:03 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:56 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 07/21] soc: qcom: minidump: Add update region support
Date:   Wed, 28 Jun 2023 18:04:34 +0530
Message-ID: <1687955688-20809-8-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pJ9iiLd8x4SKlSEio83461EBkiGyS2qz
X-Proofpoint-ORIG-GUID: pJ9iiLd8x4SKlSEio83461EBkiGyS2qz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to update client's region physical/virtual addresses,
which is useful for dynamic loadable modules, dynamic address
changing clients like if we want to collect current stack
information for each core and the current stack is changing on
each sched_switch event, So here virtual/physical address of
the current stack is changing. So, to cover such use cases
add the update region support in minidump driver and the
corresponding smem backend support.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c          | 55 +++++++++++++++++++++++++++++++
 drivers/soc/qcom/qcom_minidump_internal.h |  3 ++
 drivers/soc/qcom/qcom_minidump_smem.c     | 21 ++++++++++++
 include/soc/qcom/qcom_minidump.h          |  5 +++
 4 files changed, 84 insertions(+)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index cfdb63cc29d6..37d6ceb4d85c 100644
--- a/drivers/soc/qcom/qcom_minidump.c
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -318,6 +318,61 @@ int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
 }
 EXPORT_SYMBOL_GPL(qcom_minidump_region_unregister);
 
+/**
+ * qcom_minidump_update_region() - Update region information with new physical
+ * address and virtual address for already registered region e.g, current task
+ * stack for a core keeps on changing on each context switch, there it needs to
+ * change registered region with new updated addresses.
+ *
+ * @region: Should be already registered minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_update_region(const struct qcom_minidump_region *region)
+{
+	struct minidump_pregion *md_pregion;
+	struct qcom_minidump_region *tmp;
+	struct elfhdr *ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+	int idx;
+	int ret = 0;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md_lock);
+	if (!md) {
+		md_pregion = check_if_pending_region_exist(region);
+		if (!md_pregion) {
+			ret = -ENOENT;
+			goto unlock;
+		}
+		tmp = &md_pregion->region;
+		tmp->phys_addr = region->phys_addr;
+		tmp->virt_addr = region->virt_addr;
+		goto unlock;
+	}
+
+	ret = md->ops->md_update_region(md, &idx, region);
+	if (ret)
+		goto unlock;
+
+	/* Skip predefined shdr/phdr header entry at the start */
+	ehdr = md->elf.ehdr;
+	shdr = elf_shdr_entry_addr(ehdr, idx + 4);
+	phdr = elf_phdr_entry_addr(ehdr, idx + 1);
+
+	shdr->sh_addr = (elf_addr_t)region->virt_addr;
+	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
+	phdr->p_paddr = region->phys_addr;
+
+unlock:
+	mutex_unlock(&md_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_update_region);
+
 static int qcom_minidump_add_elf_header(struct minidump *md_data)
 {
 	struct qcom_minidump_region elfregion;
diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
index 6993e3be10c2..dc1e76c1f063 100644
--- a/drivers/soc/qcom/qcom_minidump_internal.h
+++ b/drivers/soc/qcom/qcom_minidump_internal.h
@@ -21,6 +21,7 @@ struct minidump;
  * @md_table_exit:	  Clean up the stuff populated while md_table_init()
  * @md_region_register:	  Callback to register the region at the backend.
  * @md_region_unregister: Callback to unregister the region at the backend.
+ * @md_update_region:	  Callback to update address of already registered regions.
  */
 struct minidump_ops {
 	int (*md_table_init)(struct minidump *md);
@@ -29,6 +30,8 @@ struct minidump_ops {
 				 const struct qcom_minidump_region *region);
 	int (*md_region_unregister)(struct minidump *md,
 				 const struct qcom_minidump_region *region);
+	int (*md_update_region)(struct minidump *md, int *idx,
+                                 const struct qcom_minidump_region *region);
 };
 
 /**
diff --git a/drivers/soc/qcom/qcom_minidump_smem.c b/drivers/soc/qcom/qcom_minidump_smem.c
index bdc75aa2f518..9d4021a5e4c8 100644
--- a/drivers/soc/qcom/qcom_minidump_smem.c
+++ b/drivers/soc/qcom/qcom_minidump_smem.c
@@ -263,6 +263,26 @@ static int smem_md_region_unregister(struct minidump *md,
 	return 0;
 }
 
+static int smem_md_update_region(struct minidump *md, int *idx,
+				 const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_region *mdr;
+	int ret;
+
+	ret = smem_md_get_region_index(mdss_data, region);
+	if (ret < 0) {
+		dev_err(md->dev, "%s region is not present\n", region->name);
+		return ret;
+	}
+
+	*idx = ret;
+	mdr = &mdss_data->md_regions[*idx];
+	mdr->address = cpu_to_le64(region->phys_addr);
+
+	return 0;
+}
+
 static int smem_md_table_init(struct minidump *md)
 {
 	struct minidump_global_toc *mdgtoc;
@@ -324,6 +344,7 @@ static struct minidump_ops smem_md_ops = {
 	.md_table_exit		= smem_md_table_exit,
 	.md_region_register	= smem_md_region_register,
 	.md_region_unregister	= smem_md_region_unregister,
+	.md_update_region	= smem_md_update_region,
 };
 
 static int qcom_minidump_smem_probe(struct platform_device *pdev)
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
index d0bebc3daac5..a86b0313698f 100644
--- a/include/soc/qcom/qcom_minidump.h
+++ b/include/soc/qcom/qcom_minidump.h
@@ -29,6 +29,7 @@ struct qcom_minidump_region {
 #if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
 int qcom_minidump_region_register(const struct qcom_minidump_region *region);
 int qcom_minidump_region_unregister(const struct qcom_minidump_region *region);
+int qcom_minidump_update_region(const struct qcom_minidump_region *region);
 #else
 static inline int qcom_minidump_region_register(const struct qcom_minidump_region *region)
 {
@@ -39,6 +40,10 @@ static inline int qcom_minidump_region_unregister(const struct qcom_minidump_reg
 {
 	return 0;
 }
+static inline int qcom_minidump_update_region(const struct qcom_minidump_region *region)
+{
+	return 0;
+}
 #endif /* CONFIG_QCOM_MINIDUMP */
 
 #if IS_ENABLED(CONFIG_QCOM_MINIDUMP_SMEM)
-- 
2.7.4


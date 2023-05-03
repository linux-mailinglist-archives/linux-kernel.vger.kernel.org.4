Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFFE6F5C71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjECREY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECREV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:04:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B27ABE;
        Wed,  3 May 2023 10:03:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Cfujo005960;
        Wed, 3 May 2023 17:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6O72wiVXL2Mvzy9Bh/nrcKQOoSxqdHfziFYAD/40A4M=;
 b=Y92aVDixiKrAhQQNA7alPuPM5xW1saeMSfWhrAT6lTK472P66LNxxt4HluyZkqAiDlPr
 zYj3xlY0IsH/kEp6plAUl96YaoxM0hWyylvlT6Nw2bfzelRxucEalEA97dPWL18o6Zge
 b15M2YJpGoP91v6uAScRekPaAKlbNCs4m+4GVPv3TN7dmd4DDWN7kTRSc+Nj8gwgaUC9
 4RZEPCZGeJqBh+7lsMFZOaPgreK/wxlU/kk/66cMtBHlDUKwlmJgVPCGcp9wRSgM5ask
 j+qPjjBl0lj0WyISZtqSlsmyAgXjsQczW736gG3TwY9anjOgwbFmhVUCthmRj38i8K0d vg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qb9bhte4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:03:29 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H3SPV003327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:03:28 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:03:22 -0700
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
Subject: [PATCH v3 06/18] soc: qcom: minidump: Add update region support
Date:   Wed, 3 May 2023 22:32:20 +0530
Message-ID: <1683133352-10046-7-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: 8JZvSezMEangHpzKlFUdM0TSLv8Feffo
X-Proofpoint-ORIG-GUID: 8JZvSezMEangHpzKlFUdM0TSLv8Feffo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add support to update client's region physical/virtual addresses,
which is useful for dynamic loadable modules, dynamic address
changing clients like if we want to collect current stack
information for each core and the current stack is changing on
each sched_switch event, So here virtual/physical address of
the current stack is changing. So, to cover such use cases
add the update region support in minidump driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c | 57 ++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/qcom_minidump.h |  7 +++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index 6d29371..853bdda 100644
--- a/drivers/soc/qcom/qcom_minidump.c
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -561,6 +561,63 @@ int qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region
 }
 EXPORT_SYMBOL_GPL(qcom_apss_minidump_region_unregister);
 
+/**
+ * qcom_apss_minidump_update_region() - Update region in APSS minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_apss_minidump_update_region(const struct qcom_apss_minidump_region *region)
+{
+	struct minidump_pending_region *md_pregion;
+	struct qcom_apss_minidump_region *tmp;
+	struct minidump_region *mdr;
+	struct elfhdr *ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+	int idx;
+	int ret = 0;
+
+	if (!qcom_apss_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&minidump_lock);
+	if (!__md) {
+		md_pregion = get_qcom_apss_pending_region(region);
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
+	idx = get_apss_minidump_region_index(region);
+	if (idx < 0) {
+		pr_err("%s region is not present\n", region->name);
+		ret = idx;
+		goto unlock;
+	}
+
+	mdr = &__md->md_regions[idx];
+	mdr->address = cpu_to_le64(region->phys_addr);
+
+	/* Skip predefined shdr/phdr header entry at the start */
+	ehdr = __md->elf.ehdr;
+	shdr = elf_shdr_entry_addr(ehdr, idx + 4);
+	phdr = elf_phdr_entry_addr(ehdr, idx + 1);
+
+	shdr->sh_addr = (elf_addr_t)region->virt_addr;
+	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
+	phdr->p_paddr = region->phys_addr;
+unlock:
+	mutex_unlock(&minidump_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_apss_minidump_update_region);
+
 static int qcom_minidump_init_apss_subsystem(struct minidump *md)
 {
 	struct minidump_subsystem *apsstoc;
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
index 1872668..0c8cc2d 100644
--- a/include/soc/qcom/qcom_minidump.h
+++ b/include/soc/qcom/qcom_minidump.h
@@ -102,6 +102,8 @@ extern int
 qcom_apss_minidump_region_register(const struct qcom_apss_minidump_region *region);
 extern int
 qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region *region);
+extern int
+qcom_apss_minidump_update_region(const struct qcom_apss_minidump_region *region);
 #else
 static inline
 struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_index)
@@ -119,5 +121,10 @@ qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region *reg
 {
 	return 0;
 }
+statuc inline int
+int qcom_apss_minidump_update_region(const struct qcom_apss_minidump_region *region)
+{
+	return 0;
+}
 #endif
 #endif  /* _QCOM_MINIDUMP_H_ */
-- 
2.7.4


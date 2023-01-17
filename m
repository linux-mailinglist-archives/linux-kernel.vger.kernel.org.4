Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D31E66D90F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjAQJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbjAQI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7884B1A958;
        Tue, 17 Jan 2023 00:59:42 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7VrJM018355;
        Tue, 17 Jan 2023 08:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=u64mvaXG9ZmkI319k9IWPiOkPslO2N4WJ0OwRKngvyM=;
 b=ewGfhUC6h9P2725NbsEMpudOgCZg2ZpuIrEYPM8vqgArfnefwSHvTX+k1J0hDe7E5i7d
 sKbwd93anBVNUkDZpsiZTma+WMbYHhdLUO1bURRVmnH5m4dzt/4UcXjkWVTx4CrRQSWF
 em5aedLohPpnyO31nAZQt14VMy9QA4N+Qz6+YCxKEk5aW7moHS6tWXZEntlUfe735DpG
 DFPEE+9S7WhqIB38liSrHmeffdjojjr41MbwI6T7giHl9Igjly/3gFtpbuwKzGErrLp1
 Q3/UrGA4AvqGBEsF5dHuAvx9z33jovDnlC+E9tYQCgNwisNNDRPCT4qHUXaSqUPHiQ8e 0g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3mg3d41k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H8xUrU028693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:30 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 00:59:25 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 06/11] remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem headers
Date:   Tue, 17 Jan 2023 14:28:35 +0530
Message-ID: <20230117085840.32356-7-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pCaaMLK_9249vEtzl53T81g9AKCsjFu9
X-Proofpoint-GUID: pCaaMLK_9249vEtzl53T81g9AKCsjFu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170074
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any access to the dynamically allocated metadata region by the application
processor after assigning it to the remote Q6 will result in a XPU
violation. Fix this by replacing the dynamically allocated memory region
with a no-map carveout and unmap the modem metadata memory region before
passing control to the remote Q6.

Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
 * Use size/alloc-ranges instead of a specific address [Bjorn]
 * Include size checks

v3:
 * Drop revert no_kernel_mapping since it's already on the list [Mani]
 * kfree metadata from the branch for parity

 drivers/remoteproc/qcom_q6v5_mss.c | 59 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index e2f765f87ec9..292e22f58df3 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -215,6 +216,9 @@ struct q6v5 {
 	size_t mba_size;
 	size_t dp_size;
 
+	phys_addr_t mdata_phys;
+	size_t mdata_size;
+
 	phys_addr_t mpss_phys;
 	phys_addr_t mpss_reloc;
 	size_t mpss_size;
@@ -973,15 +977,35 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
-	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
-	if (!ptr) {
-		kfree(metadata);
-		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
-		return -ENOMEM;
+	if (qproc->mdata_phys) {
+		if (size > qproc->mdata_size) {
+			ret = -EINVAL;
+			dev_err(qproc->dev, "metadata size outside memory range\n");
+			goto free_metadata;
+		}
+
+		phys = qproc->mdata_phys;
+		ptr = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
+		if (!ptr) {
+			ret = -EBUSY;
+			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
+				&qproc->mdata_phys, size);
+			goto free_metadata;
+		}
+	} else {
+		ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
+		if (!ptr) {
+			ret = -ENOMEM;
+			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
+			goto free_metadata;
+		}
 	}
 
 	memcpy(ptr, metadata, size);
 
+	if (qproc->mdata_phys)
+		memunmap(ptr);
+
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
 	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true,
@@ -1010,7 +1034,9 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 			 "mdt buffer not reclaimed system may become unstable\n");
 
 free_dma_attrs:
-	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
+	if (!qproc->mdata_phys)
+		dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
+free_metadata:
 	kfree(metadata);
 
 	return ret < 0 ? ret : 0;
@@ -1847,6 +1873,7 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 {
 	struct device_node *child;
+	struct reserved_mem *rmem;
 	struct device_node *node;
 	struct resource r;
 	int ret;
@@ -1893,6 +1920,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 	qproc->mpss_phys = qproc->mpss_reloc = r.start;
 	qproc->mpss_size = resource_size(&r);
 
+	if (!child) {
+		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
+	} else {
+		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
+		node = of_parse_phandle(child, "memory-region", 0);
+		of_node_put(child);
+	}
+
+	if (!node)
+		return 0;
+
+	rmem = of_reserved_mem_lookup(node);
+	if (!rmem) {
+		dev_err(qproc->dev, "unable to resolve metadata region\n");
+		return -EINVAL;
+	}
+
+	qproc->mdata_phys = rmem->base;
+	qproc->mdata_size = rmem->size;
+
 	return 0;
 }
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EFB661CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjAIDvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbjAIDus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:50:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B3A10FFA;
        Sun,  8 Jan 2023 19:50:46 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093ms0F020511;
        Mon, 9 Jan 2023 03:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xELrcb5+mENZBVbELCaQAz6MRFu6n7hU2laa8T2BGc0=;
 b=UrtttE21U95dB4Fik0bMefM40PixC5zVvaQf8hEs8AtHYgTkFQaIxODsnW5TsKpvL1ER
 GhxhSdmx+fOdXhQD1MyecSIgMtNJAsZgAFpUjZr1ZwyFkiOsnmfAn3m/494uuVda4FTg
 ZoltLOzf6dZpv/HQQoON+VVpi5ocqRyLwf16DuN9r5bA7llJufrKtsodZXjPoHn1zt03
 yzaDPNkEbJiyOFZV+ISX5NM8GB+7XpLHWJPh+HZCRQ6Q6u0iI8Gu5XLDaWtuki6p/4ZI
 27f/6taWX/vyRfgjTAPebotEGw9IVBzkOpXUjKQLXg1k471Zj4WvX4lQfeyppvBtavjK 9w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0u126me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093oYMu027774
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:34 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:29 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robin.murphy@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 06/11] remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem headers
Date:   Mon, 9 Jan 2023 09:18:38 +0530
Message-ID: <20230109034843.23759-7-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230109034843.23759-1-quic_sibis@quicinc.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hsUOD_Qo6AOXFySL5K0f-5oHFZmYPynQ
X-Proofpoint-ORIG-GUID: hsUOD_Qo6AOXFySL5K0f-5oHFZmYPynQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090025
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

v2:
 * Revert no_kernel_mapping [Mani/Robin]

 drivers/remoteproc/qcom_q6v5_mss.c | 48 ++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index e2f765f87ec9..b7a158751cef 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -215,6 +215,7 @@ struct q6v5 {
 	size_t mba_size;
 	size_t dp_size;
 
+	phys_addr_t mdata_phys;
 	phys_addr_t mpss_phys;
 	phys_addr_t mpss_reloc;
 	size_t mpss_size;
@@ -973,15 +974,29 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
-	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
-	if (!ptr) {
-		kfree(metadata);
-		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
-		return -ENOMEM;
+	if (qproc->mdata_phys) {
+		phys = qproc->mdata_phys;
+		ptr = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
+		if (!ptr) {
+			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
+				&qproc->mdata_phys, size);
+			ret = -EBUSY;
+			goto free_dma_attrs;
+		}
+	} else {
+		ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
+		if (!ptr) {
+			kfree(metadata);
+			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
+			return -ENOMEM;
+		}
 	}
 
 	memcpy(ptr, metadata, size);
 
+	if (qproc->mdata_phys)
+		memunmap(ptr);
+
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
 	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true,
@@ -1010,7 +1025,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 			 "mdt buffer not reclaimed system may become unstable\n");
 
 free_dma_attrs:
-	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
+	if (!qproc->mdata_phys)
+		dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
 	kfree(metadata);
 
 	return ret < 0 ? ret : 0;
@@ -1893,6 +1909,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
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
+	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
+	if (ret) {
+		dev_err(qproc->dev, "unable to resolve metadata region\n");
+		return ret;
+	}
+
+	qproc->mdata_phys = r.start;
+
 	return 0;
 }
 
-- 
2.17.1


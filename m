Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BFD5B613A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiILSmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiILSlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:41:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D5BC9;
        Mon, 12 Sep 2022 11:41:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CI5lcv001095;
        Mon, 12 Sep 2022 18:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DAbOzy7zTOG+92vcI0PAIXg5coPxX99e/DYytzhS6n0=;
 b=lye1urs/7kFV0pJcWPEWgbre81PGvMphz0TTWAmgoKCizg6iBOARKLdQ5Klj5MygCNIp
 rlqjSlAE4WIo9wmwgL4HAoV70YRDb34baniHetwIL7r7L7JL0mM8uWQnAgWXuYL465Cp
 xVSfwSg62P2FhWgXAlW+PyOrE6tp2fMkN7uydZGlkU49yaJ3dAklu7t790ywRo4y8HeL
 G0M63zzJhbpP/+IwY/GTT2fOkuADEgAVt90/BBo7bbezOmCeWlWmlcOtldtaUQvbmOAi
 MpKU1kgr/JCLJSSUsJfnVjBkTJm8gYE57e5xP101ejaRX1v6nAVmBW7NdxaQwEV6XfMb ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkve5ww0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:41:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CIfeGw001342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:41:40 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 11:41:40 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v1 1/2] firmware: qcom_scm: Remove memory alloc call from qcom_scm_pas_init_image()
Date:   Mon, 12 Sep 2022 11:41:31 -0700
Message-ID: <d59c6a04c6b5d70df3276e903a85099ed4291b09.1663007783.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663007783.git.quic_gokukris@quicinc.com>
References: <cover.1663007783.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EkhqGmE65TFQ-A3HjwCNmBF-imq0f6Lh
X-Proofpoint-GUID: EkhqGmE65TFQ-A3HjwCNmBF-imq0f6Lh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_12,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory for metadata is allocated in mdt loader and scm driver

1].  163  data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
2].  477  mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
     478                                        GFP_KERNEL);

The SCM driver is meant to only pack arguments provided to it from clients
for making the secure world calls. This change removes the logic of doing
a dma alloc coherent from the SCM driver and moves it into the mdt loader

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/firmware/qcom_scm.c   | 33 +++------------------------------
 drivers/soc/qcom/mdt_loader.c |  3 ++-
 include/linux/qcom_scm.h      |  4 +---
 3 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54..05ec03c 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -442,11 +442,9 @@ static void qcom_scm_set_download_mode(bool enable)
  *			       state machine for a given peripheral, using the
  *			       metadata
  * @peripheral: peripheral id
- * @metadata:	pointer to memory containing ELF header, program header table
+ * @mdata_phys:	pointer to memory containing ELF header, program header table
  *		and optional blob of data used for authenticating the metadata
  *		and the rest of the firmware
- * @size:	size of the metadata
- * @ctx:	optional metadata context
  *
  * Return: 0 on success.
  *
@@ -454,11 +452,8 @@ static void qcom_scm_set_download_mode(bool enable)
  * track the metadata allocation, this needs to be released by invoking
  * qcom_scm_pas_metadata_release() by the caller.
  */
-int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
-			    struct qcom_scm_pas_metadata *ctx)
+int qcom_scm_pas_init_image(u32 peripheral, dma_addr_t mdata_phys)
 {
-	dma_addr_t mdata_phys;
-	void *mdata_buf;
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
@@ -469,22 +464,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	};
 	struct qcom_scm_res res;
 
-	/*
-	 * During the scm call memory protection will be enabled for the meta
-	 * data blob, so make sure it's physically contiguous, 4K aligned and
-	 * non-cachable to avoid XPU violations.
-	 */
-	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
-				       GFP_KERNEL);
-	if (!mdata_buf) {
-		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
-		return -ENOMEM;
-	}
-	memcpy(mdata_buf, metadata, size);
-
 	ret = qcom_scm_clk_enable();
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
@@ -497,15 +479,6 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
-out:
-	if (ret < 0 || !ctx) {
-		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
-	} else if (ctx) {
-		ctx->ptr = mdata_buf;
-		ctx->phys = mdata_phys;
-		ctx->size = size;
-	}
-
 	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_init_image);
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 3f11554..8d06125 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -210,6 +210,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	const struct elf32_hdr *ehdr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
+	dma_addr_t mdata_phys;
 	size_t metadata_len;
 	void *metadata;
 	int ret;
@@ -238,7 +239,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		goto out;
 	}
 
-	ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len, ctx);
+	ret = qcom_scm_pas_init_image(pas_id, mdata_phys);
 	kfree(metadata);
 	if (ret) {
 		/* Invalid firmware metadata */
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f833564..751436a 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -74,9 +74,7 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
-extern int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
-				   size_t size,
-				   struct qcom_scm_pas_metadata *ctx);
+extern int qcom_scm_pas_init_image(u32 peripheral, dma_addr_t metadata);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
 extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 				  phys_addr_t size);
-- 
2.7.4


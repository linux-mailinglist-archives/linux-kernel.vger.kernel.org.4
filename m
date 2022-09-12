Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964D25B613C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiILSmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiILSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:41:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ABEB2C;
        Mon, 12 Sep 2022 11:41:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CGNLgY028605;
        Mon, 12 Sep 2022 18:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tV4inXm/yrbGu0Hp/u24RULvsY73E22mjF5+EChHio0=;
 b=WuxLiLdP8k+yWHDMIQxh5S/nKyt/lUwNHtpO5s1UbRSm7vQWFhixnlm2DaYrixC4NErW
 rpajfG6DtB6RLXnNH8gCQ3SqLPmlsLjkxT98TEx/abVaYWL1TyNiXJvcRRqs48zv0jIm
 rqxLoFo20wlbTMaBHFkbQEixJbj+AYYXwrELdoawDpoPTkR5VfrMtfrM8VCWZrtH84RW
 NswdFIH8W1uZzWUO7T3QwZcapk5lP9fOd1Ttr1KmHDJmF+dmUW6Kp35j+HYO9x+uIF74
 E1khzOCQiG0Jr22YhjvxISLK4y1A6OC79yzWZgKBTN3ZyXuKTTe/xT2Eh+xct1+8ZLtB xA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk6kd1s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:41:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CIfgnR013182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:41:42 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 11:41:42 -0700
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
Subject: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocation into mdt loader
Date:   Mon, 12 Sep 2022 11:41:32 -0700
Message-ID: <2ba262668e86e58acb086c64fc759ba02b39a525.1663007783.git.quic_gokukris@quicinc.com>
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
X-Proofpoint-GUID: JJhdhFDNRAOmZLrjiyAHI3TGLRNNoQA0
X-Proofpoint-ORIG-GUID: JJhdhFDNRAOmZLrjiyAHI3TGLRNNoQA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_12,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

By moving the memory allocation to mdt loader we can simplify the scm
call, by just packing arguments provided to it from the clients for
making secuer world calls. We can also simplify the memory allocation
for the qcom metadata, by just doing one memory allocation in the
mdt loader.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
 drivers/soc/qcom/mdt_loader.c       | 41 ++++++++++++++++++++++++++++---------
 include/linux/soc/qcom/mdt_loader.h |  5 +++--
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index fddb63c..1919bfc 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -947,7 +947,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 	int ret;
 	int i;
 
-	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
+	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev, NULL);
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 8d06125..e730413 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/dma-mapping.h>
 
 static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 {
@@ -110,6 +111,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_get_size);
  * @data_len:	length of the read metadata blob
  * @fw_name:	name of the firmware, for construction of segment file names
  * @dev:	device handle to associate resources with
+ * @mdata_phys:	phys address for the assigned metadata buffer
  *
  * The mechanism that performs the authentication of the loading firmware
  * expects an ELF header directly followed by the segment of hashes, with no
@@ -124,11 +126,13 @@ EXPORT_SYMBOL_GPL(qcom_mdt_get_size);
  * Return: pointer to data, or ERR_PTR()
  */
 void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
-			     const char *fw_name, struct device *dev)
+			     const char *fw_name, struct device *dev,
+			     dma_addr_t *mdata_phys)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_hdr *ehdr;
 	unsigned int hash_segment = 0;
+	struct device *scm_dev = NULL;
 	size_t hash_offset;
 	size_t hash_size;
 	size_t ehdr_size;
@@ -160,9 +164,18 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	ehdr_size = phdrs[0].p_filesz;
 	hash_size = phdrs[hash_segment].p_filesz;
 
-	data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
+	/*
+	 * During the scm call memory protection will be enabled for the meta
+	 * data blob, so make sure it's physically contiguous, 4K aligned and
+	 * non-cachable to avoid XPU violations.
+	 */
+	scm_dev = qcom_get_scm_device();
+	data = dma_alloc_coherent(scm_dev, ehdr_size + hash_size, mdata_phys,
+				       GFP_KERNEL);
+	if (!data) {
+		dev_err(dev, "Allocation of metadata buffer failed.\n");
+		return NULL;
+	}
 
 	/* Copy ELF header */
 	memcpy(data, fw->data, ehdr_size);
@@ -179,7 +192,7 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 		/* Hash is in its own segment, beyond the loaded file */
 		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
 		if (ret) {
-			kfree(data);
+			dma_free_coherent(scm_dev, ehdr_size + hash_size, data, mdata_phys);
 			return ERR_PTR(ret);
 		}
 	}
@@ -209,10 +222,11 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	const struct elf32_phdr *phdr;
 	const struct elf32_hdr *ehdr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
+	struct device *scm_dev = NULL;
 	phys_addr_t max_addr = 0;
 	dma_addr_t mdata_phys;
 	size_t metadata_len;
-	void *metadata;
+	void *mdata_buf;
 	int ret;
 	int i;
 
@@ -232,15 +246,22 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
 	}
 
-	metadata = qcom_mdt_read_metadata(fw, &metadata_len, fw_name, dev);
-	if (IS_ERR(metadata)) {
-		ret = PTR_ERR(metadata);
+	mdata_buf = qcom_mdt_read_metadata(fw, &metadata_len, fw_name, dev, &mdata_phys);
+	if (IS_ERR(mdata_buf)) {
+		ret = PTR_ERR(mdata_buf);
 		dev_err(dev, "error %d reading firmware %s metadata\n", ret, fw_name);
 		goto out;
 	}
 
 	ret = qcom_scm_pas_init_image(pas_id, mdata_phys);
-	kfree(metadata);
+	if (ret || !ctx) {
+		dma_free_coherent(scm_dev, metadata_len, mdata_buf, mdata_phys);
+	} else if (ctx) {
+		ctx->ptr = mdata_buf;
+		ctx->phys = mdata_phys;
+		ctx->size = metadata_len;
+	}
+
 	if (ret) {
 		/* Invalid firmware metadata */
 		dev_err(dev, "error %d initializing firmware %s\n", ret, fw_name);
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 9e8e604..d438442 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -28,7 +28,8 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 			  phys_addr_t mem_phys, size_t mem_size,
 			  phys_addr_t *reloc_base);
 void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
-			     const char *fw_name, struct device *dev);
+			     const char *fw_name, struct device *dev,
+			     dma_addr_t *mdata_phys);
 
 #else /* !IS_ENABLED(CONFIG_QCOM_MDT_LOADER) */
 
@@ -64,7 +65,7 @@ static inline int qcom_mdt_load_no_init(struct device *dev,
 
 static inline void *qcom_mdt_read_metadata(const struct firmware *fw,
 					   size_t *data_len, const char *fw_name,
-					   struct device *dev)
+					   struct device *dev, dma_addr_t *mdata_phys)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.7.4


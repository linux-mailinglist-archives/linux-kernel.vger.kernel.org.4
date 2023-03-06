Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01FF6AD2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCFXMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCFXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:12:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5A6BDC8;
        Mon,  6 Mar 2023 15:12:27 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326LQXct006183;
        Mon, 6 Mar 2023 23:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0LZD2cM+vYQX60C1XUR70llZ7jY3+Ms+wGaNHJaJUmc=;
 b=l+GUdoFYUDJSz1JbKkqnaUpOIK3ugIxTILNKXyxxZ6Md4M1Gu5Iy/u9HPPxxMGxUDtHy
 Eo1IvqTVhSNhN8sP8r45k8YpsV+OfezfDNuDWukN0sT3r8wsLbPwuWABqd+viPCfWZr+
 pyGKGIiGPRGMRKIa447JnfUYabN34dvXankcO7Vfvi1+BdgXvDQDYmQjwPsFCtTk0JHg
 o9UZ/Gx/2HO3A6ohPeHBfHzBADYEn6/sLI12Bwk338p23k0GL47AtX8R52WR8RgHILRP
 chGJM0Tlnu4b2/5wYv6eb+cyB3fpBuBuurwCuS+8PRQyD2ZrDzbKlMeygcUN64BV4lBf QA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p419169fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 23:12:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326NCN0r019355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 23:12:23 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 15:12:22 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        "Gokul Krishna Krishnakumar" <quic_gokukris@quicinc.com>
Subject: [PATCH v2 4/7] soc: qcom: mdt_loader: Enhance split binary detection
Date:   Mon, 6 Mar 2023 15:11:59 -0800
Message-ID: <20230306231202.12223-5-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306231202.12223-1-quic_molvera@quicinc.com>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BOP1_PX7PyL_XNcVM61tBneq-1Ly_QBQ
X-Proofpoint-GUID: BOP1_PX7PyL_XNcVM61tBneq-1Ly_QBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>

When booting with split binaries, it may be that the offset of the first
program header lies inside the mdt's filesize, in this case the loader
would incorrectly assume that the bins were not split. The loading would
then continue on and fail for split bins. This change updates the logic used
by the mdt loader to understand whether the firmware images are split or not
by checking if each programs header's segment lies within the file or not.

Signed-off-by: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/soc/qcom/mdt_loader.c | 64 +++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 33dd8c315eb7..3aadce299c02 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -31,6 +31,26 @@ static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 	return true;
 }
 
+static bool qcom_mdt_bins_are_split(const struct firmware *fw)
+{
+	const struct elf32_phdr *phdrs;
+	const struct elf32_hdr *ehdr;
+	uint64_t seg_start, seg_end;
+	int i;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+	phdrs = (struct elf32_phdr *)(ehdr + 1);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		seg_start = phdrs[i].p_offset;
+		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
+		if (seg_start > fw->size || seg_end > fw->size)
+			return true;
+	}
+
+	return false;
+}
+
 static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
 				      unsigned int segment, const char *fw_name,
 				      struct device *dev)
@@ -167,23 +187,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	/* Copy ELF header */
 	memcpy(data, fw->data, ehdr_size);
 
-	if (ehdr_size + hash_size == fw->size) {
-		/* Firmware is split and hash is packed following the ELF header */
-		hash_offset = phdrs[0].p_filesz;
-		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
-	} else if (phdrs[hash_segment].p_offset + hash_size <= fw->size) {
-		/* Hash is in its own segment, but within the loaded file */
+
+	if (qcom_mdt_bins_are_split(fw)) {
+		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
+	} else {
 		hash_offset = phdrs[hash_segment].p_offset;
 		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
-	} else {
-		/* Hash is in its own segment, beyond the loaded file */
-		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
-		if (ret) {
-			kfree(data);
-			return ERR_PTR(ret);
-		}
 	}
-
 	*data_len = ehdr_size + hash_size;
 
 	return data;
@@ -270,6 +280,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	ssize_t offset;
 	bool relocate = false;
+	bool is_split;
 	void *ptr;
 	int ret = 0;
 	int i;
@@ -277,6 +288,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	is_split = qcom_mdt_bins_are_split(fw);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -330,22 +342,16 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		ptr = mem_region + offset;
 
-		if (phdr->p_filesz && phdr->p_offset < fw->size &&
-		    phdr->p_offset + phdr->p_filesz <= fw->size) {
-			/* Firmware is large enough to be non-split */
-			if (phdr->p_offset + phdr->p_filesz > fw->size) {
-				dev_err(dev, "file %s segment %d would be truncated\n",
-					fw_name, i);
-				ret = -EINVAL;
-				break;
+		if (phdr->p_filesz) {
+			if (!is_split) {
+				/* Firmware is large enough to be non-split */
+				memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
+			} else {
+				/* Firmware not large enough, load split-out segments */
+				ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
+				if (ret)
+					break;
 			}
-
-			memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
-		} else if (phdr->p_filesz) {
-			/* Firmware not large enough, load split-out segments */
-			ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
-			if (ret)
-				break;
 		}
 
 		if (phdr->p_memsz > phdr->p_filesz)
-- 
2.25.1


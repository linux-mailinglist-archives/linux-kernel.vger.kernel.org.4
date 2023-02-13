Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32C694FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjBMSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjBMSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:53:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2551EBFB;
        Mon, 13 Feb 2023 10:53:21 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8s2sX022324;
        Mon, 13 Feb 2023 18:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=cRlyEGuhQCPlbl45yqmURDOgosWOabCQPRuUzHgHHi0=;
 b=jARj0pru49pPpZSWunjXY0oW3ZvW6MI5bdJS5Ak2AjZ2VJs5YR7GBwupN36OGPR0nynw
 p8DzwLjVWJ59K2LV/Ka1Mw9Z6N62NlwO5urCBPYNLP1m0ddYsJBWaeJSzdT2HME5+ROw
 SMITMXdz3eT6ajLJlnH7QTkqUWZsUzLQTbBC4hmzilI3q6AXDg33/etHvy5KGWw8Bia9
 mxvvKNJcJxGEpMofJ711eVdMa2CNNnOHJnAu5/V67SSEZNdTl8T9mv/RX1PHx9fVkl97
 DOXXN4kQinZrtMRWg25AbNkcE225mCu4bGukYlQDopnFc/qYlv9gm2JQhr5NDqzlU3eS Rg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np3dew1t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DIrHUD030269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:17 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 10:53:16 -0800
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
Subject: [PATCH 6/9] soc: qcom: mdt_loader: Enhance split binary detection
Date:   Mon, 13 Feb 2023 10:52:15 -0800
Message-ID: <20230213185218.166520-7-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185218.166520-1-quic_molvera@quicinc.com>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jESBzwqNWlC6APFjKh80zaAbEmxksaPe
X-Proofpoint-ORIG-GUID: jESBzwqNWlC6APFjKh80zaAbEmxksaPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>

When booting with split binaries, it is possible that the
mdt loader misdetects if a binary is split and only loads
one of the segments, so enhance the detection of the split
binaries to ensure the entirety of the firmware is loaded.

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


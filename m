Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893516DC9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjDJRO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:14:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C21210D;
        Mon, 10 Apr 2023 10:14:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFuo4M020232;
        Mon, 10 Apr 2023 17:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xdgv48S2+WPNyzZk0JpYPKZH0H+r6IYvnFJk2oxQuGI=;
 b=Rwr/ACHYd1sG4PAW9B9ErfHDyFl5ZUgrHV3iJHY58NBYUGUZXPKzLumNTV3FunchmpUH
 SFpHPEWe6OrTxbcA8gmWjMhGmbO7rUpHRpzfJZQucaqVVBsrq+uwEwRttR5KS09rGe9x
 urt73+QvFCFnCNJq3s4Bp+q3VLt/LIvyMYWGOJDyM/RUxido1CB6I9k6Bs548z2bllmh
 HlU/ksKzCYSLisyF2BeziehCBAM/J1is+eaTWi++PRSK815/B0GIOlN/aIv45TVZA1iU
 RdSItfUdKqGDxPLOB7ibZ1Z26bRtiuB8lIpz7wJ2tZNelqj8n+sUlIAf6bWm/dJyansy zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvm97gcay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 17:14:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AHEm8a001728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 17:14:48 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 10:14:47 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v5 1/1] soc: qcom: mdt_loader: Enhance split binary detection
Date:   Mon, 10 Apr 2023 10:14:32 -0700
Message-ID: <20230410171432.19046-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QgBz8lDrWg-Y0BFJkTogsBHeIynZrowI
X-Proofpoint-ORIG-GUID: QgBz8lDrWg-Y0BFJkTogsBHeIynZrowI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100148
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be that the offset of the first program header lies inside the mdt's
filesize, in this case the loader would incorrectly assume that the bins
were not split. The loading would then continue on to fail for split bins.
This change updates the logic used by the mdt loader to understand whether
the firmware images are split or not. It figures this out by checking if
each programs header's segment lies within the file or not.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
V5: Removes extra empty lines from V4.

V4: Removes the unneceessary change in qcom_mdt_read_metadata(), the
exisiting check holds good in case the hash segment is in the loaded image.

V3 is separated out from [1] and includes
changes addressing comments from that patch set.

[1] https://lore.kernel.org/all/20230306231202.12223-5-quic_molvera@quicinc.com/
---
 drivers/soc/qcom/mdt_loader.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 33dd8c315eb7..814646ce41e5 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -258,6 +258,26 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
 
+static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char* fw_name)
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
 static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			   const char *fw_name, int pas_id, void *mem_region,
 			   phys_addr_t mem_phys, size_t mem_size,
@@ -270,6 +290,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	ssize_t offset;
 	bool relocate = false;
+	bool is_split;
 	void *ptr;
 	int ret = 0;
 	int i;
@@ -277,6 +298,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	is_split = qcom_mdt_bins_are_split(fw, fw_name);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -330,8 +352,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		ptr = mem_region + offset;
 
-		if (phdr->p_filesz && phdr->p_offset < fw->size &&
-		    phdr->p_offset + phdr->p_filesz <= fw->size) {
+		if (phdr->p_filesz && !is_split) {
 			/* Firmware is large enough to be non-split */
 			if (phdr->p_offset + phdr->p_filesz > fw->size) {
 				dev_err(dev, "file %s segment %d would be truncated\n",
-- 
2.39.2


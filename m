Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964BB6C393C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCUSdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:33:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8EAD2C;
        Tue, 21 Mar 2023 11:33:14 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGEj7o029939;
        Tue, 21 Mar 2023 18:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=N7rjdkk2VBnMhk+iF3Zl/KI4r7dcDpWPOfVT+/Bb/ko=;
 b=fwAND6FWzf5hpb/Tzr3X3bu/kf4/bbKbe/LdkhPPfoTibt0YsvrpwAf4LZIazhxFB1pQ
 /CuzxFVIvW3VWW9Do9MNjTBm2gqP29QggIvE2Cu1WwiA/wa/edR1iqBzv03fI6ALJrJE
 tjWmDiNqIQFJ6PfjYkHbTolaZXCn7q05NxZ1XQ7xhv8kTGf+mRiMWa+8jP+8avyMybnp
 bMgW4uxaIcbUKo/MIAaH2ibAvDQFePUYXNk2xkBw3vXz8BxjBwNCos1XcFMNaHA+7AM4
 IgpDq+CdcULtX/hZ2pG/qOd3H5ZTS5NAEuFgdgAA2H0o72itvbIRMdYgb5aoYrNt21d0 oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfbjy9ayh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 18:33:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LIX4fo023252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 18:33:04 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 11:33:03 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Gokul krishna Krishnakumar" <quic_gokukris@quicinc.com>
Subject: [PATCH v3 1/1] soc: qcom: mdt_loader: Enhance split binary detection
Date:   Tue, 21 Mar 2023 11:32:49 -0700
Message-ID: <20230321183249.24154-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gomtDVaNqWGXs04bpBSt_d-849-pxFzb
X-Proofpoint-ORIG-GUID: gomtDVaNqWGXs04bpBSt_d-849-pxFzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
This patch is separated out from [1] and includes
changes addressing comments from that patch set.

[1] https://lore.kernel.org/all/20230306231202.12223-5-quic_molvera@quicinc.com/
---
 drivers/soc/qcom/mdt_loader.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 3f11554df2f3..08ed4c0293f2 100644
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
@@ -277,6 +298,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+
+	is_split = qcom_mdt_bins_are_split(fw, fw_name);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -330,8 +353,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		ptr = mem_region + offset;
 
-		if (phdr->p_filesz && phdr->p_offset < fw->size &&
-		    phdr->p_offset + phdr->p_filesz <= fw->size) {
+
+		if (phdr->p_filesz && !is_split) {
 			/* Firmware is large enough to be non-split */
 			if (phdr->p_offset + phdr->p_filesz > fw->size) {
 				dev_err(dev, "file %s segment %d would be truncated\n",
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1572D3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjFLV6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFLV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:58:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E015E57;
        Mon, 12 Jun 2023 14:58:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLQcvP022484;
        Mon, 12 Jun 2023 21:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=GvpUNUTqDJw6RO67A1tGd9vE8eGrmzVy7qyHvij5e3A=;
 b=O9UaAIX6D6jaFWj7Qi5ePpWfV7VxDo4UAXVMUyUSvLE4j9pr4Ef6poXW0SdPzY3eylUp
 62IDDNwd/cOgNYS/6WK1aqaBBNI6yx/kffUHhBd4h4+Md9ZgxpGDDyGZXFUDRnG8IXJ3
 /nYZ9GIShd//qe7wtbe+btHFh/4R15CySj7zrMc0/4d9gINFwvloHh4ZL0bMTjy7jK3X
 LSzs36y7J9FBMkg/fDjPT1Rlsq6hUX1YMg3w5q4nQkKIrjPIml9U+ZdxWsrd5MaHiJQQ
 LKK39JD+VWEulPNYj/dJb4KDt7Ajomv3K1wI8wv05Wolvwq3IW0SWh5ldv8SwQEkRa0W Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r60peseqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 21:58:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CLwA7q001795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 21:58:10 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 14:58:10 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Gokul krishna Krishnakumar" <quic_gokukris@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: mdt_loader: Fix split image detection
Date:   Mon, 12 Jun 2023 14:58:04 -0700
Message-ID: <20230612215804.1883458-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OfPwkohd_37N73SZ8pnjdGfUxrDmsC6Z
X-Proofpoint-ORIG-GUID: OfPwkohd_37N73SZ8pnjdGfUxrDmsC6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enhanced detection introduced in commit '210d12c8197a ("soc: qcom:
mdt_loader: Enhance split binary detection")' requires that all segments
lies within the file on disk.

But the Qualcomm firmware files consistently has a BSS-like segment at
the end, with a p_offset aligned to the next 4k boundary. As the p_size
is 0 and there's nothing to load, the image is not padded to cover this
(empty) segment.

Ignore zero-sized segments when determining if the image is split, to
avoid this problem.

Fixes: 210d12c8197a ("soc: qcom: mdt_loader: Enhance split binary detection")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/mdt_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 9418993a3a92..6f177e46fa0f 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -275,6 +275,14 @@ static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_na
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
 	for (i = 0; i < ehdr->e_phnum; i++) {
+		/*
+		 * The size of the MDT file is not padded to include any
+		 * zero-sized segments at the end. Ignore these, as they should
+		 * not affect the decision about image being split or not.
+		 */
+		if (!phdrs[i].p_filesz)
+			continue;
+
 		seg_start = phdrs[i].p_offset;
 		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
 		if (seg_start > fw->size || seg_end > fw->size)
-- 
2.25.1


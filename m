Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107DA7376B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjFTVhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFTVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:37:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD0122;
        Tue, 20 Jun 2023 14:37:12 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KKO3ow014004;
        Tue, 20 Jun 2023 21:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=E8IiX3xq5Kaz6WnoYLQCLeytrsRxL9XqVvHBESze5jo=;
 b=mxLapoMH6eStL/MFEkHtAV51FLwl8sSL8/7L3+WODX/X3uAN5/j6O6VAAcCGJo3KhON3
 T7dVUnlVYtrwS/zZ/MzFdrdKOTZ30745CbDbr0loCDPZiwRDHDpvptfzFxb/vqPIIiN6
 dm8MW2gfliMuSR3uvKnfU4MoGdcrsONMGTXp131Wgqn3k87+OUrgrNk5oF8Ad9+7yPKF
 c0Uw69QdlIjXZhaTFb3R+iwF8z75M74rMbgYMotr4fW+YPvU3xOrdClOr+JomCcayIVd
 9ThNwUXuE9byQliloy/D8etPpMs2iHHZT7QA64NwcHpONFTf5DdtV93zhBBUL8GY0mVD +A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb3fhtcwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 21:37:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KLb8ho027782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 21:37:08 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 14:37:08 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: cmd-db: Drop NUL bytes from debugfs output
Date:   Tue, 20 Jun 2023 14:37:03 -0700
Message-ID: <20230620213703.283583-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OSds_C6vNQpbyw-PS_0ZAS9IPaK0VthZ
X-Proofpoint-ORIG-GUID: OSds_C6vNQpbyw-PS_0ZAS9IPaK0VthZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306200195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs dump of Command DB relies uses %*pEp to print the resource
identifiers, with escaping of non-printable characters.
But p (ESCAPE_NP) does not escape NUL characters, so for identifiers
less than 8 bytes in length the output will retain these.

This does not cause an issue while looking at the dump in the terminal
(no known complaints at least), but when programmatically consuming the
debugfs output the extra characters are unwanted.

Change the fixed 8-byte sizeof() to a dynamic strnlen() to avoid
printing these NUL characters.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 33856abd560c..34c40368d5b5 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -284,7 +284,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
 		ent = rsc_to_entry_header(rsc);
 		for (j = 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
 			seq_printf(seq, "0x%05x: %*pEp", le32_to_cpu(ent->addr),
-				   (int)sizeof(ent->id), ent->id);
+				   (int)strnlen(ent->id, sizeof(ent->id)), ent->id);
 
 			len = le16_to_cpu(ent->len);
 			if (len) {
-- 
2.25.1


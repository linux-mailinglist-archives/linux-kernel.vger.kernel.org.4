Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3766612AF5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ3OYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:24:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF93B4BB;
        Sun, 30 Oct 2022 07:24:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29UEJ0eB029315;
        Sun, 30 Oct 2022 14:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=LDUPl7AJWoGiHgR4WjutUPTsZY9o/snrEnz/KgKrF5g=;
 b=k0wXczeyxGiROWoeVqWNRQYePwVtPoNC5eiPWpusSbIaPVJVpM9ZLxkBjCaKFEaV2kA2
 O9ueXMHtexRR5rUTUCvI0TfdCb0HYB7t+mcTBxxosL3S7JpDNS16aRX+fBxY5VA4mzjl
 qZMoU3SCzbpC1sqKNyFz/avlJWcz+zQGKhRQSgcF44rh/8A4cB3expSHtnjwMQF4JisV
 FbxmyRYtrABMpts2/vSNZCYqV3nnr36bgZ6GMwPM7wqCWViMhDIGOBZe4QI9GTR6uRQE
 GRhMebPYpyjkc0/gGThlOwstgW0NnhaoTKxRdFxUXAaGkEWIylF+0LgJxlgKLKPY+ldM 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3khf9krkte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Oct 2022 14:24:25 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29UEOO2f025649;
        Sun, 30 Oct 2022 14:24:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3khdn4hh9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Oct 2022 14:24:23 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29UEON25025644;
        Sun, 30 Oct 2022 14:24:23 GMT
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 29UEONCA025643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Oct 2022 14:24:23 +0000
Received: from shazhuss-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 30 Oct 2022 07:24:20 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <andersson@kernel.org>
CC:     <bmasney@redhat.com>, Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for gcc_ufs_ref_clkref_clk
Date:   Sun, 30 Oct 2022 19:53:33 +0530
Message-ID: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -CXHWSQnbCumlR0LcJXgIvhXYt3QXQrr
X-Proofpoint-GUID: -CXHWSQnbCumlR0LcJXgIvhXYt3QXQrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_08,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=760 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210300094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref
clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index a18ed88f3b82..72b545121c57 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -5848,6 +5848,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_ref_clkref_clk",
+			.parent_data = &gcc_parent_data_tcxo,
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.38.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC66DEA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDLEda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDLEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:33:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4524690
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:33:21 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C447kn019794;
        Wed, 12 Apr 2023 04:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5jqR/gmWFAuu1wVu6uuEschRlPfhwalbwHfoHfxxsIo=;
 b=mJJuiWZu6jN841JxTOE1F06BMFDrdxmFraveRe1JPKu8/ABdt/P8W80qICNCCD4mgdvp
 ZIg1J4TrICqZkbEgi3mKhjJc8wBg+1YQ3q8RHX6Ffc6f/DwSx/sTfGF6gwjOXWX/TGKH
 ga0qz12aqPwDVnEjobSf9rqlgAr9V+97rW/EautOuBEsslJ4TGpv4JOZg7KHQkUBi0Vj
 oYx8L9FTClGDV8s8WkDFxNFFsjkod1jgaprF6Yr/c9FbPBKa7UkXmTihroOVSa38kan3
 AjvnnG+xUKPiOntDewCuXFOzAHfBfb5trWlFzThIGS0LG292WefSod79czvxbUdnOFd1 KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw9b9hfk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 04:33:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33C4XAF2007956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 04:33:10 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 21:33:08 -0700
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH] arm64: kernel: Fix kernel warning when nokaslr is passed to commandline
Date:   Wed, 12 Apr 2023 10:02:58 +0530
Message-ID: <20230412043258.397455-1-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 54WOu-MfX6C5MyJb_hz-35BsfmgnFRTu
X-Proofpoint-ORIG-GUID: 54WOu-MfX6C5MyJb_hz-35BsfmgnFRTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Unknown kernel command line parameters "nokaslr", will be passed to
user space' message is noticed in the dmesg when nokaslr is passed to
the kernel commandline on ARM64 platform. This is because nokaslr param
is handled by early cpufeature detection infrastructure and the parameter
is never consumed by a kernel param handler. Fix this warning by
providing a dummy kernel param handler for nokaslr.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 arch/arm64/kernel/idreg-override.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 95133765ed29..75ceb7c07af7 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -177,6 +177,13 @@ static const struct {
 	{ "nokaslr",			"kaslr.disabled=1" },
 };
 
+static int __init parse_nokaslr(char *unused)
+{
+	/* nokaslr param handling is done by early cpufeature code */
+	return 0;
+}
+early_param("nokaslr", parse_nokaslr);
+
 static int __init find_field(const char *cmdline,
 			     const struct ftr_set_desc *reg, int f, u64 *v)
 {
-- 
2.25.1


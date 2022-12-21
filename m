Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB75652CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiLUGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:11:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A95421E;
        Tue, 20 Dec 2022 22:11:49 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL5oFQj028376;
        Wed, 21 Dec 2022 06:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T59+OGJo76VoGlmNoaP6JZlHidx8e5QMXw8nvlGU/A0=;
 b=fUba4cm4RyWXngajAu6qTYjEdHSJx7gXKfAHwmqAYrHsh4dpSoC6evOL1OU0za2pxzf2
 Q7FhH5Qhlfx5HOyhazccFcviHyqvXmGLwNhi8UoCpB7KilIemVYBanISGCnlyK2xX6MM
 0h1jeBFhL5TiMNlRRr87aptxg2TnNOdHQq92DZTF7zZTVyA7jetGQSIt+Ey+VGmjBWG7
 3RBdX0Foud9hrdjAqhExooy1HJ97Npc0DC/fpHHqRxBkXiLlFEepqvYh/P99MsVkoH0B
 Zo3G6vkvm6aSLLdPj3nw4Wc4VhJtbSGtUEz2UzTISrVGWdnNRV0uIklf3oAs8op1sMfA iQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk53haf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 06:11:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL6B3Md012882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 06:11:03 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 22:10:57 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 1/2] remoteproc: elf_loader: Update resource table name check
Date:   Wed, 21 Dec 2022 11:40:32 +0530
Message-ID: <1671603033-4359-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671603033-4359-1-git-send-email-quic_srivasam@quicinc.com>
References: <1671603033-4359-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y315FuH7b539WBAQ_5YBIQ2ri_IgeJdG
X-Proofpoint-ORIG-GUID: Y315FuH7b539WBAQ_5YBIQ2ri_IgeJdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_02,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the way of checking resource table name with prefix substring search
instead of complete string search.

In general, Qualcomm DSP binary is prepared by combining different ELFs'.
Hence, section header name (e.g. .resource_table), appended with ELF name
to differentiate with same section(e.g. resource_table.ac_bin_process) of
different ELFs'.

Example readelf output of DSP binary:
    [60] .start.ac_bin_process PROGBITS
    [61] .resource_table.ac_bin_process PROGBITS
    [62] .comment.ac_bin_process PROGBITS

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 5a412d7..77330d6 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firmware *fw)
 		u64 offset = elf_shdr_get_sh_offset(class, shdr);
 		u32 name = elf_shdr_get_sh_name(class, shdr);
 
-		if (strcmp(name_table + name, ".resource_table"))
+		if (!strstarts(name_table + name, ".resource_table"))
 			continue;
 
 		table = (struct resource_table *)(elf_data + offset);
-- 
2.7.4


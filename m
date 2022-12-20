Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FB651C14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiLTICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiLTIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:01:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C39FDD;
        Tue, 20 Dec 2022 00:01:54 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK6nRe7000411;
        Tue, 20 Dec 2022 08:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6NlU0taGmDKGhSDmfusS3A6AwhgU5AzHLL0TbVxx3y8=;
 b=LBiAyRxOq+wShjttZkb/yKs2YRUPyqgAb6X56whyJilkmBHdh2h8CLopMEDbEfKbitJp
 1sULY30ajCX82WEi0IrNTHcQZ8xiVHXqdcpwKw125tOlOSzokqNyhKiCad8C5ePhAZMP
 f6iTrrtmMyiMK1tg89LxusBMePQtRM3SjYac4rcMoEhnI6ywwzV4pccJ7u0HxP+nDHTO
 /Bq2v5OGwQjZKAmflAGWzvUAByj4/D9KufrSOPjyHAN/NHWdChEsjKmr7chsbqPkzgP+
 04KbLDNpN3IBVL+O7ZgCA2KkY2MAiS8EkOU9w32/oSEcNwKQSSzNH0hxWWvJ1Swe2AXr KQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk83xr5xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 08:01:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BK81flc013626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 08:01:41 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 00:01:35 -0800
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
Subject: [PATCH v3 1/2] remoteproc: elf_loader: Update resource table name check
Date:   Tue, 20 Dec 2022 13:31:08 +0530
Message-ID: <1671523269-21154-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671523269-21154-1-git-send-email-quic_srivasam@quicinc.com>
References: <1671523269-21154-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AtjWM_zcEmGoh35Etfq85tGi6vttd2v6
X-Proofpoint-GUID: AtjWM_zcEmGoh35Etfq85tGi6vttd2v6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the way of checking resource table name with prefix
substring search instead of complete string search.
In general Qualcomm DSP binary is prepared by combining different ELFs',
hence section header name (e.g. .resource_table), appended with ELF name
to differentiate with same section(e.g. resource_table.ac_bin_process) of
different ELFs'.
Example readelf output of DSP binary:
    [60] .start.ac_bin_process PROGBITS
    [61] .resource_table.ac_bin_process PROGBITS
    [62] .comment.ac_bin_process PROGBITS

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD3B6B17AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCIALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCIALH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:11:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A78464B26;
        Wed,  8 Mar 2023 16:10:55 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328LF1ie016728;
        Thu, 9 Mar 2023 00:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=rNLrrlMgSthYZSNQMxkyx8RMfeigfzLRn4ugAGBWPGk=;
 b=NxHJW+wmo5itMpteqAUInQI8yFvrpYHarueGUghs9sNqf7y0YKWz5414W3ZBsxm/WNMz
 81+QvhoDMc3K0BejGAlz7Vvh4DlklKV68BdQZbypAZv5PdCyWcPI9VDbp2TxbzZLRuB5
 eh4PPIQ0LuOjynH66onPbF74xE0+OiDeJtI5HOHv8ET5eO0T0zs3Ymz+wD16KyF5sCVu
 EvuL5ylFhTIUk4FwWWt1XInseblhI+xRqBUQajW3/wC3HmoeCLKfG3LigvnBUjOBphgk
 iYJV5Fi99R4YBVDcu8UQSt6KQvCIfg1AazQSYcYAD4n4/WDvXUw84GpLmG3Uafojq+23 MA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6v2dsbqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 00:10:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3290Amlj031952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 00:10:48 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 16:10:47 -0800
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Gokul krishna Krishnakumar" <quic_gokukris@quicinc.com>
Subject: [PATCH v1 1/1] remoteproc: qcom: pas: Coredump elf class to elf64
Date:   Wed, 8 Mar 2023 16:10:35 -0800
Message-ID: <20230309001035.24024-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hhi50YcROyrGqtOrx8PfDfvsLeVuk1mI
X-Proofpoint-ORIG-GUID: hhi50YcROyrGqtOrx8PfDfvsLeVuk1mI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303090000
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a new initialization param which modifies the elf
class accordingly. Some of the subsystem dump analysis tools need
the elf class to be elf64.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 0871108fb4dc..17ce3177be7b 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -39,6 +39,7 @@ struct adsp_data {
 	int pas_id;
 	int dtb_pas_id;
 	unsigned int minidump_id;
+	bool uses_elf64;
 	bool auto_boot;
 	bool decrypt_shutdown;
 
@@ -681,7 +682,10 @@ static int adsp_probe(struct platform_device *pdev)
 	}
 
 	rproc->auto_boot = desc->auto_boot;
-	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
+	if (desc->uses_elf64)
+		rproc_coredump_set_elf_info(rproc, ELFCLASS64, EM_NONE);
+	else
+		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
 	adsp = (struct qcom_adsp *)rproc->priv;
 	adsp->dev = &pdev->dev;
@@ -1126,6 +1130,7 @@ static const struct adsp_data sm8550_adsp_resource = {
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
 	.minidump_id = 5,
+	.uses_elf64 = true,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
@@ -1145,6 +1150,7 @@ static const struct adsp_data sm8550_cdsp_resource = {
 	.pas_id = 18,
 	.dtb_pas_id = 0x25,
 	.minidump_id = 7,
+	.uses_elf64 = true,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -1165,6 +1171,7 @@ static const struct adsp_data sm8550_mpss_resource = {
 	.pas_id = 4,
 	.dtb_pas_id = 0x26,
 	.minidump_id = 3,
+	.uses_elf64 = true,
 	.auto_boot = false,
 	.decrypt_shutdown = true,
 	.proxy_pd_names = (char*[]){
-- 
2.39.2


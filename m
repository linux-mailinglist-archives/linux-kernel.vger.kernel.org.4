Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63566B1654
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCHXOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCHXNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:13:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F446425A;
        Wed,  8 Mar 2023 15:13:51 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328NBm1H020804;
        Wed, 8 Mar 2023 23:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jBAYZfIeJ8Uolzed/I2yJ1h25q0GwuqHlg0k3NuZX4M=;
 b=CBkTRHIwJMBfpgbiI3RXTHvV965rtzNjNPbv2DflQSbtpJDXLgZV/XuxnD2owqG27LYY
 dfeYfxYzO/F9WicXvWXbl7149BmTZ4e1xsnEqF+wzrysDjWeqg2MSRllobwh1AfsQfIn
 90rMS1E9XEDXHlDGq71vYzyQcbNIjlqWjZ5BaDvv1rvHe/QqND9ngnhiIkcDgIohyYmB
 L0yYn8dRPgfk9MIwgWisjNg6EYktsOGC9sexa9aegMUll35i6O1NHn6WhjM6FYNQ/f1f
 m/z4XXniaxpPG44bycNcWIOytg3mA8187RsoPg9vToOh1iNRD1aTs2FGOX+sFWWMTn32 og== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6vrms6h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:13:38 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328NDb8L024779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 23:13:37 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 15:13:36 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, <linux-scsi@vger.kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] scsi: ufs: mcq: Use active_reqs to check busy in clock scaling
Date:   Wed, 8 Mar 2023 15:13:23 -0800
Message-ID: <a24e0d646aac70eae0fc5e05fac0c58bb7e6e680.1678317160.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kgcxh9hOInDNsfunLGwsh6L7g2-HGXmG
X-Proofpoint-GUID: kgcxh9hOInDNsfunLGwsh6L7g2-HGXmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi Circular Queue doesn't use outstanding_reqs.
But the ufs clock scaling functions use outstanding_reqs to
determine if there're requests pending. When MCQ is enabled
this check always returns false.

Hence use active_reqs to check if there're pending requests.

Fixes: eacb139b77ff ("scsi: ufs: core: mcq: Enable multi-circular queue")
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

--
v1 -> v2:
 - Added a Fixes tag as suggested by Mani
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 172d25fef740..c6b35123c83b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1500,7 +1500,7 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	scaling->window_start_t = curr_t;
 	scaling->tot_busy_t = 0;
 
-	if (hba->outstanding_reqs) {
+	if (scaling->active_reqs) {
 		scaling->busy_start_t = curr_t;
 		scaling->is_busy_started = true;
 	} else {
@@ -2118,7 +2118,7 @@ static void ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->clk_scaling.active_reqs--;
-	if (!hba->outstanding_reqs && scaling->is_busy_started) {
+	if (!scaling->active_reqs && scaling->is_busy_started) {
 		scaling->tot_busy_t += ktime_to_us(ktime_sub(ktime_get(),
 					scaling->busy_start_t));
 		scaling->busy_start_t = 0;
-- 
2.7.4


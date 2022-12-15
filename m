Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE264D573
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLODHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiLODHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:07:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690152151;
        Wed, 14 Dec 2022 19:07:02 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF1KKbs008132;
        Thu, 15 Dec 2022 03:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=J4V3Elx6TUxOXP5H0cUKYVX2ik/BmvicGkEWC1wVHIw=;
 b=L4qutq08TVRW1ArcUoBaVEYXTdEJbenDU0dlyBbzZkBmv0tlBbnD9T1sR4VjhsR24ahB
 DmAayjaTh8NYbgOS4vEoIaNZY8MHbf16Ml9KAzA/KjfEQa6avESR+ZRBgpK4P1O5Q6vp
 vo2gKjFV/rHJ7irf+xNjEriGytFfmoIhpdVyanXC7RlFcNFGQJ+cE4LJq72YsvXdIrxe
 jnWwuJUO1yBH/lfRjMnpsCYiCMQz6+YHVFMwk6ATR8Vzwy5zqUMGok0zO9UWiMYGR945
 q5sbnqNzmhDGX6bwOnXDwtKcz9vNnMkrUpLQwXu982gLiBhz9NnKgygDHINWpbKJuNeu JA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rkk2kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 03:06:47 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2BF36kiK003281;
        Thu, 15 Dec 2022 03:06:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3mf84afmeu-1;
        Thu, 15 Dec 2022 03:06:46 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BF36jc3003274;
        Thu, 15 Dec 2022 03:06:45 GMT
Received: from stor-presley.qualcomm.com (wsp769891wss.qualcomm.com [192.168.140.85] (may be forged))
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 2BF36j6Q003273;
        Thu, 15 Dec 2022 03:06:45 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 7A5FF20DB9; Wed, 14 Dec 2022 19:06:45 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Can Guo <quic_cang@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] ufs: core: Add Event Specific Interrupt configuration vendor specific ops
Date:   Wed, 14 Dec 2022 19:06:20 -0800
Message-Id: <1671073583-10065-2-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671073583-10065-1-git-send-email-quic_cang@quicinc.com>
References: <1671073583-10065-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6xb9QM55TSW3DImuz7vet65zswn_yJ-2
X-Proofpoint-GUID: 6xb9QM55TSW3DImuz7vet65zswn_yJ-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_12,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150019
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Event Specific Interrupt message format is not defined in UFSHCI JEDEC
specs, and the ESI handling highly depends on how the format is designed,
hence add a vendor specific ops such that SoC vendors can configure their
own ESI handlers. If ESI vops is not provided or returning error, go with
the legacy (central) interrupt way.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd-priv.h | 8 ++++++++
 drivers/ufs/core/ufshcd.c      | 5 +++++
 include/ufs/ufshcd.h           | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index ff03aa5..802029e 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -276,6 +276,14 @@ static inline int ufshcd_vops_get_outstanding_cqs(struct ufs_hba *hba,
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_esi)
+		return hba->vops->config_esi(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e9d6891..3762dca 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8375,6 +8375,11 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 
 static void ufshcd_config_mcq(struct ufs_hba *hba)
 {
+	int ret;
+
+	ret = ufshcd_mcq_vops_config_esi(hba);
+	dev_info(hba->dev, "ESI %sconfigured\n", ret ? "is not " : "");
+
 	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
 	ufshcd_mcq_make_queues_operational(hba);
 	ufshcd_mcq_config_mac(hba, hba->nutrs);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index f20557b..7f0139b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -302,6 +302,7 @@ struct ufs_pwr_mode_info {
  * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
  * @op_runtime_config: called to config Operation and runtime regs Pointers
  * @get_outstanding_cqs: called to get outstanding completion queues
+ * @config_esi: called to config Event Specific Interrupt
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -345,6 +346,7 @@ struct ufs_hba_variant_ops {
 	int	(*op_runtime_config)(struct ufs_hba *hba);
 	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
 				       unsigned long *ocqs);
+	int	(*config_esi)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
-- 
2.7.4


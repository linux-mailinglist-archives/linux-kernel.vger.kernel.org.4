Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BFD74FC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGLBUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:20:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551695;
        Tue, 11 Jul 2023 18:20:30 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C0tvxw013641;
        Wed, 12 Jul 2023 01:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ecm53VHjIbaUGeOpbpCY1TiL/V6mPxHJuJzuZw6r5Lk=;
 b=U8ZLXKlXiJ2Mu0Q5eYnBee595LEQZx/oFxzJA73Yb7hLnBqPYiDIhIpEe/NkyaCTp4Vf
 yhGWuuBg5jswBsOfx5kukvqvp1vsYk7oFSq3qubTCzFAM0iyTz/X5+Bhxg1X1rD2xXeh
 75BDuw44Y64BwGICYVNUtyVaxyG6NFMxXlv7YfuzDFvH/BBaA50TbRQBOvdihNnJ/Htl
 ZfYgVuNg++KE2cOqV9wta4J1i+SGB1M2Dk9buCqb4lqRcWTrJtdqdsGgIhrlmHNNjp/c
 ELueNXHUMx3xso/Jxs76dEIClx3HVquIGaVAbGEAS1dbnWa5wMG1zd1ASrOoi8xh2/Ew iQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rseqprb1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 01:20:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C1KKwQ014215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 01:20:20 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 18:20:19 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/5] drm/msm/dpu: use dpu core's major version to enable data compress
Date:   Tue, 11 Jul 2023 18:20:00 -0700
Message-ID: <20230712012003.2212-3-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712012003.2212-1-quic_abhinavk@quicinc.com>
References: <20230712012003.2212-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uire1H8nl1GfW9m5sCK3EWLpdewXbhZv
X-Proofpoint-ORIG-GUID: uire1H8nl1GfW9m5sCK3EWLpdewXbhZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a feature bit to decide whether to enable data
compress or not for DSC use-cases, use dpu core's major version
instead by assigning the enable_compression op based on the
dpu core's major version.

To make this possible pass the struct dpu_mdss_version to
dpu_hw_intf_init().

This will avoid defining feature bits for every bit level details of
registers.

changes in v5:
	- none

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h | 3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 5b0f6627e29b..d766791438e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -523,7 +523,7 @@ static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
 }
 
 static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
-		unsigned long cap)
+		unsigned long cap, const struct dpu_mdss_version *mdss_rev)
 {
 	ops->setup_timing_gen = dpu_hw_intf_setup_timing_engine;
 	ops->setup_prg_fetch  = dpu_hw_intf_setup_prg_fetch;
@@ -543,12 +543,12 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
 		ops->disable_autorefresh = dpu_hw_intf_disable_autorefresh;
 	}
 
-	if (cap & BIT(DPU_INTF_DATA_COMPRESS))
+	if (mdss_rev->core_major_ver >= 7)
 		ops->enable_compression = dpu_hw_intf_enable_compression;
 }
 
 struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
-		void __iomem *addr)
+		void __iomem *addr, const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_intf *c;
 
@@ -569,7 +569,7 @@ struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
 	 */
 	c->idx = cfg->id;
 	c->cap = cfg;
-	_setup_intf_ops(&c->ops, c->cap->features);
+	_setup_intf_ops(&c->ops, c->cap->features, mdss_rev);
 
 	return c;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 99e21c4137f9..3b5f18dbcb4b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -127,9 +127,10 @@ struct dpu_hw_intf {
  * interface catalog entry.
  * @cfg:  interface catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
+ * @mdss_rev: dpu core's major and minor versions
  */
 struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
-		void __iomem *addr);
+		void __iomem *addr, const struct dpu_mdss_version *mdss_rev);
 
 /**
  * dpu_hw_intf_destroy(): Destroys INTF driver context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index e333f4eeafc1..4a53e2c931d6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -161,7 +161,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_intf *hw;
 		const struct dpu_intf_cfg *intf = &cat->intf[i];
 
-		hw = dpu_hw_intf_init(intf, mmio);
+		hw = dpu_hw_intf_init(intf, mmio, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed intf object creation: err %d\n", rc);
-- 
2.40.1


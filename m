Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67C748046
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGEI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGEI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:59:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8510E2;
        Wed,  5 Jul 2023 01:59:15 -0700 (PDT)
X-UUID: 34d824de1b1211ee9cb5633481061a41-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vepb8sQgZ1ddPhURr2IJj8dJ6RrdgtEMpT1it/FOgsE=;
        b=guQAvCmvZTHcNsnjaFWvCYu214Rw+EOYun2WKKp0zGndtRTNPXBGAJVR29I2OSVsKfrNdkscxgO/Kbuwy3yGNLh5fvLMlVw/JHbm/9dTCEwrTqMtXYiLNsQ72NmFnlq3N0ACMgSVkdN7u6nhYv2LvFboYSkB369hubgA/ouWTT8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:016ed7f0-6679-4371-b73b-b98c374880ab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.27,REQID:016ed7f0-6679-4371-b73b-b98c374880ab,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:01c9525,CLOUDID:5cc5e20d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230705163748ZVIUNA4A,BulkQuantity:1,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 34d824de1b1211ee9cb5633481061a41-20230705
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <chung-kai.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 739156038; Wed, 05 Jul 2023 16:59:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 16:59:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 16:59:09 +0800
From:   Chungkai Yang <Chung-kai.Yang@mediatek.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Chung-kai.Yang@mediatek.com>, <ccj.yeh@mediatek.com>
Subject: [PATCH v3] PM: QoS: Restore support for default value on frequency QoS
Date:   Wed, 5 Jul 2023 16:59:07 +0800
Message-ID: <20230705085907.30880-1-Chung-kai.Yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM_QOS_DEFAULT_VALUE case is not covered.

Commit 8d36694245f2 ("PM: QoS: Add check to make sure CPU freq is
non-negative") makes sure CPU freq is non-negative to avoid negative
value converting to unsigned data type. However, when the value is
PM_QOS_DEFAULT_VALUE, pm_qos_update_target specifically uses
c->default_value which is set to FREQ_QOS_MIN/MAX_DEFAULT_VALUE when
cpufreq_policy_alloc is executed, for this case handling.

Adding check for PM_QOS_DEFAULT_VALUE to let default setting work will
fix this problem.

Signed-off-by: Chungkai Yang <Chung-kai.Yang@mediatek.com>

---
V2 -> V3: Added helper function to avoid duplicating the value check.
V1 -> V2: Checked both freq_qos_add/update_request.

Link: https://lore.kernel.org/lkml/20230626035144.19717-1-Chung-kai.Yang@mediatek.com/
Link: https://lore.kernel.org/lkml/20230627071727.16646-1-Chung-kai.Yang@mediatek.com/
Link: https://lore.kernel.org/lkml/CAJZ5v0gxNOWhC58PHeUhW_tgf6d1fGJVZ1x91zkDdht11yUv-A@mail.gmail.com/
---
 kernel/power/qos.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index af51ed6d45ef..782d3b41c1f3 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -426,6 +426,11 @@ late_initcall(cpu_latency_qos_init);
 
 /* Definitions related to the frequency QoS below. */
 
+static inline bool freq_qos_value_invalid(s32 value)
+{
+	return value < 0 && value != PM_QOS_DEFAULT_VALUE;
+}
+
 /**
  * freq_constraints_init - Initialize frequency QoS constraints.
  * @qos: Frequency QoS constraints to initialize.
@@ -531,7 +536,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(qos) || !req || value < 0)
+	if (IS_ERR_OR_NULL(qos) || !req || freq_qos_value_invalid(value))
 		return -EINVAL;
 
 	if (WARN(freq_qos_request_active(req),
@@ -563,7 +568,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req || new_value < 0)
+	if (!req || freq_qos_value_invalid(new_value))
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),
-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E873D69F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFZDxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFZDxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:53:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF01AA;
        Sun, 25 Jun 2023 20:53:05 -0700 (PDT)
X-UUID: f0465d3e13d411eeb20a276fd37b9834-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mRiuw7c2/R3mbVVNMl5h34gdIqPkRMO4ezUnsqP/NDA=;
        b=fevVfYax5z8/9G08r/4GVPZIEYXxqFPOXuw3v2MVKG5TjV6G5oGlTaPCUBScr0QKn75Xf4FcW0XKYWbC8/fqOA0OT6eS1QydcKGaxUKznSHPZ/CX2PLJ63zVhXOkMew93qecE/RDNrmHWSvtireZxeDDGP3ImlIwGUlN58iNZ/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:b4c0484f-2e91-4472-bf31-868f90061ff9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:2dd6723f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f0465d3e13d411eeb20a276fd37b9834-20230626
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chung-kai.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 771780459; Mon, 26 Jun 2023 11:52:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 11:52:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 11:52:56 +0800
From:   Chungkai Yang <Chung-kai.Yang@mediatek.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Chung-kai.Yang@mediatek.com>, <ccj.yeh@mediatek.com>
Subject: [PATCH] PM: QoS: Restore support for default value on frequency QoS
Date:   Mon, 26 Jun 2023 11:51:44 +0800
Message-ID: <20230626035144.19717-1-Chung-kai.Yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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
 kernel/power/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index af51ed6d45ef..97e1d9346cde 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req || new_value < 0)
+	if (!req || (new_value < 0 && new_value != PM_QOS_DEFAULT_VALUE))
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),
-- 
2.18.0


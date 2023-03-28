Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E606CBCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjC1Kib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1Ki3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:38:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF976618A;
        Tue, 28 Mar 2023 03:38:27 -0700 (PDT)
X-UUID: a8c76c08cd5411edb6b9f13eb10bd0fe-20230328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ai6R3h3Gt7He0ZTgxGjiKPub5Kfaf2GdPE7RG+XypA0=;
        b=YVcvFOqzp1V1eh/b4ox0CmD+Z9rn26O6g/cy5ifGLPDsQCbmY9zuKPgEvKTOHpKmbR2oX+kI32FKcSt+kSXrZ3S689FQph9mLOAPOWcRwiW8z83oznWeOPO5IfbHduhk0UdLo7S4jQgXAI2OdW85Igw78qtzbehI+GgV0O0eMLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:5232098e-aab8-4b46-95d6-757850417fc7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:5232098e-aab8-4b46-95d6-757850417fc7,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:7ec92af7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:23032818382341E2M9CC,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a8c76c08cd5411edb6b9f13eb10bd0fe-20230328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1506048750; Tue, 28 Mar 2023 18:38:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 28 Mar 2023 18:38:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 28 Mar 2023 18:38:19 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>, <mason.zhang@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Subject: [PATCH 1/2] scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
Date:   Tue, 28 Mar 2023 18:37:52 +0800
Message-ID: <20230328103801.11198-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR is introduced for plaforms that
implement different interrupt topology from UFSHCI 4.0 spec.
Some platform raise per hw queue interrupt in addition to
CQES (traditional) when ESI is disabled.

Enable this quirk will disable CQES and use only per hw queue
interrupt.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 8 ++++++--
 include/ufs/ufshcd.h      | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index acae4e194ec4..1e1271aca1f2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8493,11 +8493,15 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 static void ufshcd_config_mcq(struct ufs_hba *hba)
 {
 	int ret;
-
+	u32 intrs;
 	ret = ufshcd_mcq_vops_config_esi(hba);
+
 	dev_info(hba->dev, "ESI %sconfigured\n", ret ? "is not " : "");
 
-	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
+	intrs = (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_INTR) ?
+		(UFSHCD_ENABLE_MCQ_INTRS & ~MCQ_CQ_EVENT_STATUS) : UFSHCD_ENABLE_MCQ_INTRS;
+
+	ufshcd_enable_intr(hba, intrs);
 	ufshcd_mcq_make_queues_operational(hba);
 	ufshcd_mcq_config_mac(hba, hba->nutrs);
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 25aab8ec4f86..7bb9e1a17154 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -616,6 +616,13 @@ enum ufshcd_quirks {
 	 * to reinit the device after switching to maximum gear.
 	 */
 	UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH       = 1 << 19,
+
+	/*
+	 * Some platform raises interrupt (per queue) in addition to
+	 * CQES (traditional) when ESI is disabled.
+	 * Enable this quirk will disable CQES and use per queue interrupt.
+	 */
+	UFSHCD_QUIRK_MCQ_BROKEN_INTR			= 1 << 20,
 };
 
 enum ufshcd_caps {
-- 
2.18.0


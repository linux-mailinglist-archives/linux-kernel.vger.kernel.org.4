Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06A658911
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiL2DH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiL2DH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:07:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDAC740;
        Wed, 28 Dec 2022 19:07:24 -0800 (PST)
X-UUID: 27deb0d81236403f95e38ab3de441de5-20221229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5APWQ/KbXgNbszB/TlGiUT+18qB2uNXqqSohrW/gfYk=;
        b=M+SEdy1odN/D7M0XvmrsTCkZL4+LGihKK/MHy+ImExNMtwEhw8rg4WxKkSYwEICe3F3L1UooFt0rF8nasF5GuH0ffEqBXno2BaUe19JG5Go0PILseVDes41t5TOmH2PGtUBlcpZ0K9OzW9ZXSD7OiReaaRtKgMiGJ+WTwxRyMY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9876b4b4-a47e-48d0-b3ca-1651564b39dc,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:6d3b40f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 27deb0d81236403f95e38ab3de441de5-20221229
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1651047375; Thu, 29 Dec 2022 11:07:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 29 Dec 2022 11:07:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 29 Dec 2022 11:07:17 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-scsi@vger.kernel.org>
CC:     <peter.wang@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <naomi.chu@mediatek.com>,
        <stanley.chu@mediatek.com>, <wsd_upstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH 1/1] ufs: update the timeout timer after resume
Date:   Thu, 29 Dec 2022 11:06:45 +0800
Message-ID: <20221229030645.11558-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tags allocation is limited by the number of active queues and a
queue is marked as inactive by the queue timeout worker after up to 30Hz
by default.

Therefore, tags for the general I/O may be limited to half of the max
depth up to 30HZ after resume. To make sure the ufs request queue for pm
usage can be inactive immediately, trigger the timeout worker to release
the tag set.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e18c9f4463ec..c77570caa3a8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8842,6 +8842,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 		hba->curr_dev_pwr_mode = pwr_mode;
 	}
 
+	mod_timer(&sdp->request_queue->timeout, 0);
 	scsi_device_put(sdp);
 	hba->host->eh_noresume = 0;
 	return ret;
-- 
2.18.0


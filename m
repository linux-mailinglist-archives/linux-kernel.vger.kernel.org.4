Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07AE6A952A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCCK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCCK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:28:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289F13D48;
        Fri,  3 Mar 2023 02:28:08 -0800 (PST)
X-UUID: 125c23a8b9ae11ed945fc101203acc17-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XppWj95E8cWYPktwotHMP9jFVzh+Z+y5iJrUNDY18Rg=;
        b=qGB+y1EA8+PTYFtLW4yI6RhdYnlSvAEc6Bsaoy2RNXiVlEDGf4U7axqz9cMRrJsc/GZLLaAZwGDitFUA/c4yNHgC56+PoAriuIuq4xnyTig0oOtpDNIbB56aDVrOBC2ygjMrnUcGYs+FD7z7Aqb0OL3gCaRIMDGj8nb0PQDc7hU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:eed52435-2561-4ced-9402-4f7c22ac1c8f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.20,REQID:eed52435-2561-4ced-9402-4f7c22ac1c8f,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:25b5999,CLOUDID:7788adf4-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:2303031828037D7ZO5T1,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 125c23a8b9ae11ed945fc101203acc17-20230303
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 862682828; Fri, 03 Mar 2023 18:28:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 18:27:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 18:27:58 +0800
From:   Jason-ch Chen <jason-ch.chen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        jason-ch chen <Jason-ch.Chen@mediatek.com>
Subject: [PATCH] remoteproc: mediatek: Dereferencing a pointer that might be NULL
Date:   Fri, 3 Mar 2023 18:27:51 +0800
Message-ID: <20230303102751.9374-1-jason-ch.chen@mediatek.com>
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

From: jason-ch chen <Jason-ch.Chen@mediatek.com>

The res might be NULL when calling resource_size.

Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
---
 drivers/remoteproc/mtk_scp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index eacdf241f4ef..863d18f63f58 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -829,6 +829,9 @@ static int scp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, scp);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
+	if (!res)
+		return -ENODEV;
+
 	scp->sram_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR((__force void *)scp->sram_base)) {
 		dev_err(dev, "Failed to parse and map sram memory\n");
-- 
2.37.3


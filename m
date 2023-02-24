Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9A6A14FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBXCiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBXCiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:38:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E2199FA;
        Thu, 23 Feb 2023 18:38:17 -0800 (PST)
X-UUID: 47fa8012b3ec11eda06fc9ecc4dadd91-20230224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; bh=B4U1+Q/UYoJiKUsQ/RT3eOwBmSrlf5qH2DnCuR/+E3Y=;
        b=DVI9z2vNQ3XpIsjTjW+N8kG70w0c0zrcAqXdQbyRkG7WJVZIvyw5yHOCNkJ3VZn7REXB3AQvF7JcPi6rtZ+2W6/gRfQmOOOF5Fkb1bpqRYG4OO+2YEAY4fWlmRqjsGQ3lsDbYmQiv5KzxpD4NKTtnYssKM3wWC16bmDL65m0zBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:403977e8-6d1a-4c0d-9f0a-0a72fd6328a7,IP:0,U
        RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-30
X-CID-META: VersionHash:25b5999,CLOUDID:e93e6db1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 47fa8012b3ec11eda06fc9ecc4dadd91-20230224
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <weichen.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1515731948; Fri, 24 Feb 2023 10:38:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 24 Feb 2023 10:38:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 24 Feb 2023 10:38:09 +0800
From:   Weichen Chen <weichen.chen@mediatek.com>
To:     <weichen.chen@mediatek.com>, <yt.shen@mediatek.com>,
        <darren.chen@mediatek.com>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <angelogioacchino.delregno@collabora.com>,
        <matthias.bgg@gmail.com>, <gpiccoli@igalia.com>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] pstore/ram: Fix crash when setting number of cpus to an odd number
Date:   Fri, 24 Feb 2023 10:36:32 +0800
Message-ID: <20230224023632.6840-1-weichen.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of cpu cores is adjusted to 7 or other odd numbers,
the zone size will become an odd number.
The address of the zone will become:
    addr of zone0 = BASE
    addr of zone1 = BASE + zone_size
    addr of zone2 = BASE + zone_size*2
    ...
The address of zone1/3/5/7 will be mapped to non-alignment va.
Eventually crashes will occur when accessing these va.

So, use ALIGN_DOWN() to make sure the zone size is even
to avoid this bug.

Signed-off-by: Weichen Chen <weichen.chen@mediatek.com>
---
 fs/pstore/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66dbe5f39..fc57ac97e506 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -528,6 +528,7 @@ static int ramoops_init_przs(const char *name,
 	}
 
 	zone_sz = mem_sz / *cnt;
+	zone_sz = ALIGN_DOWN(zone_sz, 2);
 	if (!zone_sz) {
 		dev_err(dev, "%s zone size == 0\n", name);
 		goto fail;
-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C1682470
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAaGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaGcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:32:21 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1AC36467
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 22:32:20 -0800 (PST)
X-UUID: 016ddd10a13111eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gfOqWGWbqteN5psBJELTgrd0wVgMuYJEk7v1sLB2r3c=;
        b=EmeyFqQEGvSyO1agWudyGOX39L6kPSMbVCy5GwksUJM9hOr9TMAkvG5dud3bwDQ5hUS3ffNwmhHOnGxhb6jcaPRtELtOp/tuVgxUG43cvJuI29VFMZkCdb6v71hF7P8UFYBxDjGKjRgKWvh6o+C2/l6z5jijjHv1JlnlA1V1ELw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:53d66240-c71f-46dc-84d5-b63f59adab8b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:646efef6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 016ddd10a13111eda06fc9ecc4dadd91-20230131
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 524549919; Tue, 31 Jan 2023 14:32:16 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 31 Jan 2023 14:32:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 14:32:15 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
CC:     <chinwen.chang@mediatek.com>, <andrew.yang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mm/gup: Add folio to list when folio_isolate_lru() succeed
Date:   Tue, 31 Jan 2023 14:32:06 +0800
Message-ID: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
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

If we call folio_isolate_lru() successfully, we will get
return value 0. We need to add this folio to the
movable_pages_list.

Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f3d2cccb89f8..918c364d01ac 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1914,7 +1914,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			drain_allow = false;
 		}
 
-		if (!folio_isolate_lru(folio))
+		if (folio_isolate_lru(folio))
 			continue;
 
 		list_add_tail(&folio->lru, movable_page_list);
-- 
2.18.0


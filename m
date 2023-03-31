Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9F6D1C51
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjCaJ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjCaJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:28:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679C1D2F7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:28:23 -0700 (PDT)
X-UUID: 394a635ecfa611edb6b9f13eb10bd0fe-20230331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=woMdJmPGwqbmkNZP2IiNYeJBaZIPhitmDLlx3uTqBlE=;
        b=aJ1B8PIFPT6L2CEJH+H2McTj79ic49HEN9zKuRjrEWEW2TulJC/MhTfzn+hSoARpY7l9/odJbik1jr68/Fc9DACsaUnp+FEHbNP0CmHXqOdF6a2hVyTxdm+WlbagcJCaSejPY5CSlRCmqSH3SgNlzeI0eA1WL3tieFYq8dsvZLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:cabbaf4d-e56f-428d-88a6-ed4944ada1e1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:cabbaf4d-e56f-428d-88a6-ed4944ada1e1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:4cd2152a-564d-42d9-9875-7c868ee415ec,B
        ulkID:230331172717Z0H6RC8V,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 394a635ecfa611edb6b9f13eb10bd0fe-20230331
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1312685728; Fri, 31 Mar 2023 17:27:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 31 Mar 2023 17:27:13 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 31 Mar 2023 17:27:12 +0800
From:   Bo Ye <bo.ye@mediatek.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        xiongping1 <xiongping1@xiaomi.com>,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
CC:     <yongdong.zhang@mediatek.com>, <peng.zhou@mediatek.com>,
        <browse.zhang@mediatek.com>, <light.hsieh@mediatek.com>,
        Qilin Tan <qilin.tan@mediatek.com>, Bo Ye <bo.ye@mediatek.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] f2fs: add __pack attribute for extent_info
Date:   Fri, 31 Mar 2023 17:26:57 +0800
Message-ID: <20230331092658.72386-2-bo.ye@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20230331092658.72386-1-bo.ye@mediatek.com>
References: <20230331092658.72386-1-bo.ye@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qilin Tan <qilin.tan@mediatek.com>

Need add __pack for struct extent_info to align to memory
layout of struct rb_entry.

struct rb_entry {
    struct rb_node rb_node;     /* rb node located in rb-tree */
    union {
        struct {
            unsigned int ofs;   /* start offset of the entry */
            unsigned int len;   /* length of the entry */
        };
        unsigned long long key;     /* 64-bits key */
    } __packed;
};

struct extent_info {
    unsigned int fofs;      /* start offset in a file */
    unsigned int len;       /* length of the extent */
    union {
        ...
        /* block age extent_cache */
        struct {
            /* block age of the extent */
            unsigned long long age;
            /* last total blocks allocated */
            unsigned long long last_blocks;
        };
};

The new fields(age, last_blocks) are u64 in change 71644dff4811, it
cause the memory alignment based on 8 bytes in some complier. So the
field fofs and len are alloced with 8 bytes and using the last 4 byts.
Its memory is not aligned with struct rb_entry. the ofs of rb_entry
pointer to a invalid value and cause writing file failed.

struct extent_info's offset should be 12 rather than 16 from the
beginning of struct rb_entry.

The offset dump for the bad case as:
kworker/u16:6: [name:f2fs&]f2fs_lookup_rb_tree_for_insert:MTK_DEBUG: ino=1629 re=0xc675dc08 ofs=0 re->ofs=0, re->len=68 ei=0xc675dc18 ei.fofs=68 ei.len=277

Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
Signed-off-by: Bo Ye <bo.ye@mediatek.com>
Signed-off-by: Qilin Tan <qilin.tan@mediatek.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b0ab2062038a..7c690667a42f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -660,7 +660,7 @@ struct extent_info {
 			unsigned long long last_blocks;
 		};
 	};
-};
+} __packed;
 
 struct extent_node {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-- 
2.17.0


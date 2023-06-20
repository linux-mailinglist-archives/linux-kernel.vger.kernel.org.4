Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAAE736858
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjFTJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjFTJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:51:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A32D47
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:49:17 -0700 (PDT)
X-UUID: a2b429b80f4f11eeb20a276fd37b9834-20230620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KX9Gwg7gwsESAK8OAmogwWn5H1GX62YrEpzhQ8fTwcU=;
        b=QJM8Obn8Uqeo5ucpAsLebBl3A1HRDw7nVlIiG+3O7mFfgW/EBBVlFrzgDbHCw7/x7HJ3GGRu6MfEgUp89VKgOe6leau6E3nM8EyhL6tRCjJQcck159bc7aVTW06xabd5NJg3tCdHgmWEuN2J4p6zRjRmDhm5SESbb0Cw/0nmAkg=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:aee88f55-0a3a-4d72-9773-342c4c662de6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:101
X-CID-INFO: VERSION:1.1.27,REQID:aee88f55-0a3a-4d72-9773-342c4c662de6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:1,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:101
X-CID-META: VersionHash:01c9525,CLOUDID:6dff033f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:23062017484238AIYB81,BulkQuantity:0,Recheck:0,SF:28|16|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_USA,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: a2b429b80f4f11eeb20a276fd37b9834-20230620
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 913572796; Tue, 20 Jun 2023 17:48:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Jun 2023 17:48:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Jun 2023 17:48:38 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <andrew.yang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] scripts/gdb: fix 'lx-lsmod' show the wrong size
Date:   Tue, 20 Jun 2023 17:48:33 +0800
Message-ID: <20230620094834.14688-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'lsmod' shows total core layout size, so we need to
sum up all the sections in core layout in gdb scripts.

/ # lsmod
kasan_test 200704 0 - Live 0xffff80007f640000

Before patch:
(gdb) lx-lsmod
Address            Module                  Size  Used by
0xffff80007f640000 kasan_test             36864  0

After patch:
(gdb) lx-lsmod
Address            Module                  Size  Used by
0xffff80007f640000 kasan_test            200704  0

Fixes: b4aff7513df3 ("scripts/gdb: use mem instead of core_layout to get the module address")
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/constants.py.in |  3 +++
 scripts/gdb/linux/modules.py      | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 50a92c4e9984..fab74ca9df6f 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -64,6 +64,9 @@ LX_GDBPARSED(IRQ_HIDDEN)
 
 /* linux/module.h */
 LX_GDBPARSED(MOD_TEXT)
+LX_GDBPARSED(MOD_DATA)
+LX_GDBPARSED(MOD_RODATA)
+LX_GDBPARSED(MOD_RO_AFTER_INIT)
 
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 261f28640f4c..84933c4c1083 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -73,11 +73,17 @@ class LxLsmod(gdb.Command):
                 "        " if utils.get_long_type().sizeof == 8 else ""))
 
         for module in module_list():
-            layout = module['mem'][constants.LX_MOD_TEXT]
+            total_size = 0
+            for i in range(constants.LX_MOD_TEXT, constants.LX_MOD_RO_AFTER_INIT + 1):
+                layout = module['mem'][i]
+                if i == constants.LX_MOD_TEXT:
+                    text_addr = str(layout['base']).split()[0]
+                total_size += layout['size']
+
             gdb.write("{address} {name:<19} {size:>8}  {ref}".format(
-                address=str(layout['base']).split()[0],
+                address=text_addr,
                 name=module['name'].string(),
-                size=str(layout['size']),
+                size=str(total_size),
                 ref=str(module['refcnt']['counter'] - 1)))
 
             t = self._module_use_type.get_type().pointer()
-- 
2.18.0


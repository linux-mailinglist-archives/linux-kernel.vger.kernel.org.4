Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FC6DA801
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjDGDd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDGDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:33:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF19ECB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:33:51 -0700 (PDT)
X-UUID: 00070134d4f511eda9a90f0bb45854f4-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rKK8gfPQSiSzT2PbEWUauzLFSX/mIJo3ZK6c1RroMIU=;
        b=vAXCt97BToUHUHD3cvPgWfE3/yAqZ4hNaWJWa+IvqEFBI1FBBPi1DULYZ1XKol3eb60U/zaciJeswfjFQrxbGqkyNddqL376FG6EmdaVrpf+9FQsLwnF84NT6w1DUrNJTLz8V21Cr2xXNTK26MlUh6JWS04U5buzkqwm4Ac1u74=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:b4980c4a-dcdf-4ca4-9d92-bdb9894cc6b4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:b4980c4a-dcdf-4ca4-9d92-bdb9894cc6b4,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:a034972a-564d-42d9-9875-7c868ee415ec,B
        ulkID:230407113347AOKI9KG9,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 00070134d4f511eda9a90f0bb45854f4-20230407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 126650876; Fri, 07 Apr 2023 11:33:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 11:33:43 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 11:33:43 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Haibo Li <haibo.li@mediatek.com>, <xiaoming.yu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Alex Sverdlin <alexander.sverdlin@nokia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] ARM:unwind:fix unwind abort for uleb128 case
Date:   Fri, 7 Apr 2023 11:33:41 +0800
Message-ID: <20230407033341.5139-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When unwind instruction is 0xb2,the subsequent instructions
are uleb128 bytes.
For now,it uses only the first uleb128 byte in code.

For vsp increments of 0x204~0x400,use one uleb128 byte like below:
0xc06a00e4 <unwind_test_work>: 0x80b27fac
  Compact model index: 0
  0xb2 0x7f vsp = vsp + 1024
  0xac      pop {r4, r5, r6, r7, r8, r14}

For vsp increments larger than 0x400,use two uleb128 bytes like below:
0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
  Compact model index: 1
  0xb2 0x81 0x01 vsp = vsp + 1032
  0xac      pop {r4, r5, r6, r7, r8, r14}
The unwind works well since the decoded uleb128 byte is also 0x81.

For vsp increments larger than 0x600,use two uleb128 bytes like below:
0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
  Compact model index: 1
  0xb2 0x81 0x02 vsp = vsp + 1544
  0xac      pop {r4, r5, r6, r7, r8, r14}
In this case,the decoded uleb128 result is 0x101(vsp=0x204+(0x101<<2)).
While the uleb128 used in code is 0x81(vsp=0x204+(0x81<<2)).
The unwind aborts at this frame since it gets incorrect vsp.

To fix this,add uleb128 decode to cover all the above case.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 arch/arm/kernel/unwind.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 53be7ea6181b..e5796a5acba1 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -20,7 +20,6 @@
 #warning    Change compiler or disable ARM_UNWIND option.
 #endif
 #endif /* __CHECKER__ */
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/export.h>
@@ -308,6 +307,22 @@ static int unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,
 	return URC_OK;
 }
 
+static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block *ctrl)
+{
+	unsigned long result = 0;
+	unsigned long insn;
+	unsigned long bytes = 0;
+
+	do {
+		insn = unwind_get_byte(ctrl);
+		result |= (insn & 0x7f) << (bytes * 7);
+		bytes++;
+		if (bytes == sizeof(result))
+			break;
+	} while (!!(insn & 0x80));
+
+	return result;
+}
 /*
  * Execute the current unwind instruction.
  */
@@ -361,7 +376,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		if (ret)
 			goto error;
 	} else if (insn == 0xb2) {
-		unsigned long uleb128 = unwind_get_byte(ctrl);
+		unsigned long uleb128 = unwind_decode_uleb128(ctrl);
 
 		ctrl->vrs[SP] += 0x204 + (uleb128 << 2);
 	} else {
-- 
2.25.1


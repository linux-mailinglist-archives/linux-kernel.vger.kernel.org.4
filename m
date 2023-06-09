Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE827291BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbjFIHuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbjFIHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:49:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD630E3;
        Fri,  9 Jun 2023 00:48:51 -0700 (PDT)
X-UUID: 0ee72a36069a11eeb20a276fd37b9834-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8bgwt3YTtRPzBW10jkkA2PfSeU8Lw8ibSj4SfdROJGs=;
        b=eTLWnOMmJHfkR7xzPaNcK0P2kM2zmyETKQl0Z8M35iK0YNmv/VWCUp8JAs7EdWyBOi3KJ/ScBcneyaFd83N7LhtSMwwCQYj7Ddx3SKksun6RWnJBVY1DkvpHlkECl2qYTJFwYmGfv6uA4E5m1ATeJWBTffMg9Vj61peov9fKSM0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:c04f3271-59bb-4866-88c5-f5f664e7a456,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:7699193e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ee72a36069a11eeb20a276fd37b9834-20230609
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 348101938; Fri, 09 Jun 2023 15:48:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 15:48:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 15:48:42 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: mtk-sd: include bitfield header and fix incompatible pointer types
Date:   Fri, 9 Jun 2023 15:48:40 +0800
Message-ID: <20230609074840.4520-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error appeared due to the patch:
364dae3e80a4 "mmc: mtk-sd: reduce CIT for better performance"

drivers/mmc/host/mtk-sd.c: In function 'msdc_cqe_cit_cal':
drivers/mmc/host/cqhci.h:27:41: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]

drivers/mmc/host/mtk-sd.c:2471:3: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
    2471 |                 do_div(hclk_freq, 1000);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
...

This patch corrects the issue.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Fixes: 364dae3e80a4 ("mmc: mtk-sd: reduce CIT for better performance")
---
 drivers/mmc/host/cqhci.h  | 1 +
 drivers/mmc/host/mtk-sd.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index e35c655edefc..1a12e40a02e6 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -5,6 +5,7 @@
 #define LINUX_MMC_CQHCI_H
 
 #include <linux/compiler.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b582f19f82f2..99317fd9f084 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2456,15 +2456,14 @@ static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
 	struct mmc_host *mmc = mmc_from_priv(host);
 	struct cqhci_host *cq_host = mmc->cqe_private;
 	u8 itcfmul;
-	unsigned long hclk_freq;
-	u64 value;
+	u64 hclk_freq, value;
 
 	/*
 	 * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
 	 * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
 	 * Send Status Command Idle Timer (CIT) value.
 	 */
-	hclk_freq = clk_get_rate(host->h_clk);
+	hclk_freq = (u64)clk_get_rate(host->h_clk);
 	itcfmul = CQHCI_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
 	switch (itcfmul) {
 	case 0x0:
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F172F2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbjFNDVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbjFNDUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:20:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC0196
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:20:52 -0700 (PDT)
X-UUID: 7448ce220a6211ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0BfjF76ESE9qlEo/M4tmdgd9Cz9dPTxPRYkOuq+JFp8=;
        b=E0dHYKNdsOaYh3MOAGT2GsvbMcIC2y4EC3dm991DoRjPfVnqEEsaei1f4VWwDKugTbDooNFcZomNtZeGjjbtG4TZAVg/uLYvvmWkhgOU4FIpYA5tRHhgfIbrj4SvqlMq1/b7IrmdagCX1P9qOXQZzcXJaA9oPL6slhV6GqzfgkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:e1dc4df5-48b4-45c3-b398-782a15812266,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.26,REQID:e1dc4df5-48b4-45c3-b398-782a15812266,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:cb9a4e1,CLOUDID:36c55a3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230614112049KEA40V85,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 7448ce220a6211ee9cb5633481061a41-20230614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 680255152; Wed, 14 Jun 2023 11:20:46 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 11:20:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 11:20:45 +0800
From:   Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <wei-chin.tsai@mediatek.com>,
        <mel.lee@mediatek.com>, <ivan.tseng@mediatek.com>,
        Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/3] kernel : process fork/exit: export symbol for fork/exit tracing functions
Date:   Wed, 14 Jun 2023 11:20:33 +0800
Message-ID: <20230614032038.11699-2-Wei-chin.Tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ths Patch, we export symbols for two functions of
"sched_process_fork" and "sched_process_exit" for
process statistics. During the system running,
some process will run in a second and then terminate.
We hope that we can capture those processes' jiffies
information for system performance analysis.

Signed-off-by: Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
---
 kernel/exit.c | 2 ++
 kernel/fork.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index edb50b4c9972..410a3de14e09 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -81,6 +81,8 @@
  */
 static unsigned int oops_limit = 10000;
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_process_exit);
+
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kern_exit_table[] = {
 	{
diff --git a/kernel/fork.c b/kernel/fork.c
index f81985dcc4bd..8fba356fb7c2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -142,6 +142,8 @@ DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_process_fork);
+
 #ifdef CONFIG_PROVE_RCU
 int lockdep_tasklist_lock_is_held(void)
 {
-- 
2.18.0


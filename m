Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4553572A83D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjFJCQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFJCQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:16:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2153AB1;
        Fri,  9 Jun 2023 19:16:16 -0700 (PDT)
X-UUID: c44acd5c073411eeb20a276fd37b9834-20230610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lJdzP3e/EJ/8akimnAn3jpQf6Yqkt7vrJi2eCWPGmic=;
        b=lU7FAtuuuZ2sF25ycR/orqecaotiNtk4NhyUU6GbDsv63p8T6a+2eIMwizLsv5otWatRz+ucAlqJ159v+fZ9FUN+eDEtMfV9eKhjNLHErUjQYYuwOgCEgIE4hQV6nabrqnqpPIASaS3E3ymkPdooh769CjcaIIopWdl1eNvbdH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:48348667-3c65-4f4c-8a25-3362baf08a12,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.26,REQID:48348667-3c65-4f4c-8a25-3362baf08a12,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:cb9a4e1,CLOUDID:9f89f93d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230610101613PUVBU848,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_SNR
X-UUID: c44acd5c073411eeb20a276fd37b9834-20230610
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 464073811; Sat, 10 Jun 2023 10:16:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 10 Jun 2023 10:16:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 10 Jun 2023 10:16:09 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: [PATCH v2 0/2] ufs: mcq: Share first hwq for dev comamnd and IO request
Date:   Sat, 10 Jun 2023 10:15:50 +0800
Message-ID: <20230610021553.1213-1-powen.kao@mediatek.com>
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

v1 -> v2:
- Remove accidentally added ufshcd_add_command_trace() call in
  [PATCH v1 1/2]
- Add Test-by tag for both patch and refactor commit message

Po-Wen Kao (1):
  scsi: ufs: core: Remove dedicated hwq for dev command

Stanley Chu (1):
  scsi: ufs: mcq: Fix the incorrect OCS value for the device command

 drivers/ufs/core/ufs-mcq.c     | 14 ++++----------
 drivers/ufs/core/ufshcd-priv.h |  1 -
 drivers/ufs/core/ufshcd.c      | 14 +++++++++-----
 include/ufs/ufshcd.h           |  1 -
 4 files changed, 13 insertions(+), 17 deletions(-)

--
2.18.0


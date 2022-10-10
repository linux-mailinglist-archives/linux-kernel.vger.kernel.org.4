Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99DA5F9DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiJJLcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiJJLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:32:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50452E69
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:32:05 -0700 (PDT)
X-UUID: a45fdc7430e4437d97ffaee1b1531e2f-20221010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DAyYhCQx/OMHMNkdxNhY+60RJe+vnZJswgdOhohQOOk=;
        b=dIbMuRd8EN8I7NSc7PVq3Z2U9PBifbzYEhI7mkWMwHbm9Nz9EySZhKeToLpgpX3tzbrRUpPyOyJBCzbIaXGMCVJix0CRIhK0dw++CdOsjKaPTaPJ5cXqX60s/p+L6toQAzgCqNbDo6oUI+iE1S7z8v+rNQBQvuo0dyrv5oXrdVU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:52be94ce-fc84-4384-b8e2-53b7df4ca072,IP:0,U
        RL:0,TC:0,Content:76,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:76
X-CID-META: VersionHash:39a5ff1,CLOUDID:5c9f6de1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a45fdc7430e4437d97ffaee1b1531e2f-20221010
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 93331477; Mon, 10 Oct 2022 19:32:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 10 Oct 2022 19:31:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 10 Oct 2022 19:31:59 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v10, 0/4] mailbox: mtk-cmdq: add MT8186 support
Date:   Mon, 10 Oct 2022 16:50:19 +0800
Message-ID: <20221010085023.7621-1-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

base linux-next/master

change since v9:
1. improve register GCE_GCTL_VALUE write method reviewd in v9

Yongqiang Niu (4):
  mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW definition instead of number
  mailbox: mtk-cmdq: add gce software ddr enable private data
  mailbox: mtk-cmdq: add gce ddr enable support flow
  mailbox: mtk-cmdq: add MT8186 support

 drivers/mailbox/mtk-cmdq-mailbox.c | 45 +++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

-- 
2.25.1


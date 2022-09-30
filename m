Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6955F0934
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiI3Kgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiI3Kfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:35:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18312C6BA;
        Fri, 30 Sep 2022 03:25:48 -0700 (PDT)
X-UUID: e43bdcec4eb64344859d615a25a5daba-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Xt2v3fsvVPs1BpqYWYVZtY0Gpjwk0DyXlw8YbTAf0is=;
        b=T++7esW+F/a3tuHULK1ZX5tigXhePJxr7jn2/BW22415HXhO9GAWQNGBKEHr4PerDtEIOAZTtfOTxeariuMq7u/nmirgWjuPKv2gJncg+ZPkU6OaevFaYl1s++xFAc46mFMecrPwoj9zJq3LfMf2aI/o782iQYuycAFn+DcBMq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:022960bf-7236-403c-8251-42932f7d103c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:022960bf-7236-403c-8251-42932f7d103c,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:d676a1a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220930182311G7S9B2B3,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e43bdcec4eb64344859d615a25a5daba-20220930
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 53343771; Fri, 30 Sep 2022 18:23:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 18:23:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Sep 2022 18:23:07 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v1 0/2] Fix error handling for MDP3
Date:   Fri, 30 Sep 2022 18:23:04 +0800
Message-ID: <20220930102306.13201-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series fixes some error handling in MDP3 in response to the bug report
submitted by Dan Carpenter (Message ID = YxB1E00e8D6P4W2e@kili)

Moudy Ho (2):
  media: platform: mtk-mdp3: fix error handling in mdp_cmdq_send()
  media: platform: mtk-mdp3: fix error handling about components
    clock_on

 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 51 ++++++++++---------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 24 ++++++---
 2 files changed, 45 insertions(+), 30 deletions(-)

-- 
2.18.0


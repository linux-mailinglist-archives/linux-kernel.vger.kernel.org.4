Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979A5E87FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiIXDgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiIXDgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:36:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971213746D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:36:12 -0700 (PDT)
X-UUID: 3d933e4b162c48d3a58addce80cda0a2-20220924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yJdS0/iD611Z0qXT//tqsqB6YYs0XIBQmGDntx2ksWQ=;
        b=t9SaBDBg6UcFpiVxMfPQimo0vhQoKcMaEHExFxR7sow8pcG7+5ixGce+pd9AVCGZtdHFFnB0Skwr+sOuYBAOMMZ1TKpKC4rALh938Yo0epM0JyBQCk1zt6VZPrpndOdXUEMHylgmuO4smztYNOucLTppldeXm7/dZKK84TpaYso=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:48a32dcf-d958-4167-8e54-77fc19c25841,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:48a32dcf-d958-4167-8e54-77fc19c25841,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:a46ee7a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:2209241136087SI94QT7,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 3d933e4b162c48d3a58addce80cda0a2-20220924
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1838660798; Sat, 24 Sep 2022 11:36:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 24 Sep 2022 11:36:04 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 24 Sep 2022 11:36:03 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <lgirdwood@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <daniel.baluta@nxp.com>
CC:     <matthias.bgg@gmail.com>, <yc.hung@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH 0/2] ASoC: SOF: mediatek: mt8195: Add dsp_ops callback
Date:   Sat, 24 Sep 2022 11:35:57 +0800
Message-ID: <20220924033559.26599-1-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC: SOF: mediatek: mt8195: Add pcm_{hw_params,pointer} callback

Chunxu Li (2):
  ASoC: SOF: mediatek: mt8195: Add pcm_hw_params callback
  ASoC: SOF: mediatek: mt8195: Add pcm_pointer callback

 sound/soc/sof/mediatek/mt8195/mt8195.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

-- 
2.25.1


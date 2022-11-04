Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40676193E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiKDJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKDJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:51:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B32275DD;
        Fri,  4 Nov 2022 02:51:21 -0700 (PDT)
X-UUID: 35c53693db0c4c7cadd271fc2e66c4f2-20221104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vWDvI9g2pRQ52ZMOm1a7Y9bqu87BMMp4jVyuY1u4zSw=;
        b=HJG3N0xnjx28Ilih3chP00cD9FlbdImcqXdZqTqjhq2sHs4Rsv6j2FBlQJZVb8YTT8YrHhZAxBSpJp6+0HYRCNANVJrEZHJXSdv9w5SHwp84VulmcU1qx5swL6+PKMOyvOYCvG5AaBDtNRzQ+i+spE6R1LBVMxqWZUAgiy7AmTI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:195ac71e-7c4b-4b09-a749-4a4120ec9572,IP:0,U
        RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-30
X-CID-META: VersionHash:62cd327,CLOUDID:f6a0aef3-a19e-4b45-8bfe-6a73c93611e9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 35c53693db0c4c7cadd271fc2e66c4f2-20221104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 23164938; Fri, 04 Nov 2022 17:51:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 4 Nov 2022 17:51:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 4 Nov 2022 17:51:15 +0800
From:   Mengqi Zhang <mengqi.zhang@mediatek.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/2] Mediatek eMMC Inline Crypto Engine support
Date:   Fri, 4 Nov 2022 17:51:10 +0800
Message-ID: <20221104095112.27348-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v2
- change patch 1 commit title
- change patch 2 commit title, and correct commit message
- add crypto clock description base on new code base

Mediatek eMMC hardware IP has Inline Crypto Engine (ICE), we support inline encryption now.

This patchset supports Mediatek eMMC inline encryption which meets the upcoming version of the eMMC specification such as v5.1 or v5.2.

Patch 1, add crypto clock control flow in mtk-sd driver, patch 2, document the device tree description about crypto clock.

Mengqi Zhang (2):
  mmc: mtk-sd: add Inline Crypto Engine clock control
  dt-bindings: mmc: mtk-sd: add Inline Crypto Engine clock

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.c                     | 12 ++++++++++
 2 files changed, 34 insertions(+)

--
2.25.1



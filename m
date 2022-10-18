Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB7602151
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJRCnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJRCnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:43:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5392CD6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:43:13 -0700 (PDT)
X-UUID: eb32c49467a845c88e54da13fe5e0a01-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xOtiT/NwCRsCp5EbTW4+Y+cH+1/rZPndZCH6CUJOv6Y=;
        b=Dq7CRYx7Yyksd+oOf6wGZqTdNY7BE36nQMkOWZ9IgCx/k3oQOtV2pIjzv9QEAelgyatqqpbELhfxg3/flMWPaFXiyIFWqY8AA5RGpykSd4/mOBJ/uYlDIbIj9HLaWinHZytRjYrZb92dc53JcM6zCX5Z62pdtK5mkwUKSUkqtic=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.11,REQID:1a1a8510-989a-434e-aebd-9aa11e59a66f,IP:0,U
        RL:0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:195
X-CID-INFO: VERSION:1.1.11,REQID:1a1a8510-989a-434e-aebd-9aa11e59a66f,IP:0,URL
        :0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_US65DF41,ACTI
        ON:quarantine,TS:195
X-CID-META: VersionHash:39a5ff1,CLOUDID:0fe518a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:221018104308KMNIPY0V,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|801,
        TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: eb32c49467a845c88e54da13fe5e0a01-20221018
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 673028676; Tue, 18 Oct 2022 10:43:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 10:43:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 18 Oct 2022 10:43:04 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v7 0/6] iommu/mediatek: Improve safety from invalid dts input
Date:   Tue, 18 Oct 2022 10:42:52 +0800
Message-ID: <20221018024258.19073-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains misc improve patches. Mainly to improve safety from 
invalid dts input.

Change notes:
v7: Rebase on v6.1-rc1. Change nothing.

v6: https://lore.kernel.org/linux-mediatek/20220920063733.21770-1-yong.wu@mediatek.com/
    No change code. just reword the commit message in [3/6] from Angelo.

v5: https://lore.kernel.org/linux-mediatek/20220919092405.8256-1-yong.wu@mediatek.com/
    a) Loop from MTK_LARB_NR_MAX in the error path from Angelo.
    b) Fix the redundant put_device for the error patch outside the loop from dan.
 
v4: https://lore.kernel.org/linux-mediatek/20220824064306.21495-1-yong.wu@mediatek.com/
    a) Just remove the first patch about dev_err_probe since it was merged.
    b) Rebase v6.0-rc1

v3: https://lore.kernel.org/linux-mediatek/20220701053942.3266-1-yong.wu@mediatek.com/
    a) Add platform_device_put from Robin.
    b) Use component_match_add instead component_match_add_release suggested from Robin.

v2: https://lore.kernel.org/linux-mediatek/20220616054203.11365-1-yong.wu@mediatek.com/
    a) Rebase on v5.19-rc1.
    b) Add a New patch [5/5] just remove a variable that only is for v1.

v1: https://lore.kernel.org/linux-mediatek/20220511064920.18455-1-yong.wu@mediatek.com/
    Base on linux-next-20220510.
    the improve safety from dts is base on:
    https://lore.kernel.org/linux-mediatek/20211210205704.1664928-1-linux@roeck-us.net/

Guenter Roeck (1):
  iommu/mediatek: Validate number of phandles associated with
    "mediatek,larbs"

Yong Wu (5):
  iommu/mediatek: Add platform_device_put for recovering the device
    refcnt
  iommu/mediatek: Use component_match_add
  iommu/mediatek: Add error path for loop of mm_dts_parse
  iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
  iommu/mediatek: Remove unused "mapping" member from mtk_iommu_data

 drivers/iommu/mtk_iommu.c | 106 +++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 30 deletions(-)

-- 
2.18.0



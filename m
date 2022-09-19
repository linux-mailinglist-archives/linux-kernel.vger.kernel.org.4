Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9748F5BC543
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiISJY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiISJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:24:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7324F09
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:24:17 -0700 (PDT)
X-UUID: 458861fd53bd4d04a86a272d80b433f0-20220919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8y/jgF7S7DkPlz/qNVdLn1K+ViUtvj5B80dxyrq2UEw=;
        b=glcQnSHQKNa7LFE5LiLQoihd5Xf3xJYH6AxwWFhALJ7qhBh7ZplOEdifSdESaUwEvhmbptZadScAGwRWzZPr2H38+eHGauI+isNCOlV3u9TaCETJn90gCzbKlP4VLycSO4tmavGgKyPnwK3LyEZsaEkZ3lhxPEAnlgcUiTgjPdM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9ec3e28a-a303-4aa7-aafe-2c1cf580bdd5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:cbc9e2f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 458861fd53bd4d04a86a272d80b433f0-20220919
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 882201365; Mon, 19 Sep 2022 17:24:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Sep 2022 17:24:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Sep 2022 17:24:10 +0800
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
Subject: [PATCH v5 0/6] iommu/mediatek: Improve safety from invalid dts input
Date:   Mon, 19 Sep 2022 17:23:59 +0800
Message-ID: <20220919092405.8256-1-yong.wu@mediatek.com>
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
v5: a) Loop from MTK_LARB_NR_MAX in the error path from Angelo.
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



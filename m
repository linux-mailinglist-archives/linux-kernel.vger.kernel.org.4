Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0396C5E58A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiIVCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiIVCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:36:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3667AC243
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:36:25 -0700 (PDT)
X-UUID: 2d4f77de57904dadb515626b63d2e0ac-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FjK3+xpCe9u1MNFb+0HGnTV+whYp7DGiShsoGVeYjKA=;
        b=cQNCiX/l0pmhvRPC7YkptnRyY+0hmrp62MXb6jHRBOBh1nH/dpVH8Gpq41xAW3SWV65rBm9GoBgrEJnIkizmkHD163oonOvwuDnV4Ok3rfCbyU8K8EJAF1xF8yCENtzwt3ivQzVRACW4+yYflf6wAB27SreCfOqtDTYOMXm8i3M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:67e78b02-ecc9-424f-8d89-f0c9ca927c99,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:fa0fc7af-12a8-4d8e-859c-1b6ce09c0eab,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2d4f77de57904dadb515626b63d2e0ac-20220922
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1808761196; Thu, 22 Sep 2022 10:36:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Sep 2022 10:36:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 22 Sep 2022 10:36:17 +0800
Message-ID: <a3f98aa1d3d10b76b1fb5e6c2e3d64cedd0bf127.camel@mediatek.com>
Subject: Re: [PATCH 01/18] phy: mediatek: add a new helper to update bitfield
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        "Stanley Chu" <stanley.chu@mediatek.com>
Date:   Thu, 22 Sep 2022 10:36:17 +0800
In-Reply-To: <2d13b383-7d25-240b-bdbb-e53848df4d47@collabora.com>
References: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
         <20220920090038.15133-2-chunfeng.yun@mediatek.com>
         <2d13b383-7d25-240b-bdbb-e53848df4d47@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Wed, 2022-09-21 at 10:15 +0200, AngeloGioacchino Del Regno wrote:
> Il 20/09/22 11:00, Chunfeng Yun ha scritto:
> > Due to FIELD_PREP() macro can be used to prepare a bitfield value,
> > local ones can be remove; add the new helper to make bitfield
> > update
> > easier.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   drivers/phy/mediatek/phy-mtk-io.h | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-io.h
> > b/drivers/phy/mediatek/phy-mtk-io.h
> > index 500fcdab165d..a723d4afc9b4 100644
> > --- a/drivers/phy/mediatek/phy-mtk-io.h
> > +++ b/drivers/phy/mediatek/phy-mtk-io.h
> > @@ -8,6 +8,7 @@
> >   #ifndef __PHY_MTK_H__
> >   #define __PHY_MTK_H__
> >   
> > +#include <linux/bitfield.h>
> >   #include <linux/io.h>
> >   
> >   static inline void mtk_phy_clear_bits(void __iomem *reg, u32
> > bits)
> > @@ -35,4 +36,10 @@ static inline void mtk_phy_update_bits(void
> > __iomem *reg, u32 mask, u32 val)
> >   	writel(tmp, reg);
> >   }
> >   
> > +/* field @mask should be constant and continuous */
> 
> "Field @mask shall be [...]"
>               ^^^^^
Ok, will modify it

> 
> > +static inline void mtk_phy_update_field(void __iomem *reg, u32
> > mask, u32 val)
> 
> ...so, (void __iomem *reg, const u32 mask, u32 val)
Maybe no need const, @mask will be checked it in compile time when
use FIELD_PREP(), means @mask is a constant value, but not a variable.

Thanks

> 
> > +{
> > +	mtk_phy_update_bits(reg, mask, FIELD_PREP(mask, val));
> > +}
> > +
> >   #endif
> 
> 


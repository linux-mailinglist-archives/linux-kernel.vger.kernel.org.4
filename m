Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7E5E73A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIWGDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIWGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:03:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA1FAA3F5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:03:43 -0700 (PDT)
X-UUID: 7b71bd66c7894af6bb8a13f03fbb95b4-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=whEo3FlJzvrCgsZU2Vky7sq+5FTXkctNcdlBeQtXQAo=;
        b=gSGirSlJfwnn1YUrcEkshxTt6ZFu6sBBZWKGmBhBlVUb3OznoLDEsrGzGI3mCqmYj2wUpZBB4EnlW62PY85dmLpf8b+Tu7WiEGYUvp5zyo6aCtd45sX2w5UygLeLlKRyC5MSP5lz2/ydVMWIbECot4evBKhxWh9RcdYCy+tEQtA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:41bf1696-eca2-48a3-96f8-ebf9d2ff84b7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.11,REQID:41bf1696-eca2-48a3-96f8-ebf9d2ff84b7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:39a5ff1,CLOUDID:8606c506-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220922103633QJL9KCK0,BulkQuantity:135,Recheck:0,SF:28|17|19|48|823|8
        24,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:
        nil,COL:0
X-UUID: 7b71bd66c7894af6bb8a13f03fbb95b4-20220923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 375317930; Fri, 23 Sep 2022 14:03:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 14:03:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Sep 2022 14:03:35 +0800
Message-ID: <50c77b7b4854037f927880dc8775392a7b2e59fc.camel@mediatek.com>
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
Date:   Fri, 23 Sep 2022 14:03:35 +0800
In-Reply-To: <3d8fdcf5-c2cb-be63-48d5-d84d50aeace3@collabora.com>
References: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
         <20220920090038.15133-2-chunfeng.yun@mediatek.com>
         <2d13b383-7d25-240b-bdbb-e53848df4d47@collabora.com>
         <a3f98aa1d3d10b76b1fb5e6c2e3d64cedd0bf127.camel@mediatek.com>
         <3d8fdcf5-c2cb-be63-48d5-d84d50aeace3@collabora.com>
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

On Thu, 2022-09-22 at 09:17 +0200, AngeloGioacchino Del Regno wrote:
> Il 22/09/22 04:36, Chunfeng Yun ha scritto:
> > On Wed, 2022-09-21 at 10:15 +0200, AngeloGioacchino Del Regno
> > wrote:
> > > Il 20/09/22 11:00, Chunfeng Yun ha scritto:
> > > > Due to FIELD_PREP() macro can be used to prepare a bitfield
> > > > value,
> > > > local ones can be remove; add the new helper to make bitfield
> > > > update
> > > > easier.
> > > > 
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > >    drivers/phy/mediatek/phy-mtk-io.h | 7 +++++++
> > > >    1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/phy/mediatek/phy-mtk-io.h
> > > > b/drivers/phy/mediatek/phy-mtk-io.h
> > > > index 500fcdab165d..a723d4afc9b4 100644
> > > > --- a/drivers/phy/mediatek/phy-mtk-io.h
> > > > +++ b/drivers/phy/mediatek/phy-mtk-io.h
> > > > @@ -8,6 +8,7 @@
> > > >    #ifndef __PHY_MTK_H__
> > > >    #define __PHY_MTK_H__
> > > >    
> > > > +#include <linux/bitfield.h>
> > > >    #include <linux/io.h>
> > > >    
> > > >    static inline void mtk_phy_clear_bits(void __iomem *reg, u32
> > > > bits)
> > > > @@ -35,4 +36,10 @@ static inline void mtk_phy_update_bits(void
> > > > __iomem *reg, u32 mask, u32 val)
> > > >    	writel(tmp, reg);
> > > >    }
> > > >    
> > > > +/* field @mask should be constant and continuous */
> > > 
> > > "Field @mask shall be [...]"
> > >                ^^^^^
> > 
> > Ok, will modify it
> > 
> > > 
> > > > +static inline void mtk_phy_update_field(void __iomem *reg, u32
> > > > mask, u32 val)
> > > 
> > > ...so, (void __iomem *reg, const u32 mask, u32 val)
> > 
> > Maybe no need const, @mask will be checked it in compile time when
> > use FIELD_PREP(), means @mask is a constant value, but not a
> > variable.
> > 
> 
> Adding const is not *required*, but `mask` is, effectively, a
> constant, hence
> it fully makes sense to add const.
Prefer to leave it unchanged, there is no 'const' in
function mtk_phy_update_bits(), if add 'const', will cause build
warning. and FIELD_PREP() already do many checks in compile time.

Thanks

> 
> > Thanks
> > 
> > > 
> > > > +{
> > > > +	mtk_phy_update_bits(reg, mask, FIELD_PREP(mask, val));
> > > > +}
> > > > +
> > > >    #endif
> > > 
> > > 
> 
> 
> 


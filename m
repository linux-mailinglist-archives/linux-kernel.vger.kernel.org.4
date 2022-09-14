Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512835B7E32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiINBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiINBSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:18:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0261B28;
        Tue, 13 Sep 2022 18:18:00 -0700 (PDT)
X-UUID: 654a1181d56847b4b4878318a0d9af56-20220914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WAvI+BMy2RLJDJVTwe1yHE9y6+QIYr861RrSmwR4QJc=;
        b=LMnrbuzgDdMrobPrkagOKY10DAqiM5ZS/tFKP6J//ynoH1R4JreCcxgJ+Vv3MqkNmu8HmWb2yACIMv/gIQLDpBvZv3CGKNPbluMa8nkoEcL8oK1+QFU+CLo7cGGaC6OZg6CIOYrnk6rhqmYa1N2rw9n6WaVEOhBXDlinXVgWHl0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:dc0654cd-5803-4995-93ef-48110f9f24df,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:56774bf6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 654a1181d56847b4b4878318a0d9af56-20220914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 512111685; Wed, 14 Sep 2022 09:17:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 14 Sep 2022 09:17:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 14 Sep 2022 09:17:52 +0800
Message-ID: <b813ae7cf79a2889647ec4cb9dd77b59ac65030b.camel@mediatek.com>
Subject: Re: [PATCH RESEND v3 5/9] drm/mediatek: Add gamma support different
 lut_bits for other SoC
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 14 Sep 2022 09:17:51 +0800
In-Reply-To: <b740f81d62ce73e08a2a43637b4f951298b1c28a.camel@mediatek.com>
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
         <20220912013006.27541-6-jason-jh.lin@mediatek.com>
         <b740f81d62ce73e08a2a43637b4f951298b1c28a.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

Thanks for the reviews.

On Mon, 2022-09-12 at 11:40 +0800, CK Hu wrote:
> Hi, Jason:
> 
> On Mon, 2022-09-12 at 09:30 +0800, Jason-JH.Lin wrote:
> > Add lut_bits in gamma driver data for each SoC and adjust the usage
> > of lut_bits in mtk_drm_gamma_set_common().
> > 
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 36 ++++++++++++++++---
> > --
> > --
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > index 0a1022032b71..be82d15a5204 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > @@ -25,11 +25,14 @@
> >  
> >  #define LUT_10BIT_MASK				0x03ff
> >  #define LUT_SIZE_DEFAULT			512 /* for setting
> > gamma lut from AAL */
> > +#define LUT_BITS_DEFAULT			10
> > +#define LUT_INPUT_BITS				16 /* input lut
> > bit from application */
> 
> I think we should use drm_color_lut_extract() to let the input bits
> transparent. So add one patch to use drm_color_lut_extract(), and
> then
> apply this patch.
> 
> Regards,
> CK

OK, I'll separate it to 2 patches, 1 is using drm_color_lut_extract()
to handle with input lut data and the other is adding gamma support
lut_bits and shift_bits.

Regards,
Jason-JH.Lin


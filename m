Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68365FF835
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJODZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJODZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:25:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8F2D77B;
        Fri, 14 Oct 2022 20:25:41 -0700 (PDT)
X-UUID: 14a76332afa74516b6610a1edcfec374-20221015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uo5RutZKIWxTF1v3lTWtS5MOGB5BHj7gJCREIvngKpU=;
        b=eaYYRbiasLYkqEb2KSu1d3yD+Y4OrDc/MM/xCNk5zMzs3AptIq+Prj3THnXvvSwWn0VO4BJeR1/ha3POeOIy7SSzagUIGG4A1S6CQvPCMxcit16xwLBP9/sSrkF1/hquuDYknvIG4I/Vb40irmPw89ZElO2tKNUiOUujxcTuuRw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:048350b6-1b06-45e1-96f7-679c6f427fd0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:048350b6-1b06-45e1-96f7-679c6f427fd0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:bdc524b6-a023-44ff-92b1-76c504f71c7a,B
        ulkID:221015112538DSKRIK5P,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: 14a76332afa74516b6610a1edcfec374-20221015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1528785872; Sat, 15 Oct 2022 11:25:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 15 Oct 2022 11:25:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 15 Oct 2022 11:25:36 +0800
Message-ID: <b07cc3c07f472c0ea746c7c75f3bd4af1cc11cfc.camel@mediatek.com>
Subject: Re: [PATCH v4 3/3] iommu/mediatek: add support for MT8365 SoC
From:   Yong Wu <yong.wu@mediatek.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-mediatek@lists.infradead.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux.dev>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 15 Oct 2022 11:25:36 +0800
In-Reply-To: <20221001-iommu-support-v4-3-f1e13438dfd2@baylibre.com>
References: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
         <20221001-iommu-support-v4-3-f1e13438dfd2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-14 at 10:45 +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU support for MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>


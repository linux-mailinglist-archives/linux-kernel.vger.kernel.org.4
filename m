Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293D5BD95B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiITB3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiITB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:28:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E372653D0F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:28:45 -0700 (PDT)
X-UUID: 0f9a973517ba4ff1b1b0ce4a28b6e84d-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4c9H0CEkJF1e+Pq5M1oIVVNJiztrvRboz8nACrNsVyc=;
        b=XFBwqprXU45p260aSZmL+TvlQRcl5rCwSqwUKpNm1stsI0ubn5Z2xjtsXu0lPUxCpo9sb9yFNBsrAEnHey9SLxb68CfebJvBSKJ6C+D3M0Y3qnCJ0WoPBF1e+9uUNN0YiYKqOHFjzH5EmJa6JT/CR4EpmDAooy34zhV1iaJCoSY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:600c4745-b9cf-420e-8d7a-1329eb78a62e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:600c4745-b9cf-420e-8d7a-1329eb78a62e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:e10a335e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:2209192220432V8FJ766,BulkQuantity:68,Recheck:0,SF:28|17|19|48|823|82
        4,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0
X-UUID: 0f9a973517ba4ff1b1b0ce4a28b6e84d-20220920
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 838320195; Tue, 20 Sep 2022 09:28:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 09:28:40 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 09:28:38 +0800
Message-ID: <2111faa6541ad339d6b7ec07f63444a1fc512288.camel@mediatek.com>
Subject: Re: [PATCH v5 3/6] iommu/mediatek: Add error path for loop of
 mm_dts_parse
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Date:   Tue, 20 Sep 2022 09:28:38 +0800
In-Reply-To: <276a4a37-a98d-c59b-a967-db9f5b220077@collabora.com>
References: <20220919092405.8256-1-yong.wu@mediatek.com>
         <20220919092405.8256-4-yong.wu@mediatek.com>
         <276a4a37-a98d-c59b-a967-db9f5b220077@collabora.com>
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

On Mon, 2022-09-19 at 16:20 +0200, AngeloGioacchino Del Regno wrote:
> Il 19/09/22 11:24, Yong Wu ha scritto:
> > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the
> > i+1
> > larb is parsed fail, we should put_device for the 0..i larbs.
> 
> If any v6 will be required... you forgot to update the commit
> description with
> "we should put_device for the i..0 larbs".

oh. Thanks for reviewing so carefully. I will send a quick v6 to fix
this.

> 
> > 
> > There are two places need to comment:
> > 1) The larbid may be not linear mapping, we should loop whole
> >     the array in the error path.
> > 2) I move this line position: "data->larb_imu[id].dev = &plarbdev-
> > >dev;"
> >     before "if (!plarbdev->dev.driver)", That means set
> >     data->larb_imu[id].dev before the error path. then we don't
> > need
> >     "platform_device_put(plarbdev)" again in probe_defer case. All
> > depend
> >     on "put_device" of the error path in error cases.
> > 
> > Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with
> > the MM TYPE")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> In any case....
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Thanks very much:)

> 
> 
> 


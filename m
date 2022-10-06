Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF35F6557
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJFLnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJFLnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:43:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA89D51A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:43:43 -0700 (PDT)
X-UUID: 3fbfda8b9ebb4e62be93ca869691aa02-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BDnSL/JPjtSGprjeE4z6z5WlilRjfZmxNugqgexPmCE=;
        b=GRUB3WnCBotxWZGQ9en4RcbKV2Z86Al12y7pJkeCzq1kiu0HAAcVFXSEgOP+RJC08sUfrSpRAKVq6+RPn5VLXPpnk57cXCK/2W/dINl8iD/bNE1nGHgAnbPAPfjzEVpZgwrMjABM/Qt2gxrJb/cyKOtWxshN38lFtiLDGglIvWA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:27340b60-7eea-472e-b4d3-34ee1bff111a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.11,REQID:27340b60-7eea-472e-b4d3-34ee1bff111a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:39a5ff1,CLOUDID:6dd672fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:221006194341SL6DGXKC,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: 3fbfda8b9ebb4e62be93ca869691aa02-20221006
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 296243264; Thu, 06 Oct 2022 19:43:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 19:43:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 19:43:39 +0800
Message-ID: <b15a1fdfaf6d40be8abaa3b0f60a8931c3c356fa.camel@mediatek.com>
Subject: Re: [PATCH 0/8] soc: mediatek: mtk-svs: refactor and cleanup the
 driver
From:   Roger Lu <roger.lu@mediatek.com>
To:     <matthias.bgg@kernel.org>, <jia-wei.chang@mediatek.com>
CC:     <nfraprado@collabora.com>, <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu, 6 Oct 2022 19:43:39 +0800
In-Reply-To: <20220928155519.31977-1-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
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

Hi Matthias Sir,

Thanks for sharing these great ideas to improve MTK SVS driver. I've added some
feedback to this patchset. However, should I just submit the v2 of these patches
for you to review? Thanks very much.

Sincerely,
Roger Lu.

On Wed, 2022-09-28 at 17:55 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Mediatek SVS driver got accepted upstream but has coding style issues
> which were overseen in the review process. This series is a first step
> to clean up the driver. It basically cleans up the SoC specific probe.
> As next step we will need to clean up the 'struct svs_bank'.
> 
> This series should be a mere cleanup with no functional change. I'm
> happy to recieve tested-by tags to make sure it does not break anything.
> 
> 
> Matthias Brugger (8):
>   soc: mediatek: mtk-svs: clean up platform probing
>   soc: mediatek: mtk-svs: improve readability of platform_probe
>   soc: mediatek: mtk-svs: move svs_platform_probe into probe
>   soc: mediatek: mtk-svs: delete superfluous platform data entries
>   soc: mediatek: mtk-svs: Move SoC specific functions to new files
>   soc: mtk-svs: mt8183: Move thermal parsing in new function
>   soc: mtk-svs: mt8183: refactor o_slope calculation
>   soc: mtk-svs: mt8192: fix bank data
> 
>  drivers/soc/mediatek/Makefile         |   3 +-
>  drivers/soc/mediatek/mt8183-svs.h     | 113 ++++
>  drivers/soc/mediatek/mt8192-svs.h     |  64 ++
>  drivers/soc/mediatek/mtk-svs-mt8183.c | 235 +++++++
>  drivers/soc/mediatek/mtk-svs-mt8192.c |  98 +++
>  drivers/soc/mediatek/mtk-svs.c        | 882 ++------------------------
>  drivers/soc/mediatek/mtk-svs.h        | 279 ++++++++
>  7 files changed, 853 insertions(+), 821 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mt8183-svs.h
>  create mode 100644 drivers/soc/mediatek/mt8192-svs.h
>  create mode 100644 drivers/soc/mediatek/mtk-svs-mt8183.c
>  create mode 100644 drivers/soc/mediatek/mtk-svs-mt8192.c
>  create mode 100644 drivers/soc/mediatek/mtk-svs.h
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510EE6DF8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjDLOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjDLOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7AC9745;
        Wed, 12 Apr 2023 07:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7229562D9C;
        Wed, 12 Apr 2023 14:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B94C433EF;
        Wed, 12 Apr 2023 14:35:46 +0000 (UTC)
Message-ID: <2c3105d4-2e60-e77a-df5d-e2a7e37c6f4a@xs4all.nl>
Date:   Wed, 12 Apr 2023 16:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 00/14] Adjust the dma-ranges for MTK IOMMU
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        nfraprado@collabora.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
References: <20230411093144.2690-1-yong.wu@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230411093144.2690-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 11:31, Yong Wu wrote:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges is not allowed for dts leaf node.
> but we still would like to separate the different masters into
> different iova regions. Thus we adjust the internal flow, separate
> the 16GB iova range by the master HW larbid/portid and add the
> dma-ranges property in the parent "soc" node. This also could avoid
> the users forget/abuse the iova regions.
> 
> The commit f1ad5338a4d5 did affect the mt8195 venc, But it is not
> a fatal issue, it could also work well at 0-4GB iova. thus I don't
> add "Fixes:" tag.
> 
> In this series, I add functions for mt8192/mt8195/mt8186, mt8188 will
> be in its special patchset. and the previous mt8173/mt8183...support
> 0-4GB only, no need this function.

I've Acked patches 10 and 11 as well. I assume this series will be merged
through the iommu subsystem? If not, and I need to take the media patches,
then please let me know!

Regards,

	Hans

> 
> Change note:
> v7: Remove the change about mediatek,vcodec-subdev-decoder.yaml since
>     this was merged at:
>     https://lore.kernel.org/all/98c48690-631d-1086-9b7c-004c61cc8dbb@xs4all.nl/
> 
> v6: https://lore.kernel.org/linux-mediatek/20230403091337.26745-1-yong.wu@mediatek.com/
>    Add three patches for set dma-mask for iommu master devices.
> 
> v5: Nothing change. Just rebase on v6.3-rc1.
> 
> v4: https://lore.kernel.org/linux-mediatek/20230215062544.8677-1-yong.wu@mediatek.com/
>     Improve the comment in the code from AngeloGioacchino.
> 
> v3: https://lore.kernel.org/linux-mediatek/20230214031114.926-1-yong.wu@mediatek.com/
>    Add a new patch only for comment more in the code.
> 
> v2: https://lore.kernel.org/linux-mediatek/20230208053643.28249-1-yong.wu@mediatek.com/
>    a) Base on next-20230206 since mt8195 jpeg node is applied which affect
>       this patch.
>    b) Reword the commit message [1/10][2/10] to explain effect.
> 
> v1: https://lore.kernel.org/linux-mediatek/20230113060133.9394-1-yong.wu@mediatek.com/
>    Base on v6.2-rc3.
> 
> Yong Wu (14):
>   dt-bindings: media: mediatek,vcodec: Remove dma-ranges property
>   dt-bindings: media: mediatek,jpeg: Remove dma-ranges property
>   iommu/mediatek: Improve comment for the current region/bank
>   iommu/mediatek: Get regionid from larb/port id
>   iommu/mediatek: mt8192: Add iova_region_larb_msk
>   iommu/mediatek: mt8195: Add iova_region_larb_msk
>   iommu/mediatek: mt8186: Add iova_region_larb_msk
>   iommu/mediatek: Add a gap for the iova regions
>   iommu/mediatek: Set dma_mask for the master devices
>   media: mtk-jpegdec: Remove the setting for dma_mask
>   media: mediatek: vcodec: Remove the setting for dma_mask
>   arm64: dts: mt8195: Remove the unnecessary dma-ranges
>   arm64: dts: mt8195: Add dma-ranges for the parent "soc" node
>   arm64: dts: mt8186: Add dma-ranges for the parent "soc" node
> 
>  .../media/mediatek,mt8195-jpegdec.yaml        |   7 -
>  .../media/mediatek,mt8195-jpegenc.yaml        |   7 -
>  .../media/mediatek,vcodec-decoder.yaml        |   5 -
>  .../media/mediatek,vcodec-encoder.yaml        |   5 -
>  .../bindings/media/mediatek-jpeg-encoder.yaml |   5 -
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi      |   1 +
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   4 +-
>  drivers/iommu/mtk_iommu.c                     | 145 ++++++++++++++----
>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   3 -
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   8 -
>  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   3 -
>  11 files changed, 117 insertions(+), 76 deletions(-)
> 


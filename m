Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556C6E0AED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDMKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDMKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:00:06 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7459E7DB9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:59:58 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 809C8242A7C;
        Thu, 13 Apr 2023 11:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681379998;
        bh=n0QJW4lfoz67Y+PljUooZl3qQdKxzEidqXgT7gCTOns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7P++pYu0u5ZAUDr7m9Y3K32VnwYTUtaeIkOi+SP2qpJd3H1pIjv5fiKdGsvuICdP
         oD9F5kPhUwZgRcFruMin1d5RaAe95EtzgwmWM9+hWaEt5xIc+LIvd7eXhfPoByVwoa
         EspFxywwWpN8/ly+m+IzvyzMz5vH6RA6oQMKVYDjvDsr9AicYHV5Dpxbi7YIpJOrnw
         wsx9UzHCjPQEHjd0a9yUAA/so51aftNC6agS//Yi+Xun3KR1pkXx+McsTN0kqnOo52
         4KvehtZZb/UvV0qGtR3djbZOQGRLsfzF0PQXSo+UhyuzME5sTOti+cxDuoI6niMspr
         hjvzH71h3XnDg==
Date:   Thu, 13 Apr 2023 11:59:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
Subject: Re: [PATCH v7 00/14] Adjust the dma-ranges for MTK IOMMU
Message-ID: <ZDfSnOXqqVP3MNg4@8bytes.org>
References: <20230411093144.2690-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411093144.2690-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:31:30PM +0800, Yong Wu wrote:
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

Applied, thanks.

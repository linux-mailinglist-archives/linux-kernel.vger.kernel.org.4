Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1931E5FAFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJKJzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJKJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:55:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2990E1F9EB;
        Tue, 11 Oct 2022 02:55:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C395E6602356;
        Tue, 11 Oct 2022 10:55:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665482106;
        bh=zzsgbQRjWMGmMw0Zwxx8nmOt4OzG96FB3zeBCswPAU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k9zNn0cDHZf9/3U+Osh0Wvyqrhe8wq3LHEF3HdzAY7N9+4zdFxmEGc1vmnlERpLdf
         g8x9lJlZ4yVJcvwx4Fgu1D66k5OWszccrggKryMmRQM2Fy881D1W9kjjF0SWfVaN5l
         b3v+66UkaoYsfjPUA8SMyqcg42ciZsz4psVPIE+LdLIaCq1Q1rYNAqfafZpmnCAppl
         gfNFppESg0v303wVuW3pCSN2oPkeXJ1kbX7344XWajKv5um+sNacVl1dKoylCcbQHE
         gOxFWrtXQtH79STLYUc3x81qx3wXz89fxc/AiUUwEFr2AeXjtxD2URCtn7jYRgTsFP
         POsLfOvUJ5eew==
Message-ID: <54d3b706-6f5b-d5ec-82ca-45b9f4995d13@collabora.com>
Date:   Tue, 11 Oct 2022 11:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/3] iommu/mediatek: add support for 6-bit encoded port
 IDs
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org
References: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
 <20221001-iommu-support-v3-2-c7b3059b0d16@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221001-iommu-support-v3-2-c7b3059b0d16@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/10/22 14:54, Alexandre Mergnat ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Until now the port ID was always encoded as a 5-bit data. On MT8365,
> the port ID is encoded as a 6-bit data. This requires to add extra
> macro F_MMU_INT_ID_LARB_ID_EXT, and F_MMU_INT_ID_PORT_ID_EXT in order
> to support 6-bit encoded port IDs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   drivers/iommu/mtk_iommu.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5a4e00e4bbbc..35e9731c3441 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -108,8 +108,12 @@
>   #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
>   #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
>   #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
> +/* Macro for 5 bits lenght port ID field (default) */

Typo: s/lenght/length/g

>   #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
>   #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
> +/* Macro for 6 bits lenght port ID field */

Same here.

After fixing that:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



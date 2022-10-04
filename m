Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D095F428E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJDL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJDL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:59:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D050528;
        Tue,  4 Oct 2022 04:59:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F4906602295;
        Tue,  4 Oct 2022 12:59:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664884747;
        bh=uWR6mifATwteDavwCYtlxjjRbJpEMopbvXmtwSS2OCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kq2BHPr/TE+jy8XuU//QuqFoBiSGP8RiW/xByTgtQFcxLoi+FPmUajL9kfUuAl3+1
         burnOiFauGGEpDWs8p3i3FP2mesx3VBbSJrwzAHQTrLMIQPTwud5Jmi2pvir1o1nQo
         4H6MZWMqhbHPIStZ4KJCiaaaRdJgwbxGYFbSzd72KHjt461LyuqSXJRMRYk9/zg4Pu
         nI/sLAlB0ldcJ8BsLQ0fL3OsWtyggrsV8z5y1tzqvXlzXDfEMCEuhFZZ9tiv21CZib
         1sPKezcJN9qvGO3ImopbxGg5BP+mHCARfzEjNuoQdlN8U8vx8g6agChV4A+o8fnewt
         f/pNZi2wasI1g==
Message-ID: <7d37e6ae-0dca-e0ef-2841-298c1ba9784f@collabora.com>
Date:   Tue, 4 Oct 2022 13:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/3] iommu/mediatek: add support for 6-bit encoded port
 IDs
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
 <20221001-iommu-support-v2-2-dbfef2eeebc9@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221001-iommu-support-v2-2-dbfef2eeebc9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/10/22 12:01, Alexandre Mergnat ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Until now the port ID was always encoded as a 5-bit data. On MT8365,
> the port ID is encoded as a 6-bit data. This requires to rework the
> macros F_MMU_INT_ID_LARB_ID, and F_MMU_INT_ID_PORT_ID in order
> to support 5-bit and 6-bit encoded port IDs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   drivers/iommu/mtk_iommu.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5a4e00e4bbbc..a57ce509c8b5 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -108,8 +108,10 @@
>   #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
>   #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
>   #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
> -#define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
> -#define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
> +#define F_MMU_INT_ID_LARB_ID(a, int_id_port_width)	\
> +				((a) >> (((int_id_port_width) + 2) & 0x7))
> +#define F_MMU_INT_ID_PORT_ID(a, int_id_port_width)	\
> +				(((a) >> 2) & GENMASK((int_id_port_width) - 1, 0))

I can't think about any cleaner way than this one, but that's decreasing human
readability by "quite a bit".

The only way you can keep it readable is by adding a comment before these macros
that explains the sub-fields of FAULT_ID, located in the INT_ID register: please
add that.

Regards,
Angelo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99360BE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiJXXYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiJXXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:23:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119B17F2A8;
        Mon, 24 Oct 2022 14:44:40 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7737B6602392;
        Mon, 24 Oct 2022 17:43:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666629840;
        bh=4kWtLxHplFOS10HqVPq+7P3+dYq5PouJzYToXkZX4Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxnUpi1bDW82nmb44+goLMrowb5Wd9tioPQl7b/kkrgLASz3MA/H6Mfcrk1OWg9p0
         kfT8CZT2IAaA5LedmtnGE+nyDEFDU9GMgEWulgV6pIC5lxMp8S63ZLYECm16UV3Vtl
         nmLjvBik0WwkbtjEKwi76XMOYyUlFA6ToQyYFUkrlAnhl3B+7dRnMg/uoTO/8+tPtG
         ueksg4mems9ce5/g7amf9L164rpyDn32FV4nTDlaf2rB1rdxE8SRYh1PpvbtovXUdP
         0SXlzUsXOMhX+5Pbbfufsxf0NrisgDUYMQmSL0nog1TSoBOmBHnV7ANsQ9bvHiY72g
         s9ZX7RViGNyLQ==
Date:   Mon, 24 Oct 2022 12:43:53 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: mmc: mtk-sd: Set clocks based on
 compatible
Message-ID: <20221024164353.jzvx4ea442e4vahj@notapiano>
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-3-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023091247.70586-3-linux@fw-web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for picking this up.

On Sun, Oct 23, 2022 at 11:12:42AM +0200, Frank Wunderlich wrote:
> From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> The binding was describing a single clock list for all platforms, but
> that's not really suitable:
> 
> Most platforms using at least 2 clocks (source, hclk), some of them
> a third "source_cg". Mt2712 requires an extra 'bus_clk' on some of
> its controllers, while mt8192 requires 8 clocks.
> 
> Move the clock definitions inside if blocks that match on the
> compatibles.
> 
> I used Patch from Nícolas F. R. A. Prado and modified it to not using
> "not" statement.
> 
> Fixes: 59a23395d8aa ("dt-bindings: mmc: Add support for MT8192 SoC")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> ---
> v2:
> - add this patch
> v3:
> - add blank lines and change "not" to matchlist
> - reorder entries - make generic first then order alphanumeric
> - rewrite commit description
> - drop soc-specific mt8183 - constraints were also set for it above

This is wrong, see below.

> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 113 +++++++++++++-----
>  1 file changed, 83 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 3cbf0208f1b4..31bb6dc329d2 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
[..]
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: mediatek,mt8183-mmc
> -then:
> -  properties:
> -    reg:
> -      minItems: 2

You can't drop this. Nodes with the mt8183 compatible should keep requiring two
reg values. It's not covered by the branch below.

Thanks,
Nícolas

> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt2701-mmc
> +            - mediatek,mt6779-mmc
> +            - mediatek,mt6795-mmc
> +            - mediatek,mt7620-mmc
> +            - mediatek,mt7622-mmc
> +            - mediatek,mt7623-mmc
> +            - mediatek,mt8135-mmc
> +            - mediatek,mt8173-mmc
> +            - mediatek,mt8183-mmc
> +            - mediatek,mt8186-mmc
> +            - mediatek,mt8188-mmc
> +            - mediatek,mt8195-mmc
> +            - mediatek,mt8516-mmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: source_cg
> +
[..]

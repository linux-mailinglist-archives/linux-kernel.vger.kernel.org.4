Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C1D6B76A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCMLwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCMLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:52:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5606319F32;
        Mon, 13 Mar 2023 04:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D183B81055;
        Mon, 13 Mar 2023 11:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38D5C433EF;
        Mon, 13 Mar 2023 11:51:19 +0000 (UTC)
Message-ID: <6625db2f-9b60-9f11-87ab-a1f8c4d9fd8e@xs4all.nl>
Date:   Mon, 13 Mar 2023 12:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 01/11] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
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
        anan.sun@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh@kernel.org>
References: <20230307023507.13306-1-yong.wu@mediatek.com>
 <20230307023507.13306-2-yong.wu@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230307023507.13306-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 03:34, Yong Wu wrote:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges of the leaf node doesn't work. Remove
> it for vcodec here.
> 
> 1) For mediatek,vcodec-decoder.yaml and mediatek,vcodec-encoder.yaml,
> this property is in the leaf node, it is invalid as the above comment.
> 
> Currently there is only mt8195 VENC node has this property in upstream.
> Indeed, VENC is affected, but it is not a fatal issue. Originally it
> expects its iova range locate at 4GB-8GB. However after that commit, its
> expectation doesn't come true, it will fall back to 0-4GB iova and also
> could work well.
> 
> 2) For mediatek,vcodec-subdev-decoder.yaml, It already uses parent-child
> node, this property works. Instead, MediaTek iommu will control the
> masters' iova ranges by the master's larb/port id internally, then the
> dma-ranges property is unnecessary for the master's node.
> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml | 5 -----
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 5 -----
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
>  3 files changed, 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index aa55ca65d6ed..fad59b486d5d 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -56,11 +56,6 @@ properties:
>        List of the hardware port in respective IOMMU block for current Socs.
>        Refer to bindings/iommu/mediatek,iommu.yaml.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index 0f2ea8d9a10c..a2051b31fa29 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -49,11 +49,6 @@ properties:
>        List of the hardware port in respective IOMMU block for current Socs.
>        Refer to bindings/iommu/mediatek,iommu.yaml.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..290594bc91cc 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -76,11 +76,6 @@ properties:
>        The node of system control processor (SCP), using
>        the remoteproc & rpmsg framework.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    "#address-cells":
>      const: 2
>  
> @@ -203,7 +198,6 @@ required:
>    - reg
>    - iommus
>    - mediatek,scp
> -  - dma-ranges
>    - ranges
>  
>  if:
> @@ -236,7 +230,6 @@ examples:
>              compatible = "mediatek,mt8192-vcodec-dec";
>              mediatek,scp = <&scp>;
>              iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> -            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
>              #address-cells = <2>;
>              #size-cells = <2>;
>              ranges = <0 0 0 0x16000000 0 0x40000>;


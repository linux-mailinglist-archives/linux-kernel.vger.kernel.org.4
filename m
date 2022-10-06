Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D295F63A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJFJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiJFJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:29:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456363A7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:29:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j16so1773354wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPQhsuNCx4BuXZDwvEbm+upFmQ1m9MrY7Gt+pVyvCOA=;
        b=Y95xcmcvuO8YfwthjuW9bE5tUhYgaotwnv3ZfbN4vQUHrIQmzHrxwVsOXt3Jluk3s/
         nOey7OfHB/kFumj1L09KckT3c54+FGQeC9Nrg6/NHCQO67h9RpwzVNF8YAvaAyuHtfAu
         aL/pKpwLuj0d4PdIZqjyLtfuD6hcQDrnihtcIZZ2ICiL40uAfRGlK4VbbhgKfRaetEEa
         Lb8BQruoocn8LT4c573XsYzgOLA1MLIlRbEfjHgzKojzgrmcr9SdnLOWjObgc0M/bpVk
         RbO49vas5Te0P7jZj3AprwT7S7vraoSKIx7rhXJ8KN41tHUlCe8UcwkerH8O/gZhAd5K
         Fh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPQhsuNCx4BuXZDwvEbm+upFmQ1m9MrY7Gt+pVyvCOA=;
        b=G8ZMUKGUIKHJgXq0ihYo56iL6K8O+oJBc2mc0ih3SHtn6GYEywaXkdJ+Jey8MBUSy7
         BxTGoDl+oxKeAbINTVIqal+c/3YCwcZfbjznZhqQUsIMlVSgTMUafTKVv1z+W1ozrcwg
         KWsdgydCGAsmfSTNRVQVb1xBitcNUkmKWt7KjWFIgHvhh2Zp5ZQRKimRwWFQYM1j65Kz
         QI3GqpZFLQsqY7mSJg85ejMOt3AkqaJV3cumsJ3dTuupWa2hduc0dtPR9UMp+nvWBbI5
         AP5vUgAVymWaz9CsqZTyXuo/Dwx6YBaPMQuTgif5ymLsl1IJz/+an87zRIRh17wVty7G
         96pQ==
X-Gm-Message-State: ACrzQf0OL+mcv7AMufeyDon+J+14jWIrOOhJ0Gp8Kc3i2PFwdtOnxc4d
        t9cC1rv579aCXOgUWShRy1ZOEA==
X-Google-Smtp-Source: AMsMyM5jQfo1f11F0qvpLN17UMvJHTy+WlrfYLBvISsNZ78fF5tFicIUeJ9rdcG2oMxmTsRs7+6rKA==
X-Received: by 2002:a05:6000:1365:b0:22a:2ee9:4363 with SMTP id q5-20020a056000136500b0022a2ee94363mr2417817wrz.393.1665048580457;
        Thu, 06 Oct 2022 02:29:40 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id b6-20020adfde06000000b0022e2eaa2bdcsm14675044wrm.98.2022.10.06.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:29:39 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:29:39 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Message-ID: <20221006092939.6gsdmo5vavafxd6l@blmsp>
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
 <20221001-iommu-support-v2-1-dbfef2eeebc9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221001-iommu-support-v2-1-dbfef2eeebc9@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Oct 04, 2022 at 12:01:39PM +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
>  include/dt-bindings/memory/mt8365-larb-port.h      | 90 ++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b5098..4b8cf3ce6963 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -81,6 +81,7 @@ properties:
>            - mediatek,mt8195-iommu-vdo        # generation two
>            - mediatek,mt8195-iommu-vpp        # generation two
>            - mediatek,mt8195-iommu-infra      # generation two
> +          - mediatek,mt8365-m4u  # generation two

This comment should probably be aligned with the ones above.

Best,
Markus

>  
>        - description: mt7623 generation one
>          items:
> @@ -130,6 +131,7 @@ properties:
>        dt-binding/memory/mt8186-memory-port.h for mt8186,
>        dt-binding/memory/mt8192-larb-port.h for mt8192.
>        dt-binding/memory/mt8195-memory-port.h for mt8195.
> +      dt-binding/memory/mt8365-larb-port.h for mt8365.
>  
>    power-domains:
>      maxItems: 1
> diff --git a/include/dt-bindings/memory/mt8365-larb-port.h b/include/dt-bindings/memory/mt8365-larb-port.h
> new file mode 100644
> index 000000000000..56d5a5dd519e
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8365-larb-port.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + */
> +#ifndef _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
> +#define _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
> +
> +#include <dt-bindings/memory/mtk-memory-port.h>
> +
> +#define M4U_LARB0_ID			0
> +#define M4U_LARB1_ID			1
> +#define M4U_LARB2_ID			2
> +#define M4U_LARB3_ID			3
> +
> +/* larb0 */
> +#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
> +#define M4U_PORT_DISP_OVL0_2L		MTK_M4U_ID(M4U_LARB0_ID, 1)
> +#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
> +#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
> +#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 4)
> +#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
> +#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB0_ID, 6)
> +#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
> +#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
> +#define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
> +#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
> +#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
> +
> +/* larb1 */
> +#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
> +#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB1_ID, 1)
> +#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 2)
> +#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB1_ID, 3)
> +#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB1_ID, 4)
> +#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 5)
> +#define M4U_PORT_VENC_NBM_RDMA_LITE	MTK_M4U_ID(M4U_LARB1_ID, 6)
> +#define M4U_PORT_JPGENC_Y_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 7)
> +#define M4U_PORT_JPGENC_C_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 8)
> +#define M4U_PORT_JPGENC_Q_TABLE		MTK_M4U_ID(M4U_LARB1_ID, 9)
> +#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 10)
> +#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB1_ID, 11)
> +#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 12)
> +#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB1_ID, 13)
> +#define M4U_PORT_VENC_NBM_WDMA_LITE	MTK_M4U_ID(M4U_LARB1_ID, 14)
> +#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 15)
> +#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 16)
> +#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 17)
> +#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 18)
> +
> +/* larb2 */
> +#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB2_ID, 0)
> +#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB2_ID, 1)
> +#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB2_ID, 2)
> +#define M4U_PORT_CAM_LCS		MTK_M4U_ID(M4U_LARB2_ID, 3)
> +#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB2_ID, 4)
> +#define M4U_PORT_CAM_CAM_SV0		MTK_M4U_ID(M4U_LARB2_ID, 5)
> +#define M4U_PORT_CAM_CAM_SV1		MTK_M4U_ID(M4U_LARB2_ID, 6)
> +#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB2_ID, 7)
> +#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(M4U_LARB2_ID, 8)
> +#define M4U_PORT_CAM_AFO		MTK_M4U_ID(M4U_LARB2_ID, 9)
> +#define M4U_PORT_CAM_SPARE		MTK_M4U_ID(M4U_LARB2_ID, 10)
> +#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB2_ID, 11)
> +#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(M4U_LARB2_ID, 12)
> +#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(M4U_LARB2_ID, 13)
> +#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB2_ID, 14)
> +#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB2_ID, 15)
> +#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB2_ID, 16)
> +#define M4U_PORT_CAM_WPE0_I		MTK_M4U_ID(M4U_LARB2_ID, 17)
> +#define M4U_PORT_CAM_WPE1_I		MTK_M4U_ID(M4U_LARB2_ID, 18)
> +#define M4U_PORT_CAM_WPE_O		MTK_M4U_ID(M4U_LARB2_ID, 19)
> +#define M4U_PORT_CAM_FD0_I		MTK_M4U_ID(M4U_LARB2_ID, 20)
> +#define M4U_PORT_CAM_FD1_I		MTK_M4U_ID(M4U_LARB2_ID, 21)
> +#define M4U_PORT_CAM_FD0_O		MTK_M4U_ID(M4U_LARB2_ID, 22)
> +#define M4U_PORT_CAM_FD1_O		MTK_M4U_ID(M4U_LARB2_ID, 23)
> +
> +/* larb3 */
> +#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB3_ID, 0)
> +#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(M4U_LARB3_ID, 1)
> +#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB3_ID, 2)
> +#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB3_ID, 3)
> +#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB3_ID, 4)
> +#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB3_ID, 5)
> +#define M4U_PORT_HW_VDEC_TILE_EXT	MTK_M4U_ID(M4U_LARB3_ID, 6)
> +#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB3_ID, 7)
> +#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(M4U_LARB3_ID, 8)
> +#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB3_ID, 9)
> +#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB3_ID, 10)
> +
> +#endif
> 
> -- 
> b4 0.10.1

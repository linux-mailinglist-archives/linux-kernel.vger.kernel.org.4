Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272467F7A4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjA1Lqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjA1Lqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:46:47 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FB234DA;
        Sat, 28 Jan 2023 03:46:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 15783424D0;
        Sat, 28 Jan 2023 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1674906405; bh=XF6Idsk35kfCAPNyhQs/PAXkcVnV95QoxC92DpEL/c4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V15IkajZn+WdS3awUit4i1s1e3s8SG6WSJhHCNzwEvZ+LMmI8i5FtRGBxGcg4gXKv
         nHjjWFSmwbhZWFr1QCxhPFg1VY0jdaFcR+3ut3wjICWQWTqEAqiEq42o/45Wabbn2X
         12v/BFUOjBa+/a7+kH4kEuMEXnAKXsF5Kettw0MBR1KrsaRzzMDLS+xfZ9w4os4R+v
         uOrdlUVPPN/NCagInIoX/gVqVi8/oVfslaG/XCNPdNS1qAKSikXjPpkNT5/304XLNb
         amvj17OQeghu5PZgZ0iA8AOEZ+UIfmLv+ySQ/v9NOd8d9Z6WO7fOqGTeKSCgkvqNgo
         rQGn08gnUW4tQ==
Message-ID: <3b796124-5edf-aff1-15e9-4ee94da5177b@marcan.st>
Date:   Sat, 28 Jan 2023 20:46:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] iommu: dart: Add support for M1 USB4 PCIe DART
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230128111114.4049-1-sven@svenpeter.dev>
 <20230128111114.4049-5-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230128111114.4049-5-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 20.11, Sven Peter wrote:
> This variant of the regular t8103 DART is used for the two
> USB4/Thunderbolt PCIe controllers. It supports 64 instead of 16 streams
> which requires a slightly different MMIO layout. We also disallow bypass
> support since these DARTs will only ever be used for externally facing
> devices on the USB4 ports.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 7579c97a9062..a1304ba3639b 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -81,6 +81,7 @@
>  #define DART_T8020_TCR_BYPASS_DAPF      BIT(12)
>  
>  #define DART_T8020_TTBR       0x200
> +#define DART_T8020_USB4_TTBR  0x400
>  #define DART_T8020_TTBR_VALID BIT(31)
>  #define DART_T8020_TTBR_ADDR_FIELD_SHIFT 0
>  #define DART_T8020_TTBR_SHIFT 12
> @@ -1184,6 +1185,35 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
>  	.ttbr_shift = DART_T8020_TTBR_SHIFT,
>  	.ttbr_count = 4,
>  };
> +
> +static const struct apple_dart_hw apple_dart_hw_t8103_usb4 = {
> +	.type = DART_T8020,
> +	.irq_handler = apple_dart_t8020_irq,
> +	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
> +	.oas = 36,
> +	.fmt = APPLE_DART,
> +	.max_sid_count = 64,
> +
> +	.enable_streams = DART_T8020_STREAMS_ENABLE,
> +	.lock = DART_T8020_CONFIG,
> +	.lock_bit = DART_T8020_CONFIG_LOCK,
> +
> +	.error = DART_T8020_ERROR,
> +
> +	.tcr = DART_T8020_TCR,
> +	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
> +	.tcr_disabled = 0,
> +	.tcr_bypass = 0,
> +
> +	.ttbr = DART_T8020_USB4_TTBR,
> +	.ttbr_valid = DART_T8020_TTBR_VALID,
> +	.ttbr_addr_field_shift = DART_T8020_TTBR_ADDR_FIELD_SHIFT,
> +	.ttbr_shift = DART_T8020_TTBR_SHIFT,
> +	.ttbr_count = 4,
> +
> +	.disable_bypass = true,
> +};
> +
>  static const struct apple_dart_hw apple_dart_hw_t6000 = {
>  	.type = DART_T6000,
>  	.irq_handler = apple_dart_t8020_irq,
> @@ -1276,6 +1306,7 @@ DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resum
>  
>  static const struct of_device_id apple_dart_of_match[] = {
>  	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
> +	{ .compatible = "apple,t8103-dart-usb4", .data = &apple_dart_hw_t8103_usb4 },
>  	{ .compatible = "apple,t8110-dart", .data = &apple_dart_hw_t8110 },
>  	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
>  	{},

Other than the compatible as per patch #1,

Acked-by: Hector Martin <marcan@marcan.st>

- Hector

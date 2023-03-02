Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F16A84DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCBPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCBPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:04:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E67457C3;
        Thu,  2 Mar 2023 07:04:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1556F1FB;
        Thu,  2 Mar 2023 07:05:05 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F5203F67D;
        Thu,  2 Mar 2023 07:04:20 -0800 (PST)
Message-ID: <f79c884a-e344-f434-7adb-8b9e3034027c@arm.com>
Date:   Thu, 2 Mar 2023 15:04:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/4] iommu: dart: Add flag to override bypass support
Content-Language: en-GB
To:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228202132.4919-1-sven@svenpeter.dev>
 <20230228202132.4919-3-sven@svenpeter.dev>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230228202132.4919-3-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 8:21 pm, Sven Peter wrote:
> The USB4 PCIe DARTs claim to support bypass but we never want to allow
> that on externally facing ports.

IOMMU drivers shouldn't be implementing their own individual policies 
for this - externally-facing ports should be correctly marked as 
such[1], so that the PCI layer is properly informed, which in turn will 
be picked up and handled properly by IOMMU core code.

Thanks,
Robin.

[1] see Documentation/devicetree/bindings/pci/pci.txt

> Acked-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   drivers/iommu/apple-dart.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 42666617803d..7d8b2b90cdb6 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -182,6 +182,8 @@ struct apple_dart_hw {
>   	u64 ttbr_addr_field_shift;
>   	u64 ttbr_shift;
>   	int ttbr_count;
> +
> +	bool disable_bypass;
>   };
>   
>   /*
> @@ -1075,6 +1077,9 @@ static int apple_dart_probe(struct platform_device *pdev)
>   	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
>   	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
>   
> +	if (dart->hw->disable_bypass)
> +		dart->supports_bypass = 0;
> +
>   	switch (dart->hw->type) {
>   	case DART_T8020:
>   	case DART_T6000:

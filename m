Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB4730C54
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFOApn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFOApl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4451BD2;
        Wed, 14 Jun 2023 17:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 518DE61735;
        Thu, 15 Jun 2023 00:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07031C433C8;
        Thu, 15 Jun 2023 00:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686789938;
        bh=S2S+YtPbtG6r9Kjt3PcHYqK4rpFVN5o+G4qfcm4Kt8I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GA/EV1al1Yu1YhR7NxUUzixoNQMFGNuHV3NT/lptBt0cMXTZCoyiDGtLD9OagEd6Y
         I2x8h2L1YikUfOvMY+j9YU/lZsn6luYqQNnYHhijb/A5slSsghVTHHiH7bVOTtPHxR
         xDH27GwwofzHOfmGzrOOZSyVQUXTRVpGUGywaRUEoEob36urt57DCsks6MxjVuTDTD
         08rnsu7hE3CLwigg1P8XME+8dHVYOZccK0eOZTGWYOHP2YhHn/mQbHO/hRV3PtVRJs
         B2gg6judzK0aY5UdosbZSL330Mk2NQapjzAnfGi+KSqx4T9MI385xFxyOAYQNiuj1v
         XKedlnqgh8qBw==
Message-ID: <1b6011e2-6ea0-21bc-77e9-90079443eeed@kernel.org>
Date:   Thu, 15 Jun 2023 09:45:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230614173633.2430653-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 02:36, Rob Herring wrote:
> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
> so other arches can't be enabled.

Yes, I tried... That is unfortunate.

Looks good to me though. If I get an Ack for patch 1, I can queue this up
through the ata tree.

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Tested on allmodconfig build. Not sure if there's other MIPS configs 
> where this doesn't work. We'll see what 0-day says.
> 
>  drivers/ata/Kconfig          | 4 ++--
>  drivers/ata/pata_octeon_cf.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 42b51c9812a0..4572f837e504 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -239,7 +239,7 @@ config AHCI_MVEBU
>  
>  config AHCI_OCTEON
>  	tristate "Cavium Octeon Soc Serial ATA"
> -	depends on SATA_AHCI_PLATFORM && CAVIUM_OCTEON_SOC
> +	depends on SATA_AHCI_PLATFORM && MIPS && (CAVIUM_OCTEON_SOC || COMPILE_TEST)
>  	default y
>  	help
>  	  This option enables support for Cavium Octeon SoC Serial ATA.
> @@ -373,7 +373,7 @@ config PDC_ADMA
>  
>  config PATA_OCTEON_CF
>  	tristate "OCTEON Boot Bus Compact Flash support"
> -	depends on CAVIUM_OCTEON_SOC
> +	depends on MIPS && (CAVIUM_OCTEON_SOC || COMPILE_TEST)
>  	select PATA_TIMINGS
>  	help
>  	  This option enables a polled compact flash driver for use with
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 57b2166a6d5d..cc9e4b63ded9 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -853,8 +853,8 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  					of_node_put(dma_node);
>  					return -EINVAL;
>  				}
> -				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
> -									 resource_size(res_dma));
> +				cf_port->dma_base = (uintptr_t)devm_ioremap(&pdev->dev, res_dma->start,
> +									    resource_size(res_dma));
>  				if (!cf_port->dma_base) {
>  					put_device(&dma_dev->dev);
>  					of_node_put(dma_node);

-- 
Damien Le Moal
Western Digital Research


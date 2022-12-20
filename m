Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7270652175
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLTN0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiLTNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:25:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 110501A07D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:25:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C41342F4;
        Tue, 20 Dec 2022 05:25:57 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD583F703;
        Tue, 20 Dec 2022 05:25:16 -0800 (PST)
Date:   Tue, 20 Dec 2022 13:25:13 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: highbank: fix of node handling in
 highbank_init_irq
Message-ID: <20221220132513.38d956e0@donnerap.cambridge.arm.com>
In-Reply-To: <20221218142647.394881-3-martin@kaiser.cx>
References: <20221218142647.394881-1-martin@kaiser.cx>
        <20221218142647.394881-3-martin@kaiser.cx>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2022 15:26:47 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

Hi Martin,

thanks for taking care of this.

> highbank_init calls of_find_compatible_node and discards the returned
> node. We should save the node and call of_node_put on it when finished.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/mach-highbank/highbank.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 97ccb8c1b3cd..54eb1422ef8f 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -50,10 +50,16 @@ static void highbank_l2c310_write_sec(unsigned long val, unsigned reg)
>  
>  static void __init highbank_init_irq(void)
>  {
> +	struct device_node *np;
> +
>  	irqchip_init();
>  
> -	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
> -		highbank_scu_map_io();
> +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9");
> +	if (!np)
> +		return;
> +
> +	highbank_scu_map_io();
> +	of_node_put(np);

Technically the of_node_put() could happen even earlier, since we
use the of_find_compatible_node() call only to figure out if this is the
Cotex-A15 or the A9 part. But it doesn't really matter, and is correct
anyways:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

I also quickly boot tested this on a Midway(A15), but don't have a
Highbank(A9) readily set up at the moment.

Cheers,
Andre


>  }
>  
>  static void highbank_power_off(void)


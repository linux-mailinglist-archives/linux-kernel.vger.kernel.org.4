Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC6652193
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiLTNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLTNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:32:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C983DB859
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:32:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8477C2F4;
        Tue, 20 Dec 2022 05:33:34 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1233F703;
        Tue, 20 Dec 2022 05:32:52 -0800 (PST)
Date:   Tue, 20 Dec 2022 13:32:50 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lv.ruyi@zte.com.cn, cgel.zte@gmail.com
Subject: Re: [PATCH 1/2] ARM: highbank: add missing of_node_put call
Message-ID: <20221220133250.3b38a17d@donnerap.cambridge.arm.com>
In-Reply-To: <20221218142647.394881-2-martin@kaiser.cx>
References: <20221218142647.394881-1-martin@kaiser.cx>
        <20221218142647.394881-2-martin@kaiser.cx>
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

On Sun, 18 Dec 2022 15:26:46 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

Hi Martin,

> A node that is returned by of_find_compatible_node has its refcount
> incremented. We have to call of_node_put when the node is no longer
> needed.
> 
> Add a missing of_node_put call in function highbank_init.

Thanks for the patch.
So Ruyi sent the exact same one earlier this year already:
https://lore.kernel.org/linux-arm-kernel/20220408094817.2494756-1-lv.ruyi@zte.com.cn/

I asked Arnd and Olof to take it back then (see my reply), but this somehow
got lost.

I will try to push on both Ruyi's and your second patch again - but I
guess only after the holidays.

Cheers,
Andre

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/mach-highbank/highbank.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 5d4f977ac7d2..97ccb8c1b3cd 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -141,6 +141,7 @@ static void __init highbank_init(void)
>  	/* Map system registers */
>  	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
>  	sregs_base = of_iomap(np, 0);
> +	of_node_put(np);
>  	WARN_ON(!sregs_base);
>  
>  	pm_power_off = highbank_power_off;


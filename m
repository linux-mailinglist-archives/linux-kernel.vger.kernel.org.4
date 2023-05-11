Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF526FEC05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEKG5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbjEKG46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF061B3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75886615F6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7ACC433EF;
        Thu, 11 May 2023 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683788191;
        bh=XyV9FW8+PV8Y7MKrYlKpsEw6GBkn5/onhsdvpfL+HJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UhuveI69YFJAOrlVLIlNiKqkUjQWXEPYUPux8QiDJ9nC8dJLOt9Iba1XL66Jw6bfM
         JtFLWNwQDicVeZiQ/3p5VL/yoBfFVhOL4LV/zYXECgq2xka3NejsUq6EMoJhIuWPuU
         EtvlcuYQH4mBvlEMKzP8dAN3qKfJgCj/Onlth3lLalgWycWLmqDs5+Vtixid3XiWrn
         JCy4gfC0GQAokhUD8EB0nhsd5iwgj+GZqxLXhzPxCm3xkA/EVUbQK3d2vhEpxboeL/
         clwkH0GeD71WXXNnfqIq1kq7VpOSMOG1lMtaCafS+WZv60G/B34PEaWFMMZJIqzO80
         WlCZkiMBs5FKg==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1px0E1-00EGBN-Cv;
        Thu, 11 May 2023 07:56:29 +0100
MIME-Version: 1.0
Date:   Thu, 11 May 2023 07:56:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ
 descriptors
In-Reply-To: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <479a18513b9d8c6e8ccb96093a0f0dd7@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: glaubitz@physik.fu-berlin.de, tglx@linutronix.de, dalias@libc.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-10 17:33, John Paul Adrian Glaubitz wrote:
> The initialization function for the J-Core AIC aic_irq_of_init() is
> currently missing the call to irq_alloc_descs() which allocates and
> initializes all the IRQ descriptors. Add missing function call and
> return the error code from irq_alloc_descs() in case the allocation
> fails.
> 
> Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  drivers/irqchip/irq-jcore-aic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-jcore-aic.c 
> b/drivers/irqchip/irq-jcore-aic.c
> index 5f47d8ee4ae3..b9dcc8e78c75 100644
> --- a/drivers/irqchip/irq-jcore-aic.c
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node 
> *node,
>  	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
>  	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
>  	struct irq_domain *domain;
> +	int ret;
> 
>  	pr_info("Initializing J-Core AIC\n");
> 
> @@ -100,6 +101,12 @@ static int __init aic_irq_of_init(struct 
> device_node *node,
>  	jcore_aic.irq_unmask = noop;
>  	jcore_aic.name = "AIC";
> 
> +	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
> +			      of_node_to_nid(node));
> +
> +	if (ret < 0)
> +		return ret;
> +
>  	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, 
> min_irq,
>  				       &jcore_aic_irqdomain_ops,
>  				       &jcore_aic);

[- Jason]

It really begs the question: how has it ever been working before?

Is there any plan to modernise the port and get it to allocate
irq_descs on demand, as we do on most architectures?

         M.
-- 
Jazz is not dead. It just smells funny...

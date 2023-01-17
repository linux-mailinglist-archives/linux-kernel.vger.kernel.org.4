Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9731466E8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAQVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjAQVit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:38:49 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910DCF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:04:31 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id HsC1pqrhhBIxsHsC1p8tQz; Tue, 17 Jan 2023 21:04:29 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 17 Jan 2023 21:04:29 +0100
X-ME-IP: 86.243.2.178
Message-ID: <463d23fe-8fac-408c-febc-6714df59beaf@wanadoo.fr>
Date:   Tue, 17 Jan 2023 21:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH linux-next] powerpc/cell/axon_msi: Use
 dma_zalloc_coherent()
Content-Language: fr
To:     ye.xingchen@zte.com.cn, arnd@arndb.de
Cc:     linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        linux-kernel@vger.kernel.org
References: <202301171706300144532@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202301171706300144532@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/01/2023 à 10:06, ye.xingchen@zte.com.cn a écrit :
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Instead of using dma_alloc_coherent() and memset() directly use
> dma_zalloc_coherent().
> 

Hi,

dma_zalloc_coherent() has been removed at the very beginning of 2019 in 
commit dfd32cad146e.

It is not existing since v5.0-rc2.

\o/

CJ


> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   arch/powerpc/platforms/cell/axon_msi.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 0c11aad896c7..8a4c522c8e67 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -358,8 +358,8 @@ static int axon_msi_probe(struct platform_device *device)
>   		goto out_free_msic;
>   	}
> 
> -	msic->fifo_virt = dma_alloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
> -					     &msic->fifo_phys, GFP_KERNEL);
> +	msic->fifo_virt = dma_zalloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
> +					      &msic->fifo_phys, GFP_KERNEL);
>   	if (!msic->fifo_virt) {
>   		printk(KERN_ERR "axon_msi: couldn't allocate fifo for %pOF\n",
>   		       dn);
> @@ -372,7 +372,6 @@ static int axon_msi_probe(struct platform_device *device)
>   		       dn);
>   		goto out_free_fifo;
>   	}
> -	memset(msic->fifo_virt, 0xff, MSIC_FIFO_SIZE_BYTES);
> 
>   	/* We rely on being able to stash a virq in a u16, so limit irqs to < 65536 */
>   	msic->irq_domain = irq_domain_add_nomap(dn, 65536, &msic_host_ops, msic);


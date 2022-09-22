Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8915E73E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIWGWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIWGVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:21:47 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC21257B8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:21:45 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 76E4620135F;
        Fri, 23 Sep 2022 06:21:43 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 6EDEA8090C; Thu, 22 Sep 2022 16:46:59 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:46:59 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Add __init/__exit annotations to module
 init/exit funcs
Message-ID: <Yyx1Y6OuLmYMQL6O@owl.dominikbrodowski.net>
References: <20220922112323.26353-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922112323.26353-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Sep 22, 2022 at 07:23:23PM +0800 schrieb Xiu Jianfeng:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to the pcmcia tree, sans the patch to vrc4171_card.c which is
already on its way out of the kernel.

Thanks,
	Dominik

> ---
>  drivers/pcmcia/i82092.c       | 4 ++--
>  drivers/pcmcia/vrc4171_card.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
> index 192c9049d654..a335748bdef5 100644
> --- a/drivers/pcmcia/i82092.c
> +++ b/drivers/pcmcia/i82092.c
> @@ -661,12 +661,12 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
>  	return 0;
>  }
>  
> -static int i82092aa_module_init(void)
> +static int __init i82092aa_module_init(void)
>  {
>  	return pci_register_driver(&i82092aa_pci_driver);
>  }
>  
> -static void i82092aa_module_exit(void)
> +static void __exit i82092aa_module_exit(void)
>  {
>  	pci_unregister_driver(&i82092aa_pci_driver);
>  	if (sockets[0].io_base > 0)
> diff --git a/drivers/pcmcia/vrc4171_card.c b/drivers/pcmcia/vrc4171_card.c
> index 177d77892144..ebaeb582539a 100644
> --- a/drivers/pcmcia/vrc4171_card.c
> +++ b/drivers/pcmcia/vrc4171_card.c
> @@ -699,7 +699,7 @@ static struct platform_driver vrc4171_card_driver = {
>  	},
>  };
>  
> -static int vrc4171_card_init(void)
> +static int __init vrc4171_card_init(void)
>  {
>  	int retval;
>  
> @@ -733,7 +733,7 @@ static int vrc4171_card_init(void)
>  	return 0;
>  }
>  
> -static void vrc4171_card_exit(void)
> +static void __exit vrc4171_card_exit(void)
>  {
>  	free_irq(vrc4171_irq, vrc4171_sockets);
>  	vrc4171_remove_sockets();
> -- 
> 2.17.1
> 

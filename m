Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FA63EE8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLAK6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLAK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:58:09 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2F4A7CA91;
        Thu,  1 Dec 2022 02:58:06 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p0hGS-0007Uq-02; Thu, 01 Dec 2022 11:58:00 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A0C2AC1EF5; Thu,  1 Dec 2022 11:52:50 +0100 (CET)
Date:   Thu, 1 Dec 2022 11:52:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     zhang.songyi@zte.com.cn
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mips/pci: use devm_platform_ioremap_resource()
Message-ID: <20221201105250.GC6569@alpha.franken.de>
References: <202211301551252968313@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211301551252968313@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:51:25PM +0800, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  arch/mips/pci/pci-rt3883.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
> index e07ae098bdd8..d59888aaed81 100644
> --- a/arch/mips/pci/pci-rt3883.c
> +++ b/arch/mips/pci/pci-rt3883.c
> @@ -404,7 +404,6 @@ static int rt3883_pci_probe(struct platform_device *pdev)
>         struct rt3883_pci_controller *rpc;
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
> -       struct resource *res;
>         struct device_node *child;
>         u32 val;
>         int err;
> @@ -414,8 +413,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
>         if (!rpc)
>                 return -ENOMEM;
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       rpc->base = devm_ioremap_resource(dev, res);
> +       rpc->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(rpc->base))
>                 return PTR_ERR(rpc->base);
> 
> --
> 2.15.2

this patch doesn't apply because it's white-space damaged.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

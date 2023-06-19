Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529367349A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFSBJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSBJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:09:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC59E1B0;
        Sun, 18 Jun 2023 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gO2zptOoLQLiyjtyvaW8d/6Cul+niKHHcLabUBFrFQ0=; b=EKbXsqEqrCekP8mvaBMtqhR7wd
        03hyPBgaVrcsW9TzGe0F0pDGuE4ov+peG880+eHlr4R8jEbedHztDkkujGUP+8ZAiVwokXAtKKGbf
        aCsfFn6vSnBXYFj1vTJLy57i8XPFV1GbnUqIOqv5EretiZAO+Fd6KZ+z6SSXH88WPU8A00rVhmmEG
        RoKYjZ7fUlAMbRPD40lIcUC+Eb8mnZDA920iLO/FEL7TFr7KhRoMjs6WkYWZ2WzzCtiM7muggsA8n
        AolJmS+sWAua/hPTfbSNf7vNwvghoh5WGV46vWtjhkqlL+FqbtaZd2gdfo7O8HqIxdR7Rmfu0Kc8+
        YgfQXeDA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qB3O7-0075Ld-0r;
        Mon, 19 Jun 2023 01:08:59 +0000
Message-ID: <aa528a08-c099-6a7d-32e9-7072ce91bff3@infradead.org>
Date:   Sun, 18 Jun 2023 18:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] SPARC: Fix parport_pc support for 32-bit platforms
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2306190121540.14084@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2306190121540.14084@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/23 18:01, Maciej W. Rozycki wrote:
> For 32-bit SPARC platforms PC-style parallel ports are only available as 
> PCI options.  Adjust <asm/parport.h> accordingly, fixing build errors:
> 
> sparc-linux-gnu-ld: drivers/parport/parport_pc.o: in function `ecpp_remove':
> parport_pc.c:(.text+0x8f0): undefined reference to `ebus_dma_irq_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x8f8): undefined reference to `ebus_dma_unregister'
> sparc-linux-gnu-ld: drivers/parport/parport_pc.o: in function `parport_pc_fifo_write_block_dma':
> parport_pc.c:(.text+0x1430): undefined reference to `ebus_dma_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x1444): undefined reference to `ebus_dma_prepare'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x14e4): undefined reference to `ebus_dma_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x14f4): undefined reference to `ebus_dma_request'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x1584): undefined reference to `ebus_dma_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x1594): undefined reference to `ebus_dma_residue'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x1608): undefined reference to `ebus_dma_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x1618): undefined reference to `ebus_dma_residue'
> sparc-linux-gnu-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
> parport_pc.c:(.text+0x33a0): undefined reference to `ebus_dma_register'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x33b8): undefined reference to `ebus_dma_irq_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x34b0): undefined reference to `ebus_dma_irq_enable'
> sparc-linux-gnu-ld: parport_pc.c:(.text+0x34bc): undefined reference to `ebus_dma_unregister'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org> 
> Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Cc: stable@vger.kernel.org # v5.18+

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks for fixing this.

> ---

> Changes from v1:
> 
> - Wrap `dma_spin_lock' into HAS_DMA to fix a "'dma_spin_lock' defined but 
>   not used" warning.  I think it's slightly cleaner this way compared to 
>   wrapping the whole part into CONFIG_SPARC64, as this better reflects the 
>   structure of the dependencies here.  It also follows the structure of 
>   parport_pc.c, which likewise has `parport_pc_fifo_write_block_dma' put 
>   into CONFIG_PARPORT_PC_FIFO and then HAS_DMA conditionals.
> 
> - Add Reported-by tag.
> ---
>  arch/sparc/include/asm/parport.h |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> linux-sparc32-parport-pc.diff
> Index: linux-macro/arch/sparc/include/asm/parport.h
> ===================================================================
> --- linux-macro.orig/arch/sparc/include/asm/parport.h
> +++ linux-macro/arch/sparc/include/asm/parport.h
> @@ -19,9 +19,11 @@
>   * While sparc64 doesn't have an ISA DMA API, we provide something that looks
>   * close enough to make parport_pc happy
>   */
> +#ifdef CONFIG_SPARC64
>  #define HAS_DMA
> +#endif
>  
> -#ifdef CONFIG_PARPORT_PC_FIFO
> +#if defined(CONFIG_PARPORT_PC_FIFO) && defined(HAS_DMA)
>  static DEFINE_SPINLOCK(dma_spin_lock);
>  
>  #define claim_dma_lock() \
> @@ -249,7 +251,8 @@ static struct platform_driver ecpp_drive
>  
>  static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
>  {
> -	return platform_driver_register(&ecpp_driver);
> +	return (IS_ENABLED(CONFIG_SPARC64) &&
> +		platform_driver_register(&ecpp_driver));
>  }
>  
>  #endif /* !(_ASM_SPARC64_PARPORT_H */

-- 
~Randy

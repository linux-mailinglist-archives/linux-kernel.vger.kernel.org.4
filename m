Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A32734948
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 01:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFRXUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 19:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:20:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65765E44;
        Sun, 18 Jun 2023 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GJTEjYL5z/lt+SoxF2bl4kul2vmCYYSoav4S28/6QTg=; b=FpTwS7uP4TSeOstJ8kPt54EQpZ
        OcV51tBxE1E18smX38m1oXfqs449ZRxkgtwbvI0dh8Ue0j37LUwz70TqC7RuZYAbRRWEHw2Ilqnrf
        VMGOerWvfKIABRSHuSkz6/m/7Kx5YEO9stQ0DO25d6VrV2jcojPrQJc8o5Z6LQ7+gwMT3SMLzxSCG
        OMt70oNhDR2n0Nn/f2ZVaK4qjfVsAt+pvt/JHpMM1MLJ0GGxN0i44cGEP9h+Z3PJrSD9qWX9KwO+c
        rYFPj6Ux9L6K6s7+50eVwP4CS8VAZe5AFl4YZkwPtZF73EFeGAbdqHxGemqH4dm7/fKStA2zFwhC7
        ckSLqjXw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qB1gT-006vXu-1r;
        Sun, 18 Jun 2023 23:19:49 +0000
Message-ID: <159350f1-bcb2-e81d-ce28-a07a698c468f@infradead.org>
Date:   Sun, 18 Jun 2023 16:19:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] SPARC: Fix parport_pc support for 32-bit platforms
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2306182347101.14084@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2306182347101.14084@angie.orcam.me.uk>
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

Hi--

On 6/18/23 16:00, Maciej W. Rozycki wrote:
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
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Cc: stable@vger.kernel.org # v5.18+

Yes, this fixes the build errors. Thanks for the patch.

There is one new warning that should be fixed as well:

<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from ../include/linux/spinlock.h:88,
                 from ../include/linux/kref.h:16,
                 from ../include/linux/mm_types.h:8,
                 from ../include/linux/buildid.h:5,
                 from ../include/linux/module.h:14,
                 from ../drivers/parport/parport_pc.c:46:
../arch/sparc/include/asm/parport.h:27:24: warning: 'dma_spin_lock' defined but not used [-Wunused-variable]
   27 | static DEFINE_SPINLOCK(dma_spin_lock);
      |                        ^~~~~~~~~~~~~
../include/linux/spinlock_types.h:43:44: note: in definition of macro 'DEFINE_SPINLOCK'
   43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
      |                                            ^


> ---
>  arch/sparc/include/asm/parport.h |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> linux-sparc32-parport-pc.diff
> Index: linux-macro/arch/sparc/include/asm/parport.h
> ===================================================================
> --- linux-macro.orig/arch/sparc/include/asm/parport.h
> +++ linux-macro/arch/sparc/include/asm/parport.h
> @@ -19,7 +19,9 @@
>   * While sparc64 doesn't have an ISA DMA API, we provide something that looks
>   * close enough to make parport_pc happy
>   */
> +#ifdef CONFIG_SPARC64
>  #define HAS_DMA
> +#endif
>  
>  #ifdef CONFIG_PARPORT_PC_FIFO
>  static DEFINE_SPINLOCK(dma_spin_lock);
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

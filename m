Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30972747905
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGDUa2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGDUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:30:25 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F34E76;
        Tue,  4 Jul 2023 13:30:24 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGmfC-001sRK-9Q; Tue, 04 Jul 2023 22:30:18 +0200
Received: from p5b13a7a5.dip0.t-ipconnect.de ([91.19.167.165] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGmfC-003WTr-1Z; Tue, 04 Jul 2023 22:30:18 +0200
Message-ID: <0ec80cb69e4ea5eed6ee29ed7f58ea649fb5c65e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/3] sh: dma: Fix dma channel offset calculation
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Jul 2023 22:30:17 +0200
In-Reply-To: <20230527164452.64797-2-contact@artur-rojek.eu>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
         <20230527164452.64797-2-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.167.165
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-27 at 18:44 +0200, Artur Rojek wrote:
> Various SoCs of the SH3, SH4 and SH4A family, which use this driver,
> feature a differing number of DMA channels, which can be distributed
> between up to two DMAC modules. Existing implementation fails to
> correctly accommodate for all those variations, resulting in wrong
> channel offset calculations and leading to kernel panics.
> 
> Rewrite dma_base_addr() in order to properly calculate channel offsets
> in a DMAC module. Fix dmaor_read_reg() and dmaor_write_reg(), so that
> the correct DMAC module base is selected for the DMAOR register.
> 
> Fixes: 7f47c7189b3e8f19 ("sh: dma: More legacy cpu dma chainsawing.")
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> v2: also handle differing numbers of DMAC modules and channels
> 
>  arch/sh/drivers/dma/dma-sh.c | 37 +++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
> index 96c626c2cd0a..306fba1564e5 100644
> --- a/arch/sh/drivers/dma/dma-sh.c
> +++ b/arch/sh/drivers/dma/dma-sh.c
> @@ -18,6 +18,18 @@
>  #include <cpu/dma-register.h>
>  #include <cpu/dma.h>
>  
> +/*
> + * Some of the SoCs feature two DMAC modules. In such a case, the channels are
> + * distributed equally among them.
> + */
> +#ifdef	SH_DMAC_BASE1
> +#define	SH_DMAC_NR_MD_CH	(CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
> +#else
> +#define	SH_DMAC_NR_MD_CH	CONFIG_NR_ONCHIP_DMA_CHANNELS
> +#endif
> +
> +#define	SH_DMAC_CH_SZ		0x10
> +
>  /*
>   * Define the default configuration for dual address memory-memory transfer.
>   * The 0x400 value represents auto-request, external->external.
> @@ -29,7 +41,7 @@ static unsigned long dma_find_base(unsigned int chan)
>  	unsigned long base = SH_DMAC_BASE0;
>  
>  #ifdef SH_DMAC_BASE1
> -	if (chan >= 6)
> +	if (chan >= SH_DMAC_NR_MD_CH)
>  		base = SH_DMAC_BASE1;
>  #endif
>  
> @@ -40,13 +52,13 @@ static unsigned long dma_base_addr(unsigned int chan)
>  {
>  	unsigned long base = dma_find_base(chan);
>  
> -	/* Normalize offset calculation */
> -	if (chan >= 9)
> -		chan -= 6;
> -	if (chan >= 4)
> -		base += 0x10;
> +	chan = (chan % SH_DMAC_NR_MD_CH) * SH_DMAC_CH_SZ;
> +
> +	/* DMAOR is placed inside the channel register space. Step over it. */
> +	if (chan >= DMAOR)
> +		base += SH_DMAC_CH_SZ;
>  
> -	return base + (chan * 0x10);
> +	return base + chan;
>  }
>  
>  #ifdef CONFIG_SH_DMA_IRQ_MULTI
> @@ -250,12 +262,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
>  #define NR_DMAOR	1
>  #endif
>  
> -/*
> - * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
> - * channels 0 - 5, DMAOR1 6 - 11 (optional).
> - */
> -#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
> -#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
> +#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * \
> +						    SH_DMAC_NR_MD_CH) + DMAOR)
> +#define dmaor_write_reg(n, data)	__raw_writew(data, \
> +						     dma_find_base((n) * \
> +						     SH_DMAC_NR_MD_CH) + DMAOR)
>  
>  static inline int dmaor_reset(int no)
>  {

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

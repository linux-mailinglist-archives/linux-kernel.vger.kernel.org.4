Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1207974C431
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGIMsZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 08:48:24 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D48B9;
        Sun,  9 Jul 2023 05:48:23 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qITpq-002AfV-QR; Sun, 09 Jul 2023 14:48:18 +0200
Received: from dynamic-077-191-183-238.77.191.pool.telefonica.de ([77.191.183.238] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qITpq-001CdG-Iz; Sun, 09 Jul 2023 14:48:18 +0200
Message-ID: <bb896c311151f8ccc7d3e919877641a5e9fbb3ff.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: hd64461: fix virq offsets
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Jul 2023 14:48:09 +0200
In-Reply-To: <20230709121311.211720-1-contact@artur-rojek.eu>
References: <20230709121311.211720-1-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.183.238
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur!

On Sun, 2023-07-09 at 14:13 +0200, Artur Rojek wrote:
> A recent change to start counting SuperH IRQ #s from 16 breaks support
> for the Hitachi HD64461 companion chip.
> 
> Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
> accommodate for the new virq numbering rules.
> 
> Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  arch/sh/cchips/Kconfig        | 4 ++--
>  arch/sh/include/asm/hd64461.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/cchips/Kconfig b/arch/sh/cchips/Kconfig
> index efde2edb5627..9659a0bc58de 100644
> --- a/arch/sh/cchips/Kconfig
> +++ b/arch/sh/cchips/Kconfig
> @@ -29,9 +29,9 @@ endchoice
>  config HD64461_IRQ
>  	int "HD64461 IRQ"
>  	depends on HD64461
> -	default "36"
> +	default "52"
>  	help
> -	  The default setting of the HD64461 IRQ is 36.
> +	  The default setting of the HD64461 IRQ is 52.
>  
>  	  Do not change this unless you know what you are doing.
>  
> diff --git a/arch/sh/include/asm/hd64461.h b/arch/sh/include/asm/hd64461.h
> index afb24cb034b1..6d85db6cf54b 100644
> --- a/arch/sh/include/asm/hd64461.h
> +++ b/arch/sh/include/asm/hd64461.h
> @@ -229,7 +229,7 @@
>  #define	HD64461_NIMR		HD64461_IO_OFFSET(0x5002)
>  
>  #define	HD64461_IRQBASE		OFFCHIP_IRQ_BASE
> -#define	OFFCHIP_IRQ_BASE	64
> +#define	OFFCHIP_IRQ_BASE	80
>  #define	HD64461_IRQ_NUM		16
>  
>  #define	HD64461_IRQ_UART	(HD64461_IRQBASE+5)

I think it would be better to write this as (64 + 16) for consistency
with the other changes made by Sergey.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925174C3E2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjGILxd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGILxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:53:31 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C6F9;
        Sun,  9 Jul 2023 04:53:30 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qISyd-001yBo-Ki; Sun, 09 Jul 2023 13:53:19 +0200
Received: from dynamic-077-191-183-238.77.191.pool.telefonica.de ([77.191.183.238] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qISyd-0016ew-Dc; Sun, 09 Jul 2023 13:53:19 +0200
Message-ID: <58697ba16c0e14aea7337330ae6f03bb35cd76ff.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL
 demux
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Jul 2023 13:53:09 +0200
In-Reply-To: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.183.238
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Sun, 2023-07-09 at 13:15 +0200, Geert Uytterhoeven wrote:
> When booting rts7751r2dplus_defconfig on QEMU, the system hangs due to
> an interrupt storm on IRQ 20.  IRQ 20 aka event 0x280 is a cascaded IRL
> interrupt, which maps to IRQ_VOYAGER, the interrupt used by the Silicon
> Motion SM501 multimedia companion chip.  As rts7751r2d_irq_demux() does
> not take into account the new virq offset, the interrupt is no longer
> translated, leading to an unhandled interrupt.
> 
> Fix this by taking into account the virq offset when translating
> cascaded IRL interrupts.
> 
> Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Highlander and Dreamcast probably have the same issue.
> I'll send patches for these later...
> ---
>  arch/sh/boards/mach-r2d/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-r2d/irq.c b/arch/sh/boards/mach-r2d/irq.c
> index e34f81e9ae813b8d..c37b40398c5bc83e 100644
> --- a/arch/sh/boards/mach-r2d/irq.c
> +++ b/arch/sh/boards/mach-r2d/irq.c
> @@ -117,10 +117,10 @@ static unsigned char irl2irq[R2D_NR_IRL];
>  
>  int rts7751r2d_irq_demux(int irq)
>  {
> -	if (irq >= R2D_NR_IRL || irq < 0 || !irl2irq[irq])
> +	if (irq >= 16 + R2D_NR_IRL || irq < 16 || !irl2irq[irq - 16])
>  		return irq;
>  
> -	return irl2irq[irq];
> +	return irl2irq[irq - 16];
>  }
>  
>  /*

I can also confirm that this fixes the hang on QEMU.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

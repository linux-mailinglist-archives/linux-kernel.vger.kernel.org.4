Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2635B72A911
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFJE4U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jun 2023 00:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFJE4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 00:56:18 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347CF3AAE;
        Fri,  9 Jun 2023 21:56:17 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q7qe6-003h2P-FM; Sat, 10 Jun 2023 06:56:14 +0200
Received: from dynamic-092-224-243-210.92.224.pool.telefonica.de ([92.224.243.210] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q7qe6-001Ksp-8Q; Sat, 10 Jun 2023 06:56:14 +0200
Message-ID: <e1363a71503a799824e5cb6e4595b559cc2e5313.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Sat, 10 Jun 2023 06:56:13 +0200
In-Reply-To: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 92.224.243.210
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-01 at 23:22 +0300, Sergey Shtylyov wrote:
> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> return -EINVAL instead.  However, the kernel code supporting SH3/4 based
> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> Fixes: ce753ad1549c ("platform: finally disallow IRQ0 in platform_get_irq() and its ilk")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> ---
> The patch is against Linus Torvalds' 'linux.git' repo.
> 
> Changes in version 6:
> - fixed up inconsistencies and did some rewording in the patch description.
> 
> Changes in version 5:
> - updated the patch description and the "Fixes:" tag as the patch disallowing
>   the use of IRQ0 was merged meanwhile.
> 
> Changes in version 4:
> - fixed up the off-chip base IRQ #s for the Dreamcast/Highlander/R2D/SE7724
>   boards.
> 
> Changes in version 3:
> - added an appropriate Fixes: tag and added a passage about it to the patch
>   description;
> - added actual cases of the boards using IRQ0 to the patch description;
> - added Geert Uytterhoeven's and John Paul Adrian Glaubitz's tags;
> - updated the link to point to the version 2 of the patch.
> 
> Changes in version 2:
> - changed cmp/ge to cmp/hs in the assembly code.
> 
>  arch/sh/include/mach-common/mach/highlander.h |    2 +-
>  arch/sh/include/mach-common/mach/r2d.h        |    2 +-
>  arch/sh/include/mach-dreamcast/mach/sysasic.h |    2 +-
>  arch/sh/include/mach-se/mach/se7724.h         |    2 +-
>  arch/sh/kernel/cpu/sh3/entry.S                |    4 ++--
>  include/linux/sh_intc.h                       |    6 +++---
>  6 files changed, 9 insertions(+), 9 deletions(-)
> 
> Index: linux/arch/sh/include/mach-common/mach/highlander.h
> ===================================================================
> --- linux.orig/arch/sh/include/mach-common/mach/highlander.h
> +++ linux/arch/sh/include/mach-common/mach/highlander.h
> @@ -176,7 +176,7 @@
>  #define IVDR_CK_ON	4		/* iVDR Clock ON */
>  #endif
>  
> -#define HL_FPGA_IRQ_BASE	200
> +#define HL_FPGA_IRQ_BASE	(200 + 16)
>  #define HL_NR_IRL		15
>  
>  #define IRQ_AX88796		(HL_FPGA_IRQ_BASE + 0)
> Index: linux/arch/sh/include/mach-common/mach/r2d.h
> ===================================================================
> --- linux.orig/arch/sh/include/mach-common/mach/r2d.h
> +++ linux/arch/sh/include/mach-common/mach/r2d.h
> @@ -47,7 +47,7 @@
>  
>  #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
>  
> -#define R2D_FPGA_IRQ_BASE	100
> +#define R2D_FPGA_IRQ_BASE	(100 + 16)
>  
>  #define IRQ_VOYAGER		(R2D_FPGA_IRQ_BASE + 0)
>  #define IRQ_EXT			(R2D_FPGA_IRQ_BASE + 1)
> Index: linux/arch/sh/include/mach-dreamcast/mach/sysasic.h
> ===================================================================
> --- linux.orig/arch/sh/include/mach-dreamcast/mach/sysasic.h
> +++ linux/arch/sh/include/mach-dreamcast/mach/sysasic.h
> @@ -22,7 +22,7 @@
>     takes.
>  */
>  
> -#define HW_EVENT_IRQ_BASE  48
> +#define HW_EVENT_IRQ_BASE  (48 + 16)
>  
>  /* IRQ 13 */
>  #define HW_EVENT_VSYNC     (HW_EVENT_IRQ_BASE +  5) /* VSync */
> Index: linux/arch/sh/include/mach-se/mach/se7724.h
> ===================================================================
> --- linux.orig/arch/sh/include/mach-se/mach/se7724.h
> +++ linux/arch/sh/include/mach-se/mach/se7724.h
> @@ -37,7 +37,7 @@
>  #define IRQ2_IRQ        evt2irq(0x640)
>  
>  /* Bits in IRQ012 registers */
> -#define SE7724_FPGA_IRQ_BASE	220
> +#define SE7724_FPGA_IRQ_BASE	(220 + 16)
>  
>  /* IRQ0 */
>  #define IRQ0_BASE	SE7724_FPGA_IRQ_BASE
> Index: linux/arch/sh/kernel/cpu/sh3/entry.S
> ===================================================================
> --- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
> +++ linux/arch/sh/kernel/cpu/sh3/entry.S
> @@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
>  	mov	r4, r0		! save vector->jmp table offset for later
>  
>  	shlr2	r4		! vector to IRQ# conversion
> -	add	#-0x10, r4
>  
> -	cmp/pz	r4		! is it a valid IRQ?
> +	mov	#0x10, r5
> +	cmp/hs	r5, r4		! is it a valid IRQ?
>  	bt	10f
>  
>  	/*
> Index: linux/include/linux/sh_intc.h
> ===================================================================
> --- linux.orig/include/linux/sh_intc.h
> +++ linux/include/linux/sh_intc.h
> @@ -13,9 +13,9 @@
>  /*
>   * Convert back and forth between INTEVT and IRQ values.
>   */
> -#ifdef CONFIG_CPU_HAS_INTEVT
> -#define evt2irq(evt)		(((evt) >> 5) - 16)
> -#define irq2evt(irq)		(((irq) + 16) << 5)
> +#ifdef CONFIG_CPU_HAS_INTEVT	/* Avoid IRQ0 (invalid for platform devices) */
> +#define evt2irq(evt)		((evt) >> 5)
> +#define irq2evt(irq)		((irq) << 5)
>  #else
>  #define evt2irq(evt)		(evt)
>  #define irq2evt(irq)		(irq)

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

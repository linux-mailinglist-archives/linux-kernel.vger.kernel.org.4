Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9026EA8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDULDq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjDULDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:03:43 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0291902A;
        Fri, 21 Apr 2023 04:03:38 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ppoY8-001WVG-R2; Fri, 21 Apr 2023 13:03:32 +0200
Received: from p57bd9bea.dip0.t-ipconnect.de ([87.189.155.234] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ppoY8-001DxP-Hy; Fri, 21 Apr 2023 13:03:32 +0200
Message-ID: <434fe02c2c774ae4d1694ff222884bc5d5fc25e6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3] sh: Use generic GCC library routines
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, linux-sh@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Apr 2023 13:03:31 +0200
In-Reply-To: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
References: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.234
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Thu, 2023-03-23 at 11:18 +0100, Geert Uytterhoeven wrote:
> The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() in
> arch/sh/lib/ are identical to the generic C implementations in lib/.
> Reduce duplication by switching SH to the generic versions.
> 
> Update the include path in arch/sh/boot/compressed accordingly.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> v3:
>   - Add Acked-by,
> 
> v2:
>   - Fix silly typo in subject.
> 
> Tested on landisk and qemu/rts7751r2d.
> 
> Note that it also works without the change to arch/sh/boot/compressed/,
> as lib/ashldi3.c can be reached via both include/uapi/../../lib/ashldi3.c
> and arch/sh/boot/compressed/../../../../lib/ashldi3.c.
> 
> Palmer tried a similar thing before:
> https://lore.kernel.org/linux-arch/20170523220546.16758-1-palmer@dabbelt.com/
> but initially it broke the SH build due to a missing change to
> arch/sh/boot/compressed/, and the later update never got picked up.
> In the mean time, arch/sh/boot/compressed/ was changed, so his patch no
> longer applies.
> 
> Similar for the other architectures, I guess?
> ---
>  arch/sh/Kconfig                   |  3 +++
>  arch/sh/boot/compressed/ashldi3.c |  4 ++--
>  arch/sh/lib/Makefile              |  4 +---
>  arch/sh/lib/ashldi3.c             | 30 -----------------------------
>  arch/sh/lib/ashrdi3.c             | 32 -------------------------------
>  arch/sh/lib/lshrdi3.c             | 30 -----------------------------
>  6 files changed, 6 insertions(+), 97 deletions(-)
>  delete mode 100644 arch/sh/lib/ashldi3.c
>  delete mode 100644 arch/sh/lib/ashrdi3.c
>  delete mode 100644 arch/sh/lib/lshrdi3.c
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index ccb866750a884643..892903dc74990c36 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -20,6 +20,9 @@ config SUPERH
>  	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_SHOW
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_LSHRDI3
>  	select GENERIC_PCI_IOMAP if PCI
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
> diff --git a/arch/sh/boot/compressed/ashldi3.c b/arch/sh/boot/compressed/ashldi3.c
> index 7cebd646df839b48..7c12121702309e8c 100644
> --- a/arch/sh/boot/compressed/ashldi3.c
> +++ b/arch/sh/boot/compressed/ashldi3.c
> @@ -1,2 +1,2 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -#include "../../lib/ashldi3.c"
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include "../../../../lib/ashldi3.c"
> diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
> index eb473d373ca43a4b..d20a0768b31fa2b6 100644
> --- a/arch/sh/lib/Makefile
> +++ b/arch/sh/lib/Makefile
> @@ -7,9 +7,7 @@ lib-y  = delay.o memmove.o memchr.o \
>  	 checksum.o strlen.o div64.o div64-generic.o
>  
>  # Extracted from libgcc
> -obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
> -	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
> -	 udiv_qrnnd.o
> +obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o

Why are the single-precision (denoted as "si") variants not being replaced?

Don't we have generic versions for these?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

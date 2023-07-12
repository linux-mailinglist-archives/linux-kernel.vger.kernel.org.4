Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E674FEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGLFRZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 01:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGLFRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:17:23 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE0A6;
        Tue, 11 Jul 2023 22:17:22 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qJSE1-002Abj-Sp; Wed, 12 Jul 2023 07:17:17 +0200
Received: from p57bd9f0d.dip0.t-ipconnect.de ([87.189.159.13] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qJSE1-00178e-Lk; Wed, 12 Jul 2023 07:17:17 +0200
Message-ID: <59a2401742367b2921a154ff4be04d86de63acf7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] [RFC] sh: dreamcast: Handle virq offset in cascaded IRQ
 demux
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 07:17:16 +0200
In-Reply-To: <7d0cb246c9f1cd24bb1f637ec5cb67e799a4c3b8.1688908227.git.geert+renesas@glider.be>
References: <7d0cb246c9f1cd24bb1f637ec5cb67e799a4c3b8.1688908227.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.13
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

On Sun, 2023-07-09 at 15:10 +0200, Geert Uytterhoeven wrote:
> Take into account the virq offset when translating cascaded interrupts.
> 
> Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  arch/sh/boards/mach-dreamcast/irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> index cc06e4cdb4cdf9b7..4e5fb59481a26747 100644
> --- a/arch/sh/boards/mach-dreamcast/irq.c
> +++ b/arch/sh/boards/mach-dreamcast/irq.c
> @@ -108,13 +108,13 @@ int systemasic_irq_demux(int irq)
>  	__u32 j, bit;
>  
>  	switch (irq) {
> -	case 13:
> +	case 16 + 13:
>  		level = 0;
>  		break;
> -	case 11:
> +	case 16 + 11:
>  		level = 1;
>  		break;
> -	case  9:
> +	case 16 + 9:
>  		level = 2;
>  		break;
>  	default:

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

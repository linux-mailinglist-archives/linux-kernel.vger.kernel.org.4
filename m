Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144386F97B7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjEGId3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 May 2023 04:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:33:27 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B9812085;
        Sun,  7 May 2023 01:33:26 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pvZpX-001LSN-Kv; Sun, 07 May 2023 10:33:19 +0200
Received: from p57bd9c27.dip0.t-ipconnect.de ([87.189.156.39] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pvZpX-003FzF-Cv; Sun, 07 May 2023 10:33:19 +0200
Message-ID: <c630350f51eb3bf85d2a7fb7c51b3f1ba3a57c4f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 07 May 2023 10:33:17 +0200
In-Reply-To: <20230506141703.65605-3-contact@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-3-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.156.39
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
> According to the PM, the DMAC found in SH7709 features only 4 channels.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  arch/sh/drivers/dma/Kconfig | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
> index 7d54f284ce10..4494d09597e9 100644
> --- a/arch/sh/drivers/dma/Kconfig
> +++ b/arch/sh/drivers/dma/Kconfig
> @@ -28,8 +28,9 @@ config SH_DMA_API
>  config NR_ONCHIP_DMA_CHANNELS
>  	int
>  	depends on SH_DMA
> -	default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
> -		       CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
> +	default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
> +		       CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7750S || \
> +		       CPU_SUBTYPE_SH7091
>  	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
>  		       CPU_SUBTYPE_SH7760
>  	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
> @@ -37,8 +38,9 @@ config NR_ONCHIP_DMA_CHANNELS
>  	default "6"
>  	help
>  	  This allows you to specify the number of channels that the on-chip
> -	  DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
> -	  SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
> +	  DMAC supports. This will be 4 for SH7709/SH7750/SH7751/Sh7750S/SH7091
> +	  and 8 for the SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724,
> +	  default is 6.
>  
>  config SH_DMABRG
>  	bool "SH7760 DMABRG support"

I will replace "PM" with "processor manual" since the acronym is not necessarily
unambiguous, at least I didn't know at first what you were referring to. I checked
the manual [1] myself and four DMA channels is correct, thus:

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

> [1] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual?r=1055106 (S. 373)

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

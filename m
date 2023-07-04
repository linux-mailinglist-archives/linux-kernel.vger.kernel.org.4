Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92474790D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGDUfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDUfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:35:21 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003BE7B;
        Tue,  4 Jul 2023 13:35:19 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGmjy-001tUd-KH; Tue, 04 Jul 2023 22:35:14 +0200
Received: from p5b13a7a5.dip0.t-ipconnect.de ([91.19.167.165] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGmjy-003Xme-Ci; Tue, 04 Jul 2023 22:35:14 +0200
Message-ID: <f4faecbcc04acb2eb8022327da1ebb56617b732f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Jul 2023 22:35:13 +0200
In-Reply-To: <20230527164452.64797-4-contact@artur-rojek.eu>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
         <20230527164452.64797-4-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.167.165
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

On Sat, 2023-05-27 at 18:44 +0200, Artur Rojek wrote:
> According to the hardware manual [1], the DMAC found in SH7709 features
> only 4 channels.
> 
> While at it, also sort the existing targets and clarify that
> NR_ONCHIP_DMA_CHANNELS must be a multiply of two.
> 
> [1] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual (p. 373)
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> v2: - sort existing targets
>     - clarify that the value must be a multiply of two
> 
>  arch/sh/drivers/dma/Kconfig | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
> index 7d54f284ce10..382fbb189fcf 100644
> --- a/arch/sh/drivers/dma/Kconfig
> +++ b/arch/sh/drivers/dma/Kconfig
> @@ -28,17 +28,19 @@ config SH_DMA_API
>  config NR_ONCHIP_DMA_CHANNELS
>  	int
>  	depends on SH_DMA
> -	default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
> -		       CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
> +	default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
> +		       CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7751 || \
> +		       CPU_SUBTYPE_SH7091
>  	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
>  		       CPU_SUBTYPE_SH7760
> -	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
> -			CPU_SUBTYPE_SH7785 || CPU_SUBTYPE_SH7724
> +	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7724  || \
> +			CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
>  	default "6"
>  	help
>  	  This allows you to specify the number of channels that the on-chip
> -	  DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
> -	  SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
> +	  DMAC supports. This will be 4 for SH7709/SH7750/SH7750S/SH7751/SH7091,
> +	  8 for SH7750R/SH7751R/SH7760, and 12 for SH7723/SH7724/SH7780/SH7785.
> +	  Default is 6. Must be an even number.
>  
>  config SH_DMABRG
>  	bool "SH7760 DMABRG support"

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

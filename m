Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435216F97BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjEGIj0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 May 2023 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:39:25 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D9E55BF;
        Sun,  7 May 2023 01:39:24 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pvZvK-001MM2-9r; Sun, 07 May 2023 10:39:18 +0200
Received: from p57bd9c27.dip0.t-ipconnect.de ([87.189.156.39] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pvZvK-003HIr-2d; Sun, 07 May 2023 10:39:18 +0200
Message-ID: <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 07 May 2023 10:39:17 +0200
In-Reply-To: <20230506141703.65605-2-contact@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-2-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.156.39
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
> Squash two bugs introduced into said macros in 7f47c7189b3e, preventing
> them from proper operation:
> 1) Add DMAOR register offset into the address of the hw reg access,
> 2) Correct a nasty typo in the DMAOR base calculation for
>    `dmaor_write_reg`.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  arch/sh/drivers/dma/dma-sh.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
> index 96c626c2cd0a..14c18ebda400 100644
> --- a/arch/sh/drivers/dma/dma-sh.c
> +++ b/arch/sh/drivers/dma/dma-sh.c
> @@ -254,8 +254,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
>   * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
>   * channels 0 - 5, DMAOR1 6 - 11 (optional).
>   */
> -#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
> -#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
> +#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * 6) + \
> +						    DMAOR)
> +#define dmaor_write_reg(n, data)	__raw_writew(data, \
> +						     dma_find_base((n) * 6) + \
> +						     DMAOR)
>  
>  static inline int dmaor_reset(int no)
>  {

I have looked through the changes and the code and I agree that there is a typo
in dmaor_write_regn() that needs to be fixed and that the DMAOR offset is missing
although I don't understand why that didn't break the kernel on other SuperH systems
such as my SH-7785LCR evaluation board or the LANDISK board which Geert uses.

What I also don't understand is the factor 6 the DMA channel number is multiplied
with. When looking at the definition of dma_find_base(), it seems that every channel
equal to 6 or higher will return SH_DMAC_BASE1 as DMA base address. But if we multiply
the parameter with 6, this will apply to every n > 0. Is that correct?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

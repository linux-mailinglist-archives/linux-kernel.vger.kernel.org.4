Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBE6F9839
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEGKc4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 May 2023 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEGKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 06:32:54 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244AB100C1;
        Sun,  7 May 2023 03:32:53 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pvbh8-001twK-Oi; Sun, 07 May 2023 12:32:46 +0200
Received: from p57bd9c27.dip0.t-ipconnect.de ([87.189.156.39] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pvbh8-003hBo-Hc; Sun, 07 May 2023 12:32:46 +0200
Message-ID: <ef8a4c361255303359b003185e50f47cf3b422f0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 07 May 2023 12:32:45 +0200
In-Reply-To: <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-2-contact@artur-rojek.eu>
         <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
         <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
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

On Sun, 2023-05-07 at 11:34 +0200, Artur Rojek wrote:
> Hi Adrian,
> 
> On 2023-05-07 10:39, John Paul Adrian Glaubitz wrote:
> > On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
> > > Squash two bugs introduced into said macros in 7f47c7189b3e, 
> > > preventing
> > > them from proper operation:
> > > 1) Add DMAOR register offset into the address of the hw reg access,
> > > 2) Correct a nasty typo in the DMAOR base calculation for
> > >    `dmaor_write_reg`.
> > > 
> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > > ---
> > >  arch/sh/drivers/dma/dma-sh.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/sh/drivers/dma/dma-sh.c 
> > > b/arch/sh/drivers/dma/dma-sh.c
> > > index 96c626c2cd0a..14c18ebda400 100644
> > > --- a/arch/sh/drivers/dma/dma-sh.c
> > > +++ b/arch/sh/drivers/dma/dma-sh.c
> > > @@ -254,8 +254,11 @@ static int sh_dmac_get_dma_residue(struct 
> > > dma_channel *chan)
> > >   * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
> > >   * channels 0 - 5, DMAOR1 6 - 11 (optional).
> > >   */
> > > -#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
> > > -#define dmaor_write_reg(n, data)	__raw_writew(data, 
> > > dma_find_base(n)*6)
> > > +#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * 6) + \
> > > +						    DMAOR)
> > > +#define dmaor_write_reg(n, data)	__raw_writew(data, \
> > > +						     dma_find_base((n) * 6) + \
> > > +						     DMAOR)
> > > 
> > >  static inline int dmaor_reset(int no)
> > >  {
> > 
> > I have looked through the changes and the code and I agree that there 
> > is a typo
> > in dmaor_write_regn() that needs to be fixed and that the DMAOR offset
> > is missing
> > although I don't understand why that didn't break the kernel on other
> > SuperH systems
> > such as my SH-7785LCR evaluation board or the LANDISK board which Geert 
> > uses.
> 
> I also wondered that. On SH7709 it's a hard panic, it should be the same
> elsewhere.

I will give the patch a spin on my SH-7785LCR and see if it breaks anything.

Maybe Geert can test it on his LANDISK board as well as Rob on the J2 Turtleboard,
just to be safe.

> > What I also don't understand is the factor 6 the DMA channel number is
> > multiplied
> > with. When looking at the definition of dma_find_base(), it seems that
> > every channel
> > equal to 6 or higher will return SH_DMAC_BASE1 as DMA base address.
> > But if we multiply
> > the parameter with 6, this will apply to every n > 0. Is that correct?
> 
> As confusing as they look, those macros take dmaor index (a number in
> range 0 <= n < NR_DMAOR) as parameter, then multiply it by 6 to convert
> it to a format compatible with `dma_find_base` (which expects a channel
> index). In practice `n` will be either 0 or 1, so dma_find_base(0 * 6)
> will return SH_DMAC_BASE0, while dma_find_base(1 * 6) SH_DMAC_BASE1.

OK, thanks for the clarification. Let's wait what Geert has to say on this
next week when he is back online.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

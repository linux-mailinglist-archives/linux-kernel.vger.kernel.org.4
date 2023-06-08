Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EB727BF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjFHJyt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjFHJyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:54:46 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD86269E;
        Thu,  8 Jun 2023 02:54:42 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q7CLi-000Po7-Rc; Thu, 08 Jun 2023 11:54:34 +0200
Received: from p57bd96d9.dip0.t-ipconnect.de ([87.189.150.217] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q7CLi-0046Or-KG; Thu, 08 Jun 2023 11:54:34 +0200
Message-ID: <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Jun 2023 11:54:33 +0200
In-Reply-To: <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
         <20230527164452.64797-4-contact@artur-rojek.eu>
         <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.217
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for being so late to the party.

On Wed, 2023-06-07 at 11:16 +0200, Geert Uytterhoeven wrote:
> Hi Artur,
> 
> On Sat, May 27, 2023 at 6:45 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> > According to the hardware manual [1], the DMAC found in SH7709 features
> > only 4 channels.
> > 
> > While at it, also sort the existing targets and clarify that
> > NR_ONCHIP_DMA_CHANNELS must be a multiply of two.
> > 
> > [1] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual (p. 373)
> > 
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > ---
> > 
> > v2: - sort existing targets
> 
> Thanks for the update!
> 
> >     - clarify that the value must be a multiply of two
> 
> That's only true when there are two DMACs, right?
> 
> Even in that case, you could mitigate that by avoiding the division by
> 
>     #ifdef SH_DMAC_BASE1
>    -#define        SH_DMAC_NR_MD_CH        (CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
>    +#define        SH_DMAC_NR_MD_CH        6
>     #else
>     #define        SH_DMAC_NR_MD_CH        CONFIG_NR_ONCHIP_DMA_CHANNELS
>     #endif

Aren't we dropping SH_DMAC_BASE1 in the other patch anyway?

> That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> when configuring his kernel, thus breaking DMA  due to an incorrect
> value of SH_DMAC_NR_MD_CH.
> 
> Unfortunately we cannot protect against that when using a single DMAC,
> as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> 
> Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> to protect against a user overriding this value?

Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

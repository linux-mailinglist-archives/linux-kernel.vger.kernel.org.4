Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A570167A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjEMLmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:42:09 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320E40F9;
        Sat, 13 May 2023 04:41:57 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id DBF811BF206;
        Sat, 13 May 2023 11:41:54 +0000 (UTC)
MIME-Version: 1.0
Date:   Sat, 13 May 2023 13:41:54 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
In-Reply-To: <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <20230506141703.65605-2-contact@artur-rojek.eu>
 <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
 <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
 <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
Message-ID: <309305917494c5a6c7cfb7ecb8bbf766@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 13:20, Geert Uytterhoeven wrote:
> Hi Artur,
> 
> On Sun, May 7, 2023 at 11:43 AM Artur Rojek <contact@artur-rojek.eu> 
> wrote:
>> On 2023-05-07 10:39, John Paul Adrian Glaubitz wrote:
>> > On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
>> >> Squash two bugs introduced into said macros in 7f47c7189b3e,
>> >> preventing
>> >> them from proper operation:
>> >> 1) Add DMAOR register offset into the address of the hw reg access,
>> >> 2) Correct a nasty typo in the DMAOR base calculation for
>> >>    `dmaor_write_reg`.
>> >>
>> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>\
> 
> Thanks for your patch!
> 
>> >> --- a/arch/sh/drivers/dma/dma-sh.c
>> >> +++ b/arch/sh/drivers/dma/dma-sh.c
>> >> @@ -254,8 +254,11 @@ static int sh_dmac_get_dma_residue(struct
>> >> dma_channel *chan)
>> >>   * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
>> >>   * channels 0 - 5, DMAOR1 6 - 11 (optional).
>> >>   */
>> >> -#define dmaor_read_reg(n)           __raw_readw(dma_find_base((n)*6))
>> >> -#define dmaor_write_reg(n, data)    __raw_writew(data,
>> >> dma_find_base(n)*6)
>> >> +#define dmaor_read_reg(n)           __raw_readw(dma_find_base((n) * 6) + \
>> >> +                                                DMAOR)
>> >> +#define dmaor_write_reg(n, data)    __raw_writew(data, \
>> >> +                                                 dma_find_base((n) * 6) + \
>> >> +                                                 DMAOR)
> 
> Fixes: 7f47c7189b3e8f19 ("sh: dma: More legacy cpu dma chainsawing.")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>> >>  static inline int dmaor_reset(int no)
>> >>  {
>> >
>> > I have looked through the changes and the code and I agree that there
>> > is a typo
>> > in dmaor_write_regn() that needs to be fixed and that the DMAOR offset
>> > is missing
>> > although I don't understand why that didn't break the kernel on other
>> > SuperH systems
>> > such as my SH-7785LCR evaluation board or the LANDISK board which Geert
>> > uses.
>> 
>> I also wondered that. On SH7709 it's a hard panic, it should be the 
>> same
>> elsewhere.
> 
> Landisk does not seem to use DMA.
> I did have CONFIG_SH_DMA=n, but enabling it does not make any 
> difference.
> 
>> > What I also don't understand is the factor 6 the DMA channel number is
>> > multiplied
>> > with. When looking at the definition of dma_find_base(), it seems that
>> > every channel
>> > equal to 6 or higher will return SH_DMAC_BASE1 as DMA base address.
>> > But if we multiply
>> > the parameter with 6, this will apply to every n > 0. Is that correct?
>> 
>> As confusing as they look, those macros take dmaor index (a number in
>> range 0 <= n < NR_DMAOR) as parameter, then multiply it by 6 to 
>> convert
>> it to a format compatible with `dma_find_base` (which expects a 
>> channel
>> index). In practice `n` will be either 0 or 1, so dma_find_base(0 * 6)
>> will return SH_DMAC_BASE0, while dma_find_base(1 * 6) SH_DMAC_BASE1.
> 
> Looks like this is still broken on e.g. SH7751R, which has 8 channels,
> both handled by a single DMAOR register at offset 0x40...
> 
> While e.g. dma_base_addr() seems to have some provision for this
> (cfr. the "chan >= 9" (not "8") check), dma_find_base() will fail, as
> arch/sh/include/cpu-sh4/cpu/dma.h defines SH_DMAC_BASE1.

Yikes!
If this series hasn't been merged yet, perhaps we could fix this issue
in v2. I have something like this in mind (untested):
```
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 14c18ebda400..306fba1564e5 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -18,6 +18,18 @@
  #include <cpu/dma-register.h>
  #include <cpu/dma.h>

+/*
+ * Some of the SoCs feature two DMAC modules. In such a case, the 
channels are
+ * distributed equally among them.
+ */
+#ifdef SH_DMAC_BASE1
+#define        SH_DMAC_NR_MD_CH        (CONFIG_NR_ONCHIP_DMA_CHANNELS / 
2)
+#else
+#define        SH_DMAC_NR_MD_CH        CONFIG_NR_ONCHIP_DMA_CHANNELS
+#endif
+
+#define        SH_DMAC_CH_SZ           0x10
+
  /*
   * Define the default configuration for dual address memory-memory 
transfer.
   * The 0x400 value represents auto-request, external->external.
@@ -29,7 +41,7 @@ static unsigned long dma_find_base(unsigned int chan)
         unsigned long base = SH_DMAC_BASE0;

  #ifdef SH_DMAC_BASE1
-       if (chan >= 6)
+       if (chan >= SH_DMAC_NR_MD_CH)
                 base = SH_DMAC_BASE1;
  #endif

@@ -40,13 +52,13 @@ static unsigned long dma_base_addr(unsigned int 
chan)
  {
         unsigned long base = dma_find_base(chan);

-       /* Normalize offset calculation */
-       if (chan >= 9)
-               chan -= 6;
-       if (chan >= 4)
-               base += 0x10;
+       chan = (chan % SH_DMAC_NR_MD_CH) * SH_DMAC_CH_SZ;
+
+       /* DMAOR is placed inside the channel register space. Step over 
it. */
+       if (chan >= DMAOR)
+               base += SH_DMAC_CH_SZ;

-       return base + (chan * 0x10);
+       return base + chan;
  }

  #ifdef CONFIG_SH_DMA_IRQ_MULTI
@@ -250,15 +262,11 @@ static int sh_dmac_get_dma_residue(struct 
dma_channel *chan)
  #define NR_DMAOR       1
  #endif

-/*
- * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
- * channels 0 - 5, DMAOR1 6 - 11 (optional).
- */
-#define dmaor_read_reg(n)              __raw_readw(dma_find_base((n) * 
6) + \
-                                                   DMAOR)
+#define dmaor_read_reg(n)              __raw_readw(dma_find_base((n) * 
\
+                                                   SH_DMAC_NR_MD_CH) + 
DMAOR)
  #define dmaor_write_reg(n, data)       __raw_writew(data, \
-                                                    dma_find_base((n) * 
6) + \
-                                                    DMAOR)
+                                                    dma_find_base((n) * 
\
+                                                    SH_DMAC_NR_MD_CH) + 
DMAOR)

  static inline int dmaor_reset(int no)
  {

```
Otherwise, I'll send it in separately. Of course we'll also need to fix
`SH_DMAC_BASE1` so that it's set only for SoCs that feature two DMAC
modules...

Cheers,
Artur

> Anyway, that's not new, so I have no objection to your patch.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert


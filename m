Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4869174E237
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGJXZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGJXZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:25:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A498;
        Mon, 10 Jul 2023 16:25:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 8D4A4C0003;
        Mon, 10 Jul 2023 23:25:09 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 01:25:09 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: hd64461: fix virq offsets
In-Reply-To: <8c075658d00953ecb4383e1910c7b04fdaf870dd.camel@physik.fu-berlin.de>
References: <20230709121311.211720-1-contact@artur-rojek.eu>
 <bb896c311151f8ccc7d3e919877641a5e9fbb3ff.camel@physik.fu-berlin.de>
 <2c57d9cc03b6a430234c0016bf78fa22@artur-rojek.eu>
 <8c075658d00953ecb4383e1910c7b04fdaf870dd.camel@physik.fu-berlin.de>
Message-ID: <e109b448163cae9c33c285fbb2f46063@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-09 14:59, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On Sun, 2023-07-09 at 14:56 +0200, Artur Rojek wrote:
>> On 2023-07-09 14:48, John Paul Adrian Glaubitz wrote:
>> > Hi Artur!
>> >
>> > On Sun, 2023-07-09 at 14:13 +0200, Artur Rojek wrote:
>> > > A recent change to start counting SuperH IRQ #s from 16 breaks support
>> > > for the Hitachi HD64461 companion chip.
>> > >
>> > > Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
>> > > accommodate for the new virq numbering rules.
>> > >
>> > > Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
>> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> > > ---
>> > >  arch/sh/cchips/Kconfig        | 4 ++--
>> > >  arch/sh/include/asm/hd64461.h | 2 +-
>> > >  2 files changed, 3 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/arch/sh/cchips/Kconfig b/arch/sh/cchips/Kconfig
>> > > index efde2edb5627..9659a0bc58de 100644
>> > > --- a/arch/sh/cchips/Kconfig
>> > > +++ b/arch/sh/cchips/Kconfig
>> > > @@ -29,9 +29,9 @@ endchoice
>> > >  config HD64461_IRQ
>> > >  	int "HD64461 IRQ"
>> > >  	depends on HD64461
>> > > -	default "36"
>> > > +	default "52"
>> > >  	help
>> > > -	  The default setting of the HD64461 IRQ is 36.
>> > > +	  The default setting of the HD64461 IRQ is 52.
>> > >
>> > >  	  Do not change this unless you know what you are doing.
>> > >
>> > > diff --git a/arch/sh/include/asm/hd64461.h
>> > > b/arch/sh/include/asm/hd64461.h
>> > > index afb24cb034b1..6d85db6cf54b 100644
>> > > --- a/arch/sh/include/asm/hd64461.h
>> > > +++ b/arch/sh/include/asm/hd64461.h
>> > > @@ -229,7 +229,7 @@
>> > >  #define	HD64461_NIMR		HD64461_IO_OFFSET(0x5002)
>> > >
>> > >  #define	HD64461_IRQBASE		OFFCHIP_IRQ_BASE
>> > > -#define	OFFCHIP_IRQ_BASE	64
>> > > +#define	OFFCHIP_IRQ_BASE	80
>> > >  #define	HD64461_IRQ_NUM		16
>> > >
>> > >  #define	HD64461_IRQ_UART	(HD64461_IRQBASE+5)
>> >
>> > I think it would be better to write this as (64 + 16) for consistency
>> > with the other changes made by Sergey.
>> 
>> Sure, I will send v2 with this change, although the same can't be
>> applied to HD64461_IRQ value above, so some inconsistency will exist
>> either way.
>> 
> 
> That's okay, that's the user-facing part ;-).
> 
> Btw, did you verify that the default assigned IRQ is actually changed 
> from
> 36 to 52 when the machine boots?
If I understood the question correctly, then yes, the new virq number
for HD64461 interrupt is now 52 and the cchip interrupts need this patch
to work.

Cheers,
Artur
> 
> Adrian


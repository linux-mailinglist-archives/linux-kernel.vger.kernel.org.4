Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437974BFF1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGHXNs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 Jul 2023 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGHXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:13:46 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C757E102;
        Sat,  8 Jul 2023 16:13:45 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qIH7N-003hnW-Io; Sun, 09 Jul 2023 01:13:33 +0200
Received: from dynamic-077-191-176-013.77.191.pool.telefonica.de ([77.191.176.13] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qIH7N-003SEa-Bp; Sun, 09 Jul 2023 01:13:33 +0200
Message-ID: <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 09 Jul 2023 01:13:24 +0200
In-Reply-To: <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
         <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
         <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
         <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.176.13
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

Hello Guenter!

On Sat, 2023-07-08 at 15:06 -0700, Guenter Roeck wrote:
> On 7/8/23 13:52, Sergey Shtylyov wrote:
> > On 7/6/23 7:38 PM, John Paul Adrian Glaubitz wrote:
> > [...]
> > 
> > > > Which sh4 platforms in particular?
> > > > 
> > > > I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
> > > > (physical) two days ago.
> > > 
> > > I gave it a try with the command line Guenter suggested and indeed the kernel locks
> > > up right here with the patch applied and boots fine without it:
> > > 
> > > Creating 4 MTD partitions on "physmap-flash":
> > > 0x000000000000-0x000000040000 : "U-Boot"
> > > 0x000000040000-0x000000080000 : "Environment"
> > > 0x000000080000-0x000000240000 : "Kernel"
> > > 0x000000240000-0x000001000000 : "Flash_FS"
> > > 8139too: 8139too Fast Ethernet driver 0.9.28
> > > 8139too 0000:00:01.0: This (id 10ec:8139 rev 20) is an enhanced 8139C+ chip, use 8139cp
> > > sm501-usb sm501-usb: SM501 OHCI
> > > sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
> > > sm501-usb sm501-usb: irq 116, io mem 0x13e40000
> > 
> >     I guess it was irq 100 before my patch. What if you undo the following
> > part of my patch?
> > 
> 
> No, that doesn't help.

Since the SM501 works fine with the patch on my SH7785LCR board, I assume it's
related to the IRQ code for the r2d2 board.

Looking at arch/sh/boards/mach-r2d/irq.c, there is some IRQ translation going
on and maybe that's the part where we need to correct the offset by 16?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

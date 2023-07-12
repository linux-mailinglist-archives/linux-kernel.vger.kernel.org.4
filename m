Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77475013F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjGLIUq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjGLIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:20:16 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C12706;
        Wed, 12 Jul 2023 01:16:55 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qJV0i-003CBT-OC; Wed, 12 Jul 2023 10:15:44 +0200
Received: from p57bd9f0d.dip0.t-ipconnect.de ([87.189.159.13] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qJV0i-001l2s-F8; Wed, 12 Jul 2023 10:15:44 +0200
Message-ID: <b6a22e7f96fd635fa00eebbfc0accf01e971061b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     David Laight <David.Laight@ACULAB.COM>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jul 2023 10:15:43 +0200
In-Reply-To: <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
         <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
         <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
         <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
         <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
         <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.13
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

On Wed, 2023-07-12 at 08:12 +0000, David Laight wrote:
> From: John Paul Adrian Glaubitz
> > Sent: 09 July 2023 00:13
> ....
> > Looking at arch/sh/boards/mach-r2d/irq.c, there is some IRQ translation going
> > on and maybe that's the part where we need to correct the offset by 16?
> 
> Would it be less problematic to use (say) 16 for IRQ_0
> leaving IRQ_1+ as 1+ ?

That would make things more complicated as IRQ0 would have to be
handled individually.

> At least that would only cause issues for code that needed
> to use IRQ_0.

What issues are you seeing or expecting?

> (It has to be said that making IRQ 0 invalid seemed wrong
> to me. x86 (IBM PC) gets away with it because IRQ 0 is
> always assigned to platform specific hardware.)

It's invalid for driver code, not for architecture code.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

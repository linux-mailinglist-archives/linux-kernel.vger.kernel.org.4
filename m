Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8167750D19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjGLPvn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjGLPvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:51:42 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D98A2;
        Wed, 12 Jul 2023 08:51:40 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qJc7h-0028cK-6Z; Wed, 12 Jul 2023 17:51:25 +0200
Received: from p57bd9f0d.dip0.t-ipconnect.de ([87.189.159.13] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qJc7g-003DUI-VG; Wed, 12 Jul 2023 17:51:25 +0200
Message-ID: <4ceea93f7f3ae45d5d14819cf678e34350c60334.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jul 2023 17:51:24 +0200
In-Reply-To: <b02489c7-96de-b6ed-07b9-9ba423af34c6@roeck-us.net>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
         <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
         <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
         <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
         <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
         <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
         <c9483d7f-7f5f-dd29-2bba-5659a1dae7e0@gmail.com>
         <b02489c7-96de-b6ed-07b9-9ba423af34c6@roeck-us.net>
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

Hi!

On Wed, 2023-07-12 at 08:38 -0700, Guenter Roeck wrote:
> > 
> >     Not only x86, IIRC.
> >     Have you seen the commit below?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce753ad1549cbe9ccaea4c06a1f5fa47432c8289
> > 
> 
> Quoting:
> 
> using IRQ0 is considered invalid (according to Linus) outside the arch/ code
>                                                        ^^^^^^^^^^^^^^^^^^^^^^
> 
> The changes here were made _in_ the arch code. While there may be valid
> arguments for doing that, quoting the above commit as reason isn't really
> sufficient.

Well, the changes we made inside arch/sh were necessary to achieve the desired
effects in the code in drivers such as the SM501 controller or the SH companion
chips.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

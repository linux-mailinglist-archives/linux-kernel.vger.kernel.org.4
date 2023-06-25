Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03473D44E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFYVHJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFYVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:07:08 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C526DDB;
        Sun, 25 Jun 2023 14:07:06 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qDWwo-002pbu-Pb; Sun, 25 Jun 2023 23:07:02 +0200
Received: from dynamic-089-014-168-195.89.14.pool.telefonica.de ([89.14.168.195] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qDWwo-000N98-Gy; Sun, 25 Jun 2023 23:07:02 +0200
Message-ID: <d82fba37921525a445b657a5583a0f71d73da09d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various
 platforms
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Sun, 25 Jun 2023 23:07:01 +0200
In-Reply-To: <CAK7LNAQFc8pGD4y=pNePxWyiVRM+xHGFF_x6SkAuDcA01dB3cA@mail.gmail.com>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
         <3c1b53fb670467b90138aaf3ef29bf235c2b4ffa.camel@physik.fu-berlin.de>
         <CAK7LNAQFc8pGD4y=pNePxWyiVRM+xHGFF_x6SkAuDcA01dB3cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.168.195
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro!

On Sun, 2023-06-25 at 16:56 +0900, Masahiro Yamada wrote:
> On Sun, Feb 19, 2023 at 11:40 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > 
> > Hi Masahiro!
> > 
> > On Sun, 2023-02-19 at 23:15 +0900, Masahiro Yamada wrote:
> > > The 0day bot reports a lot of warnings (or errors due to CONFIG_WERROR)
> > > like this:
> > > 
> > >   cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
> > > 
> > > Indeed, arch/sh/include/mach-hp6xx does not exist.
> > > 
> > > -Wmissing-include-dirs is W=1 warning, but it may be annoying
> > > when CONFIG_BTRFS_FS is enabled because fs/btrfs/Makefile
> > > unconditionally adds this warning option.
> > > 
> > > arch/sh/Makefile defines machdir-y for two purposes:
> > > 
> > >  - Build platform code in arch/sh/boards/mach-*/
> > >  - Add arch/sh/include/mach-*/ to the header search path
> > > 
> > > For the latter, some platforms use arch/sh/include/mach-common/ instead
> > > of having its own arch/sh/include/mach-*/.
> > > 
> > > Drop unneeded machdir-y to not include non-existing include directory.
> > > 
> > > To build arch/sh/boards/mach-*/, use the standard obj-y syntax in
> > > arch/sh/boards/Makefile.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@intel.com/
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > 
> > Thanks for your patches! I'm still waiting for my kernel.org account to be created,
> > so I can set up my own linux-sh tree. I hope that happens next week. There are already
> > some patches piling up.
> 
> 
> So, what has happened since then?

I'll review and test these tomorrow when I'm back in the office.

Unless there are any issues, I am going to pick the series up for 6.5.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

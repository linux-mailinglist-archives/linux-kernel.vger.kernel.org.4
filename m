Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD373CF39
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFYIL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFYIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:11:27 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C2E53;
        Sun, 25 Jun 2023 01:11:25 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qDKq8-0012ki-HS; Sun, 25 Jun 2023 10:11:20 +0200
Received: from tmo-087-130.customers.d1-online.com ([80.187.87.130] helo=smtpclient.apple)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qDKq8-002gaQ-6u; Sun, 25 Jun 2023 10:11:20 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various platforms
Date:   Sun, 25 Jun 2023 10:11:09 +0200
Message-Id: <D124BC54-1F49-478B-997C-87A3B89A58F8@physik.fu-berlin.de>
References: <CAK7LNAQFc8pGD4y=pNePxWyiVRM+xHGFF_x6SkAuDcA01dB3cA@mail.gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
In-Reply-To: <CAK7LNAQFc8pGD4y=pNePxWyiVRM+xHGFF_x6SkAuDcA01dB3cA@mail.gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
X-Mailer: iPhone Mail (20F75)
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 80.187.87.130
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2023, at 9:57 AM, Masahiro Yamada <masahiroy@kernel.org> wrote:
> 
> ﻿On Sun, Feb 19, 2023 at 11:40 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> 
>> Hi Masahiro!
>> 
>>> On Sun, 2023-02-19 at 23:15 +0900, Masahiro Yamada wrote:
>>> The 0day bot reports a lot of warnings (or errors due to CONFIG_WERROR)
>>> like this:
>>> 
>>>  cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>>> 
>>> Indeed, arch/sh/include/mach-hp6xx does not exist.
>>> 
>>> -Wmissing-include-dirs is W=1 warning, but it may be annoying
>>> when CONFIG_BTRFS_FS is enabled because fs/btrfs/Makefile
>>> unconditionally adds this warning option.
>>> 
>>> arch/sh/Makefile defines machdir-y for two purposes:
>>> 
>>> - Build platform code in arch/sh/boards/mach-*/
>>> - Add arch/sh/include/mach-*/ to the header search path
>>> 
>>> For the latter, some platforms use arch/sh/include/mach-common/ instead
>>> of having its own arch/sh/include/mach-*/.
>>> 
>>> Drop unneeded machdir-y to not include non-existing include directory.
>>> 
>>> To build arch/sh/boards/mach-*/, use the standard obj-y syntax in
>>> arch/sh/boards/Makefile.
>>> 
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@intel.com/
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> ---
>> 
>> Thanks for your patches! I'm still waiting for my kernel.org account to be created,
>> so I can set up my own linux-sh tree. I hope that happens next week. There are already
>> some patches piling up.
> 
> 
> So, what has happened since then?

Sorry, these somehow went off my radar.

I’ll have a look later today.

Adrian

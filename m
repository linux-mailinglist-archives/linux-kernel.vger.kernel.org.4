Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3652073CF16
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFYH5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFYH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3BE4C;
        Sun, 25 Jun 2023 00:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65AAF60B51;
        Sun, 25 Jun 2023 07:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61C9C433CA;
        Sun, 25 Jun 2023 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687679840;
        bh=Of8os0H9OHLVLvcjVzInbz6tEFdUkC/CX0HwtgMbj9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WEthQxXgD6wppje6rKQgquLsIJx+k2kL2ImTzGMAjmcc3Ehpp5sncXSt5qdy5tkEo
         DTlyGUoaPosA+gU0cpmpn+Lkdc4lbPurZ2JJY7Ba3J2f8ygUbsvoYlhp83X1njmtKY
         +XSQZpxxZ2eJuztm6O4YJEa1kJHT4vmEbG5uq/qLb2W9/+cFhqcJh7cnFZVArv9o7w
         XjtY4+UgGtM1dd4fMBDt+iHhmn9DtT1sxKFf4tzn/kTTKtwuFEjiZelrfyW5nnplvt
         AqkrYSsQPndZJQwS+LICyyieZLwlRYS7UsEO/m971WW1FnwqlMXbG4fyPXBVHYv86H
         Wedz6yKtXlY8Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5634808e16eso37483eaf.2;
        Sun, 25 Jun 2023 00:57:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDwhHCXYsXJ3tfh0ilc9tqcVbMMCftYyJjPuBnJ5IEq4jlNszYYt
        +8CaK5z0SRWDpP2MetcAORzXnOCu1NDPUhpVyOE=
X-Google-Smtp-Source: ACHHUZ4soVb+dT5Teo+ZgL0ai8BLjpT0f12KgKLOkq/Tiod18AqWE6XARZDiF1A6MPIOCfhGiIt1RC620+NUYoUxkA8=
X-Received: by 2002:a4a:d884:0:b0:558:c5b8:9575 with SMTP id
 b4-20020a4ad884000000b00558c5b89575mr20976482oov.1.1687679840100; Sun, 25 Jun
 2023 00:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230219141555.2308306-1-masahiroy@kernel.org> <3c1b53fb670467b90138aaf3ef29bf235c2b4ffa.camel@physik.fu-berlin.de>
In-Reply-To: <3c1b53fb670467b90138aaf3ef29bf235c2b4ffa.camel@physik.fu-berlin.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Jun 2023 16:56:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFc8pGD4y=pNePxWyiVRM+xHGFF_x6SkAuDcA01dB3cA@mail.gmail.com>
Message-ID: <CAK7LNAQFc8pGD4y=pNePxWyiVRM+xHGFF_x6SkAuDcA01dB3cA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various platforms
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 11:40=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Masahiro!
>
> On Sun, 2023-02-19 at 23:15 +0900, Masahiro Yamada wrote:
> > The 0day bot reports a lot of warnings (or errors due to CONFIG_WERROR)
> > like this:
> >
> >   cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-W=
error=3Dmissing-include-dirs]
> >
> > Indeed, arch/sh/include/mach-hp6xx does not exist.
> >
> > -Wmissing-include-dirs is W=3D1 warning, but it may be annoying
> > when CONFIG_BTRFS_FS is enabled because fs/btrfs/Makefile
> > unconditionally adds this warning option.
> >
> > arch/sh/Makefile defines machdir-y for two purposes:
> >
> >  - Build platform code in arch/sh/boards/mach-*/
> >  - Add arch/sh/include/mach-*/ to the header search path
> >
> > For the latter, some platforms use arch/sh/include/mach-common/ instead
> > of having its own arch/sh/include/mach-*/.
> >
> > Drop unneeded machdir-y to not include non-existing include directory.
> >
> > To build arch/sh/boards/mach-*/, use the standard obj-y syntax in
> > arch/sh/boards/Makefile.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@i=
ntel.com/
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Thanks for your patches! I'm still waiting for my kernel.org account to b=
e created,
> so I can set up my own linux-sh tree. I hope that happens next week. Ther=
e are already
> some patches piling up.


So, what has happened since then?






>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913



--=20
Best Regards
Masahiro Yamada

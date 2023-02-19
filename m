Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7954369C16A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBSQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBSQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 11:55:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9A12061;
        Sun, 19 Feb 2023 08:55:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E5AFCE0A47;
        Sun, 19 Feb 2023 16:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACBDC4339E;
        Sun, 19 Feb 2023 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676825730;
        bh=ojsmhgB2O4fhYhsIeUPbIG7CAFp5CbXjb26UFEMVGbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NZXGoTDUhFusS/lRRo/0CoQGGWQQZnCz2oaoSWF/KpsJroLnAEXWDnH2iPYjfh9T1
         ykq+Ojfn7boZmu4ZnTG/WTQto02EXCjXrEW90qX2BReU01uXH9Bhnl+eHS+F01VX2N
         Nwe4qMo1PcDRcvWwDpKoxsPKQNNcUMPWHZPdvSW1nLlThGdh+vv6WI6eS9pgP9RO88
         ogqOrtyn3ZFYpfBnhDl67aDbFpdsk/RA0aSRdGzvCxxE+/Tt3xo2dtoHn+z8P7DFoP
         VW7Hu1jK0m4ieuvl8EF/FX2fU6VhNzI6vEpJb+Kq14SuqkGVkweTgysr0M7nV48IYm
         rsP+phjeCBPMw==
Received: by mail-oi1-f176.google.com with SMTP id q13so393882oiw.10;
        Sun, 19 Feb 2023 08:55:30 -0800 (PST)
X-Gm-Message-State: AO0yUKU5DJv5XHmHy4K6AMGY13CAbN7IrhvLMONSudC9LJwDSjIOUdLe
        /bARylaVlZ5Da4Q1fx8V1TslbQKIbI88gsl8Rco=
X-Google-Smtp-Source: AK7set9F+qXlTACe4j5Zwz5ZISg0LWPoiTaSg6gE4udfo9a2AbNpPkh4RIayPsysa+0L2pTB/e7MdCG8FJWODlLAnyo=
X-Received: by 2002:a05:6808:3203:b0:37a:bc9f:afe7 with SMTP id
 cb3-20020a056808320300b0037abc9fafe7mr602770oib.56.1676825729553; Sun, 19 Feb
 2023 08:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20230219141555.2308306-1-masahiroy@kernel.org> <3c1b53fb670467b90138aaf3ef29bf235c2b4ffa.camel@physik.fu-berlin.de>
In-Reply-To: <3c1b53fb670467b90138aaf3ef29bf235c2b4ffa.camel@physik.fu-berlin.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Feb 2023 01:54:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7KWrJgwXcYz7_dfHkecu-pcChsCt-xxi0f=CEK0m7Yg@mail.gmail.com>
Message-ID: <CAK7LNAT7KWrJgwXcYz7_dfHkecu-pcChsCt-xxi0f=CEK0m7Yg@mail.gmail.com>
Subject: Re: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various platforms
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 11:40 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Masahiro!
>
> On Sun, 2023-02-19 at 23:15 +0900, Masahiro Yamada wrote:
> > The 0day bot reports a lot of warnings (or errors due to CONFIG_WERROR)
> > like this:
> >
> >   cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
> >
> > Indeed, arch/sh/include/mach-hp6xx does not exist.
> >
> > -Wmissing-include-dirs is W=1 warning, but it may be annoying
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
> > Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@intel.com/
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Thanks for your patches! I'm still waiting for my kernel.org account to be created,
> so I can set up my own linux-sh tree. I hope that happens next week. There are already
> some patches piling up.
>
> Adrian


That's good news.

I just thought arch/sh is no longer maintained.
(I saw a patch for the entire removal of arch/sh/ somewhere).

I leave this series up to you.




> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913



-- 
Best Regards
Masahiro Yamada

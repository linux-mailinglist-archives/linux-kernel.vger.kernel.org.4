Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D879701AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjEMX22 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 13 May 2023 19:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9D1FDE;
        Sat, 13 May 2023 16:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B6F60C2B;
        Sat, 13 May 2023 23:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF2AC433D2;
        Sat, 13 May 2023 23:28:23 +0000 (UTC)
Date:   Sat, 13 May 2023 19:28:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: make localmodconfig doesn't work for thunderbolt
Message-ID: <20230513192821.34ca93fd@rorschach.local.home>
In-Reply-To: <CAK7LNATQeT8MaQr450x0SpHJV=QU7nrfWfDO1ZRKimppVZG4KA@mail.gmail.com>
References: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
        <CAK7LNATQeT8MaQr450x0SpHJV=QU7nrfWfDO1ZRKimppVZG4KA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 01:15:49 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> +CC Steven Rostedt, author of streamline_config.pl

Thanks!

> 
> 
> 
> On Wed, May 10, 2023 at 8:01 PM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > Hi,
> >
> > if I use localmodconfig for example like this:
> > mkdir /tmp/tb/
> > echo thunderbolt >/tmp/tb/lsmod
> > make O=/tmp/tb LSMOD=/tmp/tb/lsmod localmodconfig
> >
> > I get:
> > using config: '.config'
> > thunderbolt config not found!!
> >
> > $ grep 'USB4\>' /tmp/tb/.config
> > # CONFIG_USB4 is not set
> >
> > I believe it's due to:
> >    obj-${CONFIG_USB4} := thunderbolt.o
> > in drivers/thunderbolt/Makefile. I.e. ${} used instead of more common $().
> >
> > But even if I change the parser:
> >
> > --- a/scripts/kconfig/streamline_config.pl
> > +++ b/scripts/kconfig/streamline_config.pl
> > @@ -317,7 +317,7 @@ foreach my $makefile (@makefiles) {
> >          $_ = convert_vars($_, %make_vars);
> >
> >          # collect objects after obj-$(CONFIG_FOO_BAR)
> > -       if (/obj-\$\((CONFIG_[^\)]*)\)\s*[+:]?=\s*(.*)/) {
> > +       if (/obj-\$[({](CONFIG_[^})]*)[)}]\s*[+:]?=\s*(.*)/) {
> >              $var = $1;
> >              $objs = $2;
> >
> >
> > I see:
> > module thunderbolt did not have configs CONFIG_USB4
> >
> > and:
> > $ grep 'USB4\>' /tmp/tb/.config
> > # CONFIG_USB4 is not set
> >
> > So two questions:
> > 1) is ${} supported and should be the above change sent as a patch? Or
> > should be drivers/thunderbolt/Makefile fixed to use $(). (And maybe
> > other Makefiles too.)  
> 
> 
> I believe streamline_config.pl should be fixed.

So do I.

> 
> There is no good reason to support only $(), but not ${}.

Agreed.

> 
> 
> In fact, the comment line around line 395 of this script
> uses the curly brace style.
> 
>   # a loaded module. This is a direct obj-${CONFIG_FOO} += bar.o
> 
> 
> 
> 
> 
> 
> > 2) how to fix that 'thunderbolt did not have configs'?  
> 
> That warning is CONFIG_USB4 was unset in the resulting .config.
> 
> Was CONFIG_USB4 enabled before running localmodconfig?
> 
> In my understanding, the purpose of localmodconfig
> is to slim down the .config file.

Correct.

> 
> It disables unneeded CONFIG options, but
> it does not enable needed CONFIG options.

Also correct.

> 
> 
> 
> 
> If I start from allnoconfig (i.e. CONFIG_USB4 is unset), I see the warning.
> 
> $ echo thunderbolt >/tmp/tb/lsmod
> $ make -s O=/tmp/tb allnoconfig
> $ make O=/tmp/tb LSMOD=/tmp/tb/lsmod  localmodconfig
>   GEN     Makefile
> using config: '.config'
> module thunderbolt did not have configs CONFIG_USB4
> 
> 
> 
> If I start from allmodconfig (i.e. CONFIG_USB4 is m), I do not see the warning.
> 
> $ echo thunderbolt >/tmp/tb/lsmod
> $ make -s O=/tmp/tb allmodconfig
> $ make O=/tmp/tb LSMOD=/tmp/tb/lsmod  localmodconfig
>   GEN     Makefile
> using config: '.config'
> 

I hate the inconsistency in the Makefile, but localmodconfig should be
able to adapt to it.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks Jiri and Masamhiro!

-- Steve

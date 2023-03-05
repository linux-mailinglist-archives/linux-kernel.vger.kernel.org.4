Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF326AAE8A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 09:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCEIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 03:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 03:10:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3238D51A;
        Sun,  5 Mar 2023 00:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD1560AB1;
        Sun,  5 Mar 2023 08:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B801C433A1;
        Sun,  5 Mar 2023 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678003819;
        bh=JAXEBqW4smtYeSra+h8Nm3kI8Izhu6NtyGNvHt5ilE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KknQR0/oo0F0pi92V8Wt8RkAaJoMUHmO4qfAGTx0O12EKkObYzbpzFVPEmv1E3GDN
         P78MfXN00gHhxus4lbONKjGJS8+JyDGsRS8C/iGe0txgpcPc2CbX0LzKA5XJFX9owx
         Jlw3eOFB/cjgIo4sRi2O+iXa4EXrXB9zvv69XVbzagtgl/NvB1+jiEHtT9e1Z10v1c
         te8HCoXlMq2EOL4ASFXQQPmGPSr01hdvhEcj34gbD536BdDAOa0R6eFMfsV4CKmZtu
         0vy5ze8AotdmTRKa2ndv52ZzcdfdKfzyLHd5BhOBJr3qyiSRZ1fh7M7477gdTRWpJt
         8JT3zQ9hWlJ5A==
Received: by mail-oi1-f174.google.com with SMTP id q15so4873075oiw.11;
        Sun, 05 Mar 2023 00:10:19 -0800 (PST)
X-Gm-Message-State: AO0yUKWs4o1ANa5xdcw1if8FC9+bOAX3pDVVFm9uUEOJ7nbC0csxr/B3
        WT7Stm+35F3ncjCCQRn9UubCF5JyqL1q4ZoNx3k=
X-Google-Smtp-Source: AK7set9avGdsdRmrXutmkIsGYqUw6NbhJrqqbjs5VWAzWE+FerfQH4m4SBWAqOkOOGaJQ06gZOWh1lw/vokJLe0DPRo=
X-Received: by 2002:aca:1a0d:0:b0:36e:f6f5:66a2 with SMTP id
 a13-20020aca1a0d000000b0036ef6f566a2mr2270094oia.8.1678003818692; Sun, 05 Mar
 2023 00:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <20221205163157.269335-6-nick.alcock@oracle.com> <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
 <87mt80l2py.fsf@esperi.org.uk> <5f0a5ea7-2d48-435f-aaa0-82b6ef8cfcc5@app.fastmail.com>
 <Y5AeuI4RD0tpzlp5@bombadil.infradead.org>
In-Reply-To: <Y5AeuI4RD0tpzlp5@bombadil.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Mar 2023 17:09:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASL7_RgfASstBvN6AzhR=nMU=HsQvODf5q13Xud8tBWRQ@mail.gmail.com>
Message-ID: <CAK7LNASL7_RgfASstBvN6AzhR=nMU=HsQvODf5q13Xud8tBWRQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/13] kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION
 in non-modules
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        eugene.loh@oracle.com, kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 2:04=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Tue, Dec 06, 2022 at 10:02:30PM +0100, Arnd Bergmann wrote:
> > On Tue, Dec 6, 2022, at 21:03, Nick Alcock wrote:
> > > On 6 Dec 2022, Geert Uytterhoeven uttered the following:
> > > Only MODULE_LICENSE invokes MODULE_FILE and thus ends up introducing =
a
> > > KBUILD_MODOBJS entry that triggers things going wrong iff not a modul=
e:
> > > so only it needs to go out (or be replaced with a variant that doesn'=
t
> > > invoke MODULE_FILE, if you want to keep the license in too --
> >
> > That sounds like a better alternative
> >
> > > but if the thing is no longer a standalone entity at all I'm not sure
> > > what meaning it could possibly have).
> >
> > As far as I can tell, the general trend is to make more things modules,
> > so there is a good chance that these come back eventually. If the
> > information in the MODULE_LICENSE field isn't wrong, I would just
> > leave it in there.
>
> Tooling today uses it though to make a deterministic call on if something
> *can* be a module. In particular after commit 8b41fc4454e ("kbuild: creat=
e
> modules.builtin without Makefile.modbuiltin or tristate.conf") we rely on
> the module license tag to generate the modules.builtin file. This in
> turn is used to allow modprobe to *not* fail when trying to load a module
> which is built-in.



If we have a bool driver 'foo.ko' in modules.builtin,
'modprobe foo' will not fail where you expect it will fail.

Is it so important to make this strict?

I do not think so.


What is a point for a user to realize
"Oh, I did not know foo cannot be compiled as a module"


Re-read the commit description of
bc081dd6e9f622c73334dc465359168543ccaabf

The motivation of module.builtin is to know the functionality 'foo'
is available (via built-in or module, whatever).

In this sense, having always-builtin entries in module.builtin is OK.


I do not see any sense in the tooling mess in this patch set.








> So we can't just disable the tag for when the code is built-in as *want*
> to carry it when modules are built-in, that is the point, to help
> userspace with this determination.
>
> I don't think we want to revert 8b41fc4454e as it means we'd force Kbuild=
 to
> traverse the source tree twice.


I do not want to revert it.

and I do not want this series in the mainline.




>
> Geert's point was not keeping MODULE_LICENSE() but instead the other
> MODULE_*() crap for things which are not modules in case in the future
> code becomes a module...
>
> But I don't see the point in keeping things around just in case, if we
> want to keep things simple. Just use the SPDX license tag for the license=
.
>
>   Luis



--
Best Regards
Masahiro Yamada

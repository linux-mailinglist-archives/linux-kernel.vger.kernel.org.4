Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D716C2D86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCUJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCUJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:04:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14126869;
        Tue, 21 Mar 2023 02:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1688BB811C0;
        Tue, 21 Mar 2023 09:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6BFC4339E;
        Tue, 21 Mar 2023 09:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679389418;
        bh=QBJm/wDer1AQyhtVso4csqiF+C7PJ0MWal4bYdSXE3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AvdXYjk/crKqEIruwW4kw0vJ2kjxBxGiy6Kf77YfGgXgX7MYQHz/09q5FXvLYmikc
         Ao6GQ3ZVxCX6z/yrwdMF/JM4HNppaAoFsMyRcX2MxglHdf2hcSrkEjDP4J5TCazN+N
         qh085GqLho8vSkaxtVip5Jww1FQfP8tcgr/QYryjW0ZQ8H+FQJOe3ELdUcOKF+T2cF
         XKOJUfa4+cQ+fDdGfsktx43Nm/St2oRrBpex5zHcvZDBDJcYBP5cTnzCE+DF2QKJBv
         DqquuvxDNGhe+E0drPAYRYWU/wbP5G2TmT6TeH3ptlGoKY1ZH4cIeN1eVJW7x7RHL7
         GpOCk1rLAPJpw==
Received: by mail-oi1-f175.google.com with SMTP id e4so3751318oiy.10;
        Tue, 21 Mar 2023 02:03:38 -0700 (PDT)
X-Gm-Message-State: AO0yUKU0FXkPbBLyiFfpF8hPPWNXOgkhptdUhV/8akr4tm9/prcTMOzj
        gZqn595RLfQWdts14k6Eb0WSvcoBPgne8DlhYPo=
X-Google-Smtp-Source: AK7set9JciBVHXDc8C1ovtlnYoWm6ZJfppLjWyjt/EfJGjNHqGpfDxM9JBt7JuiKy0LHtqKJPXBa6gzD+iT9Sx9VBWA=
X-Received: by 2002:a54:4817:0:b0:387:1e2d:f281 with SMTP id
 j23-20020a544817000000b003871e2df281mr357453oij.11.1679389417888; Tue, 21 Mar
 2023 02:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
 <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com> <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
 <ZBjKb8fXHOxnHuHD@bombadil.infradead.org>
In-Reply-To: <ZBjKb8fXHOxnHuHD@bombadil.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Mar 2023 18:03:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
Message-ID: <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in /proc/dynamic_debug/control
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jim.cromie@gmail.com, linux-modules@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 6:04=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Mon, Mar 20, 2023 at 01:59:28PM -0600, jim.cromie@gmail.com wrote:
> > On Mon, Mar 20, 2023 at 12:35=E2=80=AFPM Jason Baron <jbaron@akamai.com=
> wrote:
> > >
> > >
> > >
> > > On 3/20/23 1:05 AM, jim.cromie@gmail.com wrote:
> > > > dynamic-debug METADATA uses KBUILD_MODNAME as:
> > > >
> > > > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > >          static struct _ddebug  __aligned(8)                     \
> > > >          __section("__dyndbg") name =3D {                          =
\
> > > >                  .modname =3D KBUILD_MODNAME,                      =
\
> > > >
> > > > This is going amiss for some builtins, ie those enabled here, by:
> > > >
> > > >      echo module main +pmf > /proc/dynamic_debug_control
> > > >      grep =3Dpmf /proc/dynamic_debug/control
> > > >
> > > > init/main.c:1187 [main]initcall_blacklist =3Dpmf "blacklisting init=
call %s\n"
> > > > init/main.c:1226 [main]initcall_blacklisted =3Dpmf "initcall %s bla=
cklisted\n"
> > > > init/main.c:1432 [main]run_init_process =3Dpmf "  with arguments:\n=
"
> > > > init/main.c:1434 [main]run_init_process =3Dpmf "    %s\n"
> > > > init/main.c:1435 [main]run_init_process =3Dpmf "  with environment:=
\n"
> > > > init/main.c:1437 [main]run_init_process =3Dpmf "    %s\n"
> > >
> > >
> > > Hi Jim,
> > >
> > > So if I'm following correctly, this is not a new issue, the 'module'
> > > name for dynamic debug has always been this way for builtin.
> >
> > It is not a new issue - both PM and init-main have been in [main] for s=
ome time.
> >
> > I believe that with
> > cfc1d277891e module: Move all into module/
> >
> > module's module-name joined them, changing from [module] to [main]
>
> If there was a regression due to this, we'd be very interested in
> hearing about it. Aaron he did the work to move the code to its own direc=
tory.
>
> > We could do
> > > something simple and just normalize it when we initially create the
> > > table, but setting the 'module name' to 'core' or 'builtin' or someth=
ing
> > > for all these?
> >
> > core and builtin would both lump all those separate modules together,
> > making it less meaningful.
> >
> > having stable names independent of M vs Y config choices is imperative,=
 ISTM.
> >
> > Also, I dont think "only builtins are affected" captures the whole prob=
lem.
> > I dont recall amdgpu or other modules changing when built with =3Dy
> >
> > Theres some subtlety in how KBUILD_MODNAME is set,
> > and probably many current users who like its current behavior.
> > A new var ?
> >
> > 1st, I think that anything tristate gets a sensible value,
> > but at least some of the builtin-only "modules" get basenames, by defau=
lt.
>
> In general we could all benefit from an enhancement for a shortname for
> things which could be modules being built-in. We're now seeing requests
> for dynamic debug, but it could also be usefulf for Nick's future work
> to help userspace tools / tracing map kallsysms to specific modules when
> built-in.



I think I rejected it some years ago.
He comes back again and again with almost the same approaches,
until he finds a "sponsor" (it's you) who will get it in.

Recently, I rejected the Kbuild changes again.




> To that end I had suggested the current state of affairs & current diffic=
ulty
> in trying to get us a name for this here:
>
> https://lore.kernel.org/all/Y/kXDqW+7d71C4wz@bombadil.infradead.org/
>
> I ended up suggesting perhaps we need a -DPOSSIBLE_MODULE then if we
> could *somehow* pull that off perhaps then we could instead use
> -DPOSSIBLE_KBUILD_MODNAME which would ensure a consistent symbol when
> a module is built-in as well.
>
> That still leaves the difficulty in trying to gather possible-obj-m as
> a future challenge.


I do not understand your point.

Why is it important to achieve "precisely-exactly-possible-obj-m" instead o=
f
"perhaps-possible-obj-m"?


When "modprobe foo" succeeds, the user is sure that the kernel
provides the feature "foo" (but he does not care if
"foo" is built-in or modular).

I think that is the point for kmod check also module.builtin
before saying no.


When CONFIG_FOO=3Dy, "modprobe foo" succeeds because "foo" is available
as built-in.
When CONFIG_FOO=3Dn, "modprobe foo" fails because "foo" is not available an=
ywhere.
I do not see anything wrong here.

Why do we need to make "modprobe foo" fail, where the feature "foo" is
still available
but just because we cannot compile it as a module?

He spams with MODULE_LICENSE removal with no justification.

--=20
Best Regards
Masahiro Yamada

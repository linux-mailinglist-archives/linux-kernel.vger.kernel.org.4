Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACDA64D026
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiLNTj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiLNTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:39:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45929376
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:39:52 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f3so2693816pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a47PBb52hre3dMm0AL5cihlS60hbl6dz/y8Xw4hz05A=;
        b=Sh5SIBT4csDrPl5BRApL4Hysxx9/1D/AQMgFnsK33j0DGJYNff1dWUl1X+48/CcyU9
         dhLm/QaxYsr8diOl+9WGgwQM4yPxaGOmF/HH6HtOUO/NgzgTt9JA/Tf956S3NOKJodUm
         ar9Vglzot+AgGss/XOWTiNe1oUEMWF1o1wjkK9fjo8XxmJjeWfRulzaLGLf/eqRxlLa0
         H+Eltxo1kbDaoGZues7GjInqdbCkG+fIpDaxYbZORU1mot5TiawehnXw+0LqnWNM1DO4
         sE50+vxBFBPbvCCCcI2qWST383kOkoJzg9ykvrNR0qnjMC2iXDENvrpGFl9TA5bwZ811
         Gyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a47PBb52hre3dMm0AL5cihlS60hbl6dz/y8Xw4hz05A=;
        b=ZFNQiOPkM8+13ktUi3h1mo7K10at7jrMiSv5hHOMna+onOTE/GCMcRs+YLTVCoYvDu
         kHkqoSVS7nkYlbskT46n3V0tEQJ3gCd1oYrQL1yXYkUNoW9SCOMisSq3StRPTTXoBcCs
         MqPL/Li+4Wiy5V5a61VNCUz5oePVL6WDk/daKI+K0hBC88fjiOj22FS2cRH0tmtMy+qO
         J5Oo05u9uVjXbDw9L9APOJoND5P6xWZSn/+unuuF2oc7gcOEXvQnkrOR6sGWqSOHU1ez
         dxUmo5+Vcn9zA2F+gBQcdqi7d/jTpSaulK0XtXtD55zQ0MeEHpIqwn8ZdDC01kXufE2V
         Oefw==
X-Gm-Message-State: ANoB5pmQB+XyBSd2WEtGP2FoubUODCa/Z7rQZsIDMwkxhEJURK2nRmpX
        EABvjSjXafueD3V03FsC9+rfzITC/XCLPpNHsJFI6A==
X-Google-Smtp-Source: AA0mqf7AKMNl6mFwvI5iT/7I5urKyLFaNDyvTs2QfEb+W/1+Gpll+i/lI+2KyEhmHVznncd6MtyRGkuRTfleGjMHisw=
X-Received: by 2002:a65:6385:0:b0:478:e6cf:c24c with SMTP id
 h5-20020a656385000000b00478e6cfc24cmr10948486pgv.365.1671046791399; Wed, 14
 Dec 2022 11:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20220712110248.1404125-1-atomlin@redhat.com> <20221214185658.fgsqrysq4luk2w4n@google.com>
In-Reply-To: <20221214185658.fgsqrysq4luk2w4n@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Dec 2022 11:39:40 -0800
Message-ID: <CAKwvOdms0YWw0N-0cycYR-K0qxbjhsAARrAPAykiR7Vt_snD4A@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/gdb: Ensure the absolute path is generated on
 initial source
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:57 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jul 12, 2022 at 12:02:48PM +0100, Aaron Tomlin wrote:
> > Post 'make scripts_gdb' a symbolic link to scripts/gdb/vmlinux-gdb.py
> > is created. Currently 'os.path.dirname(__file__)' does not generate
> > the absolute path to scripts/gdb resulting in the following:
> >
> >     (gdb) source vmlinux-gdb.py
> >     Traceback (most recent call last):
> >       File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
> >       import linux.utils
> >     ModuleNotFoundError: No module named 'linux'
>
> So I recently moved to a new machine, and lost my previous .gdbinit.
>
> I've re-added:
> add-auto-load-safe-path /path/to/linux/
>
> to my new ~/.gdbinit.
>
> Upon startup, lx-dmesg and friends aren't available.
>
> If I try:
> (gdb) source scripts/gdb/vmlinux-gdb.py
> Traceback (most recent call last):
>   File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
>     import linux.utils
> ModuleNotFoundError: No module named 'linux'
>
> Which is exactly the error claimed to be fixed by
> commit b99695580bfc ("scripts/gdb: ensure the absolute path is generated on initial source")
> even though I have b99695580bfc, which is how I found this thread to
> reply to.
>
> (gdb) show auto-load safe-path
> List of directories from which it is safe to auto-load files is $debugdir:$datadir/auto-load:/path/to/linux/.
>
> $ gdb-multiarch --version | head -n1
> GNU gdb (Debian 12.1-3) 12.1
> $ python3 --version
> Python 3.10.8
>
> I've also RTFM @
> Documentation/dev-tools/gdb-kernel-debugging.rst
> though perhaps there's something I've missed?
>
> $ grep -rn GDB_SCRIPTS .config
> 4162:CONFIG_GDB_SCRIPTS=y
>
> This definitely has worked in the past for me, on my previous
> workstation.
>
> (gdb) show configuration
> ...
>              --with-python=/usr (relocatable)
>              --with-python-libdir=/usr/lib (relocatable)
> ...
> (gdb) apropos lx
> (gdb)
>
> No warnings from GDB either about the autoload path not being set.
> Running gdb in my top level kernel sources.
>
> Am I holding it wrong?
>
> Any tips on how to go about debugging this?

PEBKAC; looks like I was building `vmlinux` and not `all`. D'oh!

>
> >
> > This patch ensures that the absolute path to scripts/gdb in relation to
> > the given file is generated so each module can be located accordingly.
> >
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  scripts/gdb/vmlinux-gdb.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> > index 4136dc2c59df..3e8d3669f0ce 100644
> > --- a/scripts/gdb/vmlinux-gdb.py
> > +++ b/scripts/gdb/vmlinux-gdb.py
> > @@ -13,7 +13,7 @@
> >
> >  import os
> >
> > -sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
> > +sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/scripts/gdb")
> >
> >  try:
> >      gdb.parse_and_eval("0")
> > --
> > 2.34.3
> >
> >



-- 
Thanks,
~Nick Desaulniers

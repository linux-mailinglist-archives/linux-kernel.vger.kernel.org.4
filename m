Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5F678E83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjAXCs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjAXCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:48:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1432E64;
        Mon, 23 Jan 2023 18:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28698B80FCD;
        Tue, 24 Jan 2023 02:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A3C4339B;
        Tue, 24 Jan 2023 02:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674528532;
        bh=txixw/DyRM2x3mOH5v36EhVcGwhyzbgQWa88XOxMgaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K4iUz7vgILKzfm+t0OX1DEKigV+FtI2kNKT8Txxb5q4N1Ck9fZEQesq0/u2OMhpWN
         EWMYMm24bWKBi9Jtt2Oftz/DcgtKGyL4PUVfmHXxjHZjexYQESv/jRaSPRSHTqPKga
         Ws4blaslEnzXwyuS2gKXZOED11+3WsvBmwsD7RkRHzHcodHb3t0gsVZ65NL+HFbelD
         +tBimPLb6ArVsj/ERZ0Mm0MkvJRQsDo/cPl61Ep5510jibNfn5IPUCFDUxHqJXiwJv
         pysb5kC70dEY3pIJrJP1qqQ965Ud6uhBYDnOUv3Oucys6Ms42MQUI3FuOLcywD7ROO
         W4M8YBd5eVYzw==
Received: by mail-oi1-f178.google.com with SMTP id p185so12190392oif.2;
        Mon, 23 Jan 2023 18:48:52 -0800 (PST)
X-Gm-Message-State: AFqh2koW81CEPXo4ls5O9cYFT21TnTebvpYIOaP4GUi7Bt3+uDTXmjD9
        06NOdm5CUtjW8XvGBiKfAYVF4CeTR2cHO/oCW8o=
X-Google-Smtp-Source: AMrXdXt7t+66BbeTn/cyRB6k9WMjKHVNKVrBwYd/JJ/GbD3VOJAZ6mscXLLnr1lfRdHerwkZ1Dz6c+yS/PJNoa2cQ8I=
X-Received: by 2002:aca:acd5:0:b0:364:5d10:7202 with SMTP id
 v204-20020acaacd5000000b003645d107202mr1093092oie.194.1674528532066; Mon, 23
 Jan 2023 18:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20230123052653.711899-1-masahiroy@kernel.org> <Y88NX11/LcnfloYk@google.com>
In-Reply-To: <Y88NX11/LcnfloYk@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Jan 2023 11:48:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfY+2w-aN0LQs0_gB=ASRyJoXSobsqzGa0BNL2sqpJeA@mail.gmail.com>
Message-ID: <CAK7LNASfY+2w-aN0LQs0_gB=ASRyJoXSobsqzGa0BNL2sqpJeA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: do not automatically add -w option to modpost
To:     William McVicker <willmcvicker@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 7:42 AM William McVicker
<willmcvicker@google.com> wrote:
>
> On 01/23/2023, Masahiro Yamada wrote:
> > When there is a missing input file (vmlinux.o or Module.symvers), you
> > are likely to get a ton of unresolved symbols.
> >
> > Currently, Kbuild automatically adds the -w option to allow module builds
> > to continue with warnings instead of errors.
> >
> > This may not be what the user expects because it is generally more useful
> > to catch all possible issues at build time instead of at run time.
> >
> > Let's not do what the user did not ask.
> >
> > If you still want to build modules anyway, you can proceed by explicitly
> > setting KBUILD_MODPOST_WARN=1. Since you may miss a real issue, you need
> > to be aware of what you are doing.
> >
> > Suggested-by: William McVicker <willmcvicker@google.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.modpost | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > index 43343e13c542..9254ed811ddd 100644
> > --- a/scripts/Makefile.modpost
> > +++ b/scripts/Makefile.modpost
> > @@ -121,16 +121,14 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
> >
> >  endif # ($(KBUILD_EXTMOD),)
> >
> > -ifneq ($(missing-input),)
> > -modpost-args += -w
> > -endif
> > -
> >  quiet_cmd_modpost = MODPOST $@
> >        cmd_modpost = \
> >       $(if $(missing-input), \
> >               echo >&2 "WARNING: $(missing-input) is missing."; \
> >               echo >&2 "         Modules may not have dependencies or modversions."; \
> > -             echo >&2 "         You may get many unresolved symbol warnings.";) \
> > +             echo >&2 "         You may get many unresolved symbol errors.";) \
>
> You need to move the closing parenthesis to come at the end of these
> echo messages. Otherwise you get this new message unconditionally.


Ah, thanks for catching it.


> I also found during testing that the refactoring in commit f73edc8951b2
> ("kbuild: unify two modpost invocations") dropped the check for missing
> KBUILD_EXTRA_SYMBOLS. That means if an external module depends on
> another external module and sets:
>
>   KBUILD_EXTRA_SYMBOLS=/path/to/ext_module/Module.symvers
>
> ... then make will fail even with KBUILD_MODPOST_WARN=1 since we
> unconditionally add KBUILD_EXTRA_SYMBOLS to the modpost-args like this:
>
>   modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
>
> To fix this, I suggest you also take the following patch so that
> KBUILD_MODPOST_WARN=1 will allow you to skip those unresolved symbols as
> well:


How is this useful?

KBUILD_EXTRA_SYMBOLS is explicitly specified by the user
via the command line or the environment variable.

If $(KBUILD_EXTRA_SYMBOLS) does not exist,
it is a user's fault, isn't it?






-- 
Best Regards
Masahiro Yamada

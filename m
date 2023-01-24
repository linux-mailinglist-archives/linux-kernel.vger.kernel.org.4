Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72E67A051
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjAXRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAXRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:39:28 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18DE14221
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:39:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 36so11751578pgp.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR1+Eb2Nx7WArb8KnWYRHzcFH+KeXGNrwM5HzoF5rS8=;
        b=QAzkuKBB06Ea9Mitu5Opcze99VQj39JvlMBoiWPYYnbyQ7TNJKCk2peKINkcxV/kKB
         2WRn7eqwGzwZ7Ybc5rtJK7/JM79WrFDADzG7riBvI2pxfRgmdl+4m+UnPXp4HsHzDxIc
         dvPAcoK95VVrgyVEbYABebucJnVu2vOCIHl5KXdw4+Bpe+TMbxpbcVaVZl9cQ+JJmWJo
         kApb2roHyE60HvRdLVkFff3jKh82oRY5Ke1CxEs6p0uS6rlBY69S0RXJCANvpgGPbB4F
         zlYUaAB0B4xlogdsPUGKcuk0rRGNK7vq4gSvemiWRTij1H9hsGwQQWvnre/cQyyhl7ey
         yfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR1+Eb2Nx7WArb8KnWYRHzcFH+KeXGNrwM5HzoF5rS8=;
        b=F+UF4F/Ge8zWUeiKOgVywLps2myiPHQHnHjRbsS9AoCE7xRSM0taPHcrFUrl/WUW9C
         GhEGmz5Np97EtYURAN510Rq+sF7Ipl+Sur5zl1GZLyadrqBqLv+twOuzzeWeo0FtRmQR
         RdVmscKRKNbTCHkHUPL54LPNht2FrJ/UOhqMm++h5gjugzGFnNQVAlk/BfF2pm2Mrep3
         KxiQVzoDdGHPpepu+HB9W7Ikwt2rev8WJJqrPZgCM9V0iIogZ0lmIe/gs0mj9jbTXPmk
         M6rpYzLK6Nyb17mrHPv9dhlew8zqpviKvvdWZAu45F+6Y/HGyfPW4izM3tP5E4lSH4Lq
         RZ5g==
X-Gm-Message-State: AO0yUKUeLHz3VcB66ayfs5afyATm9/RaScSAJLs0poQuY+G3n07ASnoQ
        GDoWWyxks6rhZher2XaqJlQ5gg==
X-Google-Smtp-Source: AK7set9sJdaB9831+HewZLmd9g/qnwqpTX5/RmlSRMT1+ZIk5G+2VR1xgH97SUfh3MaWzumN466zbQ==
X-Received: by 2002:a05:6a00:23cb:b0:581:bfac:7a52 with SMTP id g11-20020a056a0023cb00b00581bfac7a52mr271810pfc.1.1674581966697;
        Tue, 24 Jan 2023 09:39:26 -0800 (PST)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00170b00b0058d97f2ab31sm1858433pfc.184.2023.01.24.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:39:25 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:39:22 -0800
From:   William McVicker <willmcvicker@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: do not automatically add -w option to modpost
Message-ID: <Y9AXytjc61Le0PQZ@google.com>
References: <20230123052653.711899-1-masahiroy@kernel.org>
 <Y88NX11/LcnfloYk@google.com>
 <CAK7LNASfY+2w-aN0LQs0_gB=ASRyJoXSobsqzGa0BNL2sqpJeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASfY+2w-aN0LQs0_gB=ASRyJoXSobsqzGa0BNL2sqpJeA@mail.gmail.com>
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/2023, Masahiro Yamada wrote:
> On Tue, Jan 24, 2023 at 7:42 AM William McVicker
> <willmcvicker@google.com> wrote:
> >
> > On 01/23/2023, Masahiro Yamada wrote:
> > > When there is a missing input file (vmlinux.o or Module.symvers), you
> > > are likely to get a ton of unresolved symbols.
> > >
> > > Currently, Kbuild automatically adds the -w option to allow module builds
> > > to continue with warnings instead of errors.
> > >
> > > This may not be what the user expects because it is generally more useful
> > > to catch all possible issues at build time instead of at run time.
> > >
> > > Let's not do what the user did not ask.
> > >
> > > If you still want to build modules anyway, you can proceed by explicitly
> > > setting KBUILD_MODPOST_WARN=1. Since you may miss a real issue, you need
> > > to be aware of what you are doing.
> > >
> > > Suggested-by: William McVicker <willmcvicker@google.com>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/Makefile.modpost | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > > index 43343e13c542..9254ed811ddd 100644
> > > --- a/scripts/Makefile.modpost
> > > +++ b/scripts/Makefile.modpost
> > > @@ -121,16 +121,14 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
> > >
> > >  endif # ($(KBUILD_EXTMOD),)
> > >
> > > -ifneq ($(missing-input),)
> > > -modpost-args += -w
> > > -endif
> > > -
> > >  quiet_cmd_modpost = MODPOST $@
> > >        cmd_modpost = \
> > >       $(if $(missing-input), \
> > >               echo >&2 "WARNING: $(missing-input) is missing."; \
> > >               echo >&2 "         Modules may not have dependencies or modversions."; \
> > > -             echo >&2 "         You may get many unresolved symbol warnings.";) \
> > > +             echo >&2 "         You may get many unresolved symbol errors.";) \
> >
> > You need to move the closing parenthesis to come at the end of these
> > echo messages. Otherwise you get this new message unconditionally.
> 
> 
> Ah, thanks for catching it.
> 
> 
> > I also found during testing that the refactoring in commit f73edc8951b2
> > ("kbuild: unify two modpost invocations") dropped the check for missing
> > KBUILD_EXTRA_SYMBOLS. That means if an external module depends on
> > another external module and sets:
> >
> >   KBUILD_EXTRA_SYMBOLS=/path/to/ext_module/Module.symvers
> >
> > ... then make will fail even with KBUILD_MODPOST_WARN=1 since we
> > unconditionally add KBUILD_EXTRA_SYMBOLS to the modpost-args like this:
> >
> >   modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
> >
> > To fix this, I suggest you also take the following patch so that
> > KBUILD_MODPOST_WARN=1 will allow you to skip those unresolved symbols as
> > well:
> 
> 
> How is this useful?
> 
> KBUILD_EXTRA_SYMBOLS is explicitly specified by the user
> via the command line or the environment variable.
> 
> If $(KBUILD_EXTRA_SYMBOLS) does not exist,
> it is a user's fault, isn't it?

Sort of, yes. One could argue that it's the same situation as missing
the in-tree Module.symvers or the vmlinuux.o/vmlinux.symvers. Basically,
if you keep it as is, then KBUILD_MODPOST_WARN=1 would only work if the
user edits the Makefile to remove the KBUILD_EXTRA_SYMBOLS line.  With
my suggested patch, the user could build the module as is without any
dependencies by setting KBUILD_MODPOST_WARN=1.

I'm fine with whichever way you choose to support since I know this is
an external modules edge-case. I personally like to build my modules
with all the dependencies present to try an catch any issues at build
time.

Thanks,
Will

> 
> 
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

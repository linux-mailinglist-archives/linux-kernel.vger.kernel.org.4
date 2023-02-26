Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6726A2FE1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBZOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:04:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01929E05F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:04:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so15501013edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApfxXo5cqpc/Hq7AHd4ivcvtXCHy0YIkkj+ari342eI=;
        b=k/j0SJZZZYTsl0X8lEA3BKyUTzR3CSfnYbzhXTpj7K2KyMC5OM5/3YHOKiOrH31Exg
         agk9xrq3VeR7Uq2+srODEVEO+URpR+J82SkjbRLmaZVH6s/4LzeikaG5yoXVRPxE75PS
         Yn+WZ/UkrdaU15QiRG4LhzBPESzfk1n0XWN50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApfxXo5cqpc/Hq7AHd4ivcvtXCHy0YIkkj+ari342eI=;
        b=AP9uAU9Igyp0Dlh7zrx+HrHTCM//HOJe364SrMWJopu8zdsX4CgqbfueTHrkzv4loM
         ZdGthPe63OPlMnRcnIDGHvU6rj8nfQVBvfp5mqkMt4iw77GKg2KxrVNT0OiluBRQv4yd
         wl74uM8QPg4Yvagul9nx7rSltTcQItDFU9moevHmxIPgqkE+qkgnp9xXW9bGveytFeIp
         IptJQke0aByByFe7lACqa8tdkEQBKW42acxZFF3lQK5MGmZa343nGPsR7TeOsnkgckC4
         LujkC2alNJkIJ88milsQv15ESDCJLy6ZXZUAJPM0tsUjNe3xECq+VP3nUTvpaRxBqbZJ
         BbnA==
X-Gm-Message-State: AO0yUKWbiX69Wz13s+X64l/E2QTR7gm4uvdKkRrrMstoJWfd84LX/L1r
        w6s4kAaExd2mVwm+U8+2zqpZQtbbLuYcuDcLCBn+aQ==
X-Google-Smtp-Source: AK7set+grqKm9feoOo14z9BNUkamLLv8Cp/Y2uNOK8ytdSAdf66BPPTsVLFiT6GZOMAuVAuwr/b/lgFZu5w72Y+Rc50=
X-Received: by 2002:a50:c05a:0:b0:4ad:6fc8:69be with SMTP id
 u26-20020a50c05a000000b004ad6fc869bemr10494420edd.4.1677420259011; Sun, 26
 Feb 2023 06:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com> <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
In-Reply-To: <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 26 Feb 2023 07:04:07 -0700
Message-ID: <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > +Masahiro Yamada
>
>
>
>
> I do not know.
> This seems a shorthand in Kconfig level.
>
>
> masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
>     540    1080   24872
> masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
>     163     326    7462
>
> If hundreds of duplications are not manageable,
> go for it, but kconfig will be out-of-sync from the
> upstream Kconfig.

Yes that's right, it is a shorthand in Kconfig.

The counts above understand the problem a little since quite a few
CONFIG options without an SPL prefix are used in SPL. We don't have
tools to estimate how many, and we sometimes add a new symbol to 'gain
control' of a particular feature in a phase.

My intent in sending this patch was to check whether this support for
configuring multiple related builds (or something like it) could go
upstream, which for Kconfig is Linux, I believe. What do you think?

Regards,
Simon

>
>
> > On Fri, 24 Feb 2023 at 19:04, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> +lk
> >>
> >> On Sun, 19 Feb 2023 at 14:55, Simon Glass <sjg@chromium.org> wrote:
> >> >
> >> > In the case of Linux, only one build is produced so there is only a
> >> > single configuration. For other projects, such as U-Boot and Zephyr,=
 the
> >> > same code is used to produce multiple builds, each with related (but
> >> > different) options enabled.
> >> >
> >> > This can be handled with the existing kconfig language, but it is qu=
ite
> >> > verbose, somewhat tedious and very error-prone, since there is a lot=
 of
> >> > duplication. The result is hard to maintain.
> >> >
> >> > Describe an extension to the Kconfig language to support easier hand=
ling
> >> > of this use case.
> >> >
> >> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> > ---
> >> >
> >> >  Documentation/kbuild/kconfig-language.rst | 134 +++++++++++++++++++=
+++
> >> >  1 file changed, 134 insertions(+)
> >> >
> >> > diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentati=
on/kbuild/kconfig-language.rst
> >> > index 858ed5d80defe..73fb016a5533f 100644
> >> > --- a/Documentation/kbuild/kconfig-language.rst
> >> > +++ b/Documentation/kbuild/kconfig-language.rst
> >> > @@ -228,6 +228,24 @@ applicable everywhere (see syntax).
> >> >    enables the third modular state for all config symbols.
> >> >    At most one symbol may have the "modules" option set.
> >> >
> >> > +- phase declaration: "defphase"
> >> > +  This defines a new build phase. See `Build Phases`_.
> >> > +
> >> > +- default phase: "phasedefault"
> >> > +  This indicates the default build phase. See `Build Phases`_.
> >> > +
> >> > +- add entries for phases: "addphases"
> >> > +  This creates new phase-specific entries based on a template entry=
 and adds
> >> > +  the same attributes to it. See `Build Phases`_.
> >> > +
> >> > +- set entries for phases: "setphases"
> >> > +  This sets the phases which need an entry. This allows creating an=
 entry that
> >> > +  only has a primary phase. See `Build Phases`_.
> >> > +
> >> > +- indicate a phase-specific attribute: "forphases"
> >> > +  This marks an attribute as being applicable only to a particular =
phase or
> >> > +  group of phases.  See `Build Phases`_.
> >> > +
> >> >  Menu dependencies
> >> >  -----------------
> >> >
> >> > @@ -319,6 +337,119 @@ MODVERSIONS directly depends on MODULES, this =
means it's only visible if
> >> >  MODULES is different from 'n'. The comment on the other hand is onl=
y
> >> >  visible when MODULES is set to 'n'.
> >> >
> >> > +Build Phases
> >> > +------------
> >> > +
> >> > +Some projects use Kconfig to control multiple build phases, each ph=
ase
> >> > +resulting in a separate set of object files and executable. This is=
 the
> >> > +case in U-Boot [12]_. Zephyr OS seems to be heading this way too [1=
3]_.
> >> > +
> >> > +Generally the phases are related, so that enabling an entry in the =
primary
> >> > +phase also enables it by default in the others. But in some cases i=
t may
> >> > +be desirable to use separate conditions for each phase.
> >> > +
> >> > +All phases have a phase name, for example `SPL`. This name is used =
as a
> >> > +prefix to each entry used in that phase, with an underscore in betw=
een.
> >> > +So if FOO is the primary entry, the equivalent entry for the SPL ph=
ase
> >> > +is SPL_FOO. The primary phase is marked with a "phasedefault" entry=
.
> >> > +
> >> > +Phases are declared like any other menu entry except that also have=
 a
> >> > +"defphase" keyword. Phase entries are normally hidden so do not hav=
e a
> >> > +prompt::
> >> > +
> >> > +    config PPL
> >> > +        bool
> >> > +        defphase "Primary Program Loader"
> >> > +        phasedefault
> >> > +        help
> >> > +          This is the primary bootloader.
> >> > +
> >> > +    config SPL
> >> > +        bool
> >> > +        defphase "Secondary Program Loader"
> >> > +        help
> >> > +          This is used to set up memory and load the primary bootlo=
ader.
> >> > +
> >> > +The default phase (here PPL) is assumed for all entries, in the sen=
se that
> >> > +all entries are present in PPL by default and no prefix is needed o=
n these
> >> > +entries. So FOO means that it applies to PPL. There must be exactly=
 one
> >> > +default phase.
> >> > +
> >> > +The resulting menu entries can be used normally throughout the Kcon=
fig. With
> >> > +this technique, the different build phases can be fully and individ=
ually
> >> > +controlled from Kconfig.
> >> > +
> >> > +However it is not ideal. Often the secondary phases have far fewer =
entries than
> >> > +the primary phase, since they offer fewer features. Even so, each F=
OO that is
> >> > +needed in a phase must have an SPL_FOO, etc. To avoid an explosion =
of entries,
> >> > +it is possible to indicate which are enabled, as a shortcut for cre=
ating new
> >> > +entries::
> >> > +
> >> > +    config FOO
> >> > +        bool "Enable foo feature"
> >> > +        addphases SPL
> >> > +        depends on %BAR
> >> > +        depends on QUX
> >> > +        forphases SPL depends on FIZZ
> >> > +
> >> > +Note that "%" expands to the phase, so this is equivalent to (ignor=
ing BAR)::
> >> > +
> >> > +    config FOO
> >> > +        bool "Enable foo feature"
> >> > +        depends on BAR
> >> > +        depends on QUX
> >> > +
> >> > +    config SPL_FOO                        # Phase is prepended
> >> > +        bool "Enable foo feature (SPL)"    # Suffix is added
> >> > +        depends on SPL_BAR                 # "%" dependency is expa=
nded
> >> > +        depends on QUX
> >> > +        depends on FIZZ                    # Added only for SPL
> >> > +        depends on SPL                     # Added automatically
> >> > +
> >> > +Attributes declared in the primary symbol FOO (such as "depends on =
BAR") also
> >> > +apply to the secondary ones.
> >> > +
> >> > +An entry without any 'addphases' attribute applies to all phases. I=
ndividual
> >> > +phase entries are not available in that case. If the entry is enabl=
ed, then
> >> > +it is enabled for all phases. Only one entry appears in the resulti=
ng Kconfig.
> >> > +
> >> > +In the case where an entry should apply only to the primary phase (=
or a
> >> > +particular set of phases), you can uses "setphases" instead of "add=
phases"::
> >> > +
> >> > +    config FOO
> >> > +        bool "Enable foo feature"
> >> > +        setphases PPL
> >> > +
> >> > +This means that even if the option is enabled, it will not be activ=
e outside
> >> > +the primary-phase build, here named "PPL".
> >> > +
> >> > +Internally, phases are implemented simply by creating new entries. =
These
> >> > +appear in the Kconfig as per normal. It would be possible for a Kco=
nfig
> >> > +editor to show the entries just for a particular phase, leaving out=
 the
> >> > +entries not applicable to that phase.
> >> > +
> >> > +When phases are used, the Kconfig tool outputs separate auto.conf f=
iles for
> >> > +each phase (e.g. auto_spl.conf), so that if SPL_FOO is enabled, the=
n
> >> > +`CONFIG_FOO=3Dy` is present in the file. This makes it easy for the=
 build system
> >> > +to build the correct code, use IS_ENABLED(), etc.
> >> > +
> >> > +To ensure that the correct options are enabled for each build, in a=
ddition to
> >> > +the normal CONFIG_FOO option in the file, phase symbols are added t=
oo. For
> >> > +example, if FOO is enabled in the SPL phase, then auto_spl.conf con=
tains::
> >> > +
> >> > +    CONFIG_FOO=3Dy
> >> > +    CONFIG_SPL_FOO=3Dy
> >> > +
> >> > +The phase-specific line (CONFIG_SPL_FOO) is seldom needed, but it a=
llows one
> >> > +phase to access the symbols from another phase. For example, if the=
 primary
> >> > +phase needs to receive boot timings from SPL, then support for boot=
 timings must
> >> > +be added in both phases. If the timings are at a fixed address, thi=
s can be in a
> >> > +shared symbol (like CONFIG_SPL_TIMING_BASE) that both phases can ac=
cess.
> >> > +
> >> > +Technical note: the grammar definition of <symbol> in this documeen=
t does not
> >> > +include the "%" prefix at present. It can be used with any attribut=
e. It cannot
> >> > +be used with any top-level items, like "config", "menuconfig", "if"=
 and "menu".
> >> > +
> >> >
> >> >  Kconfig syntax
> >> >  --------------
> >> > @@ -744,3 +875,6 @@ https://kernelnewbies.org/KernelProjects/kconfig=
-sat
> >> >  .. [9] https://www4.cs.fau.de/Publications/2011/tartler_11_eurosys.=
pdf
> >> >  .. [10] https://paulgazzillo.com/papers/esecfse21.pdf
> >> >  .. [11] https://github.com/paulgazz/kmax
> >> > +
> >> > +.. [12] https://u-boot.readthedocs.io/en/latest/develop/spl.html
> >> > +.. [13] https://docs.zephyrproject.org/latest/build/sysbuild/index.=
html
> >> > --
> >> > 2.39.2.637.g21b0678d19-goog
> >> >
>
>
>
> --
> Best Regards
> Masahiro Yamada

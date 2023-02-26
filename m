Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC46A2D48
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBZDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:31:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E2126E0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B049760BB8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 03:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E862C4339B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 03:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677382297;
        bh=7Adw7R17RzR4ZOrXsZ526gI5D3MzYcOue7koEpMQh78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i/bclOgJ5q+OIzo7OHPtiRHYk15gkT6qHROAdF50fgbFIeNiMR5HBYaAE/YFlNeJM
         SwU8xwdzQes19KpdNN5q+3Mgn/GiBlkOFSLhVCP547IcQqAgqQYnjEGEgS3SZbcuo/
         U2RWi7jP6LsLMUd+p7NflDHMJYKVzXrGTCGWQYgo7HD0yMB3q5UU1M8WGef6J25Ipl
         VrtOdjEuQ+7GJOJYlwhjbcrFWtCR+hWLiy+N+uOyw3Y6b+d6ZJPJ2oDIiNXmTlMDCD
         S0b9Fv4i0+BZmVZTofuBfqgwLWQ5ldpaT++M/nxTOu9C8+Rh20iQhUnAV19UcWU70V
         Et+l/mx1rvI9A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-172334d5c8aso4152130fac.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:31:37 -0800 (PST)
X-Gm-Message-State: AO0yUKX9FYQ9WI1BGnkNIaXUaTqQjApEV+bHhaduFUxpnZ9UE3cMlQ1t
        zwUV5Y/Bsldzc6EwMcvahqK9k96//0WcBPnbSTI=
X-Google-Smtp-Source: AK7set/n3XIvfl+DPsJDuxmX0fy/X68U71sGIa6PkcrzvXftACUzH+8+zPRCsUMQBsW4EHykQ8neC+TKs2n5cmI8Q8s=
X-Received: by 2002:a05:6870:5302:b0:16e:8b45:1e0d with SMTP id
 j2-20020a056870530200b0016e8b451e0dmr2393888oan.8.1677382296290; Sat, 25 Feb
 2023 19:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com> <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Feb 2023 12:31:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
Message-ID: <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Simon Glass <sjg@chromium.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> +Masahiro Yamada




I do not know.
This seems a shorthand in Kconfig level.


masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
    540    1080   24872
masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
    163     326    7462

If hundreds of duplications are not manageable,
go for it, but kconfig will be out-of-sync from the
upstream Kconfig.

Masahiro










> On Fri, 24 Feb 2023 at 19:04, Simon Glass <sjg@chromium.org> wrote:
>>
>> +lk
>>
>> On Sun, 19 Feb 2023 at 14:55, Simon Glass <sjg@chromium.org> wrote:
>> >
>> > In the case of Linux, only one build is produced so there is only a
>> > single configuration. For other projects, such as U-Boot and Zephyr, t=
he
>> > same code is used to produce multiple builds, each with related (but
>> > different) options enabled.
>> >
>> > This can be handled with the existing kconfig language, but it is quit=
e
>> > verbose, somewhat tedious and very error-prone, since there is a lot o=
f
>> > duplication. The result is hard to maintain.
>> >
>> > Describe an extension to the Kconfig language to support easier handli=
ng
>> > of this use case.
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > ---
>> >
>> >  Documentation/kbuild/kconfig-language.rst | 134 +++++++++++++++++++++=
+
>> >  1 file changed, 134 insertions(+)
>> >
>> > diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation=
/kbuild/kconfig-language.rst
>> > index 858ed5d80defe..73fb016a5533f 100644
>> > --- a/Documentation/kbuild/kconfig-language.rst
>> > +++ b/Documentation/kbuild/kconfig-language.rst
>> > @@ -228,6 +228,24 @@ applicable everywhere (see syntax).
>> >    enables the third modular state for all config symbols.
>> >    At most one symbol may have the "modules" option set.
>> >
>> > +- phase declaration: "defphase"
>> > +  This defines a new build phase. See `Build Phases`_.
>> > +
>> > +- default phase: "phasedefault"
>> > +  This indicates the default build phase. See `Build Phases`_.
>> > +
>> > +- add entries for phases: "addphases"
>> > +  This creates new phase-specific entries based on a template entry a=
nd adds
>> > +  the same attributes to it. See `Build Phases`_.
>> > +
>> > +- set entries for phases: "setphases"
>> > +  This sets the phases which need an entry. This allows creating an e=
ntry that
>> > +  only has a primary phase. See `Build Phases`_.
>> > +
>> > +- indicate a phase-specific attribute: "forphases"
>> > +  This marks an attribute as being applicable only to a particular ph=
ase or
>> > +  group of phases.  See `Build Phases`_.
>> > +
>> >  Menu dependencies
>> >  -----------------
>> >
>> > @@ -319,6 +337,119 @@ MODVERSIONS directly depends on MODULES, this me=
ans it's only visible if
>> >  MODULES is different from 'n'. The comment on the other hand is only
>> >  visible when MODULES is set to 'n'.
>> >
>> > +Build Phases
>> > +------------
>> > +
>> > +Some projects use Kconfig to control multiple build phases, each phas=
e
>> > +resulting in a separate set of object files and executable. This is t=
he
>> > +case in U-Boot [12]_. Zephyr OS seems to be heading this way too [13]=
_.
>> > +
>> > +Generally the phases are related, so that enabling an entry in the pr=
imary
>> > +phase also enables it by default in the others. But in some cases it =
may
>> > +be desirable to use separate conditions for each phase.
>> > +
>> > +All phases have a phase name, for example `SPL`. This name is used as=
 a
>> > +prefix to each entry used in that phase, with an underscore in betwee=
n.
>> > +So if FOO is the primary entry, the equivalent entry for the SPL phas=
e
>> > +is SPL_FOO. The primary phase is marked with a "phasedefault" entry.
>> > +
>> > +Phases are declared like any other menu entry except that also have a
>> > +"defphase" keyword. Phase entries are normally hidden so do not have =
a
>> > +prompt::
>> > +
>> > +    config PPL
>> > +        bool
>> > +        defphase "Primary Program Loader"
>> > +        phasedefault
>> > +        help
>> > +          This is the primary bootloader.
>> > +
>> > +    config SPL
>> > +        bool
>> > +        defphase "Secondary Program Loader"
>> > +        help
>> > +          This is used to set up memory and load the primary bootload=
er.
>> > +
>> > +The default phase (here PPL) is assumed for all entries, in the sense=
 that
>> > +all entries are present in PPL by default and no prefix is needed on =
these
>> > +entries. So FOO means that it applies to PPL. There must be exactly o=
ne
>> > +default phase.
>> > +
>> > +The resulting menu entries can be used normally throughout the Kconfi=
g. With
>> > +this technique, the different build phases can be fully and individua=
lly
>> > +controlled from Kconfig.
>> > +
>> > +However it is not ideal. Often the secondary phases have far fewer en=
tries than
>> > +the primary phase, since they offer fewer features. Even so, each FOO=
 that is
>> > +needed in a phase must have an SPL_FOO, etc. To avoid an explosion of=
 entries,
>> > +it is possible to indicate which are enabled, as a shortcut for creat=
ing new
>> > +entries::
>> > +
>> > +    config FOO
>> > +        bool "Enable foo feature"
>> > +        addphases SPL
>> > +        depends on %BAR
>> > +        depends on QUX
>> > +        forphases SPL depends on FIZZ
>> > +
>> > +Note that "%" expands to the phase, so this is equivalent to (ignorin=
g BAR)::
>> > +
>> > +    config FOO
>> > +        bool "Enable foo feature"
>> > +        depends on BAR
>> > +        depends on QUX
>> > +
>> > +    config SPL_FOO                        # Phase is prepended
>> > +        bool "Enable foo feature (SPL)"    # Suffix is added
>> > +        depends on SPL_BAR                 # "%" dependency is expand=
ed
>> > +        depends on QUX
>> > +        depends on FIZZ                    # Added only for SPL
>> > +        depends on SPL                     # Added automatically
>> > +
>> > +Attributes declared in the primary symbol FOO (such as "depends on BA=
R") also
>> > +apply to the secondary ones.
>> > +
>> > +An entry without any 'addphases' attribute applies to all phases. Ind=
ividual
>> > +phase entries are not available in that case. If the entry is enabled=
, then
>> > +it is enabled for all phases. Only one entry appears in the resulting=
 Kconfig.
>> > +
>> > +In the case where an entry should apply only to the primary phase (or=
 a
>> > +particular set of phases), you can uses "setphases" instead of "addph=
ases"::
>> > +
>> > +    config FOO
>> > +        bool "Enable foo feature"
>> > +        setphases PPL
>> > +
>> > +This means that even if the option is enabled, it will not be active =
outside
>> > +the primary-phase build, here named "PPL".
>> > +
>> > +Internally, phases are implemented simply by creating new entries. Th=
ese
>> > +appear in the Kconfig as per normal. It would be possible for a Kconf=
ig
>> > +editor to show the entries just for a particular phase, leaving out t=
he
>> > +entries not applicable to that phase.
>> > +
>> > +When phases are used, the Kconfig tool outputs separate auto.conf fil=
es for
>> > +each phase (e.g. auto_spl.conf), so that if SPL_FOO is enabled, then
>> > +`CONFIG_FOO=3Dy` is present in the file. This makes it easy for the b=
uild system
>> > +to build the correct code, use IS_ENABLED(), etc.
>> > +
>> > +To ensure that the correct options are enabled for each build, in add=
ition to
>> > +the normal CONFIG_FOO option in the file, phase symbols are added too=
. For
>> > +example, if FOO is enabled in the SPL phase, then auto_spl.conf conta=
ins::
>> > +
>> > +    CONFIG_FOO=3Dy
>> > +    CONFIG_SPL_FOO=3Dy
>> > +
>> > +The phase-specific line (CONFIG_SPL_FOO) is seldom needed, but it all=
ows one
>> > +phase to access the symbols from another phase. For example, if the p=
rimary
>> > +phase needs to receive boot timings from SPL, then support for boot t=
imings must
>> > +be added in both phases. If the timings are at a fixed address, this =
can be in a
>> > +shared symbol (like CONFIG_SPL_TIMING_BASE) that both phases can acce=
ss.
>> > +
>> > +Technical note: the grammar definition of <symbol> in this documeent =
does not
>> > +include the "%" prefix at present. It can be used with any attribute.=
 It cannot
>> > +be used with any top-level items, like "config", "menuconfig", "if" a=
nd "menu".
>> > +
>> >
>> >  Kconfig syntax
>> >  --------------
>> > @@ -744,3 +875,6 @@ https://kernelnewbies.org/KernelProjects/kconfig-s=
at
>> >  .. [9] https://www4.cs.fau.de/Publications/2011/tartler_11_eurosys.pd=
f
>> >  .. [10] https://paulgazzillo.com/papers/esecfse21.pdf
>> >  .. [11] https://github.com/paulgazz/kmax
>> > +
>> > +.. [12] https://u-boot.readthedocs.io/en/latest/develop/spl.html
>> > +.. [13] https://docs.zephyrproject.org/latest/build/sysbuild/index.ht=
ml
>> > --
>> > 2.39.2.637.g21b0678d19-goog
>> >



--=20
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B186A26C3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 03:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBYCFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 21:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBYCFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 21:05:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68711231D2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:05:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ee7so4542979edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHSxkjQCUBNSOQwsJwoGqDZsHJ51PJEQ258rJc3R/Yg=;
        b=eeElTMdgsJc0x/mZR2nSbukairVrKOJtAHtx+nmzS7+CUmS5RKFrR9a+svB8541J51
         Dpu/tHK2D+NVizm+Msmi2C2dtVqZLjqLxhs6QN5QIb4BPVcHWaIOsIfwy1ZE7pH4qe2+
         G/uGhrfwPByZlBCLu9kvXmWlv67F4Qjz1KEB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHSxkjQCUBNSOQwsJwoGqDZsHJ51PJEQ258rJc3R/Yg=;
        b=vjZD+Cp9za/TRLMI7WrK2HiP55LI2+RlzSct4UbnPM6R8w7hFrMPcvAcNofZ9XUk3j
         r0A5nctXR2lSGQmgIXpfLIGXXua6idLlA2sNnlklL3evLtRqyjVc9w0ypd/gp6SGoQdj
         6lIjV3ZzDWFT9lURNO/eGQ6nt5nwookcx/lv5jzG0k5Wqi3Rk92JEjSU2WTElJr5x3Og
         cEyRmSBPsL1xMljIpvVBIvUVi6TX48LYacwNvrHOBGtce8lik8xw2RJv5l1yA601oF/B
         CCPxekrna8hkK0lTOiTctwNemdG4lNYic3S062c5poKI4+XOPe4fC/ywqAyVPwv4FIct
         LCyg==
X-Gm-Message-State: AO0yUKVLMfZ0mSkDZU/HKhStpBQ6JrEPVNHWQeiSSOe+pgVAHSZI84jS
        3Ek7U2CdtWcRTtBtZIz4eheynZWQ4QLlrNlMMo8QLPpcVe+o9Pvg
X-Google-Smtp-Source: AK7set83CSt8cqM05tbA+TS1RniSAVYH0mQmOFZicuIInqtgAgylyZjEGbgOy+cixa9+1A1W4LstDa+cvm87jFxhJ/w=
X-Received: by 2002:a17:906:80d7:b0:877:747d:f121 with SMTP id
 a23-20020a17090680d700b00877747df121mr11973988ejx.9.1677290704599; Fri, 24
 Feb 2023 18:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
In-Reply-To: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 24 Feb 2023 19:04:53 -0700
Message-ID: <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+lk

On Sun, 19 Feb 2023 at 14:55, Simon Glass <sjg@chromium.org> wrote:
>
> In the case of Linux, only one build is produced so there is only a
> single configuration. For other projects, such as U-Boot and Zephyr, the
> same code is used to produce multiple builds, each with related (but
> different) options enabled.
>
> This can be handled with the existing kconfig language, but it is quite
> verbose, somewhat tedious and very error-prone, since there is a lot of
> duplication. The result is hard to maintain.
>
> Describe an extension to the Kconfig language to support easier handling
> of this use case.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  Documentation/kbuild/kconfig-language.rst | 134 ++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
> index 858ed5d80defe..73fb016a5533f 100644
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -228,6 +228,24 @@ applicable everywhere (see syntax).
>    enables the third modular state for all config symbols.
>    At most one symbol may have the "modules" option set.
>
> +- phase declaration: "defphase"
> +  This defines a new build phase. See `Build Phases`_.
> +
> +- default phase: "phasedefault"
> +  This indicates the default build phase. See `Build Phases`_.
> +
> +- add entries for phases: "addphases"
> +  This creates new phase-specific entries based on a template entry and adds
> +  the same attributes to it. See `Build Phases`_.
> +
> +- set entries for phases: "setphases"
> +  This sets the phases which need an entry. This allows creating an entry that
> +  only has a primary phase. See `Build Phases`_.
> +
> +- indicate a phase-specific attribute: "forphases"
> +  This marks an attribute as being applicable only to a particular phase or
> +  group of phases.  See `Build Phases`_.
> +
>  Menu dependencies
>  -----------------
>
> @@ -319,6 +337,119 @@ MODVERSIONS directly depends on MODULES, this means it's only visible if
>  MODULES is different from 'n'. The comment on the other hand is only
>  visible when MODULES is set to 'n'.
>
> +Build Phases
> +------------
> +
> +Some projects use Kconfig to control multiple build phases, each phase
> +resulting in a separate set of object files and executable. This is the
> +case in U-Boot [12]_. Zephyr OS seems to be heading this way too [13]_.
> +
> +Generally the phases are related, so that enabling an entry in the primary
> +phase also enables it by default in the others. But in some cases it may
> +be desirable to use separate conditions for each phase.
> +
> +All phases have a phase name, for example `SPL`. This name is used as a
> +prefix to each entry used in that phase, with an underscore in between.
> +So if FOO is the primary entry, the equivalent entry for the SPL phase
> +is SPL_FOO. The primary phase is marked with a "phasedefault" entry.
> +
> +Phases are declared like any other menu entry except that also have a
> +"defphase" keyword. Phase entries are normally hidden so do not have a
> +prompt::
> +
> +    config PPL
> +        bool
> +        defphase "Primary Program Loader"
> +        phasedefault
> +        help
> +          This is the primary bootloader.
> +
> +    config SPL
> +        bool
> +        defphase "Secondary Program Loader"
> +        help
> +          This is used to set up memory and load the primary bootloader.
> +
> +The default phase (here PPL) is assumed for all entries, in the sense that
> +all entries are present in PPL by default and no prefix is needed on these
> +entries. So FOO means that it applies to PPL. There must be exactly one
> +default phase.
> +
> +The resulting menu entries can be used normally throughout the Kconfig. With
> +this technique, the different build phases can be fully and individually
> +controlled from Kconfig.
> +
> +However it is not ideal. Often the secondary phases have far fewer entries than
> +the primary phase, since they offer fewer features. Even so, each FOO that is
> +needed in a phase must have an SPL_FOO, etc. To avoid an explosion of entries,
> +it is possible to indicate which are enabled, as a shortcut for creating new
> +entries::
> +
> +    config FOO
> +        bool "Enable foo feature"
> +        addphases SPL
> +        depends on %BAR
> +        depends on QUX
> +        forphases SPL depends on FIZZ
> +
> +Note that "%" expands to the phase, so this is equivalent to (ignoring BAR)::
> +
> +    config FOO
> +        bool "Enable foo feature"
> +        depends on BAR
> +        depends on QUX
> +
> +    config SPL_FOO                        # Phase is prepended
> +        bool "Enable foo feature (SPL)"    # Suffix is added
> +        depends on SPL_BAR                 # "%" dependency is expanded
> +        depends on QUX
> +        depends on FIZZ                    # Added only for SPL
> +        depends on SPL                     # Added automatically
> +
> +Attributes declared in the primary symbol FOO (such as "depends on BAR") also
> +apply to the secondary ones.
> +
> +An entry without any 'addphases' attribute applies to all phases. Individual
> +phase entries are not available in that case. If the entry is enabled, then
> +it is enabled for all phases. Only one entry appears in the resulting Kconfig.
> +
> +In the case where an entry should apply only to the primary phase (or a
> +particular set of phases), you can uses "setphases" instead of "addphases"::
> +
> +    config FOO
> +        bool "Enable foo feature"
> +        setphases PPL
> +
> +This means that even if the option is enabled, it will not be active outside
> +the primary-phase build, here named "PPL".
> +
> +Internally, phases are implemented simply by creating new entries. These
> +appear in the Kconfig as per normal. It would be possible for a Kconfig
> +editor to show the entries just for a particular phase, leaving out the
> +entries not applicable to that phase.
> +
> +When phases are used, the Kconfig tool outputs separate auto.conf files for
> +each phase (e.g. auto_spl.conf), so that if SPL_FOO is enabled, then
> +`CONFIG_FOO=y` is present in the file. This makes it easy for the build system
> +to build the correct code, use IS_ENABLED(), etc.
> +
> +To ensure that the correct options are enabled for each build, in addition to
> +the normal CONFIG_FOO option in the file, phase symbols are added too. For
> +example, if FOO is enabled in the SPL phase, then auto_spl.conf contains::
> +
> +    CONFIG_FOO=y
> +    CONFIG_SPL_FOO=y
> +
> +The phase-specific line (CONFIG_SPL_FOO) is seldom needed, but it allows one
> +phase to access the symbols from another phase. For example, if the primary
> +phase needs to receive boot timings from SPL, then support for boot timings must
> +be added in both phases. If the timings are at a fixed address, this can be in a
> +shared symbol (like CONFIG_SPL_TIMING_BASE) that both phases can access.
> +
> +Technical note: the grammar definition of <symbol> in this documeent does not
> +include the "%" prefix at present. It can be used with any attribute. It cannot
> +be used with any top-level items, like "config", "menuconfig", "if" and "menu".
> +
>
>  Kconfig syntax
>  --------------
> @@ -744,3 +875,6 @@ https://kernelnewbies.org/KernelProjects/kconfig-sat
>  .. [9] https://www4.cs.fau.de/Publications/2011/tartler_11_eurosys.pdf
>  .. [10] https://paulgazzillo.com/papers/esecfse21.pdf
>  .. [11] https://github.com/paulgazz/kmax
> +
> +.. [12] https://u-boot.readthedocs.io/en/latest/develop/spl.html
> +.. [13] https://docs.zephyrproject.org/latest/build/sysbuild/index.html
> --
> 2.39.2.637.g21b0678d19-goog
>

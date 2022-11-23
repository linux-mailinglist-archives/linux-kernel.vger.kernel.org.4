Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B08636C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiKWVxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiKWVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:53:02 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD62213E85;
        Wed, 23 Nov 2022 13:53:00 -0800 (PST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2ANLqht0001692;
        Thu, 24 Nov 2022 06:52:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2ANLqht0001692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669240363;
        bh=4brSLwsgf2K/MFuU7IhDLjbD5WLitSIHjPY7T12lCSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZm8QKm1b9nEh3FXt5Hmij2qZ9fQfQKrmj0fOZKJCPAEMfbFNOMquZ+IDYJa6fHST
         mF9WVYM6kYDLkXLZoSVKKjUFiNGsNgOPURNqO395ZBotP2tEHCJAtPqvKiAwNGEEY8
         aI0dFoBJKxE7He44kzle8M/3RX1NWXhHZoyJZ1POIjEqJdblcUOWj4Is1zE04xmzYV
         YEJGyrX452d0yOJs6DtNcmyU7N9UgfDWiAT15pxpjzHs/QNMmbf23X2FOwPhhRqdaA
         95ZwxZrOc+RruyYTgUFV/AuUfgtT0x4BO56cNkOXGmPM9mViS6t/4uHNX3KT9xTPDy
         G3x9o2E+SPs2A==
X-Nifty-SrcIP: [209.85.161.46]
Received: by mail-oo1-f46.google.com with SMTP id o140-20020a4a2c92000000b0049effb01130so14657ooo.9;
        Wed, 23 Nov 2022 13:52:43 -0800 (PST)
X-Gm-Message-State: ANoB5pnwMG3RzQN5fw4SkfF8mABnKB5GTLbX+nFhFl2YQdj1dzQT7dDO
        EJVW7Ixykxp/OOUiYZ2h+AADhThW/e7Gbef0AJw=
X-Google-Smtp-Source: AA0mqf6i/EEWnNHGZ3i5ZmQAemkwA7O5D08FxMyftKnoinBWlrcPrejPJ9XtrRE17pl3f2WOeQ3uasT9NLLRn4I+BRA=
X-Received: by 2002:a05:6820:16a7:b0:49f:c664:44e2 with SMTP id
 bc39-20020a05682016a700b0049fc66444e2mr5014359oob.96.1669240362315; Wed, 23
 Nov 2022 13:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20221123151828.509565-1-masahiroy@kernel.org> <20221123151828.509565-3-masahiroy@kernel.org>
 <Y36KLFArg5etHRD8@bergen.fjasle.eu>
In-Reply-To: <Y36KLFArg5etHRD8@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Nov 2022 06:52:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWd-8awDOwE3iU9nx8QPj3VnoFtnUiX3NLyT+fx3BfjQ@mail.gmail.com>
Message-ID: <CAK7LNASWd-8awDOwE3iU9nx8QPj3VnoFtnUiX3NLyT+fx3BfjQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kbuild: add read-file macro
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 6:02 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu 24 Nov 2022 00:18:26 GMT, Masahiro Yamada wrote:
> > Since GMU Make 4.2, $(file ...) supports the read operater '<', which is
> > useful to read a file without forking any process. No warning is shown even
> > if the input file is missing.
> >
> > For older Make versions, it falls back to the cat command.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > (no changes since v1)
> >
> >  Makefile                  |  2 +-
> >  scripts/Kbuild.include    | 12 ++++++++++++
> >  scripts/Makefile.modfinal |  2 +-
> >  scripts/Makefile.modinst  |  2 +-
> >  4 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index eb80332f7b51..60ce9dcafc72 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -369,7 +369,7 @@ else # !mixed-build
> >  include $(srctree)/scripts/Kbuild.include
> >
> >  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
> > -KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
> > +KERNELRELEASE = $(call read-file, include/config/kernel.release)
> >  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> >  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> >
> > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > index 9996f34327cb..722846c23264 100644
> > --- a/scripts/Kbuild.include
> > +++ b/scripts/Kbuild.include
> > @@ -10,6 +10,10 @@ empty   :=
> >  space   := $(empty) $(empty)
> >  space_escape := _-_SPACE_-_
> >  pound := \#
> > +define newline
> > +
> > +
> > +endef
> >
> >  ###
> >  # Comparison macros.
> > @@ -55,6 +59,14 @@ stringify = $(squote)$(quote)$1$(quote)$(squote)
> >  kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> >  kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
> >
> > +###
> > +# Read a file, replacing newlines with spaces
> > +ifeq ($(call test-ge, $(MAKE_VERSION), 4.2),y)
> > +read-file = $(subst $(newline),$(space),$(file < $1))
> > +else
> > +read-file = $(shell cat $1 2>/dev/null)
> > +endif
> > +
>
> I like the implementation of read-file, but I am afraid that the
> MAKE_VERSION comparison breaks all make versions w/ a minor version
> number: 3.99.9x, 4.2.x, 4.3.x.


I think these should work correctly
unless I missed something terribly.


In the ASCII-sorting, they are sorted like this:

3.99.9x  4.2   4.2.x  4.3.x






The bad scenarios I came up with is GNU Make 4.10
and GNU Make 10.0 because $(sort ) will sort

10  4.10  4.2




GNU Make 4.3 was released in Jan 2020
GNU Make 4.4 was released in Oct 2022



If the current release pace continues,
we will have about 10 years until GNU Make hits 4.10

Until then, we can remove this ifeq.




-- 
Best Regards
Masahiro Yamada

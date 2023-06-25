Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143C973CF28
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjFYIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFYIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63843E53;
        Sun, 25 Jun 2023 01:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D679660B51;
        Sun, 25 Jun 2023 08:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419A4C433C9;
        Sun, 25 Jun 2023 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687680270;
        bh=VrhsBZVzpd6xlc3QG7da7dRTnXfUB2JW6VS9N09ftAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VgjVjqDgo9XpC/XszQOvlmiQQY+PDP1+UZfaDUJodRTnHzCIU7u7iJTZd4Yrvqt13
         tn/Wlb0p0WImP8C3jqhDbMJWTIz3xob3EMI8Fyyvcroa76AEkfKVTTjQWY96Z65KGn
         kZPtZB35ZW5EEnmwe9QCuP96mpWY9RugkGfwTuQnqyYm20PkTiki5NO7Jp8TOiyrwl
         +8gkGQNTp1LEAAXp/NcuztuEuRWaOP18IyTKUjHveBLrD6Tle7Zu3a+Ez6Vb6qCAN8
         FxGjp8kJ1poE5/kCH2xzuOUlSNPXiCaw69VLqovWfwHnHw59Chcy5uhbulcvuW9kVd
         cxJad1amZ2hbw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-19fa4346498so1814620fac.1;
        Sun, 25 Jun 2023 01:04:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDzRp79BEzuf2HmKRjHBnFybGUVyYgKCxTwH2rf4oXc14DPmAsSj
        u2YlIHGMGpyIHTagFCzouDePrepUslCe443DRH4=
X-Google-Smtp-Source: ACHHUZ5qpIkrJGOxYg9YuwZt7Tn7v3OoU8RwVlgTlVzcofZYt4rhOqXn6/ZsxsvX7I9v/mC9LYJSS+FUcB9eFaq0nfI=
X-Received: by 2002:a05:6871:40c:b0:1b0:3075:2f9d with SMTP id
 d12-20020a056871040c00b001b030752f9dmr1035653oag.34.1687680269500; Sun, 25
 Jun 2023 01:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230616145751.945864-1-masahiroy@kernel.org>
In-Reply-To: <20230616145751.945864-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Jun 2023 17:03:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5hSH5ov2AQOVsfzCSOTFnECMK1-t5AfvCpbAeWMa9ag@mail.gmail.com>
Message-ID: <CAK7LNAT5hSH5ov2AQOVsfzCSOTFnECMK1-t5AfvCpbAeWMa9ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: revive "Entering directory" for Make >= 4.4.1
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:57=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> With commit 9da0763bdd82 ("kbuild: Use relative path when building in
> a subdir of the source tree"), compiler messages in out-of-tree builds
> include relative paths, which are relative to the build directory, not
> the directory where make was started.
>
> To help IDEs/editors find the source files, Kbuild lets GNU Make print
> "Entering directory ..." when it changes the working directory. It has
> been working fine for a long time, but David reported it is broken with
> the latest GNU Make.
>
> The behavior was changed by GNU Make commit 8f9e7722ff0f ("[SV 63537]
> Fix setting -w in makefiles"). Previously, setting --no-print-directory
> to MAKEFLAGS only affected child makes, but it is now interpreted in
> the current make as soon as it is set.
>
> [test code]
>
>   $ cat /tmp/Makefile
>   ifneq ($(SUBMAKE),1)
>   MAKEFLAGS +=3D --no-print-directory
>   all: ; $(MAKE) SUBMAKE=3D1
>   else
>   all: ; :
>   endif
>
> [before 8f9e7722ff0f]
>
>   $ make -C /tmp
>   make: Entering directory '/tmp'
>   make SUBMAKE=3D1
>   :
>   make: Leaving directory '/tmp'
>
> [after 8f9e7722ff0f]
>
>   $ make -C /tmp
>   make SUBMAKE=3D1
>   :
>
> Previously, the effect of --no-print-directory was delayed until Kbuild
> started the directory descending, but it is no longer true with GNU Make
> 4.4.1.
>
> This commit adds one more recursion to cater to GNU Make >=3D 4.4.1.
>
> When Kbuild needs to change the working directory, __submake will be
> executed twice.
>
>   __submake without --no-print-directory  --> show "Entering directory ..=
."
>   __submake with    --no-print-directory  --> parse the rest of Makefile
>
> We end up with one more recursion than needed for GNU Make < 4.4.1, but
> I do not want to complicate the version check.
>
> Reported-by: David Howells <dhowells@redhat.com>
> Closes: https://lore.kernel.org/all/2427604.1686237298@warthog.procyon.or=
g.uk/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Fix the code. V1 did not work.
>   - Remove the version check to simplify the code


This patch broke 'make rpm-pkg'  (and 'make snap-pkg' as well).

I will send v3.











--=20
Best Regards
Masahiro Yamada

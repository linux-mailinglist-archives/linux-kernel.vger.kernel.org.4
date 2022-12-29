Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7C658A01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiL2HiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiL2HiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:38:05 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34665CD;
        Wed, 28 Dec 2022 23:38:03 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2BT7baLC031228;
        Thu, 29 Dec 2022 16:37:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2BT7baLC031228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672299457;
        bh=rL7z9pStZvZiE/K5f9+NPqC6yiliNPHqdrW1wd+GZPo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IXOfJRflZ/Aqs+eN5OdZykmQa0BOytnmYCg1nThRdL9nOwXnqygHw+dhg9WdGoqXu
         WW7DIdCuZKu6x1n8We8QGA363jW5kzUyo5WL6ej6xh7+4l/uJ2LaWvRBAFQkER7uqt
         jdnbMVQueG0hCRFGeggK7ky9BVrN+BZoGlWFJaeW4kVCtCprLpt9tbdcOmWZP8SYTI
         hn+yAKp82bAyS0KADqqFHB5buE1zNcKYxyQjYAdggMm6xhyx8vy0KBeWWJc4cfwBOy
         RfSpX6tergJoOARfQ/DxDiRRbyYFXMSiNto11mywVGv0wNVnOJr4DndWad2cLKa57K
         DZn5vCcNVdHYA==
X-Nifty-SrcIP: [209.85.210.50]
Received: by mail-ot1-f50.google.com with SMTP id k7-20020a056830168700b0067832816190so11119616otr.1;
        Wed, 28 Dec 2022 23:37:36 -0800 (PST)
X-Gm-Message-State: AFqh2kpMzbDfEKm3gx7Qy9/EeLhmdQok1guDPqsCts1HP51+Pv3M+DbB
        igu8dXUrwovC1spm+qsoMIF+recC3NiRt03KAO8=
X-Google-Smtp-Source: AMrXdXvxab1cjiUWHwlCrRH9Y6Z3+6gv3lPj2N8xPj4a/EgYadYw14GuKH+uyJCroX8zNqMLi8/n/PqToYeLFQi6GX4=
X-Received: by 2002:a9d:7e99:0:b0:670:64b2:ae66 with SMTP id
 m25-20020a9d7e99000000b0067064b2ae66mr1798405otp.225.1672299455545; Wed, 28
 Dec 2022 23:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20221224155138.447912-1-masahiroy@kernel.org> <20221224155138.447912-2-masahiroy@kernel.org>
 <Y6xzWV1abXRc/Vf2@bergen.fjasle.eu>
In-Reply-To: <Y6xzWV1abXRc/Vf2@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Dec 2022 16:36:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATajKsv-uS2JK2nzsuFV9zN4x9KEKxCXMXc=yHM_9gRhg@mail.gmail.com>
Message-ID: <CAK7LNATajKsv-uS2JK2nzsuFV9zN4x9KEKxCXMXc=yHM_9gRhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
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

On Thu, Dec 29, 2022 at 1:48 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sun 25 Dec 2022 00:51:38 GMT, Masahiro Yamada wrote:
> > The top .gitignore comments about how to detect files breaking
> > .gitignore rules, but people rarely care about it.
> >
> > Add a new W=1 warning to detect files that are tracked but ignored by
> > git. If git is not installed or the source tree is not tracked by git
> > at all, this script does not print anything.
> >
> > Running it on the v6.1 kernel detected the following:
> >
> >   $ make W=1 misc-check
> >   Documentation/devicetree/bindings/.yamllint: warning: ignored by one of the .gitignore files
> >   drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
> >   drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
> >   drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
> >   fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
> >   fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
> >   kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore files
> >   lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
> >   mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
> >
> > These are ignored by the '.*' or 'tags' in the top .gitignore, but
> > there is no rule to negate it.
> >
> > You might be tempted to do 'git add -f' but I want to have the real
> > issue fixed (by fixing a .gitignore, or by renaming files, etc.).
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Add $(srctree)/ to make it work with O=
> >
> >  Makefile           |  6 ++++++
> >  scripts/misc-check | 19 +++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >  create mode 100755 scripts/misc-check
> >
> > diff --git a/Makefile b/Makefile
> > index 44239352d2bf..f6ff8f77a669 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1852,6 +1852,12 @@ rust-analyzer:
> >  # Misc
> >  # ---------------------------------------------------------------------------
> >
> > +PHONY += misc-check
> > +misc-check:
> > +     $(Q)$(srctree)/scripts/misc-check
> > +
> > +all: misc-check
> > +
> >  PHONY += scripts_gdb
> >  scripts_gdb: prepare0
> >       $(Q)$(MAKE) $(build)=scripts/gdb
> > diff --git a/scripts/misc-check b/scripts/misc-check
> > new file mode 100755
> > index 000000000000..bf68712d1ac1
> > --- /dev/null
> > +++ b/scripts/misc-check
> > @@ -0,0 +1,19 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +set -e
> > +
> > +# Detect files that are tracked but ignored by git. This is checked only when
> > +# ${KBUILD_EXTRA_WARN} contains 1, git is installed, and the source tree is
> > +# tracked by git.
> > +check_tracked_ignored_files () {
> > +     case "${KBUILD_EXTRA_WARN}" in
> > +     *1*) ;;
> > +     *) return;;
> > +     esac
> > +
> > +     git ls-files -i -c --exclude-per-directory=.gitignore 2>/dev/null |
> > +             sed 's/$/: warning: ignored by one of the .gitignore files/' >&2
>
> I like that check.  It doesn't work with O=...; works for me with
> something like:
>
>   git ${abs_srctree:+-C "${abs_srctree}"} ls-files ...



A good catch!

I will fix it in v3.
Thanks.




>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



-- 
Best Regards
Masahiro Yamada

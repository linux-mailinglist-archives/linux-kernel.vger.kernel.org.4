Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2474D6287D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiKNSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiKNSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:04:12 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452327CDC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:03:22 -0800 (PST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2AEI31Le029190
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:03:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2AEI31Le029190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668448981;
        bh=54Y4AOtUYBegyKYHvt2LWMfUtwi2mulpZJLBNOl6jOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yFf79cL5R5weudFuwU9rbhyTS51hLkhT/WIde3qYjiheSJ9I6RYZpSdHEKf8YNRYD
         DYwB2N8LyNJMnh8ObM+f5xEsyILMJeMMhibsqi3fPXfKjzakLzH96cX0H4KnYqOyLC
         rG26KNCRrCtneqhTEiN319Y0VuLtFngd/HHN3PrUEUNfCZQSX39+AT/rWNRUdn3sPK
         Xdg0Hj9rUEdQrYWJuC5ffNhJ8odGDp+p8dPD2bHFnfb09QWwQnGyKXFWQgbmxtq1du
         zZzJ+zGc5VNCkpHg63cjDLCJgjuTM6TlbDVfCqS15fKRobZzDqgQRV7/DqPGAk9VDT
         Z3FEtI4BD8W6w==
X-Nifty-SrcIP: [209.85.161.45]
Received: by mail-oo1-f45.google.com with SMTP id r76-20020a4a374f000000b004988a70de2eso1695625oor.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:03:01 -0800 (PST)
X-Gm-Message-State: ANoB5pk/bS8vBHm3JS+TakHLhTeEJobBPa6R1opbnbkTUbNGxvD71CtK
        ltbbRcyZNGmwEF+Nn1bZmUGRRBdVOL7Wih+rUkY=
X-Google-Smtp-Source: AA0mqf5T0+nWhazSdtmPTuCQq4k59JcujutygQSrvurWGhei2TE0qAkXF/tLcwTbH9jnxDWjJE0FT0EFNfhMsUyOI80=
X-Received: by 2002:a4a:5704:0:b0:49f:449a:5f6c with SMTP id
 u4-20020a4a5704000000b0049f449a5f6cmr5722156ooa.93.1668448980435; Mon, 14 Nov
 2022 10:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <20221114114344.18650-4-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-4-jirislaby@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 03:02:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7i9wY1PS-841_7ufvS-ctF8GGH3OSQ=gu7FaOAMT0Vg@mail.gmail.com>
Message-ID: <CAK7LNAS7i9wY1PS-841_7ufvS-ctF8GGH3OSQ=gu7FaOAMT0Vg@mail.gmail.com>
Subject: Re: [PATCH 03/46] kbuild: lto: preserve MAKEFLAGS for module linking
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 8:44 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wr=
ote:
>
> From: Martin Liska <mliska@suse.cz>
>
> Prefix cc_o_c and ld_multi_m commands in makefile in order to preserve
> access to jobserver. This is needed for gcc LTO at least (enabled in
> later patches in this series). Note that both commands can invoke the
> linker (ld_single_m in the former case).
>
> Fixes this warning:
> lto-wrapper: warning: jobserver is not available: =E2=80=98--jobserver-au=
th=3D=E2=80=99 is not present in =E2=80=98MAKEFLAGS=E2=80=99
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmli=
nux_o)


Same as 02.

Also, 5d45950dfbb1 did not touch scripts/Makefile.build at all.
Please stop adding random, wrong Fixes.



Make already compiles many files in parallel.
It does not make sense to request a jobserver for
a single C file compilation.

Is there any way to turn off this annoyance?










> Signed-off-by: Martin Liska <mliska@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 41f3602fc8de..564a20ce2667 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -247,7 +247,7 @@ endef
>
>  # Built-in and composite module parts
>  $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
> -       $(call if_changed_rule,cc_o_c)
> +       +$(call if_changed_rule,cc_o_c)
>         $(call cmd,force_checksrc)
>
>  # To make this rule robust against "Argument list too long" error,
> @@ -457,7 +457,7 @@ endef
>  $(multi-obj-m): objtool-enabled :=3D $(delay-objtool)
>  $(multi-obj-m): part-of-module :=3D y
>  $(multi-obj-m): %.o: %.mod FORCE
> -       $(call if_changed_rule,ld_multi_m)
> +       +$(call if_changed_rule,ld_multi_m)
>  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
>
>  # Add intermediate targets:
> --
> 2.38.1
>


--=20
Best Regards
Masahiro Yamada

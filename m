Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898656DB3DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDGTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDGTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:02:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F75A279
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:01:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c3so28580pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680894102; x=1683486102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tum+O6CyYNU9vxjDy5o4+muJLyeV+iHYQTeNzCfrbAg=;
        b=IutiCCfJNbXQRW4jPMJUgc6kYMEcyD4cLm5OXtRQ4ufmsbInVPO/XOMbc4NAriredr
         Uj8Udl8DMss1tsFPUvbBNVIJDEWiA8z8WhuNXioG0BTTyqPQyfz7JOXhJmdDyrI5+9WC
         kjz6ykYBjksO0H+W5ngqC4v7+I5PNI3J1bFDGGY79ElET5kkqNHAfY2qNfuYLqoe4BXt
         p5jYZ+1nw2xhlR7D43N//+XS3W5/OQl4sKMxnjUziswnaU21Iyrxx/R6ncKsSZW7R/VZ
         MXv4mAmqVCkGfRsKd0eaWCUlxig/bS7eAPRb4pKfXGuha/UI3gAkYJ3k+LCp5pi6BC8v
         5yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680894102; x=1683486102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tum+O6CyYNU9vxjDy5o4+muJLyeV+iHYQTeNzCfrbAg=;
        b=L3Jh3nME6oYOLSIFqMFP1inDfsZZ+DFsTw7qaeidP3TtmOImUvLw67NMHgr2tAeGg1
         Wmqg5xs9BtNmgR6E438cpAqh/rh5sAFVwmWMyi8fdCtng8ZfNimBqWj4xRr1toK7WpJE
         fdKG+L2XENodV0YkchYLQ9iWIThGmJ/PEprXUtsTD4uxPxsztbojNtAP+pUuC9+t8MpO
         d6Yeo5wJiVXLK1rnPcddcwyhV7pckzsw5I0w+oaSzFZS1FYbE4Kh5uNTMaEWJaSh+P8V
         ckLxk8rIrYtFy3cCJJ8nI91qkl2VYPD8YaMjzElfz4yk0bC/JQvBJeS2wmQFstK3T4VC
         PAxg==
X-Gm-Message-State: AAQBX9d7c0+lB06Z/a0NbKvUYKL+eFMUlSq4oCPEtaF4xxQgiUSoRKaa
        xd4VwIZDhPIHyU/DoSGtITpcbOXieI+HPWHDv5NCuQ==
X-Google-Smtp-Source: AKy350YrYdB6eGsFu0WQiDgBGiIvg945AOZkNqG0bN0hlvobD3ezuDMHmgAX5qc9bmvTurgUilGaMEN0UERJBC8atFg=
X-Received: by 2002:a17:902:da85:b0:19f:2aa4:b1e5 with SMTP id
 j5-20020a170902da8500b0019f2aa4b1e5mr1242606plx.2.1680894101624; Fri, 07 Apr
 2023 12:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-3-masahiroy@kernel.org>
 <CAKwvOdnmiL_wDgzepYb+ZGgWt2xnsp48-awn0Cd0c4RDR43t_Q@mail.gmail.com>
In-Reply-To: <CAKwvOdnmiL_wDgzepYb+ZGgWt2xnsp48-awn0Cd0c4RDR43t_Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 12:01:30 -0700
Message-ID: <CAKwvOdn1Sjj=t1XJ3K-etFnemMs7UkbyGmbHC4c2H4O=77sjHg@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/mksysmap: use sed with in-line comments
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 11:59=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 8, 2023 at 3:53=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > Move comments close to the code.
>
> Consider adding to the commit message why you switch from grep to sed;
> that's currently unclear.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Also, perhaps scripts/mksysmap could just be replaced with a sed
input-file? Then
scripts/link-vmlinux.sh would invoke nm and pipe it into that sed script?

>
> Orthogonal to this patch, don't .L prefixed local symbols not have
> entries in the symbol table? If they're not printed with nm, why
> filter them out (since they're impossible).
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mksysmap | 61 +++++++++++++++++++++++++++++-------------------
> >  1 file changed, 37 insertions(+), 24 deletions(-)
> >
> > diff --git a/scripts/mksysmap b/scripts/mksysmap
> > index 697fc6653953..8ea1955e03c6 100755
> > --- a/scripts/mksysmap
> > +++ b/scripts/mksysmap
> > @@ -10,32 +10,45 @@
> >  #####
> >  # Generate System.map (actual filename passed as second argument)
> >
> > -# For System.map filter away:
> > -#   a - local absolute symbols
> > -#   U - undefined global symbols
> > -#   N - debugging symbols
> > -#   w - local weak symbols
> > -
> >  # readprofile starts reading symbols when _stext is found, and
> >  # continue until it finds a symbol which is not either of 'T', 't',
> >  # 'W' or 'w'.
> >  #
> > -# Ignored prefixes:
> > -#  $                    - local symbols for ARM, MIPS, etc.
> > -#  .L                   - local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.=
LASANPC, etc.
> > -#  __crc_               - modversions
> > -#  __kstrtab_           - EXPORT_SYMBOL (symbol name)
> > -#  __kstrtabns_         - EXPORT_SYMBOL (namespace)
> > +
> > +${NM} -n ${1} | sed >${2} -e "
> > +# --------------------------------------------------------------------=
-------
> > +# Ignored symbol types
> >  #
> > -# Ignored symbols:
> > -#  L0                   - for LoongArch?
> > -
> > -$NM -n $1 | grep -v            \
> > -       -e ' [aNUw] '           \
> > -       -e ' \$'                \
> > -       -e ' \.L'               \
> > -       -e ' __crc_'            \
> > -       -e ' __kstrtab_'        \
> > -       -e ' __kstrtabns_'      \
> > -       -e ' L0$'               \
> > -> $2
> > +
> > +# a: local absolute symbols
> > +# N: debugging symbols
> > +# U: undefined global symbols
> > +# w: local weak symbols
> > +/ [aNUw] /d
> > +
> > +# --------------------------------------------------------------------=
-------
> > +# Ignored prefixes
> > +#  (do not forget a space before each pattern)
> > +
> > +# local symbols for ARM, MIPS, etc.
> > +/ \$/d
> > +
> > +# local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
> > +/ \.L/d
> > +
> > +# CRC from modversions
> > +/ __crc_/d
> > +
> > +# EXPORT_SYMBOL (symbol name)
> > +/ __kstrtab_/d
> > +
> > +# EXPORT_SYMBOL (namespace)
> > +/ __kstrtabns_/d
> > +
> > +# --------------------------------------------------------------------=
-------
> > +# Ignored symbols (exact match)
> > +#  (do not forget a space before and '$' after each pattern)
> > +
> > +# for LoongArch?
> > +/ L0$/d
> > +"
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCACE6DE41E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDKSoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:44:36 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7BD12A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:44:34 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1842e278605so10919424fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681238674; x=1683830674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qysh3FB/G7ZLyb+oALSulrZAfknq+JXOVOkKpuRZ2GI=;
        b=K8h3iNdksz5yb+9Oara0pOknq/EKMjlpXw5RFwh/UoQbBsDxrgrbOmjdkI8zYHlE5y
         AxxhLtReIEAinj54h9Yc75ak10tVuz+6wTL/8zp2kdZxczfgFUQbaMuHk5c+lkwgIQRE
         jaa/M6V/ORtN4gyJ5/rBHZpYpdMV/7odoL+jVmNSsM8ZghcIyQWOu8VsQGibq3dS+K6Z
         tqCxNJcqMpW8QlPe6K7CP9SqEbdWj4xxVo4yqud9uYBRp1tGZLpZUur23P8qhsSg8sIx
         vubzQtKTQTAvvMzysUI88mdckKrtafIumnijOBPCx3HjeUYo+KgZ3KwHKnLd15T6t3ok
         boVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238674; x=1683830674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qysh3FB/G7ZLyb+oALSulrZAfknq+JXOVOkKpuRZ2GI=;
        b=iTOSnKMsysRObjT6uv8U4OjL0jAjdGC9sJ5jz7o9QzFAh4qK/IUGOuytNfiWs7tC7+
         9sDdbOFFZIJrPRIfzqrvdxncmBqYYrSPR2yVT2b0hgwWDiZhdYnNYMu1e4T4BZ0OE/9d
         usHgonrna1FizrMXHyoETJLQdqK9yIDBlDsxARYHcMEc+9Q1hzL4zP38TwIJNNY1wmBe
         7dRZBcCzE34erg/ksx8IRk8KB1zSbcHWlm4skJyI8beJyn3wdPCmFWWlglurI0ufB9Pt
         Jyy8IA28iCyACYdbfPNcv4d5PMeF+s1XYv8bxLgwhlhydOqMIrrGJP3kHAaKv5ZYLT81
         +oLA==
X-Gm-Message-State: AAQBX9eT/FYXdoXeqmZK/2ae045ZRF6Xrt65NmwxuMWch0GGqjq8Rp3M
        dcQSJ4OWjmI0wouWEoyy56YZYSMlK+3CCXDhqEpk5w==
X-Google-Smtp-Source: AKy350abpGI7zGeOfzaCZRe73VPv+FgF1YmMniW63cTumqZLpO0XQ/Q0GQCn6uEb22+hAMQp8QytWzAij3Tt1LUUQBo=
X-Received: by 2002:a05:6870:5387:b0:17f:5b1a:20ce with SMTP id
 h7-20020a056870538700b0017f5b1a20cemr5401719oan.5.1681238674024; Tue, 11 Apr
 2023 11:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212210.1001990-1-maskray@google.com> <CAKwvOd=QXGbrxct20cBia92=QonWtfWdC21WK4w2bRBprPXh=w@mail.gmail.com>
In-Reply-To: <CAKwvOd=QXGbrxct20cBia92=QonWtfWdC21WK4w2bRBprPXh=w@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 11 Apr 2023 11:44:22 -0700
Message-ID: <CAFP8O3JSs1bOYrqWpzXiv9fEEfMwiJwcTMBX6v3C654niksN2Q@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: use -z pack-relative-relocs
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>
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

On Fri, Apr 7, 2023 at 11:35=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Mar 24, 2023 at 2:22=E2=80=AFPM Fangrui Song <maskray@google.com>=
 wrote:
> >
> > Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
> > added --use-android-relr-tags to fix a GDB warning
> >
> > BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.d=
yn'
> >
> > The GDB warning has been fixed in version 11.2.
> >
> > The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized.
> > Thus, --use-android-relr-tags should be removed. While making the
> > change, try -z pack-relative-relocs, which is supported since LLD 15.
> > Keep supporting --pack-dyn-relocs=3Drelr as well for older LLD versions=
.
> >
> > As of today, GNU ld supports the latter option for x86 and powerpc64
> > ports and has no intention to support --pack-dyn-relocs=3Drelr. In the
> > absence of the glibc symbol version GLIBC_ABI_DT_RELR,
> > --pack-dyn-relocs=3Drelr and -z pack-relative-relocs are identical in
> > ld.lld.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> > Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Da=
619b58721f0a03fd91c27670d3e4c2fb0d88f1e
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Thanks v2 looks better. IIUC, this will first try to test+use
> `--pack-dyn-relocs=3Drelr` in preference to `-z pack-relative-relocs`.
> Do we want to reorder the preference, for both the test and actual
> flag used?

Thanks for the comment. The order is deliberate and there is no
obsolescence indication of --pack-dyn-relocs=3Drelr.

GNU ld and newer lld report warnings (instead of errors) for unknown
-z options, and only errors lead to non-zero exit codes.

Therefore, $(call ld-option,--pack-dyn-relocs=3Drelr,-z
pack-relative-relocs) has to place --pack-dyn-relocs=3Drelr first.
scripts/tools-support-relr.sh has to test --pack-dyn-relocs=3Drelr first as=
 well.

> > ---
> >  Makefile                      | 3 ++-
> >  scripts/tools-support-relr.sh | 8 ++++++--
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > ---
> > Changes from v1:
> > * Keep supporting --pack-dyn-relocs=3Drelr for older ld.lld versions
> >
> > diff --git a/Makefile b/Makefile
> > index a2c310df2145..e23a85476d5d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1113,7 +1113,8 @@ LDFLAGS_vmlinux   +=3D -X
> >  endif
> >
> >  ifeq ($(CONFIG_RELR),y)
> > -LDFLAGS_vmlinux        +=3D --pack-dyn-relocs=3Drelr --use-android-rel=
r-tags
> > +# ld.lld before 15 did not support -z pack-relative-relocs.
> > +LDFLAGS_vmlinux        +=3D $(call ld-option,--pack-dyn-relocs=3Drelr,=
-z pack-relative-relocs)
> >  endif
> >
> >  # We never want expected sections to be placed heuristically by the
> > diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr=
.sh
> > index cb55878bd5b8..4c121946e517 100755
> > --- a/scripts/tools-support-relr.sh
> > +++ b/scripts/tools-support-relr.sh
> > @@ -7,8 +7,12 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
> >  cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
> >  void *p =3D &p;
> >  END
> > -$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr \
> > -  --use-android-relr-tags -o $tmp_file
> > +
> > +# ld.lld before 15 did not support -z pack-relative-relocs.
> > +if ! $LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr -o $t=
mp_file 2>/dev/null; then
> > +       $LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o $=
tmp_file 2>&1 |
> > +               grep -q pack-relative-relocs && exit 1
> > +fi
> >
> >  # Despite printing an error message, GNU nm still exits with exit code=
 0 if it
> >  # sees a relr section. So we need to check that nothing is printed to =
stderr.
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

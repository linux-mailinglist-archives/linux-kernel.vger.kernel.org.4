Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49326DE53A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDKUDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDKUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:03:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417A4228
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:03:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6346aa0a227so740685b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681243398; x=1683835398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QIvtNOZpjFXcu94e1ZYRZNGqBLek5acvR5DAimawdo=;
        b=c0yUYijCoz7BQlVO1A8/4q0a0aQARahXSrZKdwBCNSn1h+KuFpf6Zw9MUHfjn9a6H7
         JZQ1ENtObsHnvxNPguDD1SvANqglY0KcTb1RkSk1UMHk5NnqkbP7TaJgvdPbEVT7VqNC
         VzO9NOn4xGa0Psb0nfeqon8YS9cib59nUCq/S30xUBJWL2MF1zHANqZ331J4p1tAyXxB
         QvSN99qxtt3GyirxxgzQJaflUQFQ/EfHMvUSOExjXluT0Ei5hBl/BDYDTDOOzj7MG0Wo
         SdjevGj+r2uPrfywMGeSuGQYMGKr1SrZRtcvy6EDX4+Ti11IIxuXHwJLAj0ZPxwOZ0uI
         Yejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243398; x=1683835398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QIvtNOZpjFXcu94e1ZYRZNGqBLek5acvR5DAimawdo=;
        b=USsT9LeqSZ5bALEuwkz6eLLyhXdrIR4Ucsp5uUIBDUbPxvTXbY8sOgpXur0fqy8yRg
         zztC4x1csUSg0JJK+htTBazFrKloU/4DLc+QeSuORPBB1YfJrhQE+pmOuJKLLbtGnVDd
         RyqNlvLlwHllinRlj6gBzc5RhKqTgkguNX9J3C1dylYo79KFc9BaQs8gKWUoC+wkJbIV
         nKAwfwMc7QaZmOqPmmwqYqmHQ0oazEyvUuwL2bQQ3Z3YedfW0yL7x+ngpWKn1qfXPrHI
         2zeC/p59BTvUKgsV7DIh7Sk/7x1JUfPG9kI5vCQHzByOFsGGcfx8D5GgtpLbyycUu9wc
         HXhg==
X-Gm-Message-State: AAQBX9eF2hUejwmHaqT6JIsuESZh/Ur31Z8D1NlJqNYhuxdR8iP3VOBL
        iEKLOTlMEMcpvVqgFVL1C5YxECG6Lms1yPlNsP9msg==
X-Google-Smtp-Source: AKy350Yj++7oOxO2QLb08w/0xfk0wmzTO10oSqB5jYN2g0CTsbzoP24SZY8H1V8XPYI27fb+SE6gOPXDk28jZek/AQM=
X-Received: by 2002:a05:6a00:1251:b0:625:c832:6a10 with SMTP id
 u17-20020a056a00125100b00625c8326a10mr5776657pfi.4.1681243397790; Tue, 11 Apr
 2023 13:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212210.1001990-1-maskray@google.com> <CAKwvOd=QXGbrxct20cBia92=QonWtfWdC21WK4w2bRBprPXh=w@mail.gmail.com>
 <CAFP8O3JSs1bOYrqWpzXiv9fEEfMwiJwcTMBX6v3C654niksN2Q@mail.gmail.com>
In-Reply-To: <CAFP8O3JSs1bOYrqWpzXiv9fEEfMwiJwcTMBX6v3C654niksN2Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Apr 2023 13:03:06 -0700
Message-ID: <CAKwvOdnAjeHYuDHKQgr8VFAem+sK05gdoC6KZea8MCw2pdFdPw@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: use -z pack-relative-relocs
To:     Fangrui Song <maskray@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:44=E2=80=AFAM Fangrui Song <maskray@google.com> =
wrote:
>
> On Fri, Apr 7, 2023 at 11:35=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 2:22=E2=80=AFPM Fangrui Song <maskray@google.co=
m> wrote:
> > >
> > > Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
> > > added --use-android-relr-tags to fix a GDB warning
> > >
> > > BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr=
.dyn'
> > >
> > > The GDB warning has been fixed in version 11.2.
> > >
> > > The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized=
.
> > > Thus, --use-android-relr-tags should be removed. While making the
> > > change, try -z pack-relative-relocs, which is supported since LLD 15.
> > > Keep supporting --pack-dyn-relocs=3Drelr as well for older LLD versio=
ns.
> > >
> > > As of today, GNU ld supports the latter option for x86 and powerpc64
> > > ports and has no intention to support --pack-dyn-relocs=3Drelr. In th=
e
> > > absence of the glibc symbol version GLIBC_ABI_DT_RELR,
> > > --pack-dyn-relocs=3Drelr and -z pack-relative-relocs are identical in
> > > ld.lld.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> > > Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=
=3Da619b58721f0a03fd91c27670d3e4c2fb0d88f1e
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Thanks v2 looks better. IIUC, this will first try to test+use
> > `--pack-dyn-relocs=3Drelr` in preference to `-z pack-relative-relocs`.
> > Do we want to reorder the preference, for both the test and actual
> > flag used?
>
> Thanks for the comment. The order is deliberate and there is no
> obsolescence indication of --pack-dyn-relocs=3Drelr.
>
> GNU ld and newer lld report warnings (instead of errors) for unknown
> -z options, and only errors lead to non-zero exit codes.

That makes sense; consider adding a note about that intention to the
commit message in a v3 along with:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Therefore, $(call ld-option,--pack-dyn-relocs=3Drelr,-z
> pack-relative-relocs) has to place --pack-dyn-relocs=3Drelr first.
> scripts/tools-support-relr.sh has to test --pack-dyn-relocs=3Drelr first =
as well.
>
> > > ---
> > >  Makefile                      | 3 ++-
> > >  scripts/tools-support-relr.sh | 8 ++++++--
> > >  2 files changed, 8 insertions(+), 3 deletions(-)
> > > ---
> > > Changes from v1:
> > > * Keep supporting --pack-dyn-relocs=3Drelr for older ld.lld versions
> > >
> > > diff --git a/Makefile b/Makefile
> > > index a2c310df2145..e23a85476d5d 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1113,7 +1113,8 @@ LDFLAGS_vmlinux   +=3D -X
> > >  endif
> > >
> > >  ifeq ($(CONFIG_RELR),y)
> > > -LDFLAGS_vmlinux        +=3D --pack-dyn-relocs=3Drelr --use-android-r=
elr-tags
> > > +# ld.lld before 15 did not support -z pack-relative-relocs.
> > > +LDFLAGS_vmlinux        +=3D $(call ld-option,--pack-dyn-relocs=3Drel=
r,-z pack-relative-relocs)
> > >  endif
> > >
> > >  # We never want expected sections to be placed heuristically by the
> > > diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-re=
lr.sh
> > > index cb55878bd5b8..4c121946e517 100755
> > > --- a/scripts/tools-support-relr.sh
> > > +++ b/scripts/tools-support-relr.sh
> > > @@ -7,8 +7,12 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXI=
T
> > >  cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
> > >  void *p =3D &p;
> > >  END
> > > -$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr \
> > > -  --use-android-relr-tags -o $tmp_file
> > > +
> > > +# ld.lld before 15 did not support -z pack-relative-relocs.
> > > +if ! $LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr -o =
$tmp_file 2>/dev/null; then
> > > +       $LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o=
 $tmp_file 2>&1 |
> > > +               grep -q pack-relative-relocs && exit 1
> > > +fi
> > >
> > >  # Despite printing an error message, GNU nm still exits with exit co=
de 0 if it
> > >  # sees a relr section. So we need to check that nothing is printed t=
o stderr.
> > > --
> > > 2.40.0.348.gf938b09366-goog
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF



--=20
Thanks,
~Nick Desaulniers

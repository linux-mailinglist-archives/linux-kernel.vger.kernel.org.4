Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83296DB2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDGSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDGSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:35:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E3ABBBE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:35:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso43975817pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680892536; x=1683484536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkvnHvhSWeo4VxY3cBnY8xmf+ae8qd887dNHfnNtpJc=;
        b=mPLcikNXDVSJkaTJnrYtE/PrmU4K58uQCaJJj2SEuX7BYjnHdOVPP0uWm7Ys8pkSNN
         3UQMtDXGdNOq3BbYpGCt3MexDznn6DMUCJKT9u7IkE0p2J6dnIGBsvH1ujAUiYNLbst8
         tU1admMpaie+k9EVyksjCS2abg71lmso213cBfaG1BJtZHm5zmKwjztqV/PXm5zjzylc
         M1HnI6njMewLKlZREZos9pPHHhYRnY/X7NUAfs4DubfgANrp4R+ThZI3UlHkrGh2/eZF
         M1C19kxcJQiD1E1i+oH+dLKCWctUrqBlIFi4eTubWT3bG0FVs8u8wzr6D31eRQRxnhuB
         L/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892536; x=1683484536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkvnHvhSWeo4VxY3cBnY8xmf+ae8qd887dNHfnNtpJc=;
        b=6vpoDtcFl4neAAzNmUElhIWU+kWXSOSD/efx2f9GTxbgayG6uUIaEa1Z5bnveK+ztW
         E02476REniSeh9YEEeMBpRiYWFLMmuGyvIHAj/8fq9mghZeMee1Z7AF5NQ0YEADXjcPf
         QkVXUP2nL9y8Ly8aKNFNfzBoI8d7pBrCx/5E5rnw9brfTNfwC9YUUyG91KJQgRGxEKuZ
         wS+UqVBZXgtJTDKDLHC+32fUvNcolrjjltpEoqptuG59rp3cvqQ93OPNPCLp/xxzYAwy
         396OWpW/hArnJFsxqdelRnEoz0Kte2GiV/6zvID/l45gULADJshb3YSQKorc333BHg4y
         uGuQ==
X-Gm-Message-State: AAQBX9fxuqI0x4fhADem4LF27L6zy0DoJRlk+RJMjsOloFoM2yXK0VqK
        DZCkcKoEjHj+e672TMMkyVjoXuMzZWq4prDtq15bj2lZ/qc5omA+CkCKQA==
X-Google-Smtp-Source: AKy350aPJLLxT7peXfZnEftBBV8F7gsFTwtE+ixtpx4oUkwKGFydDK+es9dO4+rJzqrDYQ34QWKn2vt6euzihLIOJ4I=
X-Received: by 2002:a17:90a:f10:b0:23d:535f:59c7 with SMTP id
 16-20020a17090a0f1000b0023d535f59c7mr802293pjy.7.1680892535727; Fri, 07 Apr
 2023 11:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212210.1001990-1-maskray@google.com>
In-Reply-To: <20230324212210.1001990-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:35:24 -0700
Message-ID: <CAKwvOd=QXGbrxct20cBia92=QonWtfWdC21WK4w2bRBprPXh=w@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: use -z pack-relative-relocs
To:     Fangrui Song <maskray@google.com>
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

On Fri, Mar 24, 2023 at 2:22=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
> added --use-android-relr-tags to fix a GDB warning
>
> BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.dyn=
'
>
> The GDB warning has been fixed in version 11.2.
>
> The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized.
> Thus, --use-android-relr-tags should be removed. While making the
> change, try -z pack-relative-relocs, which is supported since LLD 15.
> Keep supporting --pack-dyn-relocs=3Drelr as well for older LLD versions.
>
> As of today, GNU ld supports the latter option for x86 and powerpc64
> ports and has no intention to support --pack-dyn-relocs=3Drelr. In the
> absence of the glibc symbol version GLIBC_ABI_DT_RELR,
> --pack-dyn-relocs=3Drelr and -z pack-relative-relocs are identical in
> ld.lld.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Da61=
9b58721f0a03fd91c27670d3e4c2fb0d88f1e
> Signed-off-by: Fangrui Song <maskray@google.com>

Thanks v2 looks better. IIUC, this will first try to test+use
`--pack-dyn-relocs=3Drelr` in preference to `-z pack-relative-relocs`.
Do we want to reorder the preference, for both the test and actual
flag used?

> ---
>  Makefile                      | 3 ++-
>  scripts/tools-support-relr.sh | 8 ++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> ---
> Changes from v1:
> * Keep supporting --pack-dyn-relocs=3Drelr for older ld.lld versions
>
> diff --git a/Makefile b/Makefile
> index a2c310df2145..e23a85476d5d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1113,7 +1113,8 @@ LDFLAGS_vmlinux   +=3D -X
>  endif
>
>  ifeq ($(CONFIG_RELR),y)
> -LDFLAGS_vmlinux        +=3D --pack-dyn-relocs=3Drelr --use-android-relr-=
tags
> +# ld.lld before 15 did not support -z pack-relative-relocs.
> +LDFLAGS_vmlinux        +=3D $(call ld-option,--pack-dyn-relocs=3Drelr,-z=
 pack-relative-relocs)
>  endif
>
>  # We never want expected sections to be placed heuristically by the
> diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr.s=
h
> index cb55878bd5b8..4c121946e517 100755
> --- a/scripts/tools-support-relr.sh
> +++ b/scripts/tools-support-relr.sh
> @@ -7,8 +7,12 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
>  cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
>  void *p =3D &p;
>  END
> -$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr \
> -  --use-android-relr-tags -o $tmp_file
> +
> +# ld.lld before 15 did not support -z pack-relative-relocs.
> +if ! $LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr -o $tmp=
_file 2>/dev/null; then
> +       $LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o $tm=
p_file 2>&1 |
> +               grep -q pack-relative-relocs && exit 1
> +fi
>
>  # Despite printing an error message, GNU nm still exits with exit code 0=
 if it
>  # sees a relr section. So we need to check that nothing is printed to st=
derr.
> --
> 2.40.0.348.gf938b09366-goog
>


--=20
Thanks,
~Nick Desaulniers

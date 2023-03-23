Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1176A6C73F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCWXRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCWXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:17:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D01A656
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:17:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so3631029pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679613457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiKl7sOY7EHCgJkdTfDH25K0RbHgHAGi3xzbRlPaCYU=;
        b=LK5Bqyl6Jei1yT4nfUCL5iooEdHaIufcHgyU0dXuMm2U+ifJgKHjjYhxOi2LV9vCKO
         43d3DLC79AjWw5gxyqPPNftmcCuVLrQBbzw8cge6wQs7WYmg2L2voJiqUO0go5+3Ez2w
         6d8iAPow/xEUyTNK1Vd45EjTFgnP2/8ui7mMiYkXfREeVSp18uvkH4BP+zepvO89XjML
         uvIOueSk+NfEoAEQs5HqhZ78OrWLlRHppFbJWYN2DZIxcijghVPteCPlH9yyCT+i+2ln
         ykIQ81bbl9kd7qh8SBSp4OyrpprMvzDrCnTCzwrOVgZTYR4CnNku5ruY5x318F9EEWma
         tiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679613457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiKl7sOY7EHCgJkdTfDH25K0RbHgHAGi3xzbRlPaCYU=;
        b=BRQWY31wjtqYJ1WX/yzrvJ9HGzCY/vhFJ3vHY7e++htyTCD/EvIu1z76JXVmkmIQi/
         xf3U2qmxzaOX2YbZEILJQUHd70ZbqrRHG5zwMkPvR+dVqPbpCKQtFZHRESYjDlMvcDbo
         y+etXAYo23Uzlz9SmS4mRL0b2j1nz5pm5B3kIdhqdgjKlqGQrdQk3HBm//ylgz5ZX1D9
         bKkKAJvvrhjJjfgP2gkM6cmRTeNnGvj0eqK7Hq5hYk1yTOM8c1gGHa9bdYH0EHAEhs9a
         bnvzdbSgJItoq3O3/B0o6YC+3uU7QrEaW6vn0iGLwFHTaOjoJMVkLqSyST8EaW49Hep1
         G3GA==
X-Gm-Message-State: AAQBX9d72iuGwb2K4Aaj8eVAfI014ZErx6Yy5q6xtcHcWnOf0Q/olyqf
        JwDc2nWX9Txs2kfY+QYx+Mp2o7o4n41WEOoKe9G/7E4w1jB1/PPwRHn4S5bF
X-Google-Smtp-Source: AKy350aeaZ2CJVvWQpcxgwdGAqNrly5yV9TP3kXXP6KkQTCr5DrJaU71wjDo9NRyuP/HOv9oCIUM8gn6fSjoB4XL8sw=
X-Received: by 2002:a17:90a:9295:b0:23c:fb7d:de70 with SMTP id
 n21-20020a17090a929500b0023cfb7dde70mr231886pjo.7.1679613456794; Thu, 23 Mar
 2023 16:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323204427.3594372-1-maskray@google.com>
In-Reply-To: <20230323204427.3594372-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Mar 2023 16:17:25 -0700
Message-ID: <CAKwvOd=W49oqB7qg5Cv+MUVfQYixmdQY4FRSsMPTyecE9w0EzQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: use -z pack-relative-relocs
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

Hi Fangrui,
Thanks for the patches!

On Thu, Mar 23, 2023 at 1:44=E2=80=AFPM Fangrui Song <maskray@google.com> w=
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
> change, replace --pack-dyn-relocs=3Drelr with -z pack-relative-relocs,
> which is supported since LLD 15.

Looks like
commit 4a8de2832a2a ("[ELF] Add -z pack-relative-relocs")

>
> As of today, GNU ld supports the latter option for x86 and powerpc64
> ports and has no intention to support --pack-dyn-relocs=3Drelr. In the
> absence of the glibc symbol version GLIBC_ABI_DT_RELR,
> --pack-dyn-relocs=3Drelr and -z pack-relative-relocs are identical in
> ld.lld.

Won't this regress support for CONFIG_TOOLS_SUPPORT_RELR for LLD
11-14? (which we still support, see Documentation/process/changes.rst;
I guess we don't list LLD explicitly, but it's effectively under the
llvm umbrella there).

IIUC, looks like lld 7.0+ should support SHT_RELR based on looking at
commit 11479daf2f06 ("lld: add experimental support for SHT_RELR sections."=
)

So we might want to invoke the linker twice, once with the new flag,
and again with the old if we fail the first time?

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Da61=
9b58721f0a03fd91c27670d3e4c2fb0d88f1e
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  Makefile                      | 2 +-
>  scripts/tools-support-relr.sh | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a2c310df2145..30c2edc35813 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1113,7 +1113,7 @@ LDFLAGS_vmlinux   +=3D -X
>  endif
>
>  ifeq ($(CONFIG_RELR),y)
> -LDFLAGS_vmlinux        +=3D --pack-dyn-relocs=3Drelr --use-android-relr-=
tags
> +LDFLAGS_vmlinux        +=3D -z pack-relative-relocs
>  endif
>
>  # We never want expected sections to be placed heuristically by the
> diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr.s=
h
> index cb55878bd5b8..58c2e8b02ce8 100755
> --- a/scripts/tools-support-relr.sh
> +++ b/scripts/tools-support-relr.sh
> @@ -7,8 +7,7 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
>  cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
>  void *p =3D &p;
>  END
> -$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr \
> -  --use-android-relr-tags -o $tmp_file
> +$LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o $tmp_file
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0386BBA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjCOQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjCOQxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:53:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A719193CF;
        Wed, 15 Mar 2023 09:52:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f18so25138695lfa.3;
        Wed, 15 Mar 2023 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678899175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A9HHWcHJilZYaElLvCLlKtriSwWxAD0z2lhiz3S5JS4=;
        b=Z5KS8MJBYwG8OuxVc1j0A3pSPn2Ic6qEaRx9EK6W+HKjxNWZzjEl6ZpKpdABtpndBi
         hEbDcMaoZlSdHCTZmFyIdww7LCwEcg5eqEaaBWS2gll/I6HaHiF3FQYc0TovnSwXvh7e
         SJIyup9731+gVTkipnEkgspqUAELuSV0AzhyRxOzxOuS7nBTJ5W2MlN5u08lhfjeep8J
         AVG957NoVmb05/nEDhENGQ6Z0O5Q1/5rWO0KVeKq7dv/l3+zWrq4AcI7wgPRHpk89Dyp
         2d9PhAekAkDpP4rHLy4FzqL7RM7o3LVyhFJhA5kZMMhMeFy9RldOxOz4hfLGXU7NOGrH
         ncJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9HHWcHJilZYaElLvCLlKtriSwWxAD0z2lhiz3S5JS4=;
        b=Zqh5OcqAeLuugAJCwIG/Nk0fo6FpEHbTCZV5rqTmBNogwzh1s4uHhMqmmhXc7XGnXb
         30Uznt62M2uWv1acTuuGad2iWku6rJvA7PTeTYDFYxP8TRCaeWVWsHY0Rqyq0+twolf4
         HjiC05uJbAa4pmNk6A+Z1Ii1KRokb62UjYsi1Pdg3B+CKLsPYA29nf3w+pLPlDUVDSUj
         vfiPSdT36bJdMISubQiZMPe0mkLOAjtLdcYy8bRlJRnMIP275xHI1EKXuEvIihz8ICtW
         5zOVVrsU9ptvqYyE9CqcNLD9ZSujW1W+UVlomk0N6cdD0UXWs3hg3IR1K8mpOCx0AS5X
         Vgpg==
X-Gm-Message-State: AO0yUKVyBlSO5aIq3rOhO0uFl4976zjfF8Flhht3YTeDjEtco5YUuY3A
        zBqSVmDIAJuKkdIIOFVqdwHvlPlOh6E6X5a+6UqEvN6AXcb1nQ==
X-Google-Smtp-Source: AK7set+zxQ8UFJ5v2od/PjOFf7Z3vLpjaGldFCybbfn+d6dFcfyCr2pXaVp+BCkJjy8VVD454ZuP7RDtwkG/hbXZiMI=
X-Received: by 2002:ac2:4c3c:0:b0:4dd:fd4e:5a21 with SMTP id
 u28-20020ac24c3c000000b004ddfd4e5a21mr2198532lfq.11.1678899174955; Wed, 15
 Mar 2023 09:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230315162944.39542-1-bage@linutronix.de> <20230315162944.39542-2-bage@linutronix.de>
In-Reply-To: <20230315162944.39542-2-bage@linutronix.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Mar 2023 17:52:18 +0100
Message-ID: <CA+icZUULJVVtsdaHkPGdy=8ezU=7BiOCrfosGeRiY9dOEaf-nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
To:     Bastian Germann <bage@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 5:38=E2=80=AFPM Bastian Germann <bage@linutronix.de=
> wrote:
>
> With dpkg-buildpackage v1.21.10 or later, the only way to build the
> deb-pkg generated package parallely is adding -j<N> to the MAKEFLAGS
> environment variable or using the --jobs-force option. The package ignore=
s
> the usual parallel build option that is described in Debian Policy =C2=A7=
4.9.1.
>
> Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variabl=
e
> that ends up being set by dpkg-buildpackage -j<N>.
>
> Link: https://www.debian.org/doc/debian-policy/ch-source.html

Thanks for the patch v2 and clarifications.

Substitute above link? Or add as a 2nd link?

Link: https://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules=
-options

-Sedat-

> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---
>  scripts/package/mkdebian | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index f74380036bb5..0217790e7a26 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -238,11 +238,15 @@ fi
>  cat <<EOF > debian/rules
>  #!$(command -v $MAKE) -f
>
> +ifneq (,\$(filter parallel=3D%,\$(DEB_BUILD_OPTIONS)))
> +       JOBS =3D -j\$(subst parallel=3D,,\$(filter parallel=3D%,\$(DEB_BU=
ILD_OPTIONS)))
> +endif
> +
>  srctree ?=3D .
>
>  build-indep:
>  build-arch:
> -       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \
> +       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \$(JOBS) \
>         \$(shell \$(srctree)/scripts/package/deb-build-option) \
>         olddefconfig all
>
> @@ -250,10 +254,10 @@ build: build-arch
>
>  binary-indep:
>  binary-arch: build-arch
> -       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} intdeb-pkg
> +       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \$(JOBS) intdeb-p=
kg
>  clean:
>         rm -rf debian/files debian/linux-*
> -       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} clean
> +       \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \$(JOBS) clean
>
>  binary: binary-arch
>  EOF
> --
> 2.39.2
>

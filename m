Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C46BBA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjCOQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCOQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4009176F76;
        Wed, 15 Mar 2023 09:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92AE2B81E55;
        Wed, 15 Mar 2023 16:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391F6C4339C;
        Wed, 15 Mar 2023 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678899133;
        bh=lAk6q9BPmfU5faABtNcJsbeZfWrztSY2pScV2iGveJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UB0srgvPYO6aeU+N0xk3vAQP0+ep6URTFB9wDudAGvVuSxbz0K2Q8pgzfONJzx9Dp
         s5mqWYgOI/P5Rkpneu6gtQqMoWPNVkBHb0e2u+B9IKjBs80LgEYd2LFCfhz5TGwjrZ
         TlMiaHZunmQvw4NTEf4hXyiRJJD/Qq5r2DCLkw6YxFixwLfe8VtKaEfynElGXtSc9Q
         z39g7VuTvETlpfTw04O3ngftKV3jRhmjRKeEbEWXmLY/f5fjGLj+Rce12btAzOuKo3
         zXUXPpp5KLsS0Mcm9QSCEKNuwaB6DXBSid7GcGDB3mwk+zcEB9NxiMrtOEj1uOAHLe
         nInCAiW/CEoOw==
Received: by mail-oi1-f170.google.com with SMTP id bh20so14628607oib.9;
        Wed, 15 Mar 2023 09:52:12 -0700 (PDT)
X-Gm-Message-State: AO0yUKXNxZm/fDTgFyGpyDmXrh9WZ9JzM6wTssDK4AcJJ16MqJkOd1Ce
        gcKRzfKa2owG0Ge6FcONDnR/Mt6y2vKb2ilKss8=
X-Google-Smtp-Source: AK7set+3X1QLdLSyQeOPPaxKEucdsGmRuXbnPVmFT9ptmDIZOyO/5ZC2igD2tyql7/ArA7GoN5zE7aRY7ytNCEPNrcI=
X-Received: by 2002:aca:1308:0:b0:383:eebf:19bc with SMTP id
 e8-20020aca1308000000b00383eebf19bcmr1003048oii.11.1678899131490; Wed, 15 Mar
 2023 09:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230315162944.39542-1-bage@linutronix.de> <20230315162944.39542-2-bage@linutronix.de>
In-Reply-To: <20230315162944.39542-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Mar 2023 01:51:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbSW+W=XazFXiHqObTm8EUk8T6jHDQoj1PBJdgH6x5LA@mail.gmail.com>
Message-ID: <CAK7LNATbSW+W=XazFXiHqObTm8EUk8T6jHDQoj1PBJdgH6x5LA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 1:29=E2=80=AFAM Bastian Germann <bage@linutronix.de=
> wrote:
>
> With dpkg-buildpackage v1.21.10 or later, the only way to build the


Please include the commit hash.

I guess

Commit 1d0ea9b2ba3f ("dpkg-buildpackage: Change -j, --jobs semantics
to non-force mode")

is the one.


> deb-pkg generated package parallely is adding -j<N> to the MAKEFLAGS
> environment variable or using the --jobs-force option. The package ignore=
s
> the usual parallel build option that is described in Debian Policy =C2=A7=
4.9.1.

If a new section is inserted before, the section number '4.9.1'
may not be true in the future.

I think you can drop the section number
if you add the Link: tag close to the relevant section.


>
> Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variabl=
e
> that ends up being set by dpkg-buildpackage -j<N>.
>
> Link: https://www.debian.org/doc/debian-policy/ch-source.html



Link: https://www.debian.org/doc/debian-policy/ch-source.html#debian-rules-=
and-deb-build-options

  might be better - it points to the relevant section.





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

I prefer appending it to MAKEFLAGS instead of touching every target.
(or is there any reason why MAKEFLAGS does not work here?)

The reference code exists in the link you mentioned.

ifneq (,$(filter parallel=3D%,$(DEB_BUILD_OPTIONS)))
    NUMJOBS =3D $(patsubst parallel=3D%,%,$(filter parallel=3D%,$(DEB_BUILD=
_OPTIONS)))
    MAKEFLAGS +=3D -j$(NUMJOBS)
endif



--=20
Best Regards
Masahiro Yamada

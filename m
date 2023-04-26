Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B36EF612
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbjDZOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbjDZON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C158D6EAB;
        Wed, 26 Apr 2023 07:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E16E63671;
        Wed, 26 Apr 2023 14:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8019C4339C;
        Wed, 26 Apr 2023 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518437;
        bh=AwNbPU1+foXyQkeSpNgmI/G5BPNTipnzyi7nm5HU0Uw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=suWEIPqHrf+YDkdgFML92wIIYXWs5+wnCLC2sa4hcl0f549UtZIXomlunViGsIM4Y
         GdbWxJBgiU7fylI2kt6S9t35gO+0GhSHbr3VO2TCRrFhmlVftuQn2refNkv6Cl4ttm
         CpJJuMWbxTAuibS06f4raeYmQhcjMohnhy783klwI3pHt+LvTP4cKKNoFRn4bnu83g
         1A+l2NWJx+SLDuhiXag01DYJxzoYK/1WGb/iOuno7CPTKWQuqPilm1+q54EwoL+EGz
         YiZcN6s64hzOx+8Y04BJ/jw8mbVtud3sqv6YOUztea4RWRfzbpgiOtg3MfCVjhFtgm
         nAy7m1wsNYysw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38c35975545so5000486b6e.1;
        Wed, 26 Apr 2023 07:13:57 -0700 (PDT)
X-Gm-Message-State: AAQBX9ctMAZLeW7BgfhzXCnu3ZhX5eK66i1cFTqoTt2uakmft8DKjrC+
        pwj+f6cvpC3/EmQapqfkd6Jnkmv5Zsmeau79JOM=
X-Google-Smtp-Source: AKy350aBbJP8LL0jjzmY9Gr9F/FYu7NW2B8grBfzrLNiso5MzvwOI8UMy16A+zC5Dm4NlCzzc74aHDZrODSBOZSJH+w=
X-Received: by 2002:a05:6808:190d:b0:389:8d22:5ef4 with SMTP id
 bf13-20020a056808190d00b003898d225ef4mr11831040oib.11.1682518437048; Wed, 26
 Apr 2023 07:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230413203857.2629-1-rdunlap@infradead.org>
In-Reply-To: <20230413203857.2629-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 26 Apr 2023 23:13:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATX8kEnxrOr1HvaNhwZsZaGhvRdaX37F3goxbs3mpZrDQ@mail.gmail.com>
Message-ID: <CAK7LNATX8kEnxrOr1HvaNhwZsZaGhvRdaX37F3goxbs3mpZrDQ@mail.gmail.com>
Subject: Re: [PATCH v3] sparc: unify sparc32/sparc64 archhelp
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 5:39=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Currently, entering
> $ make ARCH=3Dsparc32 help
> prints the archhelp text for sparc64.
> ["sparc32" is documented (Documentation/kbuild/kbuild.rst)
> to be a recognized alias for 32-bit sparc.]
>
> Instead of handling ARCH=3Dsparc or ARCH=3Dsparc32 or ARCH=3Dsparc64,
> just unify all SPARC archhelp text in one place.
>
> Fixes: 5e53879008b9 ("sparc,sparc64: unify Makefile")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>


Applied to linux-kbuild.
Thank you.



> ---
> v2: rebase/resend; add Masahiro to Cc: list
> v3: merge (unify) 32/64-bit help text (Masahiro);
>     remove Sam's Ack since the patch has changed;
>
>  arch/sparc/Makefile |   15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff -- a/arch/sparc/Makefile b/arch/sparc/Makefile
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -83,18 +83,11 @@ vdso_install:
>  KBUILD_IMAGE :=3D $(boot)/zImage
>
>  # Don't use tabs in echo arguments.
> -ifeq ($(ARCH),sparc)
>  define archhelp
> -  echo  '* image        - kernel image ($(boot)/image)'
> -  echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
> +  echo  '  vmlinux      - standard SPARC kernel'
> +  echo  '  image        - kernel image ($(boot)/image)'
> +  echo  '* zImage       - stripped/compressed kernel image ($(boot)/zIma=
ge)'
>    echo  '  uImage       - U-Boot SPARC32 Image (only for LEON)'
> +  echo  '  vmlinux.aout - a.out kernel for SPARC64'
>    echo  '  tftpboot.img - image prepared for tftp'
>  endef
> -else
> -define archhelp
> -  echo  '* vmlinux      - standard sparc64 kernel'
> -  echo  '* zImage       - stripped and compressed sparc64 kernel ($(boot=
)/zImage)'
> -  echo  '  vmlinux.aout - a.out kernel for sparc64'
> -  echo  '  tftpboot.img - image prepared for tftp'
> -endef
> -endif



--=20
Best Regards
Masahiro Yamada

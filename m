Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112386B977F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCNOPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCNOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A493E25;
        Tue, 14 Mar 2023 07:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA1C6179C;
        Tue, 14 Mar 2023 14:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20722C433A0;
        Tue, 14 Mar 2023 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678803289;
        bh=lbt3u3WhPf0RUtdapFsOcCTtMZ6GZznOdU71nY6UTW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n1BP22Zcxfdv1kWsK2cC15r52JjqvMGpLQYfMCA+Vnj/p0fvAt+/LyzJJ541e7oJT
         RPZXK3izufw/PphinjQZuuCf+A9HXZOKCOVfpu/L+OKUnj3boSCCcNtGiPbaGjHANA
         FmSo3F4paBaeISzALjIfOQIA1Bf1SA+F9C7IurVDMc2ax3VEndpqfDoHCRra1Dep45
         Plsa4HRwrpd6vxhr61KAYdDw2linApRqBIKyhS5w+ElmT2hlm1WUWxK7Z+W5r2dm1e
         8I1G1kt95rsORNpjdVqxpGF+4qfQm1XrSqhaxlOeMuFPewBroif5Kc8fWM/xOE0khY
         25sSCDzK0lLow==
Received: by mail-ot1-f44.google.com with SMTP id b26-20020a9d755a000000b006972b28ae37so1053428otl.4;
        Tue, 14 Mar 2023 07:14:49 -0700 (PDT)
X-Gm-Message-State: AO0yUKWo9udTjqWb9E1tp7D2VOOS0Pp87mAfNJRykeP4h2I3g+BDdxp3
        dfwuRUPicXW8MaCekTh4lKiL2aXoML1JcL+W8Mo=
X-Google-Smtp-Source: AK7set9Ri+WI7GkE0FhiL0GJu3IcjaCzAeOQQn5JizhdOOkXiMwwGgaSvbxFge+uI1u+PT1o4fvd8V3vVBLHNM+/91I=
X-Received: by 2002:a05:6830:308a:b0:68d:48be:fa9c with SMTP id
 g10-20020a056830308a00b0068d48befa9cmr12796587ots.1.1678803288297; Tue, 14
 Mar 2023 07:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230314130248.954196-1-nvidia@cohens.org.il> <20230314130248.954196-2-nvidia@cohens.org.il>
In-Reply-To: <20230314130248.954196-2-nvidia@cohens.org.il>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Mar 2023 23:14:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpaH6dp5sX5Kq3eyxbkHyXCqFmT+oxd66i3ZJyOOpNQA@mail.gmail.com>
Message-ID: <CAK7LNAQpaH6dp5sX5Kq3eyxbkHyXCqFmT+oxd66i3ZJyOOpNQA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Make kernelrelease target work with M=
To:     nvidia@cohens.org.il
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:04=E2=80=AFPM <nvidia@cohens.org.il> wrote:
>
> From: Tzafrir Cohen <nvidia@cohens.org.il>
>
> Fixes: commit 1cb86b6c3136 ("kbuild: save overridden KERNELRELEASE in inc=
lude/config/kernel.release")
>
> That commit required the use of filechk_kernel.release for the
> kernelrelease Makefile target. It is currently only being set when
> KBUILD_EXTMOD is not set. Make sure it is set in that case as well.
>
> Signed-off-by: Tzafrir Cohen <nvidia@cohens.org.il>


Applied to linux-kbuild/fixes. Thanks.

> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 3e7f96f12f08..e0859c608147 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1880,6 +1880,8 @@ endif
>
>  else # KBUILD_EXTMOD
>
> +filechk_kernel.release =3D echo $(KERNELRELEASE)
> +
>  ###
>  # External module support.
>  # When building external modules the kernel used as basis is considered
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

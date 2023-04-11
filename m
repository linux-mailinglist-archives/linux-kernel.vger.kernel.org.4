Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B06DCE82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDKAe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDKAeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAD13A;
        Mon, 10 Apr 2023 17:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF6661F84;
        Tue, 11 Apr 2023 00:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94350C4339C;
        Tue, 11 Apr 2023 00:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681173261;
        bh=efI7CcBrOnAi7UitzE3jJIbPMYCE2T5N7BlnBnKd4Qs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ig3r+FIah4z9ucZdnt3LsAPbEVK0kMw+FZrUb2atv7b6FDNxstSYikyC9cJ1vfts9
         eQZFXDR8rVfKPok6rm+Xi0HXq64eB7B0QY1ZcrtuPHebmj8R00P6ezp0o9PqDz64kd
         IVlQJAwPZ7x3PGajarn9EDvbsLzby4Ws4RgsCkmQJ2BmUT+4VeyAxJwidwwtmmq/im
         8iI9UNg/dJcsvdZna0HHOsSZ1+G3JKjd1IH3rR/WhAVSEFVg1BbQmrbxJ5mpAsA5dJ
         k/XMl7fFJ+Zc5Klhxpr1RdHBHoOUY7WgNIeFxhLRZU14crDDtm6sa5fpKTCed5TVZ4
         C5qSZ57Y1T1tA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1842e278605so7954683fac.6;
        Mon, 10 Apr 2023 17:34:21 -0700 (PDT)
X-Gm-Message-State: AAQBX9ebU1TdagZA1LM01RVlE0Fd6Q91k/8aeGd2M+ZxyDn+dUGOFTO6
        OwgysllvTGRuHX/WBtIRFwy7ufbS2TLzvrU4/uw=
X-Google-Smtp-Source: AKy350bB56rSS3PUwMDKdzwJ7lVHGcelQUNcRVDzFaRycHVwThDweamlnw0msl9/7GJdu7dmUhERNxGbGv2CtSS7zEc=
X-Received: by 2002:a05:6870:e989:b0:17e:d308:7790 with SMTP id
 r9-20020a056870e98900b0017ed3087790mr5641366oao.11.1681173260778; Mon, 10 Apr
 2023 17:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230407101629.1298051-1-masahiroy@kernel.org> <20230407101629.1298051-3-masahiroy@kernel.org>
In-Reply-To: <20230407101629.1298051-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Apr 2023 09:33:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDqKWtNqPQX=G1JkVJTMsf+OqacgktOMePhTuqr9jtwA@mail.gmail.com>
Message-ID: <CAK7LNARDqKWtNqPQX=G1JkVJTMsf+OqacgktOMePhTuqr9jtwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar packages
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 7:16=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Commit 05e96e96a315 ("kbuild: use git-archive for source package
> creation") split the compression as a separate step to factor out
> the common build rules.
>
> With the previous commit, we got back to the situation where
> compressed source tarballs are created by a single rule.
> There is no reason to keep the separate compression rules.
>
> Generate the comressed tar packages directly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.package | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 7707975f729b..e0e18d7dfbd5 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -2,7 +2,6 @@
>  # Makefile for the different targets used to generate full packages of a=
 kernel
>
>  include $(srctree)/scripts/Kbuild.include
> -include $(srctree)/scripts/Makefile.lib

I noticed a bug.

I will keep this include directive.
Otherwise, perf-tar*-src-pkg targets would be broken.
'cmd_copy' is still used.






--=20
Best Regards
Masahiro Yamada

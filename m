Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A434707691
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQXsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEQXsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:48:31 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502D171F;
        Wed, 17 May 2023 16:48:30 -0700 (PDT)
References: <20230517232801.never.262-kees@kernel.org>
User-agent: mu4e 1.10.3; emacs 29.0.91
From:   Sam James <sam@gentoo.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Enable -fstrict-flex-arrays=3
Date:   Thu, 18 May 2023 00:47:41 +0100
In-reply-to: <20230517232801.never.262-kees@kernel.org>
Message-ID: <87lehmh647.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kees Cook <keescook@chromium.org> writes:

> The -fstrict-flex-arrays=3D3 option is now available with the release
> of GCC 13[1] and Clang 16[2]. This feature instructs the compiler to
> treat only C99 flexible arrays as dynamically sized for the purposes of
> object size calculations. In other words, the ancient practice of using
> 1-element arrays, or the GNU extension of using 0-sized arrays, as a
> dynamically sized array is disabled. This allows CONFIG_UBSAN_BOUNDS,
> CONFIG_FORTIFY_SOURCE, and other object-size aware features to behave
> unambiguously in the face of trailing arrays: only C99 flexible arrays
> are considered to be dynamically sized.
>
> Enabling this will help track down any outstanding cases of fake
> flexible arrays that need attention in kernel code.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html#index-fstri=
ct-flex-arrays
> [2] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-=
clang-fstrict-flex-arrays
>

Maybe link to https://people.kernel.org/kees/bounded-flexible-arrays-in-c a=
s well=20
just in case some confused soul ends up bisecting to this but doesn't
get the problem?

Not really required though, just a thought I had.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZGVnyF8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZDK4AEApJnGbkeqGv6dUB+L0B6SKPs1r1h3twjjsZlP
fSeldgMBAJqlsA6ESA4dbZk8TYjnZQOjh+HbtcQKAHobi/7n9ncC
=mLXG
-----END PGP SIGNATURE-----
--=-=-=--

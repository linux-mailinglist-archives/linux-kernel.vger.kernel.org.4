Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1146C2E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCUKTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAD30EB;
        Tue, 21 Mar 2023 03:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EBB9B81289;
        Tue, 21 Mar 2023 10:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A752C433EF;
        Tue, 21 Mar 2023 10:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679393949;
        bh=ylUikKVJLYdsPwLhAvebI4h/tf0/4eSJTX9CsjDm2uA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UNNxtW9m3iWj5aBS0ipwh3/cX/EGD0ZBEnZ18GCsae50MNmUIYuu1pdLSr20fWYQC
         9xANYPZ1ktA/2rcabKP/xdXSCqUzn1GjQU5yY9chjZTxJ0FsNHQwM9IqUVcOcXxurq
         h6Q0TW6FoAJjuKBYndW0CpOiFVKYjRA09f4Lnrcqj3PNpmSHC1mI+aoWU4NUB9oxEp
         ZKCyj7XPufKHMReFDfR6x/XVCX0DA+HtzfPOkvNIGh4KqdpUzO3poL/aG2siDj3M+G
         0NOV7Pj3VkmEK85Dv+Cx7x6ctnOoG8fBV19gZ8hfAq3qK76wBuVh6SC1uj7sSHsOmm
         VcBHNPvRZBpLw==
Received: by mail-oi1-f177.google.com with SMTP id bf30so4147846oib.12;
        Tue, 21 Mar 2023 03:19:08 -0700 (PDT)
X-Gm-Message-State: AO0yUKVa3iNStphIO4jW2wI74XZBUyGF2eBuKSlx7pOuCh+Lh5O4Fbro
        mPudB4HgNzzf3GSMJLtvFPOzlgc+cdyR0BDK98U=
X-Google-Smtp-Source: AK7set8jQNEQFZco3MS6fmFK0tvF/qE01Vu3ai85YFMtPnkAK2FbSxjH3DeQu21ZWEJ5ZAGA2J3AYIqwR9IwoYzBGdk=
X-Received: by 2002:a54:4617:0:b0:383:c3d5:6c9f with SMTP id
 p23-20020a544617000000b00383c3d56c9fmr454815oip.11.1679393948251; Tue, 21 Mar
 2023 03:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230315173524.63179-1-bage@linutronix.de> <20230315173524.63179-2-bage@linutronix.de>
In-Reply-To: <20230315173524.63179-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Mar 2023 19:18:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASckF_6QLHkvLEk3b8nE23v4Qy4wmm4FHd5BrDo6U2x2g@mail.gmail.com>
Message-ID: <CAK7LNASckF_6QLHkvLEk3b8nE23v4Qy4wmm4FHd5BrDo6U2x2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 16, 2023 at 2:35=E2=80=AFAM Bastian Germann <bage@linutronix.de=
> wrote:
>
> With dpkg-buildpackage v1.21.10 or later, the only way to build the
> deb-pkg generated package parallely is adding -j<N> to the MAKEFLAGS
> environment variable or using the --jobs-force option, see dpkg commit
> 1d0ea9b2ba3f ("dpkg-buildpackage: Change -j, --jobs semantics to
> non-force mode"). The package ignores the usual parallel build option
> that is described in Debian Policy.
>
> Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variabl=
e
> that ends up being set by dpkg-buildpackage -j<N>. The snippet is copied
> from Debian Policy.
>
> Link: https://www.debian.org/doc/debian-policy/ch-source.html#debian-rule=
s-and-deb-build-options
> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---


I was about to pick this up, then I stopped it.



If I apply this patch,

"make -j2 bindeb-pkg" shows a new warning.

make[3]: warning: -j16 forced in makefile: resetting jobserver mode.




Please note `nproc` returns 16 on my machine.


"make bindeb-pkg" also runs in 16 threads because
$(DEB_BUILD_OPTIONS) always contains "parallel=3D16"
even if -j<N> option is given at all.

In other words, this patch will take away user's freedom
to choose the number of threads.









>  scripts/package/mkdebian | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index f74380036bb5..ed5c2b65798b 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -238,6 +238,11 @@ fi
>  cat <<EOF > debian/rules
>  #!$(command -v $MAKE) -f
>
> +ifneq (,\$(filter parallel=3D%,\$(DEB_BUILD_OPTIONS)))
> +       NUMJOBS =3D \$(patsubst parallel=3D%,%,\$(filter parallel=3D%,\$(=
DEB_BUILD_OPTIONS)))
> +       MAKEFLAGS +=3D -j\$(NUMJOBS)
> +endif
> +
>  srctree ?=3D .
>
>  build-indep:
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

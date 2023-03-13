Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537D26B7FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCMSAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCMSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:00:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EF746C6;
        Mon, 13 Mar 2023 11:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C94BB811C1;
        Mon, 13 Mar 2023 18:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5D2C433D2;
        Mon, 13 Mar 2023 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678730410;
        bh=wdmGj1RtXq9m1HFo5MiQc/9fneqd1MmfVbNzWS11LvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cJSHQ5RRZBGqAhQq6NRYSlJRtQ16EOQ3rYaCS3yVEgH/7or85fmOSBZPx0nES4jEL
         AspgbxYMUuwXOwUpp19nXKCG25nDen04woPjVKa2KBcqL49W8J27oEz2T7iStsp529
         PsfZ8SW//jvVCbvnuTcPYqYErowwRKS0Jmm+0REos0GoN9bMJqAz/Pd199t5B73Hzc
         KjF1lMkPcwKs/1nB9KpNzPArjhYQescS+/Dlt4c7k3bDJ++2sFKWruVP056CVPPr4p
         S5DyD7029eFDOIvzUGLN1Zi5Haw1Nr6tzH/2oCvAZg1BuUZKb6JJl9vdEtzVsmU8kE
         8SFnakW2p+70A==
Received: by mail-oi1-f177.google.com with SMTP id s41so10011444oiw.13;
        Mon, 13 Mar 2023 11:00:10 -0700 (PDT)
X-Gm-Message-State: AO0yUKX+ljwmI11ZW/uQepQ7njiiiee3Q9NYJdZNxr1dEggsQOw7euxu
        7WQQYyu0cZIIMlwigkqUGJ8ZiKldT/cZGW7jvh4=
X-Google-Smtp-Source: AK7set+KBDtcj8yhw30C6vs1ZhqhKEEsa4YAtqiyGpSgJ5Zr9kmKhUQ+9eaZCFC1Y+ArRdkV6XDp6gKLZxpjL2bOYIs=
X-Received: by 2002:a05:6808:8cb:b0:384:33df:4dfc with SMTP id
 k11-20020a05680808cb00b0038433df4dfcmr12045953oij.11.1678730410205; Mon, 13
 Mar 2023 11:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230313171036.268407-1-bage@linutronix.de> <20230313171036.268407-2-bage@linutronix.de>
In-Reply-To: <20230313171036.268407-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Mar 2023 02:59:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
Message-ID: <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
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

On Tue, Mar 14, 2023 at 2:10=E2=80=AFAM Bastian Germann <bage@linutronix.de=
> wrote:
>
> Currently, the only way to build the deb-pkg generated package parallely
> is adding -jN to the MAKEFLAGS environment variable. The package ignores
> the usual parallel build option that is described in Debian Policy =C2=A7=
4.9.1.



"dpkg-buildpackage -b -j16" worked for me.







> Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variabl=
e
> that ends up being set by Debian's build tools.
>
> Link: https://www.debian.org/doc/debian-policy/ch-source.html
> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---
>  scripts/package/deb-build-option | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build=
-option
> index b079b0d121d4..dd170e2b3018 100755
> --- a/scripts/package/deb-build-option
> +++ b/scripts/package/deb-build-option
> @@ -7,6 +7,12 @@ if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_H=
OST_ARCH}" !=3D "${DEB_BUI
>         echo CROSS_COMPILE=3D${DEB_HOST_GNU_TYPE}-
>  fi
>
> +for build_opt in $DEB_BUILD_OPTIONS; do
> +       if [ "${build_opt#parallel=3D}" !=3D "$build_opt" ]; then
> +               echo -j${build_opt#parallel=3D}
> +       fi
> +done
> +
>  version=3D$(dpkg-parsechangelog -S Version)
>  version_upstream=3D"${version%-*}"
>  debian_revision=3D"${version#${version_upstream}}"
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

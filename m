Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8506FF991
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjEKSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjEKSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3637C40E0;
        Thu, 11 May 2023 11:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB1960DBF;
        Thu, 11 May 2023 18:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22092C4339B;
        Thu, 11 May 2023 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683831147;
        bh=jEXwF+0RlkbCYQKQZTZb+wHdb2EimuH8kjGlzRTWiqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BhheZ8GGX95ss0MBGeRAM2iHQIpKuBlxn4/65pyeTqQVRif5/l8aUb33IBAx+eeb1
         ksSeWkeBWqM8CL/waUyR+fBbzKqvs6afHF4g0rSAf/yV/olFpvzWEDebTXWDfYdD8o
         aTXGq90eyzg0l0U7rXeoBiDy7MwIoTe5g7XpaRvcIIegVm1NwVKpl/eYR4ewXGW8+k
         23Sz7SkhQZwTA99jRgDjNfcagdTvG9K0NP1jwLhdIY4Um7Ir8alF2m0W+qa7dSU9t2
         eaJKyE8VMgLsdK7BeZm7qmKkWJDatN0QH5YY3wgz6gQrtYfTTf1gYbr+Fn8zorfdqh
         q6VoHM/9myVUg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-38e3228d120so4550322b6e.3;
        Thu, 11 May 2023 11:52:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDyzEToMQkhfbcd473LY/RKkucxgybp5caAMLWWG28v154uSKrgc
        KGzAZ3YUQebHcP8GZROccR2T/cgJiPUIVSBfCbI=
X-Google-Smtp-Source: ACHHUZ4AlErlG0mANcR6HeOEX5m0MC4g1noIPko/YWj70R1V3reWEhd4d8yTtXcOovWDK3EwQvkD2uezuro4wiyqXAQ=
X-Received: by 2002:a05:6808:3ab:b0:394:4870:5722 with SMTP id
 n11-20020a05680803ab00b0039448705722mr2056191oie.53.1683831146340; Thu, 11
 May 2023 11:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230504201833.202494-1-darwi@linutronix.de> <20230509012616.81579-1-darwi@linutronix.de>
 <20230509012616.81579-2-darwi@linutronix.de>
In-Reply-To: <20230509012616.81579-2-darwi@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 12 May 2023 03:51:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARO6HOutPf2VZJMTR2Xmepj_3UiUgH-SLXhH57CNnGfOg@mail.gmail.com>
Message-ID: <CAK7LNARO6HOutPf2VZJMTR2Xmepj_3UiUgH-SLXhH57CNnGfOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scripts/tags.sh: Resolve gtags empty index generation
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 10:26=E2=80=AFAM Ahmed S. Darwish <darwi@linutronix.=
de> wrote:
>
> gtags considers any file outside of its current working directory
> "outside the source tree" and refuses to index it. For O=3D kernel builds=
,
> or when "make" is invoked from a directory other then the kernel source
> tree, gtags ignores the entire kernel source and generates an empty
> index.
>
> Force-set gtags current working directory to the kernel source tree.
>
> Due to commit 9da0763bdd82 ("kbuild: Use relative path when building in
> a subdir of the source tree"), if the kernel build is done in a
> sub-directory of the kernel source tree, the kernel Makefile will set
> the kernel's $srctree to ".." for shorter compile-time and run-time
> warnings. Consequently, the list of files to be indexed will be in the
> "../*" form, rendering all such paths invalid once gtags switches to the
> kernel source tree as its current working directory.
>
> If gtags indexing is requested and the build directory is not the kernel
> source tree, index all files in absolute-path form.
>
> Note, indexing in absolute-path form will not affect the generated
> index, as paths in gtags indices are always relative to the gtags "root
> directory" (as evidenced by "gtags --dump").

The code works as claimed, but I am just curious.
If all the paths are relative, how can you use the tags files located
in a separate directory?

"make O=3Dfoo gtags" creates tags files in foo/.
I want to use them from emacs.
emacs cannot find the right file because
it assumes the path is relative to 'foo' instead of the source tree.

I set GTAGSROOT to the source tree, but I could not find a way
to use it in a useful way.



> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index ea31640b2671..3de4b4ebd891 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -32,6 +32,14 @@ else
>         tree=3D${srctree}/
>  fi
>
> +

Unneeded empty line addition.


> +# gtags(1) refuses to index any file outside of its current working dir.
> +# If gtags indexing is requested and the build output directory is not
> +# the kernel source tree, index all files in absolute-path form.
> +if [ "$1" =3D "gtags" -a -n "${tree}" ]; then
> +       tree=3D$(realpath $tree)/


I decided to run shellcheck for new code.
Please follow the suggestion from the tool.


In scripts/tags.sh line 40:
tree=3D$(realpath $tree)/
                        ^---^ SC2086 (info): Double quote to prevent
globbing and word splitting.

Did you mean:
tree=3D$(realpath "$tree")/



(You do not need to fix the entire script.
This is only for new code).



> @@ -131,7 +139,11 @@ docscope()
>
>  dogtags()
>  {
> -       all_target_sources | gtags -i -f -
> +       local gtagsoutdir=3D"${PWD}"
> +       local gtagsroot=3D"${tree}"
> +
> +       [ -z "${gtagsroot}" ] && gtagsroot=3D"."
> +       all_target_sources | gtags -i -C $gtagsroot -f - $gtagsoutdir
>  }


You can write it in one line.


dogtags()
{
    all_target_sources | gtags -i -C "${tree:-.}" -f - "${PWD}"
}





--
Best Regards
Masahiro Yamada

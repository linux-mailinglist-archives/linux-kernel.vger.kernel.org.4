Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FE6A2ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 09:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBZIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 03:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 03:01:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8746586;
        Sun, 26 Feb 2023 00:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C640B80B6B;
        Sun, 26 Feb 2023 08:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400FEC4339C;
        Sun, 26 Feb 2023 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677398497;
        bh=T3YiMZrZv9x7rYN7KtRQhi1giiiXR4qVRoYZFZz0pg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+e0RFHmBKCWVSjLVm7irhRk6+jQhncgRg9pXmwKkCrhzHhIXU6+UA+q9pLO/8xgQ
         oTYPjnzKtjbd++yUtslxRKNWVcJNAvcoIQT5cMmcZjh1F0liPqIF6Jcim4BCssEF3a
         SsVA55452UrRW1oBGgepdNd3pa4/nkwpI6p55bXuxPn+HrQFvinTj5OJUS3TU+AtTJ
         nNVNqeYsGphnKPYtXg5/SmrtYAmFv0tqYn5ru8fUUI0r2VIo1cclh/0s38i0iTBbho
         kSs8wpkJPdg7g2Njskuz7Rki6ZylYU7GhmAVmj1kkpi199oi4q+RucdUcuEGYazo3u
         ilakLI1krr0Vw==
Received: by mail-oi1-f178.google.com with SMTP id e21so2986665oie.1;
        Sun, 26 Feb 2023 00:01:37 -0800 (PST)
X-Gm-Message-State: AO0yUKWuPJKKrNUvF9f7AZ5JSsdWa70OB7Tqumrz4dvoPSQSAVTV+tpW
        U0XzAcORZBNJGAAHLA5YQLOQrmoRBJvvzfsTsyg=
X-Google-Smtp-Source: AK7set/X44EtzNoIKakWEDFH3LEQb8kjMbPcJzV7cMQiW84e+HxCwrC+NakeFj3ZXypTxiP5Z1auH0yI4/A9aeErYTE=
X-Received: by 2002:a05:6808:4d7:b0:384:893:a91d with SMTP id
 a23-20020a05680804d700b003840893a91dmr1521265oie.8.1677398496386; Sun, 26 Feb
 2023 00:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20230215012034.403356-1-masahiroy@kernel.org>
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Feb 2023 17:01:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzsVCMsR-43erVnZ_xdDZoZHOMRnxXpKPxBvaaP4e-aA@mail.gmail.com>
Message-ID: <CAK7LNATzsVCMsR-43erVnZ_xdDZoZHOMRnxXpKPxBvaaP4e-aA@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] kbuild: add a tool to list files ignored by git
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
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

On Wed, Feb 15, 2023 at 10:21=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> In short, the motivation of this commit is to build a source package
> without cleaning the source tree.
>
> The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
> creating a source tarball. Otherwise build artifacts such as *.o,
> *.a, etc. would be included in the tarball. Yet, the tarball ends up
> containing several garbage files since 'make clean' does not clean
> everything.
>
> Cleaning the tree every time is annoying since it makes the incremental
> build impossible. It is desirable to create a source tarball without
> cleaning the tree.
>
> In fact, there are some ways to achieve this.
>
> The easiest solution is 'git archive'. 'make perf-tar*-src-pkg' uses
> it, but I do not like it because it works only when the source tree is
> managed by git, and all files you want in the tarball must be committed
> in advance.
>
> I want to make it work without relying on git. We can do this.
>
> Files that are ignored by git are generated files, so should be excluded
> from the source tarball. We can list them out by parsing the .gitignore
> files. Of course, .gitignore does not cover all the cases, but it works
> well enough.
>
> tar(1) claims to support it:
>
>   --exclude-vcs-ignores
>
>     Exclude files that match patterns read from VCS-specific ignore files=
.
>     Supported files are: .cvsignore, .gitignore, .bzrignore, and .hgignor=
e.
>
> The best scenario would be to use 'tar --exclude-vcs-ignores', but this
> option does not work. --exclude-vcs-ignore does not understand any of
> the negation (!), preceding slash, following slash, etc.. So, this option
> is just useless.
>
> Hence, I wrote this gitignore parser. The previous version [1], written
> in Python, was so slow. This version is implemented in C, so it works
> much faster.
>
> I imported the code from git (commit: 23c56f7bd5f1), so we get the same
> result.
>
> This tool traverses the source tree, parsing all .gitignore files, and
> prints file paths that are ignored by git.
>
> The output is similar to 'git ls-files --ignored --directory --others
> --exclude-per-directory=3D.gitignore', except
>
>   [1] Not sorted
>   [2] No trailing slash for directories
>
> [2] is intentional because tar's --exclude-from option cannot handle
> trailing slashes.
>
> [How to test this tool]
>
>   $ git clean -dfx
>   $ make -s -j$(nproc) defconfig all                       # or allmodcon=
ifg or whatever
>   $ git archive -o ../linux1.tar --prefix=3D./ HEAD
>   $ tar tf ../linux1.tar | LANG=3DC sort > ../file-list1     # files emit=
ted by 'git archive'
>   $ make scripts_package
>     HOSTCC  scripts/list-gitignored
>   $ scripts/list-gitignored  --prefix=3D./ -o ../exclude-list
>   $ tar cf ../linux2.tar --exclude-from=3D../exclude-list .
>   $ tar tf ../linux2.tar | LANG=3DC sort > ../file-list2     # files emit=
ted by 'tar'
>   $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
>   < ./Documentation/devicetree/bindings/.yamllint
>   < ./drivers/clk/.kunitconfig
>   < ./drivers/gpu/drm/tests/.kunitconfig
>   < ./drivers/hid/.kunitconfig
>   < ./fs/ext4/.kunitconfig
>   < ./fs/fat/.kunitconfig
>   < ./kernel/kcsan/.kunitconfig
>   < ./lib/kunit/.kunitconfig
>   < ./mm/kfence/.kunitconfig
>   < ./tools/testing/selftests/arm64/tags/
>   < ./tools/testing/selftests/arm64/tags/.gitignore
>   < ./tools/testing/selftests/arm64/tags/Makefile
>   < ./tools/testing/selftests/arm64/tags/run_tags_test.sh
>   < ./tools/testing/selftests/arm64/tags/tags_test.c
>   < ./tools/testing/selftests/kvm/.gitignore
>   < ./tools/testing/selftests/kvm/Makefile
>   < ./tools/testing/selftests/kvm/config
>   < ./tools/testing/selftests/kvm/settings
>
> The source tarball contains most of files that are tracked by git. You
> see some diffs, but it is just because some .gitignore files are wrong.
>
>   $ git ls-files -i -c --exclude-per-directory=3D.gitignore
>   Documentation/devicetree/bindings/.yamllint
>   drivers/clk/.kunitconfig
>   drivers/gpu/drm/tests/.kunitconfig
>   drivers/hid/.kunitconfig
>   fs/ext4/.kunitconfig
>   fs/fat/.kunitconfig
>   kernel/kcsan/.kunitconfig
>   lib/kunit/.kunitconfig
>   mm/kfence/.kunitconfig
>   tools/testing/selftests/arm64/tags/.gitignore
>   tools/testing/selftests/arm64/tags/Makefile
>   tools/testing/selftests/arm64/tags/run_tags_test.sh
>   tools/testing/selftests/arm64/tags/tags_test.c
>   tools/testing/selftests/kvm/.gitignore
>   tools/testing/selftests/kvm/Makefile
>   tools/testing/selftests/kvm/config
>   tools/testing/selftests/kvm/settings
>
> [1]: https://lore.kernel.org/all/20230128173843.765212-1-masahiroy@kernel=
.org/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


01 - 11 applied to linux-kbuild.


I will update 12/12 (postponed to v6.4)



--=20
Best Regards
Masahiro Yamada

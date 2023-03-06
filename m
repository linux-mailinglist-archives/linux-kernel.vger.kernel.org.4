Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDA6AC380
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCFOjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCFOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:39:11 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22D5598;
        Mon,  6 Mar 2023 06:38:39 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon,  6 Mar 2023 15:27:07 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 3543B80C44;
        Mon,  6 Mar 2023 15:27:07 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 2AB841818DC; Mon,  6 Mar 2023 15:27:07 +0100 (CET)
Date:   Mon, 6 Mar 2023 15:27:07 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 01/12] kbuild: add a tool to list files ignored by git
Message-ID: <ZAX4O2zg8mUulh4R@buildd.core.avm.de>
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <CAK7LNATzsVCMsR-43erVnZ_xdDZoZHOMRnxXpKPxBvaaP4e-aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATzsVCMsR-43erVnZ_xdDZoZHOMRnxXpKPxBvaaP4e-aA@mail.gmail.com>
X-purgate-ID: 149429::1678112827-65D4279A-B10ECDC1/0/0
X-purgate-type: clean
X-purgate-size: 5488
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 05:01:00PM +0900, Masahiro Yamada wrote:
> On Wed, Feb 15, 2023 at 10:21 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > In short, the motivation of this commit is to build a source package
> > without cleaning the source tree.
> >
> > The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
> > creating a source tarball. Otherwise build artifacts such as *.o,
> > *.a, etc. would be included in the tarball. Yet, the tarball ends up
> > containing several garbage files since 'make clean' does not clean
> > everything.
> >
> > Cleaning the tree every time is annoying since it makes the incremental
> > build impossible. It is desirable to create a source tarball without
> > cleaning the tree.
> >
> > In fact, there are some ways to achieve this.
> >
> > The easiest solution is 'git archive'. 'make perf-tar*-src-pkg' uses
> > it, but I do not like it because it works only when the source tree is
> > managed by git, and all files you want in the tarball must be committed
> > in advance.
> >
> > I want to make it work without relying on git. We can do this.
> >
> > Files that are ignored by git are generated files, so should be excluded
> > from the source tarball. We can list them out by parsing the .gitignore
> > files. Of course, .gitignore does not cover all the cases, but it works
> > well enough.
> >
> > tar(1) claims to support it:
> >
> >   --exclude-vcs-ignores
> >
> >     Exclude files that match patterns read from VCS-specific ignore files.
> >     Supported files are: .cvsignore, .gitignore, .bzrignore, and .hgignore.
> >
> > The best scenario would be to use 'tar --exclude-vcs-ignores', but this
> > option does not work. --exclude-vcs-ignore does not understand any of
> > the negation (!), preceding slash, following slash, etc.. So, this option
> > is just useless.
> >
> > Hence, I wrote this gitignore parser. The previous version [1], written
> > in Python, was so slow. This version is implemented in C, so it works
> > much faster.
> >
> > I imported the code from git (commit: 23c56f7bd5f1), so we get the same
> > result.
> >
> > This tool traverses the source tree, parsing all .gitignore files, and
> > prints file paths that are ignored by git.
> >
> > The output is similar to 'git ls-files --ignored --directory --others
> > --exclude-per-directory=.gitignore', except
> >
> >   [1] Not sorted
> >   [2] No trailing slash for directories
> >
> > [2] is intentional because tar's --exclude-from option cannot handle
> > trailing slashes.
> >
> > [How to test this tool]
> >
> >   $ git clean -dfx
> >   $ make -s -j$(nproc) defconfig all                       # or allmodconifg or whatever
> >   $ git archive -o ../linux1.tar --prefix=./ HEAD
> >   $ tar tf ../linux1.tar | LANG=C sort > ../file-list1     # files emitted by 'git archive'
> >   $ make scripts_package
> >     HOSTCC  scripts/list-gitignored
> >   $ scripts/list-gitignored  --prefix=./ -o ../exclude-list
> >   $ tar cf ../linux2.tar --exclude-from=../exclude-list .
> >   $ tar tf ../linux2.tar | LANG=C sort > ../file-list2     # files emitted by 'tar'
> >   $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
> >   < ./Documentation/devicetree/bindings/.yamllint
> >   < ./drivers/clk/.kunitconfig
> >   < ./drivers/gpu/drm/tests/.kunitconfig
> >   < ./drivers/hid/.kunitconfig
> >   < ./fs/ext4/.kunitconfig
> >   < ./fs/fat/.kunitconfig
> >   < ./kernel/kcsan/.kunitconfig
> >   < ./lib/kunit/.kunitconfig
> >   < ./mm/kfence/.kunitconfig
> >   < ./tools/testing/selftests/arm64/tags/
> >   < ./tools/testing/selftests/arm64/tags/.gitignore
> >   < ./tools/testing/selftests/arm64/tags/Makefile
> >   < ./tools/testing/selftests/arm64/tags/run_tags_test.sh
> >   < ./tools/testing/selftests/arm64/tags/tags_test.c
> >   < ./tools/testing/selftests/kvm/.gitignore
> >   < ./tools/testing/selftests/kvm/Makefile
> >   < ./tools/testing/selftests/kvm/config
> >   < ./tools/testing/selftests/kvm/settings
> >
> > The source tarball contains most of files that are tracked by git. You
> > see some diffs, but it is just because some .gitignore files are wrong.
> >
> >   $ git ls-files -i -c --exclude-per-directory=.gitignore
> >   Documentation/devicetree/bindings/.yamllint
> >   drivers/clk/.kunitconfig
> >   drivers/gpu/drm/tests/.kunitconfig
> >   drivers/hid/.kunitconfig
> >   fs/ext4/.kunitconfig
> >   fs/fat/.kunitconfig
> >   kernel/kcsan/.kunitconfig
> >   lib/kunit/.kunitconfig
> >   mm/kfence/.kunitconfig
> >   tools/testing/selftests/arm64/tags/.gitignore
> >   tools/testing/selftests/arm64/tags/Makefile
> >   tools/testing/selftests/arm64/tags/run_tags_test.sh
> >   tools/testing/selftests/arm64/tags/tags_test.c
> >   tools/testing/selftests/kvm/.gitignore
> >   tools/testing/selftests/kvm/Makefile
> >   tools/testing/selftests/kvm/config
> >   tools/testing/selftests/kvm/settings
> >
> > [1]: https://lore.kernel.org/all/20230128173843.765212-1-masahiroy@kernel.org/
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> 
> 
> 01 - 11 applied to linux-kbuild.
> 
> 
> I will update 12/12 (postponed to v6.4)

Might you want to re-consider to include this patch already in v6.3?
Bastian seems to be unhappy with the current state of v6.3:
https://lore.kernel.org/linux-kbuild/20230305232536.19528-1-bage@linutronix.de/T/#t

Kind regards,
Nicolas

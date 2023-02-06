Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B398F68B47E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBFDaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:30:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5A14214;
        Sun,  5 Feb 2023 19:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26F760B4F;
        Mon,  6 Feb 2023 03:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295E0C433A0;
        Mon,  6 Feb 2023 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675654220;
        bh=+fOw21fTjnDA60xFME0GUTaPBCaHO4hWfC3dn2VSDOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qKPyrDbnzhISbS8zZgYIOdbHOUS6vpB0z7gRMvUJeLK+l9m1oTfJMNTdGVsuYKu1B
         iu8TQuA4+NiLrSbNzgIy6BqhJJgE+IEFxInI+e17FPFGujh2EIpg7ENWrNyc0c8ZpT
         j5dLacEHWno1knVbtKSliIq8NAEQJDql7LTLEEZVqfPFpUVcudSWSOuHZm0Dq4a9HE
         OaEoLVsSuF6uU5grHg7I+7ExOzjGfKTNx22Q3I5sfKX5b5zubhe34UH27sKMZgFu3K
         RwsY372Z8FPG55BJzo7LYuktJkUcL5RKEYwA/og8SufpBJ/xmRfp2c5NKP+NvoRw+a
         V4YX5UTwJZX5A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-16346330067so13732586fac.3;
        Sun, 05 Feb 2023 19:30:20 -0800 (PST)
X-Gm-Message-State: AO0yUKVPv6OdrzRWxc/sILm8WAeLx3Wk68zfeN7ypN9JOqG+Njb9xsXY
        W0/BQvDu2dOfl6X6UBhKmD04/FJwtZtzC4mHaSs=
X-Google-Smtp-Source: AK7set+SaoxjXH4Hya7V++kkEJamM+VMv9aSA8M85QfaVLzP2p7EQDw+rzkoxd/2Xy2d7+AGMlFJ89fziF2v3gXBdLM=
X-Received: by 2002:a05:6871:151:b0:163:a45a:9e41 with SMTP id
 z17-20020a056871015100b00163a45a9e41mr1097918oab.194.1675654218903; Sun, 05
 Feb 2023 19:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20230202033716.341858-1-masahiroy@kernel.org> <20230202033716.341858-2-masahiroy@kernel.org>
 <Y9uYPOza9m9aOJMV@fjasle.eu>
In-Reply-To: <Y9uYPOza9m9aOJMV@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Feb 2023 12:29:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS83jU0vrQ1JgjuR_TaTXDODRTTGi=NrKbw-HpnaX3kVA@mail.gmail.com>
Message-ID: <CAK7LNAS83jU0vrQ1JgjuR_TaTXDODRTTGi=NrKbw-HpnaX3kVA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] kbuild: add a tool to generate a list of files
 ignored by git
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 8:08 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu, Feb 02, 2023 at 12:37:11PM +0900 Masahiro Yamada wrote:
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
> > In fact, there are some ways to archive this.
> >
> > The easiest way is 'git archive'. Actually, 'make perf-tar*-src-pkg'
> > does this way, but I do not like it because it works only when the source
> > tree is managed by git, and all files you want in the tarball must be
> > committed in advance.
> >
> > I want to make it work without relying on git. We can do this.
> >
> > Files that are not tracked by git are generated files. We can list them
> > out by parsing the .gitignore files. Of course, .gitignore does not cover
> > all the cases, but it works well enough.
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
> > This tool traverses the source tree, parsing the .gitignore files. It
> > prints the file paths that are not tracked by git. The output can be
> > used for tar's --exclude-from= option.
> >
> > [How to test this tool]
> >
> >   $ git clean -dfx
> >   $ make -s -j$(nproc) defconfig all                       # or allmodconifg or whatever
> >   $ git archive -o ../linux1.tar --prefix=./ HEAD
> >   $ tar tf ../linux1.tar | LANG=C sort > ../file-list1     # files emitted by 'git archive'
> >   $ make scripts_exclude
> >     HOSTCC  scripts/gen-exclude
> >   $ scripts/gen-exclude --prefix=./ -o ../exclude-list
> >   $ tar cf ../linux2.tar --exclude-from=../exclude-list .
> >   $ tar tf ../linux2.tar | LANG=C sort > ../file-list2     # files emitted by 'tar'
> >   $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
> >   < ./Documentation/devicetree/bindings/.yamllint
> >   < ./drivers/clk/.kunitconfig
> >   < ./drivers/gpu/drm/tests/.kunitconfig
> >   < ./drivers/gpu/drm/vc4/tests/.kunitconfig
> >   < ./drivers/hid/.kunitconfig
> >   < ./fs/ext4/.kunitconfig
> >   < ./fs/fat/.kunitconfig
> >   < ./kernel/kcsan/.kunitconfig
> >   < ./lib/kunit/.kunitconfig
> >   < ./mm/kfence/.kunitconfig
> >   < ./net/sunrpc/.kunitconfig
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
> >
> > (no changes since v3)
> >
> > Changes in v3:
> >  - Various code refactoring: remove struct gitignore, remove next: label etc.
> >  - Support --extra-pattern option
> >
> > Changes in v2:
> >  - Reimplement in C
> >
> >  Makefile              |   4 +
> >  scripts/.gitignore    |   1 +
> >  scripts/Makefile      |   2 +-
> >  scripts/gen-exclude.c | 623 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 629 insertions(+), 1 deletion(-)
> >  create mode 100644 scripts/gen-exclude.c
> >
> > diff --git a/Makefile b/Makefile
> > index 2faf872b6808..35b294cc6f32 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1652,6 +1652,10 @@ distclean: mrproper
> >  %pkg: include/config/kernel.release FORCE
> >       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.package $@
> >
> > +PHONY += scripts_exclude
> > +scripts_exclude: scripts_basic
> > +     $(Q)$(MAKE) $(build)=scripts scripts/gen-exclude
> > +
> >  # Brief documentation of the typical targets used
> >  # ---------------------------------------------------------------------------
> >
> > diff --git a/scripts/.gitignore b/scripts/.gitignore
> > index 6e9ce6720a05..7f433bc1461c 100644
> > --- a/scripts/.gitignore
> > +++ b/scripts/.gitignore
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  /asn1_compiler
> > +/gen-exclude
> >  /generate_rust_target
> >  /insert-sys-cert
> >  /kallsyms
> > diff --git a/scripts/Makefile b/scripts/Makefile
> > index 32b6ba722728..5dcd7f57607f 100644
> > --- a/scripts/Makefile
> > +++ b/scripts/Makefile
> > @@ -38,7 +38,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
> >  endif
> >
> >  # The following programs are only built on demand
> > -hostprogs += unifdef
> > +hostprogs += gen-exclude unifdef
> >
> >  # The module linker script is preprocessed on demand
> >  targets += module.lds
> > diff --git a/scripts/gen-exclude.c b/scripts/gen-exclude.c
> > new file mode 100644
> > index 000000000000..5c4ecd902290
> > --- /dev/null
> > +++ b/scripts/gen-exclude.c
> > @@ -0,0 +1,623 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Traverse the source tree, parsing all .gitignore files, and print file paths
> > +// that are not tracked by git.
> > +// The output is suitable to the --exclude-from option of tar.
> > +// This is useful until the --exclude-vcs-ignores option gets working correctly.
> > +//
> > +// Copyright (C) 2023 Masahiro Yamada <masahiroy@kernel.org>
> > +
> > +#include <dirent.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <fnmatch.h>
> > +#include <getopt.h>
> > +#include <stdarg.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +
> > +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > +
> > +// struct pattern - represent an ignore pattern (a line in .gitignroe)
> > +// @negate:          negate the pattern (prefixing '!')
> > +// @dir_only:        only matches directories (trailing '/')
> > +// @path_match:      true if the glob pattern is a path instead of a file name
> > +// @double_asterisk: true if the glob pattern contains double asterisks ('**')
> > +// @glob:            glob pattern
> > +struct pattern {
> > +     bool negate;
> > +     bool dir_only;
> > +     bool path_match;
> > +     bool double_asterisk;
> > +     char glob[];
> > +};
> > +
> > +struct pattern **patterns;
>
> Is there a reason, why patterns is not static?  (sparse asked)


No reason - I just forgot to run sparse.
Thanks for catching it.






> > +     q = modified_pattern;
> > +     for (p = pattern; *p; p++) {
> > +             if (!strncmp(p, "**/", 3)) {
> > +                     // "**/" means zero of more sequences of '*/".
> > +                     // "foo**/bar" matches "foobar", "foo*/bar",
> > +                     // "foo*/*/bar", etc.
> > +                     while (slash_diff-- > 0) {
> > +                             *q++ = '*';
> > +                             *q++ = '/';
> > +                     }
> > +
> > +                     if (slash_diff == 0) {
> > +                             *q++ = '*';
> > +                             *q++ = '/';
> > +                     }
> > +
> > +                     if (slash_diff < 0)
> > +                             slash_diff++;
> > +
> > +                     p += 2;
> > +             } else if (!strcmp(p, "/**")) {
> > +                     // A trailing "/**" matches everything inside.
>
> In v2 you also checked against "(*p + 3) == '\0'".  Is the explicit check
> against end-of-string really not needed here?  (pattern = "whatever/**/*.tmp"?)


This detects a trailing "/**".


See this documentation:
https://github.com/git/git/blob/v2.39.1/Documentation/gitignore.txt#L123



"whatever/**/*.tmp" is detected by the previous
     if (!strncmp(p, "**/", 3))


strcmp(p, "/**") only matches the pattern at the end,
while strncmp(p, "**/", 3) matches the pattern anywhere.


Anyway, I will throw away this code in v5.






> > +}
> > +
> > +// Return the length of the initial segment of the string that does not contain
> > +// the unquoted sequence of the given character. Similar to strcspn() in libc.
>
> I struggled across that comment and it took me quite some time to match it to
> strcspn_trailers() behaviour.  I expect it to strip all unescaped occurrences
> of c at the end of str and return the resulting strlen.  After reading it
> several times, I can get a match.  I _think_ main confusion came from my (quite
> imperfect) English:
>
>   "one two  "
>    ^^^         initial segment of string not containing unquoted c ??
>
>    ^^^^^^^     substr that is considered by strcspn_trailer
>
> But this is just about a comment and I'm sure I understand what is intended.
> No action required.


I am not good at English.

Indeed, this comment is really confusing.

Something like the following would have been clearer.

// This function strips the unescaped sequence of the given char from the end
// of the string, and returns the length of the resulting substring.





>
> > +static size_t strcspn_trailer(const char *str, char c)
> > +{
> > +     bool quoted = false;
> > +     size_t len = strlen(str);
> > +     size_t spn = len;
> > +     const char *s;
> > +
> > +     for (s = str; *s; s++) {
> > +             if (!quoted && *s == c) {
> > +                     if (s - str < spn)
> > +                             spn = s - str;
> > +             } else {
> > +                     spn = len;
>
> Is this really intended?  Or 'spn = str - s + 1'?


I think you meant, 'spn = s - str + 1'

My code works, but I think yours is cleaner
because it does not require 'len'.




BTW, I read the source code of GIT.

GIT's implementation is here:
https://github.com/git/git/blob/v2.39.1/dir.c#L934






>
> > +
> > +                     if (!quoted && *s == '\\')
> > +                             quoted = true;
> > +                     else
> > +                             quoted = false;
> > +             }
> > +     }
> > +
> > +     return spn;
> > +}
> > +
> > +// Add an gitignore pattern.
> > +static void add_pattern(char *s, const char *dirpath)
> > +{
> > +     bool negate = false;
> > +     bool dir_only = false;
> > +     bool path_match = false;
> > +     bool double_asterisk = false;
> > +     char *e = s + strlen(s);
> > +     struct pattern *p;
> > +     size_t len;
> > +
> > +     // Skip comments
> > +     if (*s == '#')
> > +             return;
> > +
> > +     // Trailing spaces are ignored unless they are quoted with backslash.
> > +     e = s + strcspn_trailer(s, ' ');
> > +     *e = '\0';
> > +
> > +     // The prefix '!' negates the pattern
> > +     if (*s == '!') {
> > +             s++;
> > +             negate = true;
> > +     }
> > +
> > +     // If there is slash(es) that is not escaped at the end of the pattern,
> > +     // it matches only directories.
>
> Are escaped slashes allowed in file names in git?  I think use of original
> strcspn() would have been enough.


Perhaps, I had some reason to implement it like this, but
I cannot recall it.



Anyway, GIT's implementation is very simple:

https://github.com/git/git/blob/v2.39.1/dir.c#L634

I will follow that.





>
> > +
> > +     if (path_match) {
> > +             strcat(p->glob, dirpath);
> > +             strcat(p->glob, "/");
> > +     }
> > +
> > +     strcat(p->glob, s);
> > +
> > +     debug("Add pattern: %s%s%s\n", negate ? "!" : "", p->glob,
> > +           dir_only ? "/" : "");
> > +
> > +     if (nr_patterns >= alloced_patterns) {
> > +             alloced_patterns += 128;
> > +             patterns = xrealloc(patterns,
> > +                                 sizeof(*patterns) * alloced_patterns);
> > +     }
> > +
> > +     patterns[nr_patterns++] = p;
> > +}
> > +
> > +static void *load_gitignore(const char *dirpath)
> > +{
> > +     struct stat st;
> > +     char path[PATH_MAX], *buf;
> > +     int fd, ret;
> > +
> > +     ret = snprintf(path, sizeof(path), "%s/.gitignore", dirpath);
> > +     if (ret >= sizeof(path))
> > +             error_exit("%s: too long path was truncated\n", path);
> > +
> > +     // If .gitignore does not exist in this directory, open() fails.
> > +     // It is ok, just skip it.
> > +     fd = open(path, O_RDONLY);
> > +     if (fd < 0)
> > +             return NULL;
>
> Why don't you check against errno == 2 (ENOENT)?  I assume, no other
> errno value is expected, but for me it feels a bit odd to not check it
> and exit loudly if something (unlikely) like EMFILE causes open() to
> fail.


Good suggestion.

I will fix it.

GIT also checks this:

https://github.com/git/git/blob/v2.39.1/wrapper.c#L399


>
> > +
> > +     if (fstat(fd, &st) < 0)
> > +             perror_exit(path);
> > +
> > +     buf = xmalloc(st.st_size + 1);
> > +     if (read(fd, buf, st.st_size) != st.st_size)
> > +             perror_exit(path);
> > +
> > +     buf[st.st_size] = '\0';
> > +     if (close(fd))
> > +             perror_exit(path);
> > +
> > +     return buf;
> > +}
> > +
> > +// Parse '.gitignore' in the given directory.
> > +static void parse_gitignore(const char *dirpath)
> > +{
> > +     char *buf, *s, *next;
> > +
> > +     buf = load_gitignore(dirpath);
> > +     if (!buf)
> > +             return;
> > +
> > +     debug("Parse %s/.gitignore\n", dirpath);
> > +
> > +     for (s = buf; *s; s = next) {
> > +             next = s;
> > +
> > +             while (*next != '\0' && *next != '\n')
>
> Not relevant for in-tree use: git does not complain about '\0' in a .gitignore
> but also handles the remaining part of the file.
>


You are right.

I confirmed it from the source code:
https://github.com/git/git/blob/v2.39.1/dir.c#L1141


I will follow that.





>
> Testing with some strange patterns seems to reveal some missing points.  It
> should not be problematic, as nobody wants to write such .gitignore patterns,
> but for completeness:
>
>   $ mkdir -p test/foo/bar
>   $ touch test/foo/bar/baz.tmp
>   $ cat <<-eof >test/.gitignore
>   **/*.tmp
>   **/baz.tmp
>   foo/**/*.tmp
>   **/bar/baz.tmp
>   /**/*.tmp
>   eof
>   $ cd test
>   $ ../scripts/gen-exclude --debug
>   [DEBUG]Add pattern: .git/
>   [DEBUG]Enter[0]: .
>   [DEBUG]  ./test: no match
>   [DEBUG]  Enter[1]: ./test
>   [DEBUG]    Parse ./test/.gitignore
>   [DEBUG]    Add pattern: ./test/**/*.tmp
>   [DEBUG]    Add pattern: ./test/**/baz.tmp
>   [DEBUG]    Add pattern: ./test/foo/**/*.tmp
>   [DEBUG]    Add pattern: ./test/**/bar/baz.tmp
>   [DEBUG]    Add pattern: ./test/**/*.tmp
>   [DEBUG]    ./test/.gitignore: no match
>   [DEBUG]    ./test/foo: no match
>   [DEBUG]    Enter[2]: ./test/foo
>   [DEBUG]      ./test/foo/bar: no match
>   [DEBUG]      Enter[3]: ./test/foo/bar
>   [DEBUG]        ./test/foo/bar/baz.tmp: no match
>   [DEBUG]      Leave[3]: ./test/foo/bar
>   [DEBUG]    Leave[2]: ./test/foo
>   [DEBUG]  Leave[1]: ./test
>   [DEBUG]Leave[0]: .
>
> Thus, no match.  Everything else I tested, did what I expected.


You are right.

test/foo/bar/baz.tmp must be ignored.


I read the code because I was curious how GIT does this.

GIT has its own fnmatch() that supports double asterisks too.
https://github.com/git/git/blob/v2.39.1/wildmatch.c#L55


I cannot write such clever code, so I will
import the matching code in v5.


V5 is almost ready for submission.
The code grew up to 1000 lines, but I can live with that.



In my local test, v5 worked correctly.


[DEBUG] Add pattern: .git/
[DEBUG] Enter[0]: .
[DEBUG]   ./test: no match
[DEBUG]   Enter[1]: ./test
[DEBUG]     Parse ./test/.gitignore
[DEBUG]     Add pattern: **/*.tmp
[DEBUG]     Add pattern: **/baz.tmp
[DEBUG]     Add pattern: foo/**/*.tmp
[DEBUG]     Add pattern: **/bar/baz.tmp
[DEBUG]     Add pattern: /**/*.tmp
[DEBUG]     ./test/foo: no match
[DEBUG]     Enter[2]: ./test/foo
[DEBUG]       ./test/foo/bar: no match
[DEBUG]       Enter[3]: ./test/foo/bar
[DEBUG]         ./test/foo/bar/baz.tmp: matches /**/*.tmp (./test/.gitignore)
[DEBUG]         Ignore: ./test/foo/bar/baz.tmp
test/foo/bar/baz.tmp
[DEBUG]         Ignore: ./test/foo/bar (due to all files inside ignored)
test/foo/bar
[DEBUG]       Leave[3]: ./test/foo/bar
[DEBUG]       Ignore: ./test/foo (due to all files inside ignored)
test/foo
[DEBUG]     Leave[2]: ./test/foo
[DEBUG]     ./test/.gitignore: no match
[DEBUG]   Leave[1]: ./test
[DEBUG] Leave[0]: .







>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Tested-by: Nicolas Schier <nicolas@fjasle.eu>


Thanks for your close review, as always.



>
> Kind regards,
> Nicolas

--
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6A68742C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBBDuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBDut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:50:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB97CC84;
        Wed,  1 Feb 2023 19:50:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB0BBCE2736;
        Thu,  2 Feb 2023 03:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28973C4339C;
        Thu,  2 Feb 2023 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675309837;
        bh=vOOE6qEdOXVAdndCW+Z8sC+3s9YRz1AKZV2oyGAzdhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=loNRucmwZioR9POexrXv8C+XpquM399L62LZN+L5iAjVmP6UjLSxeMFBGvPBeJoUZ
         O7f5GNSYyx2vORvxf+WmQMNm3W86id2W46rWbGAWckdKAqemfP95bY5QXBvn2zgPBH
         onW1nlciCPh+daFg/A7mM0rp22MKwTdfXO532/+16xHKRoRK3WmKm+ebNbv6Bi7aHo
         vK3aDxBR4ZiROa6IS8JkWRCsckcn655jsSjY714Nt9H9XqS3Ll+lrQuLGQmzuMuiu3
         j94J3g0Z/CCMqvrkefykfzneDyjf9EOcPh4NqxCzuplGKY0eVFs27rz5aO1smjruyO
         KZdJgmMsh+yfg==
Received: by mail-oi1-f180.google.com with SMTP id j21so449574oie.4;
        Wed, 01 Feb 2023 19:50:37 -0800 (PST)
X-Gm-Message-State: AO0yUKX61tUlKsT2H0c7h/DdUC6/8dACPgcdp29rgsDQf5ky3EsRKsrC
        8PQg+clH7EgnlUW1He8GnnslyzZ3T57uCWwg5Ks=
X-Google-Smtp-Source: AK7set/wZXzVLQIQ8ECkVfmWqp0A8gtcqO6gbuIt2FK4k5zdoA0M2iATnSWd864Pez33EbJSLUyQJc23FygPBhk8CyQ=
X-Received: by 2002:aca:6c6:0:b0:35e:7c55:b015 with SMTP id
 189-20020aca06c6000000b0035e7c55b015mr71134oig.287.1675309836142; Wed, 01 Feb
 2023 19:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20230202033716.341858-1-masahiroy@kernel.org> <20230202033716.341858-2-masahiroy@kernel.org>
In-Reply-To: <20230202033716.341858-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Feb 2023 12:49:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBEEQYNyDKJC+D7hmkbX1GwOUtzTZZZ8A4QkgVJPoKDQ@mail.gmail.com>
Message-ID: <CAK7LNASBEEQYNyDKJC+D7hmkbX1GwOUtzTZZZ8A4QkgVJPoKDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] kbuild: add a tool to generate a list of files
 ignored by git
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
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

On Thu, Feb 2, 2023 at 12:38 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
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
> In fact, there are some ways to archive this.

"achieve this".



>
> The easiest way is 'git archive'. Actually, 'make perf-tar*-src-pkg'
> does this way, but I do not like it because it works only when the source
> tree is managed by git, and all files you want in the tarball must be
> committed in advance.
>
> I want to make it work without relying on git. We can do this.
>
> Files that are not tracked by git are generated files. We can list them
> out by parsing the .gitignore files. Of course, .gitignore does not cover
> all the cases, but it works well enough.
>
> tar(1) claims to support it:
>
>   --exclude-vcs-ignores
>
>     Exclude files that match patterns read from VCS-specific ignore files.
>     Supported files are: .cvsignore, .gitignore, .bzrignore, and .hgignore.
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
> This tool traverses the source tree, parsing the .gitignore files. It
> prints the file paths that are not tracked by git. The output can be
> used for tar's --exclude-from= option.
>
> [How to test this tool]
>
>   $ git clean -dfx
>   $ make -s -j$(nproc) defconfig all                       # or allmodconifg or whatever
>   $ git archive -o ../linux1.tar --prefix=./ HEAD
>   $ tar tf ../linux1.tar | LANG=C sort > ../file-list1     # files emitted by 'git archive'
>   $ make scripts_exclude
>     HOSTCC  scripts/gen-exclude
>   $ scripts/gen-exclude --prefix=./ -o ../exclude-list
>   $ tar cf ../linux2.tar --exclude-from=../exclude-list .
>   $ tar tf ../linux2.tar | LANG=C sort > ../file-list2     # files emitted by 'tar'
>   $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
>   < ./Documentation/devicetree/bindings/.yamllint
>   < ./drivers/clk/.kunitconfig
>   < ./drivers/gpu/drm/tests/.kunitconfig
>   < ./drivers/gpu/drm/vc4/tests/.kunitconfig
>   < ./drivers/hid/.kunitconfig
>   < ./fs/ext4/.kunitconfig
>   < ./fs/fat/.kunitconfig
>   < ./kernel/kcsan/.kunitconfig
>   < ./lib/kunit/.kunitconfig
>   < ./mm/kfence/.kunitconfig
>   < ./net/sunrpc/.kunitconfig
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
>   $ git ls-files -i -c --exclude-per-directory=.gitignore
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
> [1]: https://lore.kernel.org/all/20230128173843.765212-1-masahiroy@kernel.org/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
>  - Various code refactoring: remove struct gitignore, remove next: label etc.
>  - Support --extra-pattern option
>
> Changes in v2:
>  - Reimplement in C
>
>  Makefile              |   4 +
>  scripts/.gitignore    |   1 +
>  scripts/Makefile      |   2 +-
>  scripts/gen-exclude.c | 623 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 629 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/gen-exclude.c
>
> diff --git a/Makefile b/Makefile
> index 2faf872b6808..35b294cc6f32 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1652,6 +1652,10 @@ distclean: mrproper
>  %pkg: include/config/kernel.release FORCE
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.package $@
>
> +PHONY += scripts_exclude
> +scripts_exclude: scripts_basic
> +       $(Q)$(MAKE) $(build)=scripts scripts/gen-exclude
> +
>  # Brief documentation of the typical targets used
>  # ---------------------------------------------------------------------------
>
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 6e9ce6720a05..7f433bc1461c 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /asn1_compiler
> +/gen-exclude
>  /generate_rust_target
>  /insert-sys-cert
>  /kallsyms
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 32b6ba722728..5dcd7f57607f 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -38,7 +38,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
>  endif
>
>  # The following programs are only built on demand
> -hostprogs += unifdef
> +hostprogs += gen-exclude unifdef
>
>  # The module linker script is preprocessed on demand
>  targets += module.lds
> diff --git a/scripts/gen-exclude.c b/scripts/gen-exclude.c
> new file mode 100644
> index 000000000000..5c4ecd902290
> --- /dev/null
> +++ b/scripts/gen-exclude.c
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Traverse the source tree, parsing all .gitignore files, and print file paths
> +// that are not tracked by git.
> +// The output is suitable to the --exclude-from option of tar.
> +// This is useful until the --exclude-vcs-ignores option gets working correctly.
> +//
> +// Copyright (C) 2023 Masahiro Yamada <masahiroy@kernel.org>
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <fnmatch.h>
> +#include <getopt.h>
> +#include <stdarg.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +
> +// struct pattern - represent an ignore pattern (a line in .gitignroe)
> +// @negate:          negate the pattern (prefixing '!')
> +// @dir_only:        only matches directories (trailing '/')
> +// @path_match:      true if the glob pattern is a path instead of a file name
> +// @double_asterisk: true if the glob pattern contains double asterisks ('**')
> +// @glob:            glob pattern
> +struct pattern {
> +       bool negate;
> +       bool dir_only;
> +       bool path_match;
> +       bool double_asterisk;
> +       char glob[];
> +};
> +
> +struct pattern **patterns;
> +static int nr_patterns, alloced_patterns;
> +
> +// Remember the number of patterns at each directory level
> +static int *nr_patterns_at;
> +// Track the current/max directory level;
> +static int depth, max_depth;
> +static bool debug_on;
> +static FILE *out_fp;
> +static char *prefix = "";
> +static char *progname;
> +
> +static void __attribute__((noreturn)) perror_exit(const char *s)
> +{
> +       perror(s);
> +
> +       exit(EXIT_FAILURE);
> +}
> +
> +static void __attribute__((noreturn)) error_exit(const char *fmt, ...)
> +{
> +       va_list args;
> +
> +       fprintf(stderr, "%s: error: ", progname);
> +
> +       va_start(args, fmt);
> +       vfprintf(stderr, fmt, args);
> +       va_end(args);
> +
> +       exit(EXIT_FAILURE);
> +}
> +
> +static void debug(const char *fmt, ...)
> +{
> +       va_list args;
> +       int i;
> +
> +       if (!debug_on)
> +               return;
> +
> +       fprintf(stderr, "[DEBUG]");
> +
> +       for (i = 0; i < depth * 2; i++)
> +               fputc(' ', stderr);
> +
> +       va_start(args, fmt);
> +       vfprintf(stderr, fmt, args);
> +       va_end(args);
> +}
> +
> +static void *xrealloc(void *ptr, size_t size)
> +{
> +       ptr = realloc(ptr, size);
> +       if (!ptr)
> +               perror_exit(progname);
> +
> +       return ptr;
> +}
> +
> +static void *xmalloc(size_t size)
> +{
> +       return xrealloc(NULL, size);
> +}
> +
> +static char *xstrdup(const char *s)
> +{
> +       char *new = strdup(s);
> +
> +       if (!new)
> +               perror_exit(progname);
> +
> +       return new;
> +}
> +
> +static bool simple_match(const char *string, const char *pattern)
> +{
> +       return fnmatch(pattern, string, FNM_PATHNAME) == 0;
> +}
> +
> +// Handle double asterisks ("**") matching.
> +// FIXME:
> +//  This function does not work if double asterisks apppear multiple times,
> +//  like "foo/**/bar/**/baz".
> +static bool double_asterisk_match(const char *path, const char *pattern)
> +{
> +       bool result = false;
> +       int slash_diff = 0;
> +       char *modified_pattern, *q;
> +       const char *p;
> +       size_t len;
> +
> +       for (p = path; *p; p++)
> +               if (*p == '/')
> +                       slash_diff++;
> +
> +       for (p = pattern; *p; p++)
> +               if (*p == '/')
> +                       slash_diff--;
> +
> +       len = strlen(pattern) + 1;
> +
> +       if (slash_diff > 0)
> +               len += slash_diff * 2;
> +       modified_pattern = xmalloc(len);
> +
> +       q = modified_pattern;
> +       for (p = pattern; *p; p++) {
> +               if (!strncmp(p, "**/", 3)) {
> +                       // "**/" means zero of more sequences of '*/".
> +                       // "foo**/bar" matches "foobar", "foo*/bar",
> +                       // "foo*/*/bar", etc.
> +                       while (slash_diff-- > 0) {
> +                               *q++ = '*';
> +                               *q++ = '/';
> +                       }
> +
> +                       if (slash_diff == 0) {
> +                               *q++ = '*';
> +                               *q++ = '/';
> +                       }
> +
> +                       if (slash_diff < 0)
> +                               slash_diff++;
> +
> +                       p += 2;
> +               } else if (!strcmp(p, "/**")) {
> +                       // A trailing "/**" matches everything inside.
> +                       while (slash_diff-- >= 0) {
> +                               *q++ = '/';
> +                               *q++ = '*';
> +                       }
> +
> +                       p += 2;
> +               } else {
> +                       // Copy other patterns as-is.
> +                       // Other consecutive asterisks are considered regular
> +                       // asterisks. fnmatch() already handles them like that.
> +                       *q++ = *p;
> +               }
> +       }
> +
> +       *q = '\0';
> +
> +       result = simple_match(path, modified_pattern);
> +
> +       free(modified_pattern);
> +
> +       return result;
> +}
> +
> +// Return true if the given path is ignored by git.
> +static bool is_ignored(const char *path, const char *name, bool is_dir)
> +{
> +       int i;
> +
> +       // Search the patterns in the reverse order because the last matching
> +       // pattern wins.
> +       for (i = nr_patterns - 1; i >= 0; i--) {
> +               struct pattern *p = patterns[i];
> +
> +               if (!is_dir && p->dir_only)
> +                       continue;
> +
> +               if (!p->path_match) {
> +                       // If the pattern has no slash at the beginning or
> +                       // middle, it matches against the basename. Most cases
> +                       // fall into this and work well with double asterisks.
> +                       if (!simple_match(name, p->glob))
> +                               continue;
> +               } else if (!p->double_asterisk) {
> +                       // Unless the pattern has double asterisks, it is still
> +                       // simple but matches against the path instead.
> +                       if (!simple_match(path, p->glob))
> +                               continue;
> +               } else {
> +                       // Double asterisks with a slash. Complex, but rare.
> +                       if (!double_asterisk_match(path, p->glob))
> +                               continue;
> +               }
> +
> +               debug("%s: matches %s%s%s\n", path, p->negate ? "!" : "",
> +                     p->glob, p->dir_only ? "/" : "");
> +
> +               return !p->negate;
> +       }
> +
> +       debug("%s: no match\n", path);
> +
> +       return false;
> +}
> +
> +// Return the length of the initial segment of the string that does not contain
> +// the unquoted sequence of the given character. Similar to strcspn() in libc.
> +static size_t strcspn_trailer(const char *str, char c)
> +{
> +       bool quoted = false;
> +       size_t len = strlen(str);
> +       size_t spn = len;
> +       const char *s;
> +
> +       for (s = str; *s; s++) {
> +               if (!quoted && *s == c) {
> +                       if (s - str < spn)
> +                               spn = s - str;
> +               } else {
> +                       spn = len;
> +
> +                       if (!quoted && *s == '\\')
> +                               quoted = true;
> +                       else
> +                               quoted = false;
> +               }
> +       }
> +
> +       return spn;
> +}
> +
> +// Add an gitignore pattern.
> +static void add_pattern(char *s, const char *dirpath)
> +{
> +       bool negate = false;
> +       bool dir_only = false;
> +       bool path_match = false;
> +       bool double_asterisk = false;
> +       char *e = s + strlen(s);
> +       struct pattern *p;
> +       size_t len;
> +
> +       // Skip comments
> +       if (*s == '#')
> +               return;
> +
> +       // Trailing spaces are ignored unless they are quoted with backslash.
> +       e = s + strcspn_trailer(s, ' ');
> +       *e = '\0';
> +
> +       // The prefix '!' negates the pattern
> +       if (*s == '!') {
> +               s++;
> +               negate = true;
> +       }
> +
> +       // If there is slash(es) that is not escaped at the end of the pattern,
> +       // it matches only directories.
> +       len = strcspn_trailer(s, '/');
> +       if (s + len < e) {
> +               dir_only = true;
> +               e = s + len;
> +               *e = '\0';
> +       }
> +
> +       // Skip if the line gets empty
> +       if (*s == '\0')
> +               return;
> +
> +       // Double asterisk is tricky. Mark it to handle it specially later.
> +       if (strstr(s, "**/") || strstr(s, "/**"))
> +               double_asterisk = true;
> +
> +       // If there is a slash at the beginning or middle, the pattern
> +       // is relative to the directory level of the .gitignore.
> +       if (strchr(s, '/')) {
> +               if (*s == '/')
> +                       s++;
> +               path_match = true;
> +       }
> +
> +       len = e - s;
> +
> +       // We need more room to store dirpath and '/'
> +       if (path_match)
> +               len += strlen(dirpath) + 1;
> +
> +       p = xmalloc(sizeof(*p) + len + 1);
> +       p->negate = negate;
> +       p->dir_only = dir_only;
> +       p->path_match = path_match;
> +       p->double_asterisk = double_asterisk;
> +       p->glob[0] = '\0';
> +
> +       if (path_match) {
> +               strcat(p->glob, dirpath);
> +               strcat(p->glob, "/");
> +       }
> +
> +       strcat(p->glob, s);
> +
> +       debug("Add pattern: %s%s%s\n", negate ? "!" : "", p->glob,
> +             dir_only ? "/" : "");
> +
> +       if (nr_patterns >= alloced_patterns) {
> +               alloced_patterns += 128;
> +               patterns = xrealloc(patterns,
> +                                   sizeof(*patterns) * alloced_patterns);
> +       }
> +
> +       patterns[nr_patterns++] = p;
> +}
> +
> +static void *load_gitignore(const char *dirpath)
> +{
> +       struct stat st;
> +       char path[PATH_MAX], *buf;
> +       int fd, ret;
> +
> +       ret = snprintf(path, sizeof(path), "%s/.gitignore", dirpath);
> +       if (ret >= sizeof(path))
> +               error_exit("%s: too long path was truncated\n", path);
> +
> +       // If .gitignore does not exist in this directory, open() fails.
> +       // It is ok, just skip it.
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0)
> +               return NULL;
> +
> +       if (fstat(fd, &st) < 0)
> +               perror_exit(path);
> +
> +       buf = xmalloc(st.st_size + 1);
> +       if (read(fd, buf, st.st_size) != st.st_size)
> +               perror_exit(path);
> +
> +       buf[st.st_size] = '\0';
> +       if (close(fd))
> +               perror_exit(path);
> +
> +       return buf;
> +}
> +
> +// Parse '.gitignore' in the given directory.
> +static void parse_gitignore(const char *dirpath)
> +{
> +       char *buf, *s, *next;
> +
> +       buf = load_gitignore(dirpath);
> +       if (!buf)
> +               return;
> +
> +       debug("Parse %s/.gitignore\n", dirpath);
> +
> +       for (s = buf; *s; s = next) {
> +               next = s;
> +
> +               while (*next != '\0' && *next != '\n')
> +                       next++;
> +
> +               if (*next != '\0') {
> +                       *next = '\0';
> +                       next++;
> +               }
> +
> +               add_pattern(s, dirpath);
> +       }
> +
> +       free(buf);
> +}
> +
> +// Save the current number of patterns and increment the depth
> +static void increment_depth(void)
> +{
> +       if (depth >= max_depth) {
> +               max_depth += 1;
> +               nr_patterns_at = xrealloc(nr_patterns_at,
> +                                         sizeof(*nr_patterns_at) * max_depth);
> +       }
> +
> +       nr_patterns_at[depth] = nr_patterns;
> +       depth++;
> +}
> +
> +// Decrement the depth, and free up the patterns of this directory level.
> +static void decrement_depth(void)
> +{
> +       depth--;
> +       if (depth < 0)
> +               error_exit("BUG\n");
> +
> +       while (nr_patterns > nr_patterns_at[depth])
> +               free(patterns[--nr_patterns]);
> +}
> +
> +// If we find an ignored path, print it.
> +static void print_path(const char *path)
> +{
> +       // The path always start with "./". If not, it is a bug.
> +       if (strlen(path) < 2)
> +               error_exit("BUG\n");
> +
> +       // Replace the root directory with the prefix you like.
> +       // This is useful for the tar command.
> +       fprintf(out_fp, "%s%s\n", prefix, path + 2);
> +}
> +
> +// Traverse the entire directory tree, parsing .gitignore files.
> +// Print file paths that are not tracked by git.
> +//
> +// Return true if all files under the directory are ignored, false otherwise.
> +static bool traverse_directory(const char *dirpath)
> +{
> +       bool all_ignored = true;
> +       DIR *dirp;
> +
> +       debug("Enter[%d]: %s\n", depth, dirpath);
> +       increment_depth();
> +
> +       // We do not know whether .gitignore exists in this directory or not.
> +       // Anyway, try to open it.
> +       parse_gitignore(dirpath);
> +
> +       dirp = opendir(dirpath);
> +       if (!dirp)
> +               perror_exit(dirpath);
> +
> +       while (1) {
> +               char path[PATH_MAX];
> +               struct dirent *d;
> +               int ret;
> +
> +               errno = 0;
> +               d = readdir(dirp);
> +               if (!d) {
> +                       // readdir() returns NULL on the end of the directory
> +                       // steam, and also on an error. To distinguish them,
> +                       // errno should be checked.
> +                       if (errno)
> +                               perror_exit(dirpath);
> +                       break;
> +               }
> +
> +               if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
> +                       continue;
> +
> +               ret = snprintf(path, sizeof(path), "%s/%s", dirpath, d->d_name);
> +               if (ret >= sizeof(path))
> +                       error_exit("%s: too long path was truncated\n", path);
> +
> +               if (is_ignored(path, d->d_name, d->d_type & DT_DIR)) {
> +                       debug("Ignore: %s\n", path);
> +                       print_path(path);
> +               } else {
> +                       if ((d->d_type & DT_DIR) && !(d->d_type & DT_LNK)) {
> +                               if (!traverse_directory(path))
> +                                       all_ignored = false;
> +                       } else {
> +                               all_ignored = false;
> +                       }
> +               }
> +       }
> +
> +       if (closedir(dirp))
> +               perror_exit(dirpath);
> +
> +       // If all the files under this directory are ignored, let's ignore this
> +       // directory as well in order to avoid empty directories in the tarball.
> +       if (all_ignored) {
> +               debug("Ignore: %s (due to all files inside ignored)\n", dirpath);
> +               print_path(dirpath);
> +       }
> +
> +       decrement_depth();
> +       debug("Leave[%d]: %s\n", depth, dirpath);
> +
> +       return all_ignored;
> +}
> +
> +// Register hard-coded ignore patterns.
> +static void add_fixed_patterns(void)
> +{
> +       const char * const fixed_patterns[] = {
> +               ".git/",
> +       };
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(fixed_patterns); i++) {
> +               char *s = xstrdup(fixed_patterns[i]);
> +
> +               add_pattern(s, ".");
> +               free(s);
> +       }
> +}
> +
> +static void usage(void)
> +{
> +       fprintf(stderr,
> +               "usage: %s [options]\n"
> +               "\n"
> +               "Print files that are not ignored by git\n"
> +               "\n"
> +               "options:\n"
> +               "  -d, --debug                   print debug messages to stderr\n"
> +               "  -e, --extra-pattern PATTERN   Add extra ignore patterns. This behaves like it is prepended to the top .gitignore\n"
> +               "  -h, --help                    show this help message and exit\n"
> +               "  -o, --output FILE             output to a file (default: '-', i.e. stdout)\n"
> +               "  -p, --prefix PREFIX           prefix added to each path (default: empty string)\n"
> +               "  -r, --rootdir DIR             root of the source tree (default: current working directory):\n",
> +               progname);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       const char *output = "-";
> +       const char *rootdir = ".";
> +
> +       progname = strrchr(argv[0], '/');
> +       if (progname)
> +               progname++;
> +       else
> +               progname = argv[0];
> +
> +       while (1) {
> +               static struct option long_options[] = {
> +                       {"debug",         no_argument,       NULL, 'd'},
> +                       {"extra-pattern", required_argument, NULL, 'e'},
> +                       {"help",          no_argument,       NULL, 'h'},
> +                       {"output",        required_argument, NULL, 'o'},
> +                       {"prefix",        required_argument, NULL, 'p'},
> +                       {"rootdir",       required_argument, NULL, 'r'},
> +                       {},
> +               };
> +
> +               int c = getopt_long(argc, argv, "de:ho:p:r:", long_options, NULL);
> +
> +               if (c == -1)
> +                       break;
> +
> +               switch (c) {
> +               case 'd':
> +                       debug_on = true;
> +                       break;
> +               case 'e':
> +                       add_pattern(optarg, ".");
> +                       break;
> +               case 'h':
> +                       usage();
> +                       exit(0);
> +               case 'o':
> +                       output = optarg;
> +                       break;
> +               case 'p':
> +                       prefix = optarg;
> +                       break;
> +               case 'r':
> +                       rootdir = optarg;
> +                       break;
> +               case '?':
> +                       usage();
> +                       /* fallthrough */
> +               default:
> +                       exit(EXIT_FAILURE);
> +               }
> +       }
> +
> +       if (chdir(rootdir))
> +               perror_exit(rootdir);
> +
> +       if (strcmp(output, "-")) {
> +               out_fp = fopen(output, "w");
> +               if (!out_fp)
> +                       perror_exit(output);
> +       } else {
> +               out_fp = stdout;
> +       }
> +
> +       add_fixed_patterns();
> +
> +       traverse_directory(".");
> +
> +       if (depth != 0)
> +               error_exit("BUG\n");
> +
> +       while (nr_patterns > 0)
> +               free(patterns[--nr_patterns]);
> +       free(patterns);
> +       free(nr_patterns_at);
> +
> +       fflush(out_fp);
> +       if (ferror(out_fp))
> +               error_exit("not all data was written to the output\n");
> +
> +       if (fclose(out_fp))
> +               perror_exit(output);
> +
> +       return 0;
> +}
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada

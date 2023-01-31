Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F1683284
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAaQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:27:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EE53E4F;
        Tue, 31 Jan 2023 08:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C386159A;
        Tue, 31 Jan 2023 16:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30C5C433EF;
        Tue, 31 Jan 2023 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675182442;
        bh=XpHJNxjtiCCFCEoleGsv+2kCo8+SabiuXjs6x0sS/yg=;
        h=From:To:Cc:Subject:Date:From;
        b=qy/ZtxJMV+mTG8kK6CJ0swnOPUeHJFldQZt0prx83N6b99UEwaT+Xm1M3ddFvPQU1
         W1wiJlSs9X5YIG6YQfjsdGOjAhwsQUHjfCx2YT83pusFou81K9PiOfLPQSjEu3NdCw
         mkTx3qSuWE1xQeX6i05n9kpM09R60Ru9r6KRK0GJCZMITVBLHskJwF2aVRLNuezW67
         okFH/5Cnr/D+zptnXL96/oWVKw7DFodbEbED8ufpgGbweXUKsQ5O+OWcTaufgaGzbp
         f5Wg021icwdurKMJGkhTozHSvOErNqmNuahfU+xQSIlOoxhcBd+OHWeaqqb56FtwQ9
         gkYdoXTor7qvQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v3 1/5] kbuild: add a tool to generate a list of files ignored by git
Date:   Wed,  1 Feb 2023 01:26:11 +0900
Message-Id: <20230131162615.1575215-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In short, the motivation of this commit is to build a source package
without cleaning the source tree.

The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
creating a source tarball. Otherwise build artifacts such as *.o,
*.a, etc. would be included in the tarball. Yet, the tarball ends up
containing several garbage files since 'make clean' does not clean
everything.

Cleaning the tree everytime is annoying since it makes the incremental
build impossible. It is desirable to create a source tarball without
cleaning the tree.

In fact, there are some ways to archive this.

The easiest way is 'git archive'. Actually, 'make perf-tar*-src-pkg'
does this way, but I do not like it because it works only when the source
tree is managed by git, and all files you want in the tarball must be
committed in advance.

I want to make it work without relying on git. We can do this.

Files that are not tracked by git are generated files. We can list them
out by parsing the .gitignore files. Of course, .gitignore does not cover
all the cases, but it works well enough.

tar(1) claims to support it:

  --exclude-vcs-ignores

    Exclude files that match patterns read from VCS-specific ignore files.
    Supported files are: .cvsignore, .gitignore, .bzrignore, and .hgignore.

The best scenario would be to use 'tar --exclude-vcs-ignores', but this
option does not work. --exclude-vcs-ignore does not understand any of
the negation (!), preceding slash, following slash, etc.. So, this option
is just useless.

Hence, I wrote this gitignore parser. The previous version [1], written
in Python, was so slow. This version is implemented in C, so it works
much faster.

This tool tarverses the source tree, parsing the .gitignore files. It
prints the file paths that are not tracked by git. This is suitable to
be passed to tar's --exclude-from= option.

[How to test this tool]

  $ git clean -dfx
  $ make -s -j$(nproc) defconfig all                       # or allmodconifg or whatever
  $ git archive -o ../linux1.tar --prefix=./ HEAD
  $ tar tf ../linux1.tar | LANG=C sort > ../file-list1     # files emitted by 'git archive'
  $ make scripts_exclude
    HOSTCC  scripts/gen-exclude
  $ scripts/gen-exclude --prefix=./ -o ../exclude-list
  $ tar cf ../linux2.tar --exclude-from=../exclude-list .
  $ tar tf ../linux2.tar | LANG=C sort > ../file-list2     # files emitted by 'tar'
  $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
  < ./Documentation/devicetree/bindings/.yamllint
  < ./drivers/clk/.kunitconfig
  < ./drivers/gpu/drm/tests/.kunitconfig
  < ./drivers/gpu/drm/vc4/tests/.kunitconfig
  < ./drivers/hid/.kunitconfig
  < ./fs/ext4/.kunitconfig
  < ./fs/fat/.kunitconfig
  < ./kernel/kcsan/.kunitconfig
  < ./lib/kunit/.kunitconfig
  < ./mm/kfence/.kunitconfig
  < ./net/sunrpc/.kunitconfig
  < ./tools/testing/selftests/arm64/tags/
  < ./tools/testing/selftests/arm64/tags/.gitignore
  < ./tools/testing/selftests/arm64/tags/Makefile
  < ./tools/testing/selftests/arm64/tags/run_tags_test.sh
  < ./tools/testing/selftests/arm64/tags/tags_test.c
  < ./tools/testing/selftests/kvm/.gitignore
  < ./tools/testing/selftests/kvm/Makefile
  < ./tools/testing/selftests/kvm/config
  < ./tools/testing/selftests/kvm/settings

The source tarball contains most of files that are tracked by git. You
see some diffs, but it is just because some .gitignore files are wrong.

  $ git ls-files -i -c --exclude-per-directory=.gitignore
  Documentation/devicetree/bindings/.yamllint
  drivers/clk/.kunitconfig
  drivers/gpu/drm/tests/.kunitconfig
  drivers/hid/.kunitconfig
  fs/ext4/.kunitconfig
  fs/fat/.kunitconfig
  kernel/kcsan/.kunitconfig
  lib/kunit/.kunitconfig
  mm/kfence/.kunitconfig
  tools/testing/selftests/arm64/tags/.gitignore
  tools/testing/selftests/arm64/tags/Makefile
  tools/testing/selftests/arm64/tags/run_tags_test.sh
  tools/testing/selftests/arm64/tags/tags_test.c
  tools/testing/selftests/kvm/.gitignore
  tools/testing/selftests/kvm/Makefile
  tools/testing/selftests/kvm/config
  tools/testing/selftests/kvm/settings

[1]: https://lore.kernel.org/all/20230128173843.765212-1-masahiroy@kernel.org/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
 - Various code refactoring: remove struct gitignore, remove next: label etc.
 - Support --extra-pattern option

Changes in v2:
 - Reimplement in C

 Makefile              |   4 +
 scripts/.gitignore    |   1 +
 scripts/Makefile      |   2 +-
 scripts/gen-exclude.c | 618 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 scripts/gen-exclude.c

diff --git a/Makefile b/Makefile
index 339121558928..01c6f4ff515f 100644
--- a/Makefile
+++ b/Makefile
@@ -1652,6 +1652,10 @@ distclean: mrproper
 %pkg: include/config/kernel.release FORCE
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.package $@
 
+PHONY += scripts_exclude
+scripts_exclude: scripts_basic
+	$(Q)$(MAKE) $(build)=scripts scripts/gen-exclude
+
 # Brief documentation of the typical targets used
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 6e9ce6720a05..7f433bc1461c 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /asn1_compiler
+/gen-exclude
 /generate_rust_target
 /insert-sys-cert
 /kallsyms
diff --git a/scripts/Makefile b/scripts/Makefile
index 32b6ba722728..5dcd7f57607f 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -38,7 +38,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
 # The following programs are only built on demand
-hostprogs += unifdef
+hostprogs += gen-exclude unifdef
 
 # The module linker script is preprocessed on demand
 targets += module.lds
diff --git a/scripts/gen-exclude.c b/scripts/gen-exclude.c
new file mode 100644
index 000000000000..7d58cfaeba48
--- /dev/null
+++ b/scripts/gen-exclude.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Traverse the source tree, parsing all .gitignore files, and print file paths
+// that are not tracked by git.
+// The output is suitable to the --exclude-from option of tar.
+// This is useful until the --exclude-vcs-ignores option gets working correctly.
+//
+// Copyright (C) 2023 Masahiro Yamada <masahiroy@kernel.org>
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <fnmatch.h>
+#include <getopt.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+// struct pattern - represent an ignore pattern (a line in .gitignroe)
+// @negate:          negate the pattern (prefixing '!')
+// @dir_only:        only matches directories (trailing '/')
+// @path_match:      true if the glob pattern is a path instead of a file name
+// @double_asterisk: true if the glob pattern contains double asterisks ('**')
+// @glob:            glob pattern
+struct pattern {
+	bool negate;
+	bool dir_only;
+	bool path_match;
+	bool double_asterisk;
+	char glob[];
+};
+
+struct pattern **patterns;
+static int nr_patterns, alloced_patterns;
+
+// remember the number of patterns at each directory level
+static int *nr_patterns_at;
+// track the current/max directory level;
+static int depth, max_depth;
+static bool debug_on;
+static FILE *out_fp;
+static char *prefix = "";
+static char *progname;
+
+static void __attribute__((noreturn)) perror_exit(const char *s)
+{
+	perror(s);
+	exit(EXIT_FAILURE);
+}
+
+static void __attribute__((noreturn)) error_exit(const char *fmt, ...)
+{
+	va_list args;
+
+	fprintf(stderr, "%s: error: ", progname);
+
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+
+	exit(EXIT_FAILURE);
+}
+
+static void debug(const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	if (!debug_on)
+		return;
+
+	fprintf(stderr, "[DEBUG]");
+
+	for (i = 0; i < depth * 2; i++)
+		fputc(' ', stderr);
+
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+}
+
+static void *xrealloc(void *ptr, size_t size)
+{
+	ptr = realloc(ptr, size);
+	if (!ptr)
+		perror_exit(progname);
+
+	return ptr;
+}
+
+static void *xmalloc(size_t size)
+{
+	return xrealloc(NULL, size);
+}
+
+static char *xstrdup(const char *s)
+{
+	char *new = strdup(s);
+
+	if (!new)
+		perror_exit(progname);
+
+	return new;
+}
+
+static bool simple_match(const char *string, const char *pattern)
+{
+	return fnmatch(pattern, string, FNM_PATHNAME) == 0;
+}
+
+// Handle double asterisks ("**") matching.
+// FIXME:
+//  This function does not work if double asterisks apppear multiple times,
+//  like "foo/**/bar/**/baz".
+static bool double_asterisk_match(const char *path, const char *pattern)
+{
+	bool result = false;
+	int slash_diff = 0;
+	char *modified_pattern, *q;
+	const char *p;
+	size_t len;
+
+	for (p = path; *p; p++)
+		if (*p == '/')
+			slash_diff++;
+
+	for (p = pattern; *p; p++)
+		if (*p == '/')
+			slash_diff--;
+
+	len = strlen(pattern) + 1;
+
+	if (slash_diff > 0)
+		len += slash_diff * 2;
+	modified_pattern = xmalloc(len);
+
+	q = modified_pattern;
+	for (p = pattern; *p; p++) {
+		if (!strncmp(p, "**/", 3)) {
+			// "**/" means zero of more sequences of '*/".
+			// "foo**/bar" matches "foobar", "foo*/bar",
+			// "foo*/*/bar", etc.
+			while (slash_diff-- > 0) {
+				*q++ = '*';
+				*q++ = '/';
+			}
+
+			if (slash_diff == 0) {
+				*q++ = '*';
+				*q++ = '/';
+			}
+
+			if (slash_diff < 0)
+				slash_diff++;
+
+			p += 2;
+		} else if (!strcmp(p, "/**")) {
+			// A trailing "/**" matches everything inside.
+			while (slash_diff-- >= 0) {
+				*q++ = '/';
+				*q++ = '*';
+			}
+
+			p += 2;
+		} else {
+			// Copy other patterns as-is.
+			// Other consecutive asterisks are considered regular
+			// asterisks. fnmatch() already handles them like that.
+			*q++ = *p;
+		}
+	}
+
+	*q = '\0';
+
+	result = simple_match(path, modified_pattern);
+
+	free(modified_pattern);
+
+	return result;
+}
+
+// Return true if the given path is ignored by git.
+static bool is_ignored(const char *path, const char *name, bool is_dir)
+{
+	int i;
+
+	// Search the patterns in the reverse order because the last matching
+	// pattern wins.
+	for (i = nr_patterns - 1; i >= 0; i--) {
+		struct pattern *p = patterns[i];
+
+		if (!is_dir && p->dir_only)
+			continue;
+
+		if (!p->path_match) {
+			// If the pattern has no slash at the beginning or
+			// middle, it matches against the basename. Most cases
+			// fall into this and work well with double asterisks.
+			if (!simple_match(name, p->glob))
+				continue;
+		} else if (!p->double_asterisk) {
+			// Unless the pattern has double asterisks, it is still
+			// simple but matches against the path instead.
+			if (!simple_match(path, p->glob))
+				continue;
+		} else {
+			// Double asterisks with a slash. Complex, but rare.
+			if (!double_asterisk_match(path, p->glob))
+				continue;
+		}
+
+		debug("%s: matches %s%s%s\n", path, p->negate ? "!" : "",
+		      p->glob, p->dir_only ? "/" : "");
+
+		return !p->negate;
+	}
+
+	debug("%s: no match\n", path);
+
+	return false;
+}
+
+// Return the length of the initial segment of the string that does not contain
+// the unquoted sequence of the given character.
+static size_t strcspn_trailer(const char *str, char c)
+{
+	bool quoted = false;
+	size_t len = strlen(str);
+	size_t spn = len;
+	const char *s;
+
+	for (s = str; *s; s++) {
+		if (!quoted && *s == c) {
+			if (s - str < spn)
+				spn = s - str;
+		} else {
+			spn = len;
+
+			if (!quoted && *s == '\\')
+				quoted = true;
+			else
+				quoted = false;
+		}
+	}
+
+	return spn;
+}
+
+static void add_pattern(char *s, const char *dirpath)
+{
+	bool negate = false;
+	bool dir_only = false;
+	bool path_match = false;
+	bool double_asterisk = false;
+	char *e = s + strlen(s);
+	struct pattern *p;
+	size_t len;
+
+	// Skip comments
+	if (*s == '#')
+		return;
+
+	// Trailing spaces are ignored unless they are quoted with backslash.
+	e = s + strcspn_trailer(s, ' ');
+	*e = '\0';
+
+	// The prefix '!' negates the pattern
+	if (*s == '!') {
+		s++;
+		negate = true;
+	}
+
+	// If there is slash(es) that is not escaped at the end of the pattern,
+	// it matches only directories.
+	len = strcspn_trailer(s, '/');
+	if (s + len < e) {
+		dir_only = true;
+		e = s + len;
+		*e = '\0';
+	}
+
+	// Skip if the line gets empty
+	if (*s == '\0')
+		return;
+
+	// Double asterisk is tricky. Mark it to handle it specially later.
+	if (strstr(s, "**/") || strstr(s, "/**"))
+		double_asterisk = true;
+
+	// If there is a slash at the beginning or middle, the pattern
+	// is relative to the directory level of the .gitignore.
+	if (strchr(s, '/')) {
+		if (*s == '/')
+			s++;
+		path_match = true;
+	}
+
+	len = e - s;
+
+	// We need more room to store dirpath and '/'
+	if (path_match)
+		len += strlen(dirpath) + 1;
+
+	p = xmalloc(sizeof(*p) + len + 1);
+	p->negate = negate;
+	p->dir_only = dir_only;
+	p->path_match = path_match;
+	p->double_asterisk = double_asterisk;
+	p->glob[0] = '\0';
+
+	if (path_match) {
+		strcat(p->glob, dirpath);
+		strcat(p->glob, "/");
+	}
+
+	strcat(p->glob, s);
+
+	debug("Add pattern: %s%s%s\n", negate ? "!" : "", p->glob,
+	      dir_only ? "/" : "");
+
+	if (nr_patterns >= alloced_patterns) {
+		alloced_patterns += 128;
+		patterns = xrealloc(patterns,
+				    sizeof(*patterns) * alloced_patterns);
+	}
+
+	patterns[nr_patterns++] = p;
+}
+
+static void *load_gitignore(const char *dirpath)
+{
+	struct stat st;
+	char path[PATH_MAX], *buf;
+	int fd, ret;
+
+	ret = snprintf(path, sizeof(path), "%s/.gitignore", dirpath);
+	if (ret >= sizeof(path))
+		error_exit("%s: too long path was truncated\n", path);
+
+	// If .gitignore does not exist in this directory, open() fails.
+	// It is ok, just skip it.
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+
+	if (fstat(fd, &st) < 0)
+		perror_exit(path);
+
+	buf = xmalloc(st.st_size + 1);
+	if (read(fd, buf, st.st_size) != st.st_size)
+		perror_exit(path);
+
+	buf[st.st_size] = '\0';
+	if (close(fd))
+		perror_exit(path);
+
+	return buf;
+}
+
+// Parse '.gitignore' in the given directory.
+static void parse_gitignore(const char *dirpath)
+{
+	char *buf, *s, *next;
+
+	buf = load_gitignore(dirpath);
+	if (!buf)
+		return;
+
+	debug("Parse %s/.gitignore\n", dirpath);
+
+	for (s = buf; *s; s = next) {
+		next = s;
+
+		while (*next != '\0' && *next != '\n')
+			next++;
+
+		if (*next != '\0') {
+			*next = '\0';
+			next++;
+		}
+
+		add_pattern(s, dirpath);
+	}
+
+	free(buf);
+}
+
+// Save the current number of patterns and increment the depth
+static void increment_depth(void)
+{
+	if (depth >= max_depth) {
+		max_depth += 1;
+		nr_patterns_at = xrealloc(nr_patterns_at,
+					  sizeof(*nr_patterns_at) * max_depth);
+	}
+
+	nr_patterns_at[depth] = nr_patterns;
+	depth++;
+}
+
+// Decrement the depth, and free up the patterns of this directory level.
+static void decrement_depth(void)
+{
+	depth--;
+	if (depth < 0)
+		error_exit("BUG\n");
+
+	while (nr_patterns > nr_patterns_at[depth])
+		free(patterns[--nr_patterns]);
+}
+
+// If we find an ignored path, print it.
+static void print_path(const char *path)
+{
+	if (strlen(path) < 2)
+		error_exit("BUG\n");
+
+	fprintf(out_fp, "%s%s\n", prefix, path + 2);
+}
+
+// Traverse the entire directory tree, parsing .gitignore files.
+// Print file paths that are not tracked by git.
+//
+// Return true if all files under the directory are ignored, false otherwise.
+static bool traverse_directory(const char *dirpath)
+{
+	bool all_ignored = true;
+	DIR *dirp;
+
+	debug("Enter[%d]: %s\n", depth, dirpath);
+	increment_depth();
+
+	// We do not know whether .gitignore exists in this directory or not.
+	// Anyway, try to open it.
+	parse_gitignore(dirpath);
+
+	dirp = opendir(dirpath);
+	if (!dirp)
+		perror_exit(dirpath);
+
+	while (1) {
+		char path[PATH_MAX];
+		struct dirent *d;
+		int ret;
+
+		errno = 0;
+		d = readdir(dirp);
+		if (!d) {
+			// readdir() returns NULL on the end of the directory
+			// steam, and also on an error. To distinguish them,
+			// errno should be checked.
+			if (errno)
+				perror_exit(dirpath);
+			break;
+		}
+
+		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
+			continue;
+
+		ret = snprintf(path, sizeof(path), "%s/%s", dirpath, d->d_name);
+		if (ret >= sizeof(path))
+			error_exit("%s: too long path was truncated\n", path);
+
+		if (is_ignored(path, d->d_name, d->d_type & DT_DIR)) {
+			debug("Ignore: %s\n", path);
+			print_path(path);
+		} else {
+			if ((d->d_type & DT_DIR) && !(d->d_type & DT_LNK)) {
+				if (!traverse_directory(path))
+					all_ignored = false;
+			} else {
+				all_ignored = false;
+			}
+		}
+	}
+
+	if (closedir(dirp))
+		perror_exit(dirpath);
+
+	// If all the files under this directory are ignored, let's ignore this
+	// directory as well in order to avoid empty directories in the tarball.
+	if (all_ignored) {
+		debug("Ignore: %s (due to all files inside ignored)\n", dirpath);
+		print_path(dirpath);
+	}
+
+	decrement_depth();
+	debug("Leave[%d]: %s\n", depth, dirpath);
+
+	return all_ignored;
+}
+
+// Register hard-coded ignore patterns.
+static void add_fixed_patterns(void)
+{
+	const char * const fixed_patterns[] = {
+		".git/",
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fixed_patterns); i++) {
+		char *s = xstrdup(fixed_patterns[i]);
+
+		add_pattern(s, ".");
+		free(s);
+	}
+}
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"usage: %s [options]\n"
+		"\n"
+		"Print files that are not ignored by git\n"
+		"\n"
+		"options:\n"
+		"  -d, --debug                   print debug messages to stderr\n"
+		"  -e, --extra-pattern PATTERN   Add extra ignore patterns. This behaves like it is prepended to the top .gitignore\n"
+		"  -h, --help                    show this help message and exit\n"
+		"  -o, --output FILE             output to a file (default: '-', i.e. stdout)\n"
+		"  -p, --prefix PREFIX           prefix added to each path\n"
+		"  -r, --rootdir DIR             root of the source tree (default: current working directory):\n",
+		progname);
+}
+
+int main(int argc, char *argv[])
+{
+	const char *output = "-";
+	const char *rootdir = ".";
+
+	progname = strrchr(argv[0], '/');
+	if (progname)
+		progname++;
+	else
+		progname = argv[0];
+
+	while (1) {
+		static struct option long_options[] = {
+			{"debug",         no_argument,       NULL, 'd'},
+			{"extra-pattern", required_argument, NULL, 'e'},
+			{"help",          no_argument,       NULL, 'h'},
+			{"output",        required_argument, NULL, 'o'},
+			{"prefix",        required_argument, NULL, 'p'},
+			{"rootdir",       required_argument, NULL, 'r'},
+			{},
+		};
+
+		int c = getopt_long(argc, argv, "de:ho:p:r:", long_options, NULL);
+
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'd':
+			debug_on = true;
+			break;
+		case 'e':
+			add_pattern(optarg, ".");
+			break;
+		case 'h':
+			usage();
+			exit(0);
+		case 'o':
+			output = optarg;
+			break;
+		case 'p':
+			prefix = optarg;
+			break;
+		case 'r':
+			rootdir = optarg;
+			break;
+		case '?':
+			usage();
+			/* fallthrough */
+		default:
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	if (chdir(rootdir))
+		perror_exit(rootdir);
+
+	if (strcmp(output, "-")) {
+		out_fp = fopen(output, "w");
+		if (!out_fp)
+			perror_exit(output);
+	} else {
+		out_fp = stdout;
+	}
+
+	add_fixed_patterns();
+
+	traverse_directory(".");
+
+	if (depth != 0)
+		error_exit("BUG\n");
+
+	while (nr_patterns > 0)
+		free(patterns[--nr_patterns]);
+	free(patterns);
+	free(nr_patterns_at);
+
+	fflush(out_fp);
+	if (ferror(out_fp))
+		error_exit("not all data was written to the output\n");
+
+	if (fclose(out_fp))
+		perror_exit(output);
+
+	return 0;
+}
-- 
2.34.1


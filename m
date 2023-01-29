Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F26800DF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjA2SqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjA2SqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694541E1F7;
        Sun, 29 Jan 2023 10:46:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94C760DF3;
        Sun, 29 Jan 2023 18:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E8FC433D2;
        Sun, 29 Jan 2023 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675017970;
        bh=PPUg74e9/Ezyvf1fel1aE3NRSAIS6eJqCCmhs0ulU1A=;
        h=From:To:Cc:Subject:Date:From;
        b=UKJmmfnGo4mKkTdUnjlaUpQPoXaXbI0silCjeTg+GOfHqlWSlUxyrXkqtVgkqOvVJ
         AL9KyBCItADhjzBnWk1KAYd1wREaLDvp5BZdDj4vzaZHnHmEjSOWEmKSmybk0Zrt12
         mtjP8Z2XBBAA5gz/h4YY73NXjHnVJwkcDHcRd5aoJwn+yrVVALT2HMZWHJwpsoVJ7o
         c+VKyDgV8ZdPxtv6thrHwhQM+mqASHHBmobcgJ8KbY5DCO3aQVb9jcgX1qVZpeNRIU
         qODu7648Ru8KecCqD3vX/aqcIJmJ0iI3uCqUaI/cSeQJMvtrc+H+0J7wF3yj6rRcY/
         t4ZZ8Y5EYOldQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/5] kbuild: add a tool to generate a list of files ignored by git
Date:   Mon, 30 Jan 2023 03:45:58 +0900
Message-Id: <20230129184602.3974058-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Changes in v2:
  - Reimplement in C

 Makefile              |   4 +
 scripts/.gitignore    |   1 +
 scripts/Makefile      |   2 +-
 scripts/gen-exclude.c | 639 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 645 insertions(+), 1 deletion(-)
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
index 000000000000..3f23b9c934e2
--- /dev/null
+++ b/scripts/gen-exclude.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Traverse the source tree, parsing all .gitignore files, and print file paths
+// that are not tracked by git.
+// The output is suitable to the --exclude-from option of tar.
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
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/stat.h>
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
+// struct gitignore - represent a .gitignore file
+// @nr_patterns: a number of patterns that exists in this .gitignore
+// @patterns:    array of pointers of patterns
+struct gitignore {
+	unsigned int nr_patterns;
+	struct pattern **patterns;
+};
+
+static struct gitignore *gitignores;
+static int nr_gitignores;
+static unsigned int alloced_gitignores;
+
+static bool debug_on;
+static int depth;
+static FILE *out_fp;
+static char *prefix = "";
+static char *progname;
+
+static void __attribute__ ((noreturn)) perror_exit(const char *s)
+{
+	perror(s);
+	exit(EXIT_FAILURE);
+}
+
+static void __attribute__ ((noreturn)) error_exit(const char *fmt, ...)
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
+	const char *p;
+	int slash_diff = 0;
+	char *modified_pattern;
+	size_t len;
+	bool result = false;
+	char *q;
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
+		if (*p == '*' && *(p + 1) == '*' && *(p + 2) == '/') {
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
+			p += 2;
+		} else if (*p == '/' && *(p + 1) == '*' && *(p + 2) == '*' &&
+			   *(p + 3) == '\0') {
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
+			// asterisks, but fnmatch() handle them like that.
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
+	int i, j;
+
+	// ignore more patterns that are not specified by .gitignore
+	if ((is_dir && !strcmp(name, ".git")) ||
+	    simple_match(name, "*.rej") || simple_match(name, "*.mbx"))
+		return true;
+
+	// search the .gitignore in the same directory, and then in any
+	// parent directory up to the top-level.
+	for (i = nr_gitignores - 1; i >= 0; i--) {
+		// search the patterns in the reverse order because the last
+		// matching pattern wins.
+		for (j = gitignores[i].nr_patterns - 1; j >= 0; j--) {
+			struct pattern *pat = gitignores[i].patterns[j];
+
+			if (!is_dir && pat->dir_only)
+				continue;
+
+			if (!pat->path_match) {
+				// If the pattern has no slash at the beginning
+				// or middle, it matches against the basename.
+				// Most cases fall into this.
+				// Double asterisks behave as regular asterisks.
+				if (!simple_match(name, pat->glob))
+					continue;
+			} else if (!pat->double_asterisk) {
+				// Unless the pattern has double asterisks, it
+				// is still simple but matches against the path.
+				if (!simple_match(path, pat->glob))
+					continue;
+			} else {
+				// Double asterisks with a slash.
+				// This is complex, but rare.
+				if (!double_asterisk_match(path, pat->glob))
+					continue;
+			}
+
+			debug("%s: matches %s%s%s\n", path, pat->negate ? "!" : "",
+			      pat->glob, pat->dir_only ? "/" : "");
+
+			return !pat->negate;
+		}
+	}
+
+	debug("%s: no match\n", path);
+
+	return false;
+}
+
+static void *load_gitignore(const char *dirpath)
+{
+	struct stat st;
+	int fd;
+	char *buf;
+	int ret;
+	char path[PATH_MAX];
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
+// Check if the substring @needle is contained in the string that starts at @p
+// and ends at @q. (just like strstr() with unterminated 'haystack')
+static bool contain_str(const char *p, const char *q, const char *needle)
+{
+	size_t len = strlen(needle);
+	int i;
+
+	while (p <= q) {
+		bool match = true;
+
+		for (i = 0; i < len; i++) {
+			if (needle[i] != p[i]) {
+				match = false;
+				break;
+			}
+		}
+
+		if (match)
+			return true;
+		p++;
+	}
+
+	return false;
+}
+
+// Check if the unquoted sequence of the given charcter @c is found at the end
+// of the string that starts at @p and ends at @q. If found, return the
+// pointer to such a sequence, otherwise NULL.
+static const char *find_trailing_chars(const char *p, const char *q, char c)
+{
+	bool quoted = false;
+	const char *found = NULL;
+
+	while (p <= q) {
+		if (!quoted && *p == c) {
+			if (!found)
+				found = p;
+		} else {
+			found = NULL;
+
+			if (!quoted && *p == '\\')
+				quoted = true;
+			else
+				quoted = false;
+		}
+
+		p++;
+	}
+
+	return found;
+}
+
+// Parse '.gitignore' in the given directory.
+static void parse_gitignore(const char *dirpath, struct gitignore *g)
+{
+	int alloced_patterns = 0;
+	struct pattern *pat;
+	void *buf;
+	const char *p;
+
+	g->nr_patterns = 0;
+	g->patterns = NULL;
+
+	buf = load_gitignore(dirpath);
+	if (!buf)
+		return;
+
+	debug("Parse %s/.gitignore\n", dirpath);
+
+	p = buf;
+
+	while (*p) {
+		const char *q, *e, *found;
+		bool negate = false;
+		bool dir_only = false;
+		bool path_match = false;
+		bool double_asterisk = false;
+		int len;
+
+		e = p;
+
+		while (*e && *e != '\n')
+			e++;
+
+		q = e - 1;
+
+		// skip comments
+		if (*p == '#')
+			goto next;
+
+		// trailing spaces are ignored unless they are quoted with
+		// backslash.
+		found = find_trailing_chars(p, q, ' ');
+		if (found)
+			q = found - 1;
+
+		// The prefix '!' negates the pattern
+		if (*p == '!') {
+			p++;
+			negate = true;
+		}
+
+		// If there is slash(es) that is not escaped at the end of the pattern,
+		// it matches only directories.
+		found = find_trailing_chars(p, q, '/');
+		if (found) {
+			dir_only = true;
+			q = found - 1;
+		}
+
+		// skip empty lines
+		if (p > q)
+			goto next;
+
+		// It is tricky to support double asterisks.
+		// Mark it to handle it specially later.
+		if (contain_str(p, q, "**/") || contain_str(p, q, "/**"))
+			double_asterisk = true;
+
+		if (contain_str(p, q, "/")) {
+			if (*p == '/')
+				p++;
+			path_match = true;
+		}
+
+		len = q - p + 1;
+
+		if (path_match)
+			// we need more room to store dirpath and '/'
+			len += strlen(dirpath) + 1;
+
+		pat = xmalloc(sizeof(*pat) + len + 1);
+		pat->negate = negate;
+		pat->dir_only = dir_only;
+		pat->path_match = path_match;
+		pat->double_asterisk = double_asterisk;
+
+		pat->glob[0] = '\0';
+
+		if (path_match) {
+			strcpy(pat->glob, dirpath);
+			strcat(pat->glob, "/");
+		}
+
+		strncat(pat->glob, p, q - p + 1);
+
+		debug("Add pattern: %s%s%s\n", pat->negate ? "!" : "",
+		      pat->glob, pat->dir_only ? "/" : "");
+
+		if (g->nr_patterns >= alloced_patterns) {
+			alloced_patterns += 128;
+			g->patterns = xrealloc(g->patterns,
+					       sizeof(*g->patterns) * alloced_patterns);
+		}
+
+		g->patterns[g->nr_patterns++] = pat;
+
+next:
+		if (!*e)
+			break;
+
+		p = e + 1;
+	}
+
+	free(buf);
+}
+
+// Add a gitignore entry every time we descend a directory level.
+// If .gitignore does not exist in the directory, add an empty entry.
+static void add_gitignore(const char *dirpath)
+{
+	if (nr_gitignores >= alloced_gitignores) {
+		alloced_gitignores += 32;
+		gitignores = xrealloc(gitignores,
+				      sizeof(*gitignores) * alloced_gitignores);
+	}
+
+	parse_gitignore(dirpath, &gitignores[nr_gitignores]);
+
+	nr_gitignores++;
+}
+
+// Pop a gitignore entry every time we ascend back a directory level.
+static void remove_gitignore(void)
+{
+	struct gitignore *g;
+
+	nr_gitignores--;
+	if (nr_gitignores < 0)
+		error_exit("BUG\n");
+
+	g = &gitignores[nr_gitignores];
+
+	while (g->nr_patterns-- > 0)
+		free(g->patterns[g->nr_patterns]);
+
+	free(g->patterns);
+}
+
+// If we find an ignored file path, print it.
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
+	DIR *dirp;
+	bool all_ignored = true;
+
+	debug("Enter[%d]: %s\n", depth, dirpath);
+	depth++;
+
+	// We do not know whether .gitignore exists in this directory or not.
+	// Anyway, try to open it.
+	add_gitignore(dirpath);
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
+			// error should be checked.
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
+	// If all the files under this directory, ignore this directory as well.
+	// This is useful to not create an empty directory in the tarball.
+	if (all_ignored)
+		print_path(dirpath);
+
+	remove_gitignore();
+
+	depth--;
+	debug("Leave[%d]: %s\n", depth, dirpath);
+
+	return all_ignored;
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
+		"  -d, --debug            print debug messages to stderr\n"
+		"  -h, --help             show this help message and exit\n"
+		"  -o, --output FILE      output to a file (default: '-', i.e. stdout)\n"
+		"  -p, --prefix PREFIX    prefix added to each path\n"
+		"  -r, --rootdir DIR      root of the source tree (default: current working directory):\n",
+		progname);
+}
+
+int main(int argc, char *argv[])
+{
+	const char *rootdir = ".";
+	const char *output = "-";
+
+	progname = strrchr(argv[0], '/');
+	if (progname)
+		progname++;
+	else
+		progname = argv[0];
+
+	while (1) {
+		static struct option long_options[] = {
+			{"debug",   no_argument,       NULL, 'd'},
+			{"help",    no_argument,       NULL, 'h'},
+			{"output",  required_argument, NULL, 'o'},
+			{"prefix",  required_argument, NULL, 'p'},
+			{"rootdir", required_argument, NULL, 'r'},
+			{},
+		};
+
+		int c = getopt_long(argc, argv, "dho:p:r:", long_options, NULL);
+
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'd':
+			debug_on = true;
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
+	traverse_directory(".");
+
+	free(gitignores);
+
+	if (nr_gitignores != 0 || depth != 0)
+		error_exit("BUG\n");
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


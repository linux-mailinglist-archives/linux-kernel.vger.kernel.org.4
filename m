Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D702365A2FC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiLaGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiLaGmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:42:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE0DF1E;
        Fri, 30 Dec 2022 22:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E8060907;
        Sat, 31 Dec 2022 06:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A2DC43398;
        Sat, 31 Dec 2022 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672468949;
        bh=pPtNFbrwZDEe7R9hGihgBI1Cy7TXHMHG4P1tYoFNjZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjVgtKIEuSKQV5RCpmNW/O1yoF8JI3xd4McrQbIA1czpfqaWgRrk6xd17BGHx0PCm
         DFolHEM19x+a1P2/nb6IRjgHxdQ8jIa4JXX7AlN3oWWhy7oYUZ6IDqVWRWnxdn3lT+
         asNw5BnhqGchSuGcSLoup/1h6PO6BKWS0EVdJye5wpTpFPNymP3pn5cjdKHPre+bd9
         i35/ppuKtMFTmAhI3VmsvfST7UgTpDXRHbURyPRtzHGmFoOYYzhDhHX3By9gt+HH3z
         YhVjAzGUxc7HxAFwbKQKjw8jiN3dmx4LDphYdntmnQp1Q9PG2Z4nQZg5z9mLoJDfwK
         8aJdtTZBiB4Jw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: [PATCH 5/6] fixdep: avoid parsing the same file over again
Date:   Sat, 31 Dec 2022 15:42:02 +0900
Message-Id: <20221231064203.1623793-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221231064203.1623793-1-masahiroy@kernel.org>
References: <20221231064203.1623793-1-masahiroy@kernel.org>
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

The dep files (*.d files) emitted by C compilers usually contain the
deduplicated list of included files.

There is an exceptional case; if a header is included by the -include
command line option, and also by #include directive, it appears twice
in the *.d file.

For example, the top Makefile specifies the command line option,
-include $(srctree)/include/linux/kconfig.h. You do not need to
add #include <linux/kconfig.h> in every source file.

In fact, include/linux/kconfig.h is listed twice in many .*.cmd files
due to include/linux/xarray.h including <linux/kconfig.h>.
I did not fix that since it is a small redundancy.

However, this is more annoying for rustc. rustc emits the dependency
for each emission type.

For example, cmd_rustc_library emits dep-info, obj, and metadata.
So, the emitted *.d file contains the dependency for those 3 targets,
which makes fixdep parse the same file 3 times.

  $ grep rust/alloc/raw_vec.rs rust/.alloc.o.cmd
    rust/alloc/raw_vec.rs \
    rust/alloc/raw_vec.rs \
    rust/alloc/raw_vec.rs \

To skip the second parsing, this commit adds a hash table for parsed
files, just like we did for CONFIG options.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/basic/fixdep.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index b20777b888d7..cc8f6d34c2ca 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -113,7 +113,7 @@ struct item {
 };
 
 #define HASHSZ 256
-static struct item *config_hashtab[HASHSZ];
+static struct item *config_hashtab[HASHSZ], *file_hashtab[HASHSZ];
 
 static unsigned int strhash(const char *str, unsigned int sz)
 {
@@ -361,6 +361,10 @@ static void parse_dep_file(char *p, const char *target)
 			 * name, which will be the original one, and ignore any
 			 * other source names, which will be intermediate
 			 * temporary files.
+			 *
+			 * rustc emits the same dependency list for each
+			 * emission type. It is enough to list the source name
+			 * just once.
 			 */
 			if (!saw_any_target) {
 				saw_any_target = true;
@@ -368,7 +372,8 @@ static void parse_dep_file(char *p, const char *target)
 				printf("deps_%s := \\\n", target);
 				need_parse = true;
 			}
-		} else if (!is_ignored_file(p, q - p)) {
+		} else if (!is_ignored_file(p, q - p) &&
+			   !in_hashtable(p, q - p, file_hashtab)) {
 			printf("  %s \\\n", p);
 			need_parse = true;
 		}
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8F660D38
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjAGJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjAGJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:18:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD687F36;
        Sat,  7 Jan 2023 01:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 653B960A1F;
        Sat,  7 Jan 2023 09:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C2C43392;
        Sat,  7 Jan 2023 09:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083128;
        bh=cZp3/f8g3cCc0UPJMUJ/mOB550SUSwktxIGn/lu/TWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJ8U3AN+n5hzQC3fHvtMDG/wqdaGph5cgla581EymJqOg9fAhTZyi3A+UT2Rm550z
         uPzXjzPdf85fEqQFs3DQ8unVm0dh5HqWYUmxEGg/V2AqfMTRznkW6CTe5nhbXrjfw/
         14Qr+bMktdGTaI20vVCcCZr3EVPhxjrsUhbbMFSm9KQwBzOtpld5E83oQOFrsXN2FN
         wLFAwP3IXq3+2ghWWA7/ceOXpvfHWFa7W2AU659tC3KE8aMn96zM+xVyPKBbF9vfyn
         DG8ynn+16sv1qWVuHGhDMNpCQoi9czA+fNYjAqJR+1XWgeIe+HGJMeowFgiLlC6xk7
         GYQ+2LFQ574HQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 6/7] fixdep: avoid parsing the same file over again
Date:   Sat,  7 Jan 2023 18:18:19 +0900
Message-Id: <20230107091820.3382134-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107091820.3382134-1-masahiroy@kernel.org>
References: <20230107091820.3382134-1-masahiroy@kernel.org>
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

One exceptional case is when a header is included by the -include
command line option, and also by #include directive.

For example, the top Makefile adds the command line option,
"-include $(srctree)/include/linux/kconfig.h". You do not need to
include <linux/kconfig.h> in every source file.

In fact, include/linux/kconfig.h is listed twice in many .*.cmd files
due to include/linux/xarray.h having "#include <linux/kconfig.h>".
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
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---

(no changes since v1)

 scripts/basic/fixdep.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 74f90a0deeb9..e22e689de61e 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -113,7 +113,7 @@ struct item {
 };
 
 #define HASHSZ 256
-static struct item *config_hashtab[HASHSZ];
+static struct item *config_hashtab[HASHSZ], *file_hashtab[HASHSZ];
 
 static unsigned int strhash(const char *str, unsigned int sz)
 {
@@ -365,6 +365,10 @@ static void parse_dep_file(char *p, const char *target)
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
@@ -372,7 +376,8 @@ static void parse_dep_file(char *p, const char *target)
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


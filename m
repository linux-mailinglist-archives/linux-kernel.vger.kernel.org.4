Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E6660D39
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjAGJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbjAGJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:19:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0736872B6;
        Sat,  7 Jan 2023 01:18:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CEFC6090C;
        Sat,  7 Jan 2023 09:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C345C433EF;
        Sat,  7 Jan 2023 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083132;
        bh=HDunvAi4h/6vbPRGpgqV3uOp71+s45kzLihxASdER6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1/C1SDC7NEjkzK2S71h54G7aOxc8q6IPPHLAda71lSvw44xzbVWUe7EGjQNB+eI8
         pbMmD9fNrbItRnBLyKZcJeLRyleV8hCJYM0O6fcYvuyvb+ad5vl0r/S7nOzs/feQiB
         h4Q8LGa1tHQ5nSVPyaoEfQuAzd6daToA4Fi4BDnSvlSD3i71a6cjw1tvV9x8HG1lPS
         Yyfuo4KAHhPDY4upAhA0rQ/t7IlJ47HdDrZ1pyVt4w9EoqgsHo1Mrz2qJ4sPXYGZju
         JSres/MKNjUUZkE6lwV6dPB2Tu8vt5aEoO/xQzSObiu5NzWloGAHqTh129pAJZtRYs
         DHX6rCD+a/U4Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 7/7] fixdep: do not parse *.rlib, *.rmeta, *.so
Date:   Sat,  7 Jan 2023 18:18:20 +0900
Message-Id: <20230107091820.3382134-7-masahiroy@kernel.org>
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

fixdep is designed only for parsing text files. read_file() appends
a terminating null byte ('\0') and parse_config_file() calls strstr()
to search for CONFIG options.

rustc outputs *.rlib, *.rmeta, *.so to dep-info. fixdep needs them in
the dependency, but there is no point in parsing such binary files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
---

(no changes since v1)

 scripts/basic/fixdep.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index e22e689de61e..3a61b037d5ba 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -250,6 +250,15 @@ static int is_ignored_file(const char *s, int len)
 	       str_ends_with(s, len, "include/generated/autoksyms.h");
 }
 
+/* Do not parse these files */
+static int is_no_parse_file(const char *s, int len)
+{
+	/* rustc may output binary files into dep-info */
+	return str_ends_with(s, len, ".rlib") ||
+	       str_ends_with(s, len, ".rmeta") ||
+	       str_ends_with(s, len, ".so");
+}
+
 /*
  * Important: The below generated source_foo.o and deps_foo.o variable
  * assignments are parsed not only by make, but also by the rather simple
@@ -382,7 +391,7 @@ static void parse_dep_file(char *p, const char *target)
 			need_parse = true;
 		}
 
-		if (need_parse) {
+		if (need_parse && !is_no_parse_file(p, q - p)) {
 			void *buf;
 
 			buf = read_file(p);
-- 
2.34.1


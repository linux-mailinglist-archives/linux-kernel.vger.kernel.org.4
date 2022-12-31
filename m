Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15665A2FD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLaGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiLaGmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:42:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406A13FA1;
        Fri, 30 Dec 2022 22:42:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34DA8CE19E5;
        Sat, 31 Dec 2022 06:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D05C433D2;
        Sat, 31 Dec 2022 06:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672468951;
        bh=5OrrSG3HnFPsNx647A+ePC6NFhN8w9ptOuEE6V18iio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQpteJpGRVv60LnIO7ahIvfLcIxAKn74971cR7DTRmsYTY33XJHnS08UUG+84IoBP
         pVe1xO14P/bla6/4BYWc98HdAwu0NndZIrktvbokoATjjIaAqJzurUacaFvULcpVxu
         96Mys0LKaInJn01urGD9T/qbvbrNiy6+3s6ZuRtZuOBC3AmChrsbrxDHYBqe+32EQX
         j3bKXf4V+KVbLIo+9LILeLLZtrzjCCQDGav8oSIFbKmjBrg4Ww4IH2qQaS36CBFioS
         VUHm9N4+9+h7hrukuvytq1Zlv9F1qGNgUhEbQoEeXIWa4sT+EQanqf+yRoRXDFkdhJ
         xxxM0M6O6iV5g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 6/6] fixdep: do not parse *.so, *.rmeta, *.rlib
Date:   Sat, 31 Dec 2022 15:42:03 +0900
Message-Id: <20221231064203.1623793-7-masahiroy@kernel.org>
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

fixdep is designed only for parsing text files. read_file() appends
a terminating null byte ('\0') and parse_config_file() calls strstr()
to search for CONFIG options.

rustc outputs *.so, *.rmeta, *rlib to dep-info. fixdep needs them in
the dependency, but there is no point to parse such binary files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/basic/fixdep.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index cc8f6d34c2ca..b70885116ed2 100644
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
@@ -378,7 +387,7 @@ static void parse_dep_file(char *p, const char *target)
 			need_parse = true;
 		}
 
-		if (need_parse) {
+		if (need_parse && !is_no_parse_file(p, q - p)) {
 			void *buf;
 
 			buf = read_file(p);
-- 
2.34.1


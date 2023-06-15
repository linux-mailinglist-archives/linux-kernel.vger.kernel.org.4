Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F4731BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbjFOO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbjFOO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:56:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758BC2954
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:56:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8cc04c278so19222425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686840988; x=1689432988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZejLKN5aLCLQqaxNI770STmW64dCVjdqgJRYwrLAEQY=;
        b=PLv0SOqjQIJKhHDvPhJa/ZXB9L6XDUaeP7ZKUz07rxGmbHpPzPDaIqnBTNJRKv73lf
         73zFaCphp11PzXmvWBy7SMjfUaaGsYMlOhN5KfuKgPgKWX7pmuIauxcdRvTtKWboDOaS
         6ZdWEqdqMTaq49d1a7W2ZfqKhadmkebP+Trm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840988; x=1689432988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZejLKN5aLCLQqaxNI770STmW64dCVjdqgJRYwrLAEQY=;
        b=fRvw+qw5hEIlrC14v+w+tTzAdN/LD08w8yc0TZp/PbULeK2bd5mpEkYh7j0ZT9/TOL
         a3DdZM+a9rDNW9u4bPQXXXLvS780HY14OOBVhTvCMYTFzhjC5qR4L26vfiFluj63HXR1
         ZqfELwPISIV4oPFora1lsv31nU2pJbVdKQicrxpOAJVMQgFTHVO2fyor6/0Yr6wXLTxq
         rYCOTHBcZ0NT8zBz/FrY/+BRzV/S3Qbrl1RLtaYLcENqc7yV8nQIhsugkWUCMP7e6DUP
         nRrPy8YngB2TgMJu3CqlQgl5MgUhwUR1+GnR0Q8ZlRl+ElmIeSfscajruXM2Xb1T5SZ/
         JagQ==
X-Gm-Message-State: AC+VfDwZ7TpnW8d4qEVM7L81QNS5uXcFce/KyQQPZPJdCFeecXKIIv0w
        f+n6AdbmptsddtPRv3X7WbiGmw==
X-Google-Smtp-Source: ACHHUZ5OpUwlJ/vrCXpmVoMFPIO8LTjjlYgRLY492Ohe4rUYc/w74e7rMy7X0TCztfIjKLgSpnSJyQ==
X-Received: by 2002:a05:600c:b54:b0:3f6:2ee:6993 with SMTP id k20-20020a05600c0b5400b003f602ee6993mr14415646wmr.4.1686840987856;
        Thu, 15 Jun 2023 07:56:27 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:7ec7:7f97:45af:3056])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b003f709a7e46bsm20617755wme.46.2023.06.15.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:56:27 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        Florent Revest <revest@chromium.org>, stable@vger.kernel.org
Subject: [PATCH bpf] bpf/btf: Accept function names that contain dots
Date:   Thu, 15 Jun 2023 16:56:07 +0200
Message-ID: <20230615145607.3469985-1-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a kernel with LLVM=1, LLVM_IAS=0 and CONFIG_KASAN=y, LLVM
leaves DWARF tags for the "asan.module_ctor" & co symbols. In turn,
pahole creates BTF_KIND_FUNC entries for these and this makes the BTF
metadata validation fail because they contain a dot.

In a dramatic turn of event, this BTF verification failure can cause
the netfilter_bpf initialization to fail, causing netfilter_core to
free the netfilter_helper hashmap and netfilter_ftp to trigger a
use-after-free. The risk of u-a-f in netfilter will be addressed
separately but the existence of "asan.module_ctor" debug info under some
build conditions sounds like a good enough reason to accept functions
that contain dots in BTF.

Cc: stable@vger.kernel.org
Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/bpf/btf.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b682b8e4b50..72b32b7cd9cd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -744,13 +744,12 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first, bool dot_ok)
+static bool __btf_name_char_ok(char c, bool first)
 {
 	if ((first ? !isalpha(c) :
 		     !isalnum(c)) &&
 	    c != '_' &&
-	    ((c == '.' && !dot_ok) ||
-	      c != '.'))
+	    c != '.')
 		return false;
 	return true;
 }
@@ -767,20 +766,20 @@ static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
+static bool __btf_name_valid(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true, dot_ok))
+	if (!__btf_name_char_ok(*src, true))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false, dot_ok))
+		if (!__btf_name_char_ok(*src, false))
 			return false;
 		src++;
 	}
@@ -788,17 +787,14 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
 	return !*src;
 }
 
-/* Only C-style identifier is permitted. This can be relaxed if
- * necessary.
- */
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, false);
+	return __btf_name_valid(btf, offset);
 }
 
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, true);
+	return __btf_name_valid(btf, offset);
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
@@ -4422,7 +4418,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off, true)) {
+	    !__btf_name_valid(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
-- 
2.41.0.162.gfafddb0af9-goog


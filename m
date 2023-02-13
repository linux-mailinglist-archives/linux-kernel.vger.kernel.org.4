Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB0695183
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBMUNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBMUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:13:52 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C61E2B0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:13:51 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id z2-20020a1709060be200b0088b579825f9so8212541ejg.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhrJl5YJ7d2XgMTj7m/kCtzHq/X4U46pZjqetmx6EIU=;
        b=E84LspmK1D8CXYJ1386IiSX+2k5JvewADoqzxlVfJfiuzplqS+qe96ezEhckq47eoC
         I7MJxBjlzNIhSX7Luw4uTSli+Chwbl/PPWFlMOWohdwzIjriQ7EN6xOiPO0fJ0/VuUvg
         8cgjJ+VL2sso67wojRMlMstNwr4HP2B8/KtBlYx9+ulA3D5b7xkHHflOa5+nsJEEjLxV
         xTZVcIVI/F2oQ9HDud3W+SFSQoSiA3TSAXdF0W8PZvJyp/y88r50fsxg4TWdiUKdeIXN
         uL82iRVvCTHNjqxwZ+4Y6O2F0xn403iW7uF/DnPkemHbXKiDYFAcQoAPHJzBi1NhRl9/
         ZkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhrJl5YJ7d2XgMTj7m/kCtzHq/X4U46pZjqetmx6EIU=;
        b=BdWPsB4fN8YGKF5/jpLI/9EpalWp9hPE3+1Y1EAJE7VpmyZ5hgpuL7DOmGHMxMf5mY
         pnGLVffuD/7aDHIa9hDhtWtVFKGzxpQzpegJuo4Y5oyT/M49pf7i//f8J5sJUuJrF2+G
         D9FC/UTSHg9SpMiuvUMVBiVLceZAyOeU/M+zjW2kuw1Ppy5qEw2O8XUnWhTDbly42uv9
         xEOVtlyIvL+6JbAEnp7DeZnM6y7KLyyGyukGV2G2rtYcRVRuEm2UUsevbRqS+QjCmGR1
         FLJeRGQoamB6dLccZvJGesXc6sJ41Zw7J8s7stjMvgnbwGXHavAiw7fTaC1zK9mkUnOx
         3ErA==
X-Gm-Message-State: AO0yUKWeY0POv2BUrJiiMPgPXhgcSdgg+0DuBL4FOsSafVp+0tl4GMNa
        /hWa+NjSPy8KBlAVKgrghbzjjicc3Q==
X-Google-Smtp-Source: AK7set/YX+nQGo+fkH1LmT5uNQKhRY+VXPy7aEj/l1Z715GOIrZhtZCLlU/Yyd4YY6+utR6I4vl/W5A/Fw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6cba:3834:3b50:a0b2])
 (user=elver job=sendgmr) by 2002:a50:ab5b:0:b0:4ab:c702:656 with SMTP id
 t27-20020a50ab5b000000b004abc7020656mr4694edc.1.1676319229479; Mon, 13 Feb
 2023 12:13:49 -0800 (PST)
Date:   Mon, 13 Feb 2023 21:13:35 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213201334.1494626-1-elver@google.com>
Subject: [PATCH -tip v3] kasan: Emit different calls for instrumentable memintrinsics
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
with __asan_ in instrumented functions: https://reviews.llvm.org/D122724

GCC will add support in future:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777

Use it to regain KASAN instrumentation of memcpy/memset/memmove on
architectures that require noinstr to be really free from instrumented
mem*() functions (all GENERIC_ENTRY architectures).

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Resend with actual fix.

v2:
* Use asan-kernel-mem-intrinsic-prefix=1, so that once GCC supports the
  param, it also works there (it needs the =1).

The Fixes tag is just there to show the dependency, and that people
shouldn't apply this patch without 69d4c0d32186.
---
 scripts/Makefile.kasan | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index b9e94c5e7097..3b35a88af60d 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -38,6 +38,13 @@ endif
 
 CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
 
+ifdef CONFIG_GENERIC_ENTRY
+# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
+# instead. With compilers that don't support this option, compiler-inserted
+# memintrinsics won't be checked by KASAN.
+CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
+endif
+
 endif # CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_SW_TAGS
-- 
2.39.1.581.gbfd45094c4-goog


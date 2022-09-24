Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275555E8DB3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiIXPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIXPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:07:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9BB2ED52
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:07:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d11so2604804pll.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Yv8qMtUOFq9U9xG8MPRumD6xwRqoGuunAGd7S0VMH2Y=;
        b=AvVXSksJKyZ8iaUtBC5R6+Yo8434vSJde3Szzt0vGU6PG1F/CwrMD0mJMSve9zxAbf
         3Bp5gHLk38xPM3X/CWgwnA8NkVT+V6oBQEHik5Fgu9vyUylBf3pX7F8zqiNopAUwv7wV
         9mLZpBZRTKOf6VxEv6L9VFSib+jHDmDpquNfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Yv8qMtUOFq9U9xG8MPRumD6xwRqoGuunAGd7S0VMH2Y=;
        b=p1EneyJSm9HR8scWKKv5SEytf0Q0rqV72a4xOEz7E4zA9Ka/Na5nuaExyHKO4vn18r
         Cw2p2gzyjnwx80+2lCSFOIoAjRJwQa2CZVBarylYRB722q7jCPEMdHAux+KWMfNm58mq
         Y4NHkIEzlPUT2VTfG4Q4sAqcHw1UPCzqeQkc1MOM8zONFghT2VxExMh/sc56tjaeBp5M
         LB8xxj2uJsBVtYY5FKJmE9T+Ox/BjDRUMEBp9V8JgyMMMWhEQ1MtSLrv4hermlfz99zv
         EFsu1AnGI5YOmv27yPk59KXjZcvghQS8x2cSHETno+oVnD7v7bKevRV41UHb/3C29Ij4
         rztQ==
X-Gm-Message-State: ACrzQf2fCFddsPcooTazx4RCsn7bbx3yh3peweVziVX/b0NbHzGQQ7tl
        HjUu/quS4JHS6h9idxEH/qeAL/w7TCholg==
X-Google-Smtp-Source: AMsMyM6IW6pmgxKM3t96ncNA4SXZplLw5nLDILnctdz8HYaHHdDoTWx8HPCFYQrwBu2G9rNkvs2zPA==
X-Received: by 2002:a17:90b:1b4c:b0:202:c05f:6e7b with SMTP id nv12-20020a17090b1b4c00b00202c05f6e7bmr15485387pjb.200.1664032043998;
        Sat, 24 Sep 2022 08:07:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12-20020aa7960c000000b00538056de6ecsm8541003pfg.52.2022.09.24.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:07:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] Compiler Attributes: Introduce __access_*() function attribute
Date:   Sat, 24 Sep 2022 08:07:15 -0700
Message-Id: <20220924150715.247417-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; h=from:subject; bh=9QUAPr+LbmvLvzHSrwCAgoD3MCPZJCJazSX2ioWcsdE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLx0j8ULLJEiPU0qsDsKV96TCM3n8cUwh6oIFuNl8 SbbGAy2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy8dIwAKCRCJcvTf3G3AJrdGEA CO++jFiNa3s+RuBTTfHT6xP89L/2GDxIq/xASFQoS9OOpt88jHJvbYlwpK/IngVsPgXkXoCiGn66Ku H9Wq8o5w/cYfSNIptPKlAYJ/VOhHld8Y2MU5IG5aoJmNdBJHtKDFbOoyeBoQn1heeV88ejRNpmu+TF EEcDRFnXXMX3MX/7cfK8QCrtXFZ3EFsfga269rVljvJnbwjRciCD60MYEopOCZvrBJLUmzXLj8/C+L KGoMFgk4UNwohjPgrB9MiRefrm4ArRULwTByQU/3TZkJuYOtQI/nNDdOAS5XuuUHnrO2AXP/nvwxwb 6k16l4aW2N8h3U6VXzsR09r7Ou4f7ZNuZKreaTH4rLVy3sT7kvwqsYMTQktPZRXgSHTXwIWhG1iQci S4vSZywi9VKK9TZioPvpXOVYNlRTh/CsFxGpMYg5CtrA3Hvb/6jwhxaChVSmbF7n3SZm071+dWDSyM n91dLPzOHlJt8rJ7AgyvoYLy7twQ35ZzFVxYlfjSk6mSiMPN9mwDoNMq/2zEG5ol2Qm+VlV3r51Icg ZGbPkJf4PCrPZF7hKE8tgxKDxAPPXcH2MmMW/pyupB5HnlFQc5KFiWP8v7FNpYunYmpLjQol8iORiF 0X6wjDDO2FiePVsENhG/lu8g/eXSvXMh6T4RAewvtT+C5MMLJ9fM949VyeRQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added in GCC 10.1, the "access" function attribute is used to mark pointer
arguments for how they are expected to be accessed in a given function.
Both their access type (read/write, read-only, or write-only) and bounds
are specified.

These can improve GCC's compile-time diagnostics including -Warray-bounds,
-Wstringop-overflow, etc, and can affect __builtin_dynamic_object_size()
results.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 9a9907fad6fd..465be5f072ff 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -20,6 +20,36 @@
  * Provide links to the documentation of each supported compiler, if it exists.
  */
 
+/*
+ * Optional: only supported since gcc >= 10
+ * Optional: not supported by Clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-access-function-attribute
+ *
+ * While it is legal to provide only the pointer argument position and
+ * access type, the kernel macros are designed to require also the bounds
+ * (element count) argument position; if a function has no bounds argument,
+ * refactor the code to include one.
+ *
+ * These can be used multiple times. For example:
+ *
+ * __access_wo(2, 3) __access_ro(4, 5)
+ * int copy_something(struct context *ctx, u32 *dst, size_t dst_count,
+ *		      const u8 *src, int src_len);
+ *
+ * If "dst" will also be read from, it could use __access_rw(2, 3) instead.
+ *
+ */
+#if __has_attribute(__access__)
+# define __access_rw(ptr, count)	__attribute__((__access__(read_write, ptr, count)))
+# define __access_ro(ptr, count)	__attribute__((__access__(read_only,  ptr, count)))
+# define __access_wo(ptr, count)	__attribute__((__access__(write_only, ptr, count)))
+#else
+# define __access_rw(ptr, count)
+# define __access_ro(ptr, count)
+# define __access_wo(ptr, count)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
  */
-- 
2.34.1


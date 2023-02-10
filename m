Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA8692993
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjBJVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjBJVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:51:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3816566F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:51:45 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11CFF3F194
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676065904;
        bh=zFT0oOBpYveO604RTQTdkSq+7ygdeMz6BBCP0ZNZAbw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=hmEh7MaWGz+RUO+0mLratkKjHU3S6FghrjiX84sKsAa/ajkk9ST6P0zPyJb3bO7+t
         I437AOWk1wGwslgLPjBfQYWWuLfQ/6/izMPDGf7ggwrO5EG5dBuY4PaFrHNmbfhMjW
         Kx/PBfXOmpsVEd7bpboLaq5coO6qZW1m1qXLAQDml+lHho0NnMqgKh0T5mwmKd1wlO
         kZo6/BJ0omPv1pexPhQHGi35XzBCTv4H8bYbmHVOz4PU9U5fR91EWs6GZ1GUExqD7V
         EW54cIP5aB4bLz1m10ukpS1xw96BiOhGQLRRx45rQsymLxZLU8/XySa8SoL8N60d8N
         8/2yxihgzFaGA==
Received: by mail-ed1-f69.google.com with SMTP id o21-20020aa7dd55000000b004a245f58006so4395308edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFT0oOBpYveO604RTQTdkSq+7ygdeMz6BBCP0ZNZAbw=;
        b=RQyoXcvXTEyFyxNmzCxbLOtusrEs5Ravgpa8kjcAGXzrds+8kJ8AOLejSN7IRJbcnS
         EswZHns2oAkAE2ph6dSVK4AU2z/qOb19TFICQDoTDH5k/qF8YCwa0wNJQVqlunCsUaGV
         l2KzcxPCRykmZqFDoqXLlTPrYca8eg8d46So2jsTs7DLEX6p5EyDrkXqZtjwHYycXmFj
         QFOOuGVpGBVcgDEOVXXygeXtQ/paScfrPfoVlX/PowYYSTHaZ3KuO5F6EAnI7696TIMl
         J1mxUV87msU+0x8li5QiJHHRIIU8myI+XcBQBIklpEa4nYLBqkv7GYOJf/wOoqtq0Ydx
         FV9w==
X-Gm-Message-State: AO0yUKWVAuagoLDkffb0mteqAS8Wswc0D/BPbra/LdW/U4kYw97SqTve
        rnBsLCjeIMveFqm8JT3Fz/FqeBlFx4+dlo4DtUeODEV+qvALmajrwr6l/BF3JvcfAOAOup5MWAl
        /vHwnD5VuWwfVUZmCX0wEHhP6Jt73rbFrQVVT8O/s+L7yXDDwgw==
X-Received: by 2002:a50:9e6e:0:b0:4aa:a709:8aaa with SMTP id z101-20020a509e6e000000b004aaa7098aaamr17736716ede.26.1676065902951;
        Fri, 10 Feb 2023 13:51:42 -0800 (PST)
X-Google-Smtp-Source: AK7set9+BHlJMDBcsvgiM7vwnGCVZttPxeqAKvR0hWfwXQt8YmKsWjwVxROQgnN9KPCp3zjIdBwimQ==
X-Received: by 2002:a50:9e6e:0:b0:4aa:a709:8aaa with SMTP id z101-20020a509e6e000000b004aaa7098aaamr17736703ede.26.1676065902700;
        Fri, 10 Feb 2023 13:51:42 -0800 (PST)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id o17-20020a50c291000000b0049ef70a2894sm2852729edf.38.2023.02.10.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 13:51:42 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
Date:   Fri, 10 Feb 2023 22:51:41 +0100
Message-Id: <20230210215141.108958-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.37.2
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

With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen passes
-ftrivial-auto-var-init=zero to clang, that triggers the following
error:

 error: '-ftrivial-auto-var-init=zero' hasn't been enabled; enable it at your own peril for benchmarking purpose only with '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'

However, this additional option that is currently required by clang is
going to be removed in the future (as the name of the option suggests),
likely with clang-17.

So, make sure bindgen is using this extra option if the major version of
the libclang used by bindgen is < 17.

In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
without triggering any build error.

Link: https://github.com/llvm/llvm-project/issues/44842
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---

Changes in v2:
 - check the version of libclang used by bindgen to determine if we need
   to pass the additional clang option

 rust/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index ff70c4c916f8..c77d7ce96a85 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -269,6 +269,19 @@ BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 # some configurations, with new GCC versions, etc.
 bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
 
+# Auto variable zero-initialization requires an additional special option with
+# clang that is going to be removed sometimes in the future (likely in
+# clang-17), so make sure to pass this option only if clang supports it
+# (libclang major version < 17).
+#
+# https://github.com/llvm/llvm-project/issues/44842
+ifdef CONFIG_INIT_STACK_ALL_ZERO
+libclang_maj_ver=$(shell $(BINDGEN) $(srctree)/scripts/rust_is_available_bindgen_libclang.h 2>&1 | sed -ne 's/.*clang version \([0-9]*\).*/\1/p')
+ifeq ($(shell expr $(libclang_maj_ver) \< 17), 1)
+bindgen_extra_c_flags += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+endif
+endif
+
 bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
 	$(bindgen_extra_c_flags)
 endif
-- 
2.38.1


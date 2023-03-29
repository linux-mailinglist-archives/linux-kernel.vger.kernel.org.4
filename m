Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB36CF795
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC2Xj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjC2Xj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:39:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8B4200;
        Wed, 29 Mar 2023 16:39:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so69817759edc.3;
        Wed, 29 Mar 2023 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680133164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqEPbtG5TnzsvZer03neXKsYACOyDSZeEW5I6AIlmNs=;
        b=IY7w1l4YmObaNWVkpPgYdEfMcpT1ctYp3obMhWv0Xm8cynVdixd1VHjN/sLeq3PUw1
         bjfEK/H7cwZa0RY2LfGBfdxZLNRt6UKYrjtBdGGBj72xrzFkYrHJG73e4Lf3G7GRSSSN
         iydWFvu+eQeZdGEvm9h1cAmk/R2RX2wNvUh/A/FnGXsCc6gA08vWFMKpmheVYBYknisf
         NauiJiDkgebaoLSbaCAD4Sdyvg2dbsvwcr/UnZTSdBgUGzIpgT5Y22/OiJ/KHcrbqHDW
         seGT3qo84j6Y5p6L2b8JgEMtnND5l0hxD6X9dMnYBbXIuWa0uVIVH5xeD7QyafhkPTgZ
         66BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqEPbtG5TnzsvZer03neXKsYACOyDSZeEW5I6AIlmNs=;
        b=QCoYM4D1OjZ0PHekwZphE3Gr/PsAnsewpo8nhZDLNzpgGxF7vd+WAzwMBXPY8Z3egv
         7e9U6nkDacRWrcPzPbEifpDMzzoM0VGYAei1uxsIFQuizuTw6Fk5T4MTa7w89LaGlbh/
         n8X+SYFkbma5z3YLOeihK/RrB7FL36TLZjIa/GSDvr9Ea1MwngTfTWsvdygJzIuDhycf
         XU7GeBYjMWGhtiWCcmN2/tMTn62xgostS+OVzzSXHKjhgnqit2ocLOonWLD51FQfIHx3
         8dWhj9eG1zmhGvmSkl93NFf/+izweTE7kxIlRpIgXFg6fWmMLMCgSPpiT8ooiLtvFdK+
         k8fg==
X-Gm-Message-State: AAQBX9eLRcWBBlAN0qLiep8S0Z7QnsoHV7hedhGLcJqtFcWatEvKGuFi
        g/UB1mhTvvbP79fiMmmOzW99UAvi0s81zw==
X-Google-Smtp-Source: AKy350ZjdxbO/H7VX8W5FkfHtneSxJsIufYC0g+yX+AZB7YVyuK4+pY4dNSjcNWr0lwU7Ja1ZJwweA==
X-Received: by 2002:a17:907:98ce:b0:931:de86:1879 with SMTP id kd14-20020a17090798ce00b00931de861879mr23877693ejc.9.1680133163858;
        Wed, 29 Mar 2023 16:39:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e11:1404:8860:cab:2031:9769:deea])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906409100b009338ad391b9sm14513791ejj.213.2023.03.29.16.39.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Mar 2023 16:39:23 -0700 (PDT)
From:   technoboy85@gmail.com
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matteo Croce <teknoraver@meta.com>
Subject: [PATCH] rust: fix bindgen arguments
Date:   Thu, 30 Mar 2023 01:39:21 +0200
Message-Id: <20230329233921.16729-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <teknoraver@meta.com>

bindgen renamed some arguments to be more inclusive.
Detect if bindgen uses the new syntax and use it,
otherwise fallback to the previous one.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 rust/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index ff70c4c916f8..3a4971d84b63 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -68,6 +68,11 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
+bindgen-list = $(shell if $(BINDGEN) --help |grep -q -- --allowlist;			\
+	then echo "--blocklist-type '.*' --allowlist-var '' --allowlist-function";	\
+	else echo "--blacklist-type '.*' --whitelist-var '' --whitelist-function";	\
+	fi)
+
 # The `html_logo_url` and `html_favicon_url` forms of the `doc` attribute
 # can be used to specify a custom logo. However:
 #   - The given value is used as-is, thus it cannot be relative or a local file
@@ -300,8 +305,7 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
 # given it is `libclang`; but for consistency, future Clang changes and/or
 # a potential future GCC backend for `bindgen`, we disable it too.
 $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_flags = \
-    --blacklist-type '.*' --whitelist-var '' \
-    --whitelist-function 'rust_helper_.*'
+    $(bindgen-list) 'rust_helper_.*'
 $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_cflags = \
     -I$(objtree)/$(obj) -Wno-missing-prototypes -Wno-missing-declarations
 $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ; \
-- 
2.40.0


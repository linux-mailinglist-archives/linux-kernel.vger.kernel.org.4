Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02BD701986
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjEMTeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEMTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 15:34:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827D1FD5;
        Sat, 13 May 2023 12:34:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f41b73104eso26081861cf.3;
        Sat, 13 May 2023 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684006443; x=1686598443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/2Y0NnOA4rOyDN7e+HMDW4ZS3Xal4lAQgzHlbrtxb8=;
        b=TKvU88cEw94xxNGVXdWVlGX4SELbGq5Tjssy8H3d8emcgndXTF68PDTb11pNKBVd+v
         2pItfqbo5XJlLmB3N9FiVeR5pd3BbzyL9IaeeB7aOTyWr3EFWCOHZ4dR4K68KQcrnH6E
         v0Fa7f8peU8H9jE2WMjcun/Guui6XuV0qitpGJmYcJoU3iwMMgi+g7S4JY9y3WPNpQpo
         /5AHPXmHI1ijEJRG7vRrvgW6QX7FGR7yswHulAc0ZeGxEBRx39nctPVPUF/4zgQFna1t
         5QzwPm+wLWXL7VSNm1nAI4SAP1u0yUkiQdyExEydkjqZ0tN0OfxSwWBWhQDtUjKzOAkr
         CCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684006443; x=1686598443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/2Y0NnOA4rOyDN7e+HMDW4ZS3Xal4lAQgzHlbrtxb8=;
        b=LakoN1p3X64trQuZEKlfUgopBOEIIPdI6N4bY4gqaiA4gmzmZUUpP3A3alm6EIvL4d
         oFyvDaw7O7I6+JgjG3s54EYUvvVVA14MXK3JrE3yj7mot9M4t/VvvBCHTcOBXEg2sL3r
         4nUEC5eeC//hDbGpA5mr8bfa/S0+N3FCRjGPxnjhipFbZkaKYFtq2+KHghMwFKzfZqRH
         yQ6Hj3ZnqLRh8+5fr8ncs6zi8qeQ2iIf3358/44o6In/U7mYbZ5qLQLT0FKTtPurySAL
         U+knfb1+Ai0n+lU037QVJeppKCrSEAdP7DyDGkhJmtRFSXc2fx/2yotj4Q74sNDPh7Rw
         lVHg==
X-Gm-Message-State: AC+VfDzK2y6BWnrk5zmv/YGKpvqqV3VlRnvZdQRMplQWnp9TEW9mxBPy
        metj+NxVZwUS4vgsxyNOiGM=
X-Google-Smtp-Source: ACHHUZ4e67Vm1wY0nJaNasVnetT4L1KyrgtLN+6+PVyfXg0nNvcoSJhF8DE502RICDRhxbWjSP0Tng==
X-Received: by 2002:a05:622a:1309:b0:3ef:415f:188 with SMTP id v9-20020a05622a130900b003ef415f0188mr49337463qtk.61.1684006443437;
        Sat, 13 May 2023 12:34:03 -0700 (PDT)
Received: from localhost.localdomain (2603-6000-8100-7fd4-0000-0000-0000-0c33.res6.spectrum.com. [2603:6000:8100:7fd4::c33])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a018d00b003f018e18c35sm4054115qtw.27.2023.05.13.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 12:34:03 -0700 (PDT)
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org (open list:RUST),
        linux-kernel@vger.kernel.org (open list),
        llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Cc:     "Ethan D. Twardy" <ethan.twardy@gmail.com>
Subject: [PATCH] Fix libclang version check for out-of-tree builds
Date:   Sat, 13 May 2023 14:32:37 -0500
Message-Id: <20230513193238.28208-1-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During out-of-tree builds where the path to the kernel source tree
contains a version string, scripts/rust_is_available.sh incorrectly
parses the version string of libclang, resulting in
CONFIG_RUST_IS_AVAILABLE erroneously set to 'n'.

To reproduce:

    $ cd ~/build && make -C ~/linux-6.4.0-rc1 O=$PWD rustavailable

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
---
 scripts/rust_is_available.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index aebbf1913970..e8a1439be9f8 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -102,8 +102,8 @@ fi
 # Check that the `libclang` used by the Rust bindings generator is suitable.
 bindgen_libclang_version=$( \
 	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null \
-		| grep -F 'clang version ' \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+		| grep -oE 'clang version [0-9]+\.[0-9]+\.[0-9]+' \
+		| cut -d' ' -f3 \
 		| head -n 1 \
 )
 bindgen_libclang_min_version=$($min_tool_version llvm)

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1


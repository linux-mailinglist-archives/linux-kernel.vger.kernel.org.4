Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C871398A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjE1NVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjE1NVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:21:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE77BE;
        Sun, 28 May 2023 06:21:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6c229b42bso11935981cf.0;
        Sun, 28 May 2023 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685280062; x=1687872062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ggyLkGv6g0jo85hrXvJLdeY1eXxDxkX/cg7GhTS4sI=;
        b=aIBF6b59zCRUAFbsviZO2vgNM+XM7mLFoWPVhWAuTOkeq320Ub6GSuS925yI0+uIQg
         YZAPupRUPu36GoC6sG6P1NaOHkcR/qWgBwJJJoEzEcajnfkmSYZrrznxahNUUQ3O7jlj
         A9REwphBY3TX2DE4xZ86Bmva0sn/eP2AffDJ24UtrivbhPdS6z+ScZqC5e8ueCubNNU2
         x8zlgeMt4vdx2L5iirnlglRnYLof0b1zriQ6GwZg+6w/bIi1+XneBfV0kAhWgMOLIIH/
         tn1pXiDs4p4HvW3TnYpCUuxMl8WZCWl4zIFK9QJl1XpufZsps3hNIwwQD9ySqGv4bRzi
         reVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685280062; x=1687872062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ggyLkGv6g0jo85hrXvJLdeY1eXxDxkX/cg7GhTS4sI=;
        b=WE36U8DVxVPJQV+Vp3TBQR+GzqqbjXyDUk+qBB0n1CRJDatD9aUhYBQEmsJDynRTDM
         w582zKAqQhasig9xuNe/eGADydYqcjcQPsIeKo4VvV6bsUUkzolcxvDuRJ+/bG7zwu8M
         imJTF0Gn9yb8/vkV+VNLc/msEYH+t9fZvxeUK/8tdr26MuegcNeOMmR61eiw63w9E8cE
         /RD5hj5h5iOhJp2vJcf5ODdc/FseewLz9MCqTKD/G6AQDFzufvlsuFNoRkk9qcKkwotd
         w9LyKzVvf9gxbv+jkEf1HOo2aXNVlWAuZpjl0JIx3S7pTiwNWSgJcBKQkHY63SqQD32H
         7FwQ==
X-Gm-Message-State: AC+VfDzHPwQhsrgmkuduXsQmrMaEbyL8arYf4xdknjlckocMV4FYDlqg
        3c02KoQMvbdlgP177uKgDFM=
X-Google-Smtp-Source: ACHHUZ5Z9y8gbyIHcZ/hfBctPRdliNDg9tOMLiNyj/Ez85Nq8VRnR3pN8fizYKYsBYAg+gP7l9WCvA==
X-Received: by 2002:ad4:5f08:0:b0:626:1ca6:5efe with SMTP id fo8-20020ad45f08000000b006261ca65efemr1344446qvb.9.1685280062336;
        Sun, 28 May 2023 06:21:02 -0700 (PDT)
Received: from localhost.localdomain (2603-6000-8100-7fd4-0000-0000-0000-0619.res6.spectrum.com. [2603:6000:8100:7fd4::619])
        by smtp.gmail.com with ESMTPSA id x5-20020ad44585000000b005dd8b9345b9sm87190qvu.81.2023.05.28.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 06:21:02 -0700 (PDT)
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
        Kees Cook <keescook@chromium.org>, Finn Behrens <me@kloenk.de>,
        rust-for-linux@vger.kernel.org (open list:RUST),
        linux-kernel@vger.kernel.org (open list),
        llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Cc:     "Ethan D. Twardy" <ethan.twardy@gmail.com>
Subject: [PATCH v2 1/1] scripts/rust_is_available: Fix clang version check
Date:   Sun, 28 May 2023 08:18:02 -0500
Message-Id: <20230528131802.6390-2-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528131802.6390-1-ethan.twardy@gmail.com>
References: <20230528131802.6390-1-ethan.twardy@gmail.com>
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
identified the version string of libclang to be the version string in
the kernel sources path, resulting in CONFIG_RUST_IS_AVAILABLE
erroneously set to 'n'.

This issue was previously affecting builds on distributions, such as
Gentoo Linux, where the kernel source tree is under version control,
and placed under a path containing the current kernel version string
in /usr/src.

The fix is to take special care to match only the version string
following the string 'clang version' in the output.

To reproduce:

  $ cd ~/build && make -C ~/linux-6.2.0 O=$PWD LLVM=1 rustavailable
  [...]
  *** libclang (used by the Rust bindings generator 'bindgen') is too old.
  ***   Your version:    6.2.0
  ***   Minimum version: 11.0.0
  [...]

Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

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
-- 
2.40.1


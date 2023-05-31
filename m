Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B7717338
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjEaBfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjEaBfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:35:11 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B1F9;
        Tue, 30 May 2023 18:35:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6261616efd2so18292996d6.2;
        Tue, 30 May 2023 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685496907; x=1688088907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMSUAIzAABF4Dds+SMcyk4c0VPg+DkSfaML9RK0MaQU=;
        b=o4yu9VXVx0+PhpGvAJBS9FUEuVLZQFg95Oapn4amLeSNcvo74e+hD9BKdJ3a5RQVFd
         TQlVQ/1L3qVOOr0D6gus/8HtKg4UAKf3AJdPwkkf90ELERuTcfjahmZnecczwTCilgtU
         UIt/Z+XGvtvuaix8kzC9NCVItKsk/E4/1/1DHGs9I3SFyzEBjGKz68exFauMKPLhbYuO
         KyMvreiMVP5HwSZoIGhdvWAxpxwsmk4J0Uev4s/dU+XZDcQOR7d7Wm9X3QyEEmKOv16X
         KQOPl7czev0Ew0E86EeI/kIPSC5rdz4Ex40bVl5mC165E+KanR9V/VGnmnDeCa/dQbld
         4dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685496907; x=1688088907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMSUAIzAABF4Dds+SMcyk4c0VPg+DkSfaML9RK0MaQU=;
        b=K6DGR0fKhQLbgWxkEGMYfWTk36dpen2BOaDs8+uLOtPDu0tgNXmryIZL/Xyal1ZUC1
         GTWD8LvPKfHTictrSScx9kXlG9yZ4Xj7gtiqeVsxxZbXEvX5E3YCTE9flNsUgVdrdSZZ
         KG87VCvu8LWPTHIv032R+eCbRrKJhDn1n3P8EmT7ji4UB6WURrkU7zsqtZy3O9E17nR3
         bNsW1ELH+nswFXEn4cOtsebyJK1P27Lkvhe1mhaJ+yhEINxfngcBqzgCxBrs3qYpftC1
         C6AumMCBrSidBC0fTDESflU5thHwU2PZkisvfGge1VOwkO+YfOvrys4djD6q3gbAvvjl
         Eglg==
X-Gm-Message-State: AC+VfDwyg0YqzrSx6elwIuwNaQMiHGEv4T1h3KhySJZ0P3AfCM2O8mAb
        qv2m5er7UWFBui/YAfnCSy4=
X-Google-Smtp-Source: ACHHUZ5bYzXnvzzuInBywt/p/Waes6JQMdcwGCxFFldsnk74MWixpZZS8wyzVcftXv539hIdf3NvRQ==
X-Received: by 2002:a05:6214:c6b:b0:614:da60:f44a with SMTP id t11-20020a0562140c6b00b00614da60f44amr3506501qvj.46.1685496906699;
        Tue, 30 May 2023 18:35:06 -0700 (PDT)
Received: from localhost.localdomain (2603-6000-8100-7fd4-0000-0000-0000-0619.res6.spectrum.com. [2603:6000:8100:7fd4::619])
        by smtp.gmail.com with ESMTPSA id h19-20020a0cf213000000b0062383edece8sm4249123qvk.91.2023.05.30.18.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 18:35:06 -0700 (PDT)
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>, Finn Behrens <me@kloenk.de>,
        Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org (open list:RUST),
        linux-kernel@vger.kernel.org (open list),
        llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Cc:     "Ethan D. Twardy" <ethan.twardy@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v3 1/1] scripts/rust_is_available: Fix clang version check
Date:   Tue, 30 May 2023 20:32:11 -0500
Message-Id: <20230531013211.27408-2-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531013211.27408-1-ethan.twardy@gmail.com>
References: <20230531013211.27408-1-ethan.twardy@gmail.com>
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

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


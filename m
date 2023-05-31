Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1111717337
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjEaBfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjEaBfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:35:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273BD10B;
        Tue, 30 May 2023 18:35:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f6b20ad49dso29413101cf.2;
        Tue, 30 May 2023 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685496905; x=1688088905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2/x4JOomTNoYK68TGeo1jbdWXKZOEcQ5s6x1ltkZ2s=;
        b=gST+wZxaCix9hoL3YTUbKzF9UZTLP3WZExwHZQ9c5yg7/uIRQmf+7eS/AnsRf5rwbN
         6ipTDdIl65s5NqSHG3NQ8gKl7fDv0dkfUPAkb/Opjs5k/lf6vo6DGF5JpS5188zhxTP/
         bCytnHenP8lGxB34qffNlJIQcGaXNPh9w+zzpL1J0Pa1V2wzF/WRqxkNJNll9xe+Kj4v
         wbGjc8O+uW6wBfKmi0UM7D+dDx0O8NJ28d92BJQiNAhlhFOEDwwJLzqCOoYPRrvJHhuK
         MrY6GKl9jN+0mmZMxVnhyYKDipBqwyQSKy4DoBnFSIb2FnGX5Hb/SLmbuks9vNgePDJb
         nbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685496905; x=1688088905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2/x4JOomTNoYK68TGeo1jbdWXKZOEcQ5s6x1ltkZ2s=;
        b=CUo5SXt9+YmGB461TcZ4ThISe9Svtk5p4MnLo92figPqoQNwVrpprmyD/7kEbWuR/0
         wKmImpxZcayAVbdI4pqPL6v5NYuAQC+n4DCfUYLwKvQ9cjyCTRprvcObCFqD0Pq57tmd
         oUN7b7VgiRPmUWwNBWiA7HGGctEoNT7Jx1IRpUiipV4IhbG02swL58O+8sCMmJqtio1f
         8VAD+puPAPd1Xtc/vrABZ4yrWNy+U8OIOZOV/pVQlencHvKaMgCh1HU8CKBNL+dhnH7J
         4x7JbXEogqVtPofbifUMvdfipQR84aA4RDKu6wUxvpEwxMZaYlcM9YS5uTASW13VBQfv
         KZTw==
X-Gm-Message-State: AC+VfDyEe8xj9OY6IR78yCkjJ/MZlpQys5/WfpJDaa5/dUczd3cdXvWc
        jGDWtCGSKnME6nb8WyC/1hI6tvJ9Veoxndq6
X-Google-Smtp-Source: ACHHUZ68LDwF97pTiFd+PZTyp94MfgdTWWbMyz0f1+uhbqIGGxI03MrrcAei9wCkNdSxx8u8qhdYgQ==
X-Received: by 2002:a05:6214:1d0a:b0:626:37fe:218c with SMTP id e10-20020a0562141d0a00b0062637fe218cmr4735734qvd.24.1685496905230;
        Tue, 30 May 2023 18:35:05 -0700 (PDT)
Received: from localhost.localdomain (2603-6000-8100-7fd4-0000-0000-0000-0619.res6.spectrum.com. [2603:6000:8100:7fd4::619])
        by smtp.gmail.com with ESMTPSA id h19-20020a0cf213000000b0062383edece8sm4249123qvk.91.2023.05.30.18.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 18:35:04 -0700 (PDT)
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        rust-for-linux@vger.kernel.org (open list:RUST),
        linux-kernel@vger.kernel.org (open list),
        llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Cc:     "Ethan D. Twardy" <ethan.twardy@gmail.com>
Subject: [PATCH v3 0/1] Fix libclang version check for rustavailable
Date:   Tue, 30 May 2023 20:32:10 -0500
Message-Id: <20230531013211.27408-1-ethan.twardy@gmail.com>
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

This series contains just one two-line patch, to fix a small issue
in scripts/rust_is_available.sh. This issue is currently affecting
kernel builds with Rust on Gentoo Linux (and potentially other
distributions/workflows where the kernel source path contains a
version string).

Changes from v2:
* Add tags from review and testing

Changes from v1:
* Patch formatting. I believe there were some serious issues with the
  formatting that caused it to be lost/ignored by the mailing list.
  I sincerely hope that the formatting of this patch is acceptable,
  this is my first contribution to the kernel so I haven't mastered
  the patch workflow yet.

Ethan D. Twardy (1):
  scripts/rust_is_available: Fix clang version check

 scripts/rust_is_available.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1

